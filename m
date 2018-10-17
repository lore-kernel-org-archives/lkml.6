Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB8ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B8B214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="BGh1+CfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B8B214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJQUaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:30:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53442 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:29:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so1841749wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=93GEonh2nb+KSw9E8OqrNKqrDbLN5DYI6s6C3SX4j0o=;
        b=BGh1+CfSvYdajb3WC5LnthQpp536zLE00hBiMOi7g7c/QXZoIo1p/SGJec0A3dfJGL
         M3zVi31L1kD2CKaBI8y2KqoSyrS/6OEwj8l5V3tEZ11g8opI6dXAM76SVi6UcVfQBQ1C
         RwvfE1YbtMyDpWjvRTcE0HIJxu1x6+VlE9VEvdsB7FXNd8Q2zOPAGVDHd1vXOAQQ/crN
         MF0wHMQOr71WCKJSAwo45oHCh8/VwSbLbO36+5q4l/xklXhLFw3uYaTr+4okT5cuTbmH
         20PQsw58AomioKKOEthrxgUbbcjR2C9dQ/d2No1gNNa8bzdhmO6dBdNBBiNJzqDEUFwY
         DqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=93GEonh2nb+KSw9E8OqrNKqrDbLN5DYI6s6C3SX4j0o=;
        b=uNsbH7fBwopbrcqxt7QkL/c9GnxrQ5/wlxO0DClq/OuMbjVAB0zFVlJHgzYnYV92HN
         mk3PuesZFyC9sbdcQHjrd5ZgSALT/re0n9/AvqxCEXv2bDRo1lJGkPrRfi8WYT2ttW03
         l5vIk26rN3t662OxyKRpVRfgxrZLFHjv6sjlH50QwMGi1ak3q77EJlHQYsBA/7/uxEuU
         B8a7kW0Ih+gD0fU9N73/RDq0ASnYQzOuACyTX7qXDOqlKG/tXiRWrA+HfJGl0zAO+gzW
         2ZmgWiitv8C+gN8uTsovXThakrrXGNfZ6qPNq52WaCZkqaz3Dpij/wEiTjzXWhwORAXw
         zcSQ==
X-Gm-Message-State: ABuFfohDftwCOhLkn8sttvikcySISb9GrCIQsS2VOUuPOGx7b0QfNm6j
        AA/lY+ya3buepzH92nXucN8jVg==
X-Google-Smtp-Source: ACcGV60rVhUsTkj6qXgExSfjklpEt2Hv4jwKsMcxzVDNBJeU0EFDnc4ibz3aLGVhEawF9vPPnktaTg==
X-Received: by 2002:a1c:1d6:: with SMTP id 205-v6mr2770990wmb.0.1539779667845;
        Wed, 17 Oct 2018 05:34:27 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id k23-v6sm15476332wrd.85.2018.10.17.05.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 05:34:27 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:34:26 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     dushistov@mail.ru, David.Laight@aculab.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181017123426.GA17296@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
header and replace with simple assignment. For each case, S_IFx >> 12
is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
us the correct file type. This is verified at compile-time with
BUILD_BUG_ON macro calls. For invalid cases, upper layer validation
catches this anyway, so this improves readability and arguably
performance by assigning (mode & S_IFMT) >> 12 directly.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/ufs/util.h | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1fd3011ea623..dcf86829edc2 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -16,6 +16,7 @@
  * some useful macros
  */
 #define in_range(b,first,len)	((b)>=(first)&&(b)<(first)+(len))
+#define S_SHIFT			12
 
 /*
  * functions used for retyping
@@ -158,34 +159,16 @@ ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
 		return;
 
-	/*
-	 * TODO turn this into a table lookup
-	 */
-	switch (mode & S_IFMT) {
-	case S_IFSOCK:
-		de->d_u.d_44.d_type = DT_SOCK;
-		break;
-	case S_IFLNK:
-		de->d_u.d_44.d_type = DT_LNK;
-		break;
-	case S_IFREG:
-		de->d_u.d_44.d_type = DT_REG;
-		break;
-	case S_IFBLK:
-		de->d_u.d_44.d_type = DT_BLK;
-		break;
-	case S_IFDIR:
-		de->d_u.d_44.d_type = DT_DIR;
-		break;
-	case S_IFCHR:
-		de->d_u.d_44.d_type = DT_CHR;
-		break;
-	case S_IFIFO:
-		de->d_u.d_44.d_type = DT_FIFO;
-		break;
-	default:
-		de->d_u.d_44.d_type = DT_UNKNOWN;
-	}
+	/* Compile-time assertions that S_IFx >> S_SHIFT == DT_x */
+	BUILD_BUG_ON(S_IFIFO >> S_SHIFT != DT_FIFO);
+	BUILD_BUG_ON(S_IFCHR >> S_SHIFT != DT_CHR);
+	BUILD_BUG_ON(S_IFDIR >> S_SHIFT != DT_DIR);
+	BUILD_BUG_ON(S_IFBLK >> S_SHIFT != DT_BLK);
+	BUILD_BUG_ON(S_IFREG >> S_SHIFT != DT_REG);
+	BUILD_BUG_ON(S_IFLNK >> S_SHIFT != DT_LNK);
+	BUILD_BUG_ON(S_IFSOCK >> S_SHIFT != DT_SOCK);
+
+	de->d_u.d_44.d_type = (mode & S_IFMT) >> S_SHIFT;
 }
 
 static inline u32
-- 
2.17.2

