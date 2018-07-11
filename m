Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59A1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78198208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78198208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbeGKJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:18:18 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeGKJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:18:14 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M0Qv7-1fvOTt2wnN-00ubJL; Wed, 11 Jul 2018 11:14:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     adilger.kernel@dilger.ca
Cc:     arnd@arndb.de, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com, tytso@mit.edu,
        y2038@lists.linaro.org
Subject: [PATCH v2 1/6] ext4: sysfs: print ext4_super_block fields as little-endian
Date:   Wed, 11 Jul 2018 11:14:09 +0200
Message-Id: <20180711091414.1494843-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:k96ja8uKs2cKCxeGGBOC7DdqQntq9kxxFt1GvibNWAjl6FnyhOc
 oGHbX9U/lTfzNyLSYeEqIh8QMmHpWFCDN0fMQod7i990D13JxOiVNwE09hYFzGLsF9Sej8a
 amVEi7x1dqyLMdUtaRmea0LhEkI/q88GpUwpIlIvICnvTd6Skkf1BJwhz70QyjJZ1YdmYdv
 z65cQ82y5Ltecb5vKHzhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XB78hOjXeho=:VUFx62ifQMg9bF/Ofbfhut
 OS3T9wkUGtA3dTe65iJ3NRV9He4Z6QJb+u4uYT/tGBtshquIjKGXQbaZQjUKVz2wUXdFNR8L/
 0sNOA5nE8UNybHFG+U7svmR3SaPYNoyNYoS4X4QbJTN1YB9E2DpQpafEWaZlBnvjRjMF4V607
 UsQuozQcnT3qTHJWAK74bf+2TBZYjudvwKs+091+36bebY+dG3mflqUue1dVrtm/hK5RWYAQJ
 4Vry5oNXC0Ir+DekBxHvzWZFX1ozOxABKUKw6T6p6vWO3nHj4yKgtTpRgJjxPR2o1iQFKE4+S
 rjUnkp7kDDrH7ypPZOEhoohy6Rrydg21t5YMGaea64u3Ic6cOKCWnBY49Iu0DHENoIUU371Gz
 nm5b/y+E0r3WP47H/FlKG31YkwZFzzCHDR8wsWXHd6973rWgJ7eOaNtae8pKZlRmcv3BbFB/M
 4DSlChT/z3R/qjdqdLhveO6F8UuBZRsBxqMuDuz0aeE5hlvJaMmFPIgVRtjA1To+Y3Z972fw5
 UNgkHJM4h98ksf4sfT1j34ugITRrmifc0bsMeIhAyAhKfYoJgHKJaLEjuln+L6zP5RsW1zqJe
 cEGbwoPveN4YX6I8J3SQXurVZj3WnkvOYeAZ0BpwAnNPzChLOF+7wKR68OpeRAUTRlwqN3/Pt
 sYGFJCmfwvWkhzuCayQOur+XqnuCk4LBrlHz5jQm4zNkX7kzlyG/Yl+MAAJc/yVeSn04=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on extended rand for last_error/first_error timestamps,
I noticed that the endianess is wrong, we access the little-endian
fields in struct ext4_super_block as native-endian when we print them.

This adds a special case in ext4_attr_show() and ext4_attr_store()
to byteswap the superblock fields if needed.

In older kernels, this code was part of super.c, it got moved to sysfs.c
in linux-4.4.

Cc: stable@vger.kernel.org
Fixes: 52c198c6820f ("ext4: add sysfs entry showing whether the fs contains errors")
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index f34da0bb8f17..b970a200f20c 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -274,8 +274,12 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 	case attr_pointer_ui:
 		if (!ptr)
 			return 0;
-		return snprintf(buf, PAGE_SIZE, "%u\n",
-				*((unsigned int *) ptr));
+		if (a->attr_ptr == ptr_ext4_super_block_offset)
+			return snprintf(buf, PAGE_SIZE, "%u\n",
+					le32_to_cpup(ptr));
+		else
+			return snprintf(buf, PAGE_SIZE, "%u\n",
+					*((unsigned int *) ptr));
 	case attr_pointer_atomic:
 		if (!ptr)
 			return 0;
@@ -308,7 +312,10 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 		ret = kstrtoul(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
-		*((unsigned int *) ptr) = t;
+		if (a->attr_ptr == ptr_ext4_super_block_offset)
+			*((__le32 *) ptr) = cpu_to_le32(t);
+		else
+			*((unsigned int *) ptr) = t;
 		return len;
 	case attr_inode_readahead:
 		return inode_readahead_blks_store(sbi, buf, len);
-- 
2.9.0

