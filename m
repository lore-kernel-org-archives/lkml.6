Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02462C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF9E20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF9E20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeFTKBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:01:42 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbeFTKBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:01:38 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MC1IG-1fMkE31NeS-008rUW; Wed, 20 Jun 2018 12:01:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] adfs: use timespec64 for time conversion
Date:   Wed, 20 Jun 2018 12:01:07 +0200
Message-Id: <20180620100133.4035614-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:TnexxAo5hjAMo7G2Vm6zeOeHtHvRti584NXnMeIunRoT9c+ilsQ
 jivjcIW2MFmhHn20JR5FYEu+W8HdgB5X3a0uyt2vDxXuSRgVQtX69LS6THHP23a99jwQC/9
 tWvDZxMrrAtS8TzsQQnxlRkc9ZF6skjr7oHqSQJ+NV97zW2QZgAsZi4NfQoh+BjWeAk1EU6
 jNBt45iphSXpworT3ICXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zAcjZA3xhwA=:2TzHoA+gfs8foOBPPYzuO1
 PzHd2RNVdgnrUAErp+WQyNyRzy0swMj0vWLMRwzi4PVxQjV1ITV2p2RG1L9ormQBzp+kbeU9w
 KIo2LbOIhqrA/PNDfxz5X8hjPobxFKMKEQoqIDp0lDZeDWYWfov6oC/k3OAIYQtTApdoiBQXO
 vl0bsSafXnyzjE8PaRN1UZCqu6hLuIeXfXfDOfTGTq4ihzC/aESphw5JDVVSEQzuJdYBWFKfe
 fLr4Ic+iNccWSekfpFfpVkrac5qE34LeRdBtqjorctLc4lZXX038l0dR4JDAA+9rXLDigoFr4
 d3aQCHxzybcVSwr8V8LM01heoRaQMP2HlAMoXue3PbCYfLt2VyprCMroNNnSy6Yh5ZYhzafSc
 VjJ1UeIs35gRAMn6CY8/SfsunnKA2X4DKKEhMQvldkoRzkRJURzPQOIAEk+0IRurEM8X2LBAI
 44TTRAPZ7KsDCub3zoL2WEudFv425kcr74TRdWU/PRAAVzhGThGL02DAizvKqBNQSYLTPKRP0
 RLvCBo+7uYJ5SlnBEV872DAwnwHYP13pFjGp0iIpj3qNyCuPlHHYGCTFZTCaOj7mrNGqC3uL4
 Q7E95cF+QVO1Adbo7syPiauZ18Yl5aX7ddUCIPFZLS3nyteqTUcJpSAskFsGJOW9+3kjtbavw
 XQFePAgm6WBqgdTOUXx9Y0YpqjCI3eR9trtQ8Jpc7UGlIYZ0+GBOcNVAtu0SuGbPhAus=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We just truncate the seconds to 32-bit in one place now, so this
can trivially be converted over to using timespec64 consistently.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/adfs/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index c836c425ca94..3f3c3b7ec82e 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -167,7 +167,7 @@ adfs_mode2atts(struct super_block *sb, struct inode *inode)
  * of time to convert from RISC OS epoch to Unix epoch.
  */
 static void
-adfs_adfs2unix_time(struct timespec *tv, struct inode *inode)
+adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
 {
 	unsigned int high, low;
 	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
@@ -195,11 +195,11 @@ adfs_adfs2unix_time(struct timespec *tv, struct inode *inode)
 	/* convert from RISC OS to Unix epoch */
 	nsec -= nsec_unix_epoch_diff_risc_os_epoch;
 
-	*tv = ns_to_timespec(nsec);
+	*tv = ns_to_timespec64(nsec);
 	return;
 
  cur_time:
-	*tv = timespec64_to_timespec(current_time(inode));
+	*tv = current_time(inode);
 	return;
 
  too_early:
@@ -242,7 +242,6 @@ adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
 struct inode *
 adfs_iget(struct super_block *sb, struct object_info *obj)
 {
-	struct timespec ts;
 	struct inode *inode;
 
 	inode = new_inode(sb);
@@ -271,9 +270,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 	ADFS_I(inode)->stamped   = ((obj->loadaddr & 0xfff00000) == 0xfff00000);
 
 	inode->i_mode	 = adfs_atts2mode(sb, inode);
-	ts = timespec64_to_timespec(inode->i_mtime);
-	adfs_adfs2unix_time(&ts, inode);
-	inode->i_mtime = timespec_to_timespec64(ts);
+	adfs_adfs2unix_time(&inode->i_mtime, inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
 
-- 
2.9.0

