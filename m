Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD7C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00B52150F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsCOKB5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00B52150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJTTQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:16:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37280 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbeJTTQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:16:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1-v6so7048616wrs.4;
        Sat, 20 Oct 2018 04:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=IJAJJiwFNvjj7bORW7gZyS33/oB/J4FSdi44ZVhV1fg=;
        b=YsCOKB5X020jbobMa6Av0djDnIQbg50dRwijNf8rJlekJztx4pjRuc0nu/a1P8NhFr
         f/9jJXtbAm18YlVsHA7TOD7kSLYxa3+lGXnZjSou8jK13DcynlWnETjoGUeu9KN8/IPh
         RRVSHMJqaOTMkoqsix7V/s6l8D0fsBmrA5XlPaJukQQsmjoNCWRFav7b+JunNtz+ogML
         FJoV8J6K8Ynv6IQM4USwri+ahbHEfOMUTlBtCGPztKavo16Kc4/tdih+xZ3Omkwz2YEG
         H4P1NC1s6b15u6hRYOMvugxR+a3crDViPOtUu0ynHpHKGcmmFjt4Z8tjyIJkJ9eaAmZT
         f+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=IJAJJiwFNvjj7bORW7gZyS33/oB/J4FSdi44ZVhV1fg=;
        b=qyy6SCgdBM97RgYbF7UT7dH2T9aH9Zz1xoqpoDu4PRNxPptp8zoPZKewR/lAtqeu9D
         ddwzAF/XPViBdYhhZNpp0af3k6svr6evSehr6hwyGDKMr+iu7gFRdysSzazYKvypLMSI
         scCxuQjQjlTCXnFGD1NhijlY8oufNkG0Nc2sEPc0nf+nSdl9qspirWWZHCYNjFkhRTUo
         ifLCAdwtqYSH0dB3vnBEKctUXA7pzxi0f/xbOVkbP0ydBRKc2MEF6f3Kb/PeBm7bonQt
         +UnN165Zg60MnMFKq058gSV/cyldwg/+3PBJpkh27mGEQzv5AGkJvrVWytXDA3AraeRi
         2mwQ==
X-Gm-Message-State: ABuFfojnV1iBltLFUufCmP7gOjNlvmRsAHUUi6rt445LBAskUAD7ivcy
        dkOpFctjD9Ys98WsrgqI1Vo=
X-Google-Smtp-Source: ACcGV600KUCp3Wo538g7P1+knJQcuE6luf/LvtCZEKfoxxv/sHRZtdMR71XifxNfKjFz3yzPvGS42Q==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr36647480wrx.215.1540033594683;
        Sat, 20 Oct 2018 04:06:34 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id 77-v6sm10925074wmv.6.2018.10.20.04.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 04:06:33 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <97872123-70be-2833-ea7a-a463ce204b53@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <6518.1539956277@warthog.procyon.org.uk>
 <29902.1539988579@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <209e8c35-d26e-0a29-84d7-b8b1d0ecbebc@gmail.com>
Date:   Sat, 20 Oct 2018 12:06:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <29902.1539988579@warthog.procyon.org.uk>
Content-Type: multipart/mixed;
 boundary="------------2713B31BBB6A8610EA3C1D98"
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2713B31BBB6A8610EA3C1D98
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/10/2018 23:36, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> # open_tree_clone 3</mnt 3 sh
>> # cd /proc/self/fd/3
>> # mount --move . /mnt
>> [   41.747831] mnt_flags=1020 umount=0
>> # cd /
>> # umount /mnt
>> umount: /mnt: target is busy
>>
>> ^ a newly introduced bug? I do not remember having this problem before.
> The reason EBUSY is returned is because propagate_mount_busy() is called by
> do_umount() with refcnt == 2, but mnt_count == 3:
>
>            umount-3577  M=f8898a34 u=3 0x555 sp=__x64_sys_umount+0x12/0x15
>
> the trace line being added here:
>
> 		if (!propagate_mount_busy(mnt, 2)) {
> 			if (!list_empty(&mnt->mnt_list))
> 				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
> 			retval = 0;
> 		} else {
> 			trace_mnt_count(mnt, mnt->mnt_id,
> 					atomic_read(&mnt->mnt_count),
> 					0x555, __builtin_return_address(0));
> 		}
>
> The busy evaluation is a result of this check:
>
> 	if (!list_empty(&mnt->mnt_mounts) || do_refcount_check(mnt, refcnt))
>
> in propagate_mount_busy().
>
>
> The problem apparently being that mnt_count counts both refs from mountings
> and refs from other sources, such as file descriptors or pathwalk.
>
> David

Sorry for wasting your time on the EBUSY.  The EBUSY error is not new, 
it is correct, and I was doing the wrong thing.  I cannot "umount /mnt" 
if I still have an FD which points inside /mnt.

I was trying to provide a nice clearer overview, but it was still too 
sloppy to understand.  I've written a second attempt to rephrase it (and 
remove my mistake about EBUSY).  This all seems consistent with what Al 
just said, so if you got the picture from Al's message, you can ignore 
this one :-).

~

