Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03DBC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B1120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108205;
	bh=/SkmE4jiFB+wb6RpolQ+aHRGctihERT2AYV9tXDKxUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MyGpc0NCgmaCloep+ONjivLgRLqijvGnmrBu8hEcdIGlvbkf4x2ayUJMqh2iXE8D5
	 XmTtyZtzYu6J01gXuZQq19TavdIB58ofCk8+0Ga7yg4z9EH0fVQG22JQFn96ukJvr0
	 YqFlit2qZwU27CZOU6MnFn+JIwIpHHFFmJe9iNLo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B1120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeLFO4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbeLFOnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC1B220892;
        Thu,  6 Dec 2018 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107392;
        bh=/SkmE4jiFB+wb6RpolQ+aHRGctihERT2AYV9tXDKxUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKbqIyNnNfLTVRwa9/NjglJfcumKRtixjnPUAXWwbujmsMh1et7DXXac0rLdPEojB
         5gfE93TynvVx0Oq/JYQ6fNfD85BwjbB3fxNJ9RhWmcxLNIvrZPv8nMFO3TcFM9kfk3
         NOruHdF3YIGOTuZGU4+dESmQtrI4V5hevYXoPdts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 44/55] udf: Allow mounting volumes with incorrect identification strings
Date:   Thu,  6 Dec 2018 15:39:18 +0100
Message-Id: <20181206143004.121072039@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit b54e41f5efcb4316b2f30b30c2535cc194270373 upstream.

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
Reported-and-tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/udf/super.c   |   16 ++++++++++------
 fs/udf/unicode.c |   14 +++++++++++---
 2 files changed, 21 insertions(+), 9 deletions(-)

--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -922,16 +922,20 @@ static int udf_load_pvoldesc(struct supe
 	}
 
 	ret = udf_dstrCS0toUTF8(outstr, 31, pvoldesc->volIdent, 32);
-	if (ret < 0)
-		goto out_bh;
-
-	strncpy(UDF_SB(sb)->s_volume_ident, outstr, ret);
+	if (ret < 0) {
+		strcpy(UDF_SB(sb)->s_volume_ident, "InvalidName");
+		pr_warn("incorrect volume identification, setting to "
+			"'InvalidName'\n");
+	} else {
+		strncpy(UDF_SB(sb)->s_volume_ident, outstr, ret);
+	}
 	udf_debug("volIdent[] = '%s'\n", UDF_SB(sb)->s_volume_ident);
 
 	ret = udf_dstrCS0toUTF8(outstr, 127, pvoldesc->volSetIdent, 128);
-	if (ret < 0)
+	if (ret < 0) {
+		ret = 0;
 		goto out_bh;
-
+	}
 	outstr[ret] = 0;
 	udf_debug("volSetIdent[] = '%s'\n", outstr);
 
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -341,6 +341,11 @@ try_again:
 	return u_len;
 }
 
+/*
+ * Convert CS0 dstring to output charset. Warning: This function may truncate
+ * input string if it is too long as it is used for informational strings only
+ * and it is better to truncate the string than to refuse mounting a media.
+ */
 int udf_dstrCS0toUTF8(uint8_t *utf_o, int o_len,
 		      const uint8_t *ocu_i, int i_len)
 {
@@ -349,9 +354,12 @@ int udf_dstrCS0toUTF8(uint8_t *utf_o, in
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
 


