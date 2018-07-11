Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58754C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C37208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C37208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeGKKXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:23:41 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:40725 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeGKKXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:23:41 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6BAJtRr010327;
        Wed, 11 Jul 2018 19:19:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Wed, 11 Jul 2018 19:19:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6BAJntU010282
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 11 Jul 2018 19:19:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in iterate_supers
To:     viro@zeniv.linux.org.uk
Cc:     syzbot <syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000da8a9b0570a29c01@google.com>
 <0145d376-7ef8-3e17-5a24-94de946a01e5@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <7dc64116-f43d-3739-7b35-4eef7a80e343@I-love.SAKURA.ne.jp>
Date:   Wed, 11 Jul 2018 19:19:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0145d376-7ef8-3e17-5a24-94de946a01e5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/10 19:34, Tetsuo Handa wrote:
> It turned out that, although the reason of stalling v9fs_mount() is currently
> unknown, the reason of many processes stuck at iterate_supers() is that
> they are unable to take s->s_umount object due to down_write_nested() below.
> 
> 	/*
> 	 * sget() can have s_umount recursion.
> 	 *
> 	 * When it cannot find a suitable sb, it allocates a new
> 	 * one (this one), and tries again to find a suitable old
> 	 * one.
> 	 *
> 	 * In case that succeeds, it will acquire the s_umount
> 	 * lock of the old one. Since these are clearly distrinct
> 	 * locks, and this object isn't exposed yet, there's no
> 	 * risk of deadlocks.
> 	 *
> 	 * Annotate this by putting this lock in a different
> 	 * subclass.
> 	 */
> 	down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);
> 

Guessing from commit dabe0dc194d5d56d ("vfs: fix the rest of sget() races"),
this is an overlooked sget() race.

iterate_supers() is calling down_read(&sb_s_umount) on all superblocks found by
traversing super_blocks list. But sget_userns() adds "newly created superblock
to super_blocks list with ->s_umount held by alloc_super() for write" before
"mount_fs() sets SB_BORN flag after returning from type->mount()".

Therefore, if type->mount() (e.g. v9fs_mount()) took long after sget() for
some reason, processes will be blocked on a superblock on SB_BORN not yet set.
Doing the test (which is done after ->s_umount is held) before holding ->s_umount
(patch shown below) works for me. Although there seems to be many bugs in v9fs
code, I think that making sure that other threads won't try to wait for superblock
with SB_BORN not yet set is better.

---
 fs/super.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 50728d9..03c3b3f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,11 @@
 #include <linux/user_namespace.h>
 #include "internal.h"
 
+static inline bool sb_is_alive(struct super_block *sb)
+{
+	return sb->s_root && (sb->s_flags & SB_BORN);
+}
+
 static int thaw_super_locked(struct super_block *sb);
 
 static LIST_HEAD(super_blocks);
@@ -407,8 +412,7 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
 bool trylock_super(struct super_block *sb)
 {
 	if (down_read_trylock(&sb->s_umount)) {
-		if (!hlist_unhashed(&sb->s_instances) &&
-		    sb->s_root && (sb->s_flags & SB_BORN))
+		if (!hlist_unhashed(&sb->s_instances) && sb_is_alive(sb))
 			return true;
 		up_read(&sb->s_umount);
 	}
@@ -590,6 +594,8 @@ static void __iterate_supers(void (*f)(struct super_block *))
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!sb_is_alive(sb))
+			continue;
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
 		sb->s_count++;
@@ -620,13 +626,15 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!sb_is_alive(sb))
+			continue;
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
 		down_read(&sb->s_umount);
-		if (sb->s_root && (sb->s_flags & SB_BORN))
+		if (sb_is_alive(sb))
 			f(sb, arg);
 		up_read(&sb->s_umount);
 
