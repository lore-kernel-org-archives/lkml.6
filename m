Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031205AbeBNPQW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:16:22 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:53330 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030922AbeBNPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:16:21 -0500
From: Richard Weinberger <richard@sigma-star.at>
To: Enrico Weigelt <lkml@metux.net>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Date: Wed, 14 Feb 2018 16:17:35 +0100
Message-ID: <60748622.exvCVAzLTp@blindfold>
In-Reply-To: <4f620eb7-c00c-487b-2e06-8cc4c97af38c@metux.net>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net> <2050418.Dl5pXkWGsk@blindfold> <4f620eb7-c00c-487b-2e06-8cc4c97af38c@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico,

Am Mittwoch, 14. Februar 2018, 16:02:18 CET schrieb Enrico Weigelt:
> stat64("/etc/busybox.conf", {st_mode=S_IFREG|0644, st_size=198, ...}) = 0

busybox...

> brk(NULL)                               = 0x58000
> brk(0x79000)                            = 0x79000
> open("/etc/busybox.conf", O_RDONLY|O_LARGEFILE) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=198, ...}) = 0
> read(3, "[SUID]\n#lines starting with # ar"..., 1024) = 198
> read(3, "", 1024)                       = 0
> close(3)                                = 0
> getgid32()                              = 1
> setgid32(1)                             = 0
> setuid32(1)                             = 0
> geteuid32()                             = 1
> getegid32()                             = 1
> unshare(CLONE_NEWUTS|CLONE_NEWUSER)     = 0
> open("/proc/self/setgroups", O_WRONLY|O_LARGEFILE) = 3
> write(3, "deny", 4)                     = 4
> close(3)                                = 0
> open("/proc/self/uid_map", O_WRONLY|O_LARGEFILE) = 3
> write(3, "1 0 1", 5)                    = -1 EPERM (Operation not permitted)

This mapping looks broken.
Please report to busybox folks.

>From taking a *very* quick look into busybox source, I suspect this should fix 
it:

diff --git a/util-linux/unshare.c b/util-linux/unshare.c
index 875e3f86e304..3f59cf4d27c2 100644
--- a/util-linux/unshare.c
+++ b/util-linux/unshare.c
@@ -350,9 +350,9 @@ int unshare_main(int argc UNUSED_PARAM, char **argv)
 		 * in that user namespace.
 		 */
 		xopen_xwrite_close(PATH_PROC_SETGROUPS, "deny");
-		sprintf(uidmap_buf, "%u 0 1", (unsigned)reuid);
+		sprintf(uidmap_buf, "0 %u 1", (unsigned)reuid);
 		xopen_xwrite_close(PATH_PROC_UIDMAP, uidmap_buf);
-		sprintf(uidmap_buf, "%u 0 1", (unsigned)regid);
+		sprintf(uidmap_buf, "0 %u 1", (unsigned)regid);
 		xopen_xwrite_close(PATH_PROC_GIDMAP, uidmap_buf);
 	} else
 	if (setgrp_str) {

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
