Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C023C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02DB217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167785;
	bh=/sC2IibcNzVKcEKSrYFMbDCInNwUrHFL8jtjJ48BCjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k+tAcM0gNcL334tpX6y5Soeo1M36ccN7oxMedqBciowOWk7kSaOYp7SkmINJ1ctos
	 8BsQ2QJFI7abiIzB5wNyPoA/Np+BEw4YdOjH2raC5AP9XEUwvBeF40dhlJFo3koaes
	 H2VotS6nhYw39JRAK4t3BMl+OgWCL4rUXSLh4eyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfAVOgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbfAVOgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:36:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D5A20854;
        Tue, 22 Jan 2019 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167782;
        bh=/sC2IibcNzVKcEKSrYFMbDCInNwUrHFL8jtjJ48BCjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNCQHgPi8PmK/rjUmgV4tA0LZUIlhwsbhMrkRm8cBhsJ7vFLhkLTDNRM1zVgHDIJa
         CoDB4G954ug3fWfBv8mncn4G78+A7xTI/OLVTvo4FgOuRvMvzYqMHjX0DpOgjOyvHE
         kuPSKyhuTFrBp5U94+4CLO4ZehkAcb81A4oxW6h4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Subject: [PATCH 3/6] x86: kvm: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:35:39 +0100
Message-Id: <20190122143542.8816-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122143542.8816-1-gregkh@linuxfoundation.org>
References: <20190122143542.8816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <kvm@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/debugfs.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index c19c7ede9bd6..827cd58400d2 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -43,26 +43,16 @@ DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_frac_fops, vcpu_get_tsc_scaling_frac_bi
 
 int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 {
-	struct dentry *ret;
-
-	ret = debugfs_create_file("tsc-offset", 0444,
-							vcpu->debugfs_dentry,
-							vcpu, &vcpu_tsc_offset_fops);
-	if (!ret)
-		return -ENOMEM;
+	debugfs_create_file("tsc-offset", 0444, vcpu->debugfs_dentry, vcpu,
+			    &vcpu_tsc_offset_fops);
 
 	if (kvm_has_tsc_control) {
-		ret = debugfs_create_file("tsc-scaling-ratio", 0444,
-							vcpu->debugfs_dentry,
-							vcpu, &vcpu_tsc_scaling_fops);
-		if (!ret)
-			return -ENOMEM;
-		ret = debugfs_create_file("tsc-scaling-ratio-frac-bits", 0444,
-							vcpu->debugfs_dentry,
-							vcpu, &vcpu_tsc_scaling_frac_fops);
-		if (!ret)
-			return -ENOMEM;
-
+		debugfs_create_file("tsc-scaling-ratio", 0444,
+				    vcpu->debugfs_dentry, vcpu,
+				    &vcpu_tsc_scaling_fops);
+		debugfs_create_file("tsc-scaling-ratio-frac-bits", 0444,
+				    vcpu->debugfs_dentry, vcpu,
+				    &vcpu_tsc_scaling_frac_fops);
 	}
 
 	return 0;
-- 
2.20.1