@@ -656,11 +664,13 @@ void iterate_supers_type(struct file_system_type *type,
 
 	spin_lock(&sb_lock);
 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
+		if (!sb_is_alive(sb))
+			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
 		down_read(&sb->s_umount);
-		if (sb->s_root && (sb->s_flags & SB_BORN))
+		if (sb_is_alive(sb))
 			f(sb, arg);
 		up_read(&sb->s_umount);
 
@@ -689,6 +699,8 @@ static struct super_block *__get_super(struct block_device *bdev, bool excl)
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
 		if (sb->s_bdev == bdev) {
+			if (!sb_is_alive(sb))
+				continue;
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			if (!excl)
@@ -696,7 +708,7 @@ static struct super_block *__get_super(struct block_device *bdev, bool excl)
 			else
 				down_write(&sb->s_umount);
 			/* still alive? */
-			if (sb->s_root && (sb->s_flags & SB_BORN))
+			if (sb_is_alive(sb))
 				return sb;
 			if (!excl)
 				up_read(&sb->s_umount);
@@ -813,11 +825,13 @@ struct super_block *user_get_super(dev_t dev)
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
 		if (sb->s_dev ==  dev) {
+			if (!sb_is_alive(sb))
+				continue;
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
 			/* still alive? */
-			if (sb->s_root && (sb->s_flags & SB_BORN))
+			if (sb_is_alive(sb))
 				return sb;
 			up_read(&sb->s_umount);
 			/* nope, got unmounted */
@@ -916,8 +930,7 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data, int force)
 static void do_emergency_remount_callback(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
-	if (sb->s_root && sb->s_bdev && (sb->s_flags & SB_BORN) &&
-	    !sb_rdonly(sb)) {
+	if (sb_is_alive(sb) && sb->s_bdev && !sb_rdonly(sb)) {
 		/*
 		 * What lock protects sb->s_flags??
 		 */
@@ -947,7 +960,7 @@ void emergency_remount(void)
 static void do_thaw_all_callback(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
-	if (sb->s_root && sb->s_flags & SB_BORN) {
+	if (sb_is_alive(sb)) {
 		emergency_thaw_bdev(sb);
 		thaw_super_locked(sb);
 	} else {
-- 
1.8.3.1



----------------------------------------
// autogenerated by syzkaller (http://github.com/google/syzkaller)

#define _GNU_SOURCE
#include <fcntl.h>
#include <linux/futex.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <sys/mount.h>
#include <signal.h>

struct thread_t {
	int created, running, call;
	pthread_t th;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
	struct thread_t* th = (struct thread_t*)arg;
	for (;;) {
		while (!__atomic_load_n(&th->running, __ATOMIC_ACQUIRE))
			syscall(SYS_futex, &th->running, FUTEX_WAIT, 0, 0);
		execute_call(th->call);
		__atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
		__atomic_store_n(&th->running, 0, __ATOMIC_RELEASE);
		syscall(SYS_futex, &th->running, FUTEX_WAKE);
	}
	return 0;
}

static void execute(int num_calls)
{
	int call, thread;
	running = 0;
	for (call = 0; call < num_calls; call++) {
		for (thread = 0; thread < sizeof(threads) / sizeof(threads[0]); thread++) {
			struct thread_t* th = &threads[thread];
			if (!th->created) {
				th->created = 1;
				pthread_attr_t attr;
				pthread_attr_init(&attr);
				pthread_attr_setstacksize(&attr, 128 << 10);
				pthread_create(&th->th, &attr, thr, th);
			}
			if (!__atomic_load_n(&th->running, __ATOMIC_ACQUIRE)) {
				th->call = call;
				__atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
				__atomic_store_n(&th->running, 1, __ATOMIC_RELEASE);
				syscall(SYS_futex, &th->running, FUTEX_WAKE);
				struct timespec ts;
				ts.tv_sec = 0;
				ts.tv_nsec = 20 * 1000 * 1000;
				syscall(SYS_futex, &th->running, FUTEX_WAIT, 1, &ts);
				if (__atomic_load_n(&running, __ATOMIC_RELAXED))
					usleep((call == num_calls - 1) ? 10000 : 1000);
				break;
			}
		}
	}
}

static void execute_call(int call)
{
	static int fd[2] = { EOF, EOF };
	static char buffer[128] = { };
	switch (call) {
	case 4:
		sync();
		break;
	case 6:
		if (pipe(fd) == EOF)
			kill(0, SIGKILL);
		break;
	case 7:
		mkdir("./file0", 0);
		break;
	case 8:
		snprintf(buffer, sizeof(buffer) - 1, "trans=fd,rfdno=0x%x,wfdno=0x%x,version=9p2000.u,", fd[0], fd[1]);
		mount(NULL, "./file0", "9p", 0, buffer);
		break;
	case 9:
		write(fd[1], "\x79\x04\x00\x00\x7d\x01\x00\x05\x00\x58\x00\x00\x00\x00\x00\x00"
		      "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
		      "\x00\x00\x00\x00\x00\x00\x00\x00\x23\x00\x00\x00\x00\x39\x00\x00"
		      "\x00\x00\x00\x10\x00\x76\x65\x72\x73\x69\x6f\x6e\x3d\x39\x70\x32"
		      "\x30\x30\x30\x2e\x75\x0d\x00\x77\x6c\x61\x6e\x31\x76\x62\x6f\x78"
		      "\x6e\x65\x74\x30\x03\x00\x39\x70\x00\x05\x00\x72\x66\x64\x6e\x6f"
		      "\x0c\x00\x76\x9a\xae\x6d\x5f\xff\xf0\x68\xa6\xbe\x6b\x2c\xc3\xfd"
		      "\x62\x6f\x78\x6e\x65\x74\x31\x28\x7d\x25\x24\x00\x00\x00\x00\x00"
		      "\x00\x00\x00\x00\x00\x00\x00", 135);
		break;
	}
}

int main(int argc, char *argv[])
{
	int procid;
	for (procid = 0; procid < 8; procid++)
		if (fork() == 0)
			while (1)
				execute(10);
	sleep(1000000);
	return 0;
}
----------------------------------------



By the way, iterate_supers_type() was introduced in v3.1 for fs/ubifs/debug.c

        /*
         * TODO: this is racy - the file-system might have already been
         * unmounted and we'd oops in this case. The plan is to fix it with
         * help of 'iterate_supers_type()' which we should have in v3.0: when
         * a debugfs opened, we rember FS's UUID in file->private_data. Then
         * whenever we access the FS via a debugfs file, we iterate all UBIFS
         * superblocks and fine the one with the same UUID, and take the
         * locking right.
         *
         * The other way to go suggested by Al Viro is to create a separate
         * 'ubifs-debug' file-system instead.
         */

but is still not called. Do we want to remove iterate_supers_type() ?
