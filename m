Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55390C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC50214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVisua2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC50214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406310AbeKTD1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405677AbeKTD1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:27:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56968214E0;
        Mon, 19 Nov 2018 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647016;
        bh=XdLkS/VBoRwLRITJZw1CyLbTNqEGCBWVbQhkn9dszzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVisua2tmdJwPiy4ON/i+erULldtxjrZY5dKINcBss4WB732SbvthEfmcmV66wL6e
         0A0VCYSCjSBUkaorDyoMvDodh4oe7vDDE24UXFvHu4MiQuGAtOeQSzOIVjSGLbPDy8
         yPVr0rbr/WglRz4D3mr5/1KnLSwixFExevGOKhYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 19/90] x86: boot: Fix EFI stub alignment
Date:   Mon, 19 Nov 2018 17:29:01 +0100
Message-Id: <20181119162624.026267991@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

[ Upstream commit 9c1442a9d039a1a3302fa93e9a11001c5f23b624 ]

We currently align the end of the compressed image to a multiple of
16.  However, the PE-COFF header included in the EFI stub says that
the file alignment is 32 bytes, and when adding an EFI signature to
the file it must first be padded to this alignment.

sbsigntool commands warn about this:

  warning: file-aligned section .text extends beyond end of file
  warning: checksum areas are greater than image size. Invalid section table?

Worse, pesign -at least when creating a detached signature- uses the
hash of the unpadded file, resulting in an invalid signature if
padding is required.

Avoid both these problems by increasing alignment to 32 bytes when
CONFIG_EFI_STUB is enabled.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/tools/build.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -391,6 +391,13 @@ int main(int argc, char ** argv)
 		die("Unable to mmap '%s': %m", argv[2]);
 	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
 	sys_size = (sz + 15 + 4) / 16;
+#ifdef CONFIG_EFI_STUB
+	/*
+	 * COFF requires minimum 32-byte alignment of sections, and
+	 * adding a signature is problematic without that alignment.
+	 */
+	sys_size = (sys_size + 1) & ~1;
+#endif
 
 	/* Patch the setup code with the appropriate size parameters */
 	buf[0x1f1] = setup_sectors-1;


