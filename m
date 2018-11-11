Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93333C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E8021104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4ub4y0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E8021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbeKLITS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387600AbeKLITQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:16 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8952A21582;
        Sun, 11 Nov 2018 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975360;
        bh=yQqCvnVeGSL3D3iYu1VcV9I42Y4xFF46IVOzc1X15Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4ub4y0z8i0VQYp88stS6Zt8WeYXr0EY8wtwDHRZDG5NCWKQKriAQeiXud9pW2F2B
         eeJN+za2zPbSzwoq6muIOrGeZhqpkUdOHGICFJjyHKY3QdW5ZRCWHpIQj/1s7HgxSz
         XVg3K9T40FmthzIwFOXoQl2WUvki6Hoht68d/Mds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 4.18 029/350] parisc: Fix exported address of os_hpmc handler
Date:   Sun, 11 Nov 2018 14:18:13 -0800
Message-Id: <20181111221708.395643065@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 99a3ae51d557d8e38a7aece65678a31f9db215ee upstream.

In the C-code we need to put the physical address of the hpmc handler in
the interrupt vector table (IVA) in order to get HPMCs working.  Since
on parisc64 function pointers are indirect (in fact they are function
descriptors) we instead export the address as variable and not as
function.

This reverts a small part of commit f39cce654f9a ("parisc: Add
cfi_startproc and cfi_endproc to assembly code").

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org>    [4.9+]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/hpmc.S |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/parisc/kernel/hpmc.S
+++ b/arch/parisc/kernel/hpmc.S
@@ -85,7 +85,7 @@ END(hpmc_pim_data)
 
 	.import intr_save, code
 	.align 16
-ENTRY_CFI(os_hpmc)
+ENTRY(os_hpmc)
 .os_hpmc:
 
 	/*
@@ -302,7 +302,6 @@ os_hpmc_6:
 	b .
 	nop
 	.align 16	/* make function length multiple of 16 bytes */
-ENDPROC_CFI(os_hpmc)
 .os_hpmc_end:
 
 


