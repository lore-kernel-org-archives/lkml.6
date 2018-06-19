Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19BB20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19BB20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966878AbeFSP7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:59:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36113 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966823AbeFSP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:59:33 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MYHJs-1fiYa5275k-00UncD; Tue, 19 Jun 2018 17:58:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gang He <ghe@suse.com>, Alex Chen <alex.chen@huawei.com>,
        piaojun <piaojun@huawei.com>, Eric Ren <zren@suse.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Larry Chen <lchen@suse.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: dlmglue: clean up timestamp handling
Date:   Tue, 19 Jun 2018 17:58:07 +0200
Message-Id: <20180619155826.4106487-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:YL6FV2+7bJSirRzfNYFrms3DDgm0QuOHraNIKTwM7HMd+NM5tiF
 c4elAoqV/CVGw9wmGn9ukWT7czTRn1jKLbYdwuNOyUm/vv3odV10sEvUBhiEJO84qUNh4t+
 bd3pSiYWWvCTdbsF0JCNZ+WxRJyPBQ6csv6W4Al+0LGM/zNEwF7+xByB0cY+FNlQGlxh/F2
 gQ8z4WkCJfJl80neBAEVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:79ql++emtRY=:3owj7DTM2xXRxcTD25GD1l
 GaKhcWDoZXw8w4pUqMGGLswRROwwqwltyfwtKOVLYD1Qa5dFSbD4VdPOqasveL+gvNzZyh9x5
 d5fSb/iTn6d3iHVj/iQ88gtCc9lL41b7ATnkoj3di12J4KZMPoULIcWSQ7NxR39aKdrffpEzI
 ZXpM3YSR+R6pVRgxu3WxKIy8NbU/hPH0zuQOYveHZxpos7RjCAPqaOrk28CADP6ufq/TOSqbE
 osWdH2gdxrksbMv0myPRVxIyJqe2tiDWcwQaU7k5U25WSS+0dZHOeAy7AD73EwS4pMKN3mpu4
 s07tis92H9wPAYLOFbd2zgnrTKZ/Jk4GbDoWdGhVRRLM1PvH8d9gs7wc8h2Na93nAM2TVJQOg
 8szvleGKMRwcOdUlSx9LytwWXmS8qO/Q1d9E6BrNWLNejKsJO1dOSvPtbKel0G+UybRsAKxdW
 pIsB9pnh3YECdeSQSTBqGEloI4JDD205rosgBHO3jijWYN+QF4xM6PY/E5dFkEG3Micy9v6f5
 CopEnjjRQ3ZBNThuI7OScJEnET7UErHWJBZfJ93K+/rAfKt4Y6MEdyru0vAOaVkLTSaCoaxKJ
 b71NqK9CSnmMeRfL//OmgFRjITLT+wPnEZrNWO+qxT8A0X9F9B8W6hvd6jiu0nEvb8kCPxa1A
 HvTQ7aoPypzYBgUM1JxlfIyfZJoHC0DsAjgCcI0GPUdJG3V+lDoWdlTJPuEEuOK92zuA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of timestamps outside of the 1970..2038 range in the dlm
glue is rather inconsistent: on 32-bit architectures, this has always
wrapped around to negative timestamps in the 1902..1969 range, while on
64-bit kernels all timestamps are interpreted as positive 34 bit numbers
in the 1970..2514 year range.

Now that the VFS code handles 64-bit timestamps on all architectures,
we can make the behavior more consistent here, and return the same result
that we had on 64-bit already, making the file system y2038 safe in the
process. Outside of dlmglue, it already uses 64-bit on-disk timestamps
anway, so that part is fine.