The patch series [ver #12] has a problem.  OPEN_TREE_CLONE creates an 
open file, marked with FMODE_NEED_UNMOUNT for cleanup. Users are 
expected to move_mount() directly from that file.

However, it is also possible to use openat() on the open file, which 
gives you a second open file.  This raises questions about the cleanup 
handling.  The second open file is *not* marked FMODE_NEED_UNMOUNT.  
What happens if we clean up the first open file and then move_mount() 
from the second one?  And what happens if you consume the second open 
file using move_mount(), and then cleanup up the first open file?

When I test the patch series [ver #12], it seems I can trigger the same 
bug for either case.  The two reproducers use the same commands, but in 
a different order.

"close-then-mount"

# open_tree_clone 3</mnt 3 sh
# cd /proc/self/fd/3
# exec 3<&-  # close FD 3
# mount --move . /mnt && cd /
# umount -l /mnt
watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [umount:1472]
...
RIP: 0010:pin_kill+0x128/0x140
...
  Call Trace:
  pin_kill+0x5a/0x140
  ? finish_wait+0x80/0x80
  group_pin_kill+0x1a/0x30
  namespace_unlock+0x6f/0x80
  ksys_umount+0x220/0x420
  __x64_sys_umount+0x12/0x20
  do_syscall_64+0x5b/0x160
  entry_SYSCALL_64_after_hwframe+0x44/0xa9


"mount-then-close"

# open_tree_clone 3</mnt 3 sh
# cd /proc/self/fd/3
# mount --move . /mnt && cd /
# umount -l /mnt
# exec 3<&-  # close FD 3
watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [sh:1423]
...
RIP: 0010:pin_kill+0x128/0x140
...
Call Trace:
  ? finish_wait+0x80/0x80
  group_pin_kill+0x1a/0x30
  namespace_unlock+0x6f/0x80
  __fput+0x239/0x240
  task_work_run+0x84/0xa0
  exit_to_usermode_loop+0xb4/0xc0
  do_syscall_64+0x14d/0x160
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

When I debug the kernel and reproduce "close-then-mount", I can see 
something is wrong even before the last command.  The mount command 
attaches a mount into the mount namespace which is still marked as 
MNT_UMOUNT.  This contradicts a comment in the predicate function, 
disconnect_mount():

	/* Because the reference counting rules change when mounts are
* unmounted and connected, umounted mounts may not be
* connected to mounted mounts.
*/
	if  (!(mnt 
<https://elixir.bootlin.com/linux/latest/ident/mnt>->mnt_parent->mnt 
<https://elixir.bootlin.com/linux/latest/ident/mnt>.mnt_flags  &  MNT_UMOUNT <https://elixir.bootlin.com/linux/latest/ident/MNT_UMOUNT>))
		return  true;

We could ask if there is a procedure to safely clear MNT_UMOUNT on a 
detached tree, but we don't have a specific reason to. You suggested a 
one-line diff, to deny the problematic mount command in "close-then-mount".

@@ -2469,7 +2469,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
      if (old->mnt_ns && !attached)
          goto out1;
  
-    if (old->mnt.mnt_flags & MNT_LOCKED)
+    if (old->mnt.mnt_flags & (MNT_LOCKED | MNT_UMOUNT))
          goto out1;
  
      if (old_path->dentry != old_path->mnt->mnt_root)

It sounds plausible, and it worked as suggested.  But it feels 
incomplete.  If my two reproducer sequences are really symmetric, we 
need to fix the code path in move_mount() *and* the code path in 
close().  I asked if we can add this on top:

@@ -1763,7 +1763,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
  {
      namespace_lock();
      lock_mount_hash();
-    if (!real_mount(mnt)->mnt_ns) {
+    if (!real_mount(mnt)->mnt_ns && !(mnt->mnt_flags & MNT_UMOUNT)) {
          mntget(mnt);
          umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
      }

(To apply without whitespace damage, see the attachment).  I tested now 
and this seems to allow "mount-then-close"; there is no immediate 
softlockup or error message.

You mentioned when you tested, you can get a GPF in fsnotify instead, 
depending on the timing of the commands.  I have been entering my 
commands one at a time, and I have not seen the GPF so far.

You posted an analysis of a GPF, where you showed the reference count 
was clearly one less than it should have been.  You narrowed this down 
to a step where you connected an unmounted mount (MNT_UMOUNT) to a 
mounted mount.  So your analysis is consistent with the comment in 
disconnect_mount(), which says 1) you're not allowed to do that, 2) the 
reason is because of different reference-counting rules.  AFAICT, the 
GPF you analyzed would be prevented by the fix in do_move_mount(), 
checking for MNT_UMOUNT.

I have been trying to understand MNT_UMOUNT by reading the patch series 
that added it.  Now I'm getting the impression the different 
ref-counting rules pre-date MNT_UMOUNT.  I *think* the added check in 
dissolve_on_fput() makes things right, but I don't understand enough to 
be sure.

Alan


--------------2713B31BBB6A8610EA3C1D98
Content-Type: text/x-patch;
 name="MNT_UMOUNT.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="MNT_UMOUNT.diff"

diff --git a/fs/namespace.c b/fs/namespace.c
index 4dfe7e23b7ee..e8d61d5f581d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1763,7 +1763,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 {
 	namespace_lock();
 	lock_mount_hash();
-	if (!real_mount(mnt)->mnt_ns) {
+	if (!real_mount(mnt)->mnt_ns && !(mnt->mnt_flags & MNT_UMOUNT)) {
 		mntget(mnt);
 		umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
 	}
@@ -2469,7 +2469,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	if (old->mnt_ns && !attached)
 		goto out1;
 
-	if (old->mnt.mnt_flags & MNT_LOCKED)
+	if (old->mnt.mnt_flags & (MNT_LOCKED | MNT_UMOUNT))
 		goto out1;
 
 	if (old_path->dentry != old_path->mnt->mnt_root)

--------------2713B31BBB6A8610EA3C1D98--
