Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9056DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F8C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye5tg9QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F8C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeJIBvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:51:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A1120C0A;
        Mon,  8 Oct 2018 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023913;
        bh=VrxR3Khs4mxrCnWgj7tKfpl7S8AgFx0W4SCxm6E3dzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ye5tg9QBgYBzO9T8f8uWLmIler+Zlhz74TB+OScDCpI61A6QHipUJ3UpfMtGJnlOs
         rGVjgO1pWftDdmOmMHNVvqVsodI0M7Zg+ZhMAR8iGEmrdH22ebBbriYpjFJsed5fDq
         hYap8P81oKhmaGxw4cQhsspLnIfZIa85kyPizKGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 04/59] KVM: PPC: Book3S HV: Dont truncate HPTE index in xlate function
Date:   Mon,  8 Oct 2018 20:31:11 +0200
Message-Id: <20181008175547.329910370@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit 46dec40fb741f00f1864580130779aeeaf24fb3d ]

This fixes a bug which causes guest virtual addresses to get translated
to guest real addresses incorrectly when the guest is using the HPT MMU
and has more than 256GB of RAM, or more specifically has a HPT larger
than 2GB.  This has showed up in testing as a failure of the host to
emulate doorbell instructions correctly on POWER9 for HPT guests with
more than 256GB of RAM.

The bug is that the HPTE index in kvmppc_mmu_book3s_64_hv_xlate()
is stored as an int, and in forming the HPTE address, the index gets
shifted left 4 bits as an int before being signed-extended to 64 bits.
The simple fix is to make the variable a long int, matching the
return type of kvmppc_hv_find_lock_hpte(), which is what calculates
the index.

Fixes: 697d3899dcb4 ("KVM: PPC: Implement MMIO emulation support for Book3S HV guests")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -314,7 +314,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate
 	unsigned long pp, key;
 	unsigned long v, gr;
 	__be64 *hptep;
-	int index;
+	long int index;
 	int virtmode = vcpu->arch.shregs.msr & (data ? MSR_DR : MSR_IR);
 
 	/* Get SLB entry */