For consistency, I'm changing ocfs2_pack_timespec() to clamp
anything outside of the supported range to the minimum and maximum
values. This avoids a possible ambiguity of values before 1970
in particular, which used to be interpreted as times at the end of the
2514 range previously.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ocfs2/dlmglue.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 0ff424c6d17c..50610a9ed9f4 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2121,10 +2121,10 @@ static void ocfs2_downconvert_on_unlock(struct ocfs2_super *osb,
 
 /* LVB only has room for 64 bits of time here so we pack it for
  * now. */
-static u64 ocfs2_pack_timespec(struct timespec *spec)
+static u64 ocfs2_pack_timespec(struct timespec64 *spec)
 {
 	u64 res;
-	u64 sec = spec->tv_sec;
+	u64 sec = clamp_t(time64_t, spec->tv_sec, 0, 0x3ffffffffull);
 	u32 nsec = spec->tv_nsec;
 
 	res = (sec << OCFS2_SEC_SHIFT) | (nsec & OCFS2_NSEC_MASK);
@@ -2140,7 +2140,6 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_meta_lvb *lvb;
-	struct timespec ts;
 
 	lvb = ocfs2_dlm_lvb(&lockres->l_lksb);
 
@@ -2161,15 +2160,12 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	lvb->lvb_igid      = cpu_to_be32(i_gid_read(inode));
 	lvb->lvb_imode     = cpu_to_be16(inode->i_mode);
 	lvb->lvb_inlink    = cpu_to_be16(inode->i_nlink);
-	ts = timespec64_to_timespec(inode->i_atime);
 	lvb->lvb_iatime_packed  =
-		cpu_to_be64(ocfs2_pack_timespec(&ts));
-	ts = timespec64_to_timespec(inode->i_ctime);
+		cpu_to_be64(ocfs2_pack_timespec(&inode->i_atime));
 	lvb->lvb_ictime_packed =
-		cpu_to_be64(ocfs2_pack_timespec(&ts));
-	ts = timespec64_to_timespec(inode->i_mtime);
+		cpu_to_be64(ocfs2_pack_timespec(&inode->i_ctime));
 	lvb->lvb_imtime_packed =
-		cpu_to_be64(ocfs2_pack_timespec(&ts));
+		cpu_to_be64(ocfs2_pack_timespec(&inode->i_mtime));
 	lvb->lvb_iattr    = cpu_to_be32(oi->ip_attr);
 	lvb->lvb_idynfeatures = cpu_to_be16(oi->ip_dyn_features);
 	lvb->lvb_igeneration = cpu_to_be32(inode->i_generation);
@@ -2178,7 +2174,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	mlog_meta_lvb(0, lockres);
 }
 
-static void ocfs2_unpack_timespec(struct timespec *spec,
+static void ocfs2_unpack_timespec(struct timespec64 *spec,
 				  u64 packed_time)
 {
 	spec->tv_sec = packed_time >> OCFS2_SEC_SHIFT;
@@ -2187,7 +2183,6 @@ static void ocfs2_unpack_timespec(struct timespec *spec,
 
 static void ocfs2_refresh_inode_from_lvb(struct inode *inode)
 {
-	struct timespec ts;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_meta_lvb *lvb;
@@ -2215,15 +2210,12 @@ static void ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	i_gid_write(inode, be32_to_cpu(lvb->lvb_igid));
 	inode->i_mode    = be16_to_cpu(lvb->lvb_imode);
 	set_nlink(inode, be16_to_cpu(lvb->lvb_inlink));
-	ocfs2_unpack_timespec(&ts,
+	ocfs2_unpack_timespec(&inode->i_atime,
 			      be64_to_cpu(lvb->lvb_iatime_packed));
-	inode->i_atime = timespec_to_timespec64(ts);
-	ocfs2_unpack_timespec(&ts,
+	ocfs2_unpack_timespec(&inode->i_mtime,
 			      be64_to_cpu(lvb->lvb_imtime_packed));
-	inode->i_mtime = timespec_to_timespec64(ts);
-	ocfs2_unpack_timespec(&ts,
+	ocfs2_unpack_timespec(&inode->i_ctime,
 			      be64_to_cpu(lvb->lvb_ictime_packed));
-	inode->i_ctime = timespec_to_timespec64(ts);
 	spin_unlock(&oi->ip_lock);
 }
 
-- 
2.9.0

