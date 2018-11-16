Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6969EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2617C2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2617C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbeKPXIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:08:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:34170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbeKPXIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:08:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D172CAF15;
        Fri, 16 Nov 2018 12:56:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C8B341E09B3; Fri, 16 Nov 2018 13:56:33 +0100 (CET)
Date:   Fri, 16 Nov 2018 13:56:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: Re: [PATCH] udf: fix dvd mounting error
Message-ID: <20181116125633.GG24157@quack2.suse.cz>
References: <20181115122600.15821-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20181115122600.15821-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 15-11-18 12:26:00, Sudip Mukherjee wrote:
> Some DVDs are failing to mount with the error:
> 
> [  632.305370] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
> [  632.305372] UDF-fs: Scanning with blocksize 512 failed
> [  632.307837] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
> [  632.307839] UDF-fs: Scanning with blocksize 1024 failed
> [  632.309320] UDF-fs: incorrect dstring lengths (32/32)
> [  632.309361] UDF-fs: Scanning with blocksize 2048 failed
> [  632.309530] UDF-fs: warning (device loop0): udf_load_vrs: No VRS found
> [  632.309531] UDF-fs: Scanning with blocksize 4096 failed
> 
> This particular DVD used to work with v4.4 kernels, and has stopped
> working after updating the kernel to v4.14. Did a git bisect and that
> pointed to:
> c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")
> 
> This patch effectively reverts c26f6c615788 and removes the length
> check that it introduced. And after this patch:
> 
> [   61.767204] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
> [   61.767206] UDF-fs: Scanning with blocksize 512 failed
> [   61.770011] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
> [   61.770026] UDF-fs: Scanning with blocksize 1024 failed
> [   61.773006] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
> [   61.773007] UDF-fs: Scanning with blocksize 512 failed
> [   61.774401] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
> [   61.774402] UDF-fs: Scanning with blocksize 1024 failed
> [   61.775045] UDF-fs: INFO Mounting volume 'TOUR_2017_THANKSGIVING_25_DISC ',
> 			timestamp 2018/01/30 05:57 (1000)
> 
> The DVD is available at:
> https://www.amazon.co.jp/Live-%E3%80%8CMr-Children-DOME-STADIUM-Thanksgiving/dp/B079B5W6KC
> 
> Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Thanks for report and the analysis! Looking at the UDF specification and
your report, the media is simply incorrect. However I do agree that it is
lame to just refuse to mount the media when we don't need the problematic
string for anything important. However I don't agree with just stopping the
checking of string length. That opens potential security issues with
corrupted media. Attached patch should fix your problem in a safe way. Can
you please test it with your media?

								Honza

> ---
> 
> I dont't think this is the correct fix but has solved the problem for
> now. I have the iso image of the DVD for testing, and if there is a better
> solution I can test.
> 
>  fs/udf/unicode.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
> index 45234791fec2..9f80c56178a5 100644
> --- a/fs/udf/unicode.c
> +++ b/fs/udf/unicode.c
> @@ -356,14 +356,8 @@ int udf_dstrCS0toChar(struct super_block *sb, uint8_t *utf_o, int o_len,
>  {
>  	int s_len = 0;
>  
> -	if (i_len > 0) {
> +	if (i_len > 0)
>  		s_len = ocu_i[i_len - 1];
> -		if (s_len >= i_len) {
> -			pr_err("incorrect dstring lengths (%d/%d)\n",
> -			       s_len, i_len);
> -			return -EINVAL;
> -		}
> -	}
>  
>  	return udf_name_from_CS0(sb, utf_o, o_len, ocu_i, s_len, 0);
>  }
> -- 
> 2.11.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--4Ckj6UjgE2iN1+kY
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-udf-Allow-mounting-volumes-with-incorrect-identifica.patch"

From e1a7680b960fe25821f2419b4c0b1215f8ab2f9b Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 16 Nov 2018 13:43:17 +0100
Subject: [PATCH] udf: Allow mounting volumes with incorrect identification
 strings

Commit c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")
started to be more strict when checking whether converted strings are
properly formatted. Sudip reports that there are DVDs where the volume
identification string is actually too long - UDF reports:

[  632.309320] UDF-fs: incorrect dstring lengths (32/32)

during mount and fails the mount. This is mostly harmless failure as we
don't need volume identification (and even less volume set
identification) for anything. So just truncate the volume identification
string if it is too long and replace it with 'Invalid' if we just cannot
convert it for other reasons. This keeps slightly incorrect media still
mountable.

CC: stable@vger.kernel.org
Fixes: c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")
Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c   | 16 ++++++++++------
 fs/udf/unicode.c | 14 +++++++++++---
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 8f2f56d9a1bb..0672382b79e3 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -827,16 +827,20 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 
 
 	ret = udf_dstrCS0toChar(sb, outstr, 31, pvoldesc->volIdent, 32);
-	if (ret < 0)
-		goto out_bh;
-
-	strncpy(UDF_SB(sb)->s_volume_ident, outstr, ret);
+	if (ret < 0) {
+		strcpy(UDF_SB(sb)->s_volume_ident, "Invalid");
+		pr_warn("incorrect volume identification, setting to "
+			"'Invalid'\n");
+	} else {
+		strncpy(UDF_SB(sb)->s_volume_ident, outstr, ret);
+	}
 	udf_debug("volIdent[] = '%s'\n", UDF_SB(sb)->s_volume_ident);
 
 	ret = udf_dstrCS0toChar(sb, outstr, 127, pvoldesc->volSetIdent, 128);
-	if (ret < 0)
+	if (ret < 0) {
+		ret = 0;
 		goto out_bh;
-
+	}
 	outstr[ret] = 0;
 	udf_debug("volSetIdent[] = '%s'\n", outstr);
 
diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 45234791fec2..5fcfa96463eb 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -351,6 +351,11 @@ static int udf_name_to_CS0(struct super_block *sb,
 	return u_len;
 }
 
+/*
+ * Convert CS0 dstring to output charset. Warning: This function may truncate
+ * input string if it is too long as it is used for informational strings only
+ * and it is better to truncate the string than to refuse mounting a media.
+ */
 int udf_dstrCS0toChar(struct super_block *sb, uint8_t *utf_o, int o_len,
 		      const uint8_t *ocu_i, int i_len)
 {
@@ -359,9 +364,12 @@ int udf_dstrCS0toChar(struct super_block *sb, uint8_t *utf_o, int o_len,
 	if (i_len > 0) {
 		s_len = ocu_i[i_len - 1];
 		if (s_len >= i_len) {
-			pr_err("incorrect dstring lengths (%d/%d)\n",
-			       s_len, i_len);
-			return -EINVAL;
+			pr_warn("incorrect dstring lengths (%d/%d),"
+				" truncating\n", s_len, i_len);
+			s_len = i_len - 1;
+			/* 2-byte encoding? Need to round properly... */
+			if (ocu_i[0] == 16)
+				s_len -= (s_len - 1) & 2;
 		}
 	}
 
-- 
2.16.4


--4Ckj6UjgE2iN1+kY--
