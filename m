Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4BFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DFD20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="waxDbAxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DFD20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeKAINl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732282AbeKAIMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6FA20989;
        Wed, 31 Oct 2018 23:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027537;
        bh=2QpXOtDKFvZhfQjDO6qRveeN4eSMpRyEhqVdqhSOxh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=waxDbAxJ0yG08Xu71AWAYaEEZYWEQbHgGAh7j05PyHeUHv2Zegztg7u5NXjyZh032
         KqnqZ5u9ii8mMIHR6Cqmt904BzSuGEB+dj7h/H0RYiSdkAjzniajCoLgawCdDOnxit
         NEI/NgFIPr/T7U3aKyDk4FG50ftnKIz2O1RsgUrY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 11/22] x86: boot: Fix EFI stub alignment
Date:   Wed, 31 Oct 2018 19:11:55 -0400
Message-Id: <20181031231206.29509-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231206.29509-1-sashal@kernel.org>
References: <20181031231206.29509-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/boot/tools/build.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index a7661c430cd9..523db6ce88dd 100644
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
-- 
2.17.1

