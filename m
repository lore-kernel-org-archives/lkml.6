Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABC1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88102184B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999262;
	bh=AMCaSDIH73na4YK8tjdVUNCJys/0Jtrv/PRvSmcv++w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vdXMik5CZVVOquM1HV8w5oj1BSVpyxZDlRshNAeoWPJFOUb+Ny1Q8T0j6RT8edWlP
	 VNhoCbvXBGAlArtN4EdO7GPe7QFMDlm+mNXABPltJ0EeV7ZlOidVAcn7jF3Iby8GnQ
	 RpqrhPbC/sGZzv0V45EAh6elWIgaYDwRu6sT++qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeL1MOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbeL1MOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0852087F;
        Fri, 28 Dec 2018 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999258;
        bh=AMCaSDIH73na4YK8tjdVUNCJys/0Jtrv/PRvSmcv++w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEhDNnBtW1CFVpjJuRe8oPPcRbmSamMLgRfNUM3+RWNOvWJpQLqK8mQPn2HVo1Vtr
         5oTS8LHCjQnvichT5W+OqN51bt6ss+V4sYdrQm7yQcvFsGJmP4ROaENCe3RZels0C/
         PrgcB8eMbGv4xFCf3kXnXuvPndc5vUdWWKGQDhK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>, security@kernel.org
Subject: [PATCH 4.19 26/46] x86/mtrr: Dont copy uninitialized gentry fields back to userspace
Date:   Fri, 28 Dec 2018 12:52:20 +0100
Message-Id: <20181228113126.323491777@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 32043fa065b51e0b1433e48d118821c71b5cd65d upstream.

Currently the copy_to_user of data in the gentry struct is copying
uninitiaized data in field _pad from the stack to userspace.

Fix this by explicitly memset'ing gentry to zero, this also will zero any
compiler added padding fields that may be in struct (currently there are
none).

Detected by CoverityScan, CID#200783 ("Uninitialized scalar variable")

Fixes: b263b31e8ad6 ("x86, mtrr: Use explicit sizing and padding for the 64-bit ioctls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Cc: security@kernel.org
Link: https://lkml.kernel.org/r/20181218172956.1440-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mtrr/if.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -165,6 +165,8 @@ mtrr_ioctl(struct file *file, unsigned i
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
 
+	memset(&gentry, 0, sizeof(gentry));
+
 	switch (cmd) {
 	case MTRRIOC_ADD_ENTRY:
 	case MTRRIOC_SET_ENTRY:


