Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A2C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C367021019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kORl+iX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAWXLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:11:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33888 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfAWXLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:11:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so1936850plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ghci5RYyJTurBJRPd2W1R8y3G9RVvh1VuxBKSrcz5ZM=;
        b=kORl+iX11XpoVDVqRUIFpgMCY7LhJuTXaMPFNmZIF0HVIpsYVEwF+POju8UXdeHL8A
         dKV5/HETevemyopSVRCnPFPtYJzQqI3hlGVHOGVwKx2lDVhLEoermqZodaziUKkFfRAK
         ruLQXfp6W6x3Gl3bpCHS2pTIBgzH2Bk7+h2F15baR5o76fHlhV7EKHRM3Z3Csb4D92Q3
         WV1IaYd7X9Vs+299YnRBTXlsakmqi4pNgkN1xbwdhCDXSYqyRc8AtmJmYylr2NY0V1NR
         DHHcbuAntzZIVNEhr+StSseoITWQRm6pSDmQjOov6go07DrkNZVJwoJO/sSbS+EfcQVw
         viZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ghci5RYyJTurBJRPd2W1R8y3G9RVvh1VuxBKSrcz5ZM=;
        b=JBjrDwcTguwujVSypX3hrfh2yuZjLok0reKgJ8DvW2IXMXM3PeOGQPC07xCToGpX01
         HMnggFTLalQEvrIJH+wdQSJqLHQgoo5FW62ekuRxEJJXWEbV3SaaOWSr3GPJXBg3f0go
         jBBWai709TwqunbfOJXhQ/ZJT4Luo6CkYWSIcql1glmkgwS8E8S+269EoDS8VUDaf5t8
         A+6F/3lnvLEiSc91WYisM4rE1w3gI5asx5hC1muaAhA8KqjyXNUx3TJmKYwQqPjVo1wk
         ONgB0qE5H5iNQIxB8zW5ykkSjq+9knzqEzpsXV0qSuP15KTLOkWk1qtbYDOhA85rdB0F
         qJBg==
X-Gm-Message-State: AJcUukeWfa9F9p+G3vavKeLT8ZlL8t6FDQSwxRviDwZY4e591Np8O6Nd
        qiO3AUJkk4ZcxLpnfuHWcox+FCT5ZVOy3g==
X-Google-Smtp-Source: ALg8bN7SMtr0+jb7vNKejJQL793zmjCWvlgsWyQWkjmQ5ZGgeYDOVoFtzTGoO/PuRqZbUb5/l412Pw==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr4270996plr.89.1548285059224;
        Wed, 23 Jan 2019 15:10:59 -0800 (PST)
Received: from localhost ([2620:15c:2c3:fd00:55c3:110d:bbc8:eaa8])
        by smtp.gmail.com with ESMTPSA id q1sm27597695pfb.96.2019.01.23.15.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 15:10:58 -0800 (PST)
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@elte.hu, ak@linux.intel.com, kan.liang@intel.com
Subject: [PATCH] perf tools api fs: make xxx__mountpoint() more scalable
Date:   Wed, 23 Jan 2019 15:10:47 -0800
Message-Id: <1548285047-5808-1-git-send-email-eranian@google.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xxx_mountpoint() interface provided by fs.c finds
mount points for common pseudo filesystems. The first
time xxx_mountpoint() is invoked, it scans the mount
table (/proc/mounts) looking for a match. If found, it
is cached. The price to scan /proc/mounts is paid once
if the mount is found.

When the mount point is not found, subsequent calls to
xxx_mountpoint() scan /proc/mounts over and over again.
There is no cacheing.

This causes a scaling issue in perf record with hugeltbfs__mountpoint().
The function is called for each process found in synthesize__mmap_events().
If the machine has thousands of processes and if the /proc/mounts has many
entries this could cause major overhead in perf record. We have observed
multi-second slowdowns on some configurations.

As an example on a laptop:

Before:
$ sudo umount /dev/hugepages
$ strace -etrace=open -o /tmp/tt perf record -a ls
$ fgrep mounts /tmp/tt
285

After:
$ sudo umount /dev/hugepages
$ strace -etrace=open -o /tmp/tt perf record -a ls
$ fgrep mounts /tmp/tt
1

One could argue that the non-cacheing in case the moint point is not found
is intentional. That way subsequent calls may discover a moint point if
the syadmin mounts the filesystem. But the same argument could be made
against cacheing the moint point. It could be unmounted causing errors.
It all depends on the intent of the interface. This patch assumes it
is expected to scan /proc/mounts once. The patch documents the cacheing
behavior in the fs.h header file.

An alternative would be to just fix perf record. But it would solve
the problem with hugetlbs__mountpoint() but there could be similar
issues (possibly down the line) with other xxx_mountpoint() calls
in perf or other tools.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/lib/api/fs/fs.c | 19 +++++++++++++++++++
 tools/lib/api/fs/fs.h | 11 +++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 7aba8243a0e7..6934da54c96b 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -90,6 +90,7 @@ struct fs {
 	const char * const	*mounts;
 	char			 path[PATH_MAX];
 	bool			 found;
+	bool			 checked;
 	long			 magic;
 };
 
@@ -111,31 +112,37 @@ static struct fs fs__entries[] = {
 		.name	= "sysfs",
 		.mounts	= sysfs__fs_known_mountpoints,
 		.magic	= SYSFS_MAGIC,
+		.checked= false,
 	},
 	[FS__PROCFS] = {
 		.name	= "proc",
 		.mounts	= procfs__known_mountpoints,
 		.magic	= PROC_SUPER_MAGIC,
+		.checked= false,
 	},
 	[FS__DEBUGFS] = {
 		.name	= "debugfs",
 		.mounts	= debugfs__known_mountpoints,
 		.magic	= DEBUGFS_MAGIC,
+		.checked= false,
 	},
 	[FS__TRACEFS] = {
 		.name	= "tracefs",
 		.mounts	= tracefs__known_mountpoints,
 		.magic	= TRACEFS_MAGIC,
+		.checked= false,
 	},
 	[FS__HUGETLBFS] = {
 		.name	= "hugetlbfs",
 		.mounts = hugetlbfs__known_mountpoints,
 		.magic	= HUGETLBFS_MAGIC,
+		.checked= false,
 	},
 	[FS__BPF_FS] = {
 		.name	= "bpf",
 		.mounts = bpf_fs__known_mountpoints,
 		.magic	= BPF_FS_MAGIC,
+		.checked= false,
 	},
 };
 
@@ -158,6 +165,7 @@ static bool fs__read_mounts(struct fs *fs)
 	}
 
 	fclose(fp);
+	fs->checked = true;
 	return fs->found = found;
 }
 
@@ -219,6 +227,7 @@ static bool fs__env_override(struct fs *fs)
 		return false;
 
 	fs->found = true;
+	fs->checked = true;
 	strncpy(fs->path, override_path, sizeof(fs->path));
 	return true;
 }
@@ -244,6 +253,16 @@ static const char *fs__mountpoint(int idx)
 	if (fs->found)
 		return (const char *)fs->path;
 
+	/* the mount point was already checked for the mount point
+	 * but and did not exist, so return NULL to avoid scanning again.
+	 * This makes the found and not found paths cost equivalent
+	 * in case of multiple calls. This was not the case before
+	 * and could cause significant scaling issues with callers.
+	 * in case /proc/mounts need to be checked many times
+	 */
+	if (fs->checked)
+		return NULL;
+
 	return fs__get_mountpoint(fs);
 }
 
diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
index 92d03b8396b1..00a5127b00e8 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -18,6 +18,17 @@
 	const char *name##__mount(void);	\
 	bool name##__configured(void);		\
 
+/*
+ * The xxxx__mountpoint() entry points find the first match mount point for each
+ * filesystems listed below, where xxxx is the filesystem type.
+ *
+ * The interface is as follows:
+ * - If a mount point is found on first call, it is cached and used for all subsequent
+ *   calls.
+ *
+ * - If a mount point is not found, NULL is returned on first call and all
+ *   subsequent calls.
+ */
 FS(sysfs)
 FS(procfs)
 FS(debugfs)
-- 
2.7.4

