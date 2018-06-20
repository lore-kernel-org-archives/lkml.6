Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2990FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E302A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E302A20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeFTPeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:34:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753938AbeFTPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:34:12 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LscDB-1gBm9K477x-012Gb0; Wed, 20 Jun 2018 17:33:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>
Cc:     y2038@lists.linaro.org, linux-ext4@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Tyson Nottingham <tgnottingham@gmail.com>,
        Riccardo Schirone <sirmy15@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ext4: sysfs: print ext4_super_block fields as little-endian
Date:   Wed, 20 Jun 2018 17:32:58 +0200
Message-Id: <20180620153322.54221-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:VkaJ/Z/IFyPmmUhGam8Uo0ZjIddzhfasuzSoRXgb5ck7jeePMGP
 cPe0Cer7D4lQe0ATfH2R+BlufNPhJYBHWT5rJ2ssZNspITM7/Mo3mGmQzzDwaF/FuVKGMDO
 2wX5LkUhd4mBEzKGir+hm5M9XnnOaJVLEglf24SOtC8+L/DaRR9wok5sSDx4Vd6pJUIFpZ5
 g5oR50P2YDIcMExtXAniw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3djHRb4JBDA=:TaGLgNG07MzmDY/TEQwZ7D
 YkOiSeaGOyno27Vfc03eESxrIIzO1TrCLdHcAJK1KEBPhk644SYDG/kKlVkwl0ABOCi8fdKO8
 R0V1+KA+vHrMhylHKECjwXO8FE+dfXS1XVzZDEgYZOJAV2+wG6m9McdYUNl1Yo8nLu0mIt46s
 UnQzBXZ2Oe8/e1xuMaGm2pbHT02iXoa3qVu/18VNrJf7nSGEt+3QzGd8c+Y/FnAUmOT/UYin/
 iB7t9G2X9LNIypCmXBkf3VeZBOjaZtx9Uzg6uquVTir1p57jHauCKgTLY5DJkgtLer0Z9u12A
 +ODeP/zSGM09s8OlObMqKhhgWVrfA2DtU0F6vky8+1nF38siHpJd+umpmF63vRY1MiXyl82Vj
 50Ks9stakws3h+cGCDwZeRKjpMkGJHSKWAfFigVVkDz8f+QE3kKBjHZSFkK0rNP75vheHEsJ0
 d+nG1Hf0Ln/+U4A1FqBJCsixu3q5LCVWQRR39v359cRwxYX72JcAVnL6A8hDvuNU8P2kzGuot
 3wsHT92WG57ACUdN/Og8dAnZDvV9OzT1yO4dm930SfEEEUg1k9j0anQzfwd2vWIBiNxplFWHi
 F6UQNz9ywICkKKrYtP6tzo6nMuTug6bC/R3t/6aCz4EQ7H1Qo9qJufzxohF8f8/ADbpgoNy+g
 VLshcMlPQ5X6J4HoKMPGbwkMGQf/f5becrT8UH809bq3DdvzXXuIB2tE4kRpyPOHSqKQ=
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

