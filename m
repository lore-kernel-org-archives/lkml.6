Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D343C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D7B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762989;
	bh=MEF+HOZp1V9qicfAxvz/hIeLmc5Rh1SQ9rgbyGZ9rSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vp5k4E/OZ77cMx+YXRA9V79js+IbrDSmJqiVHWLpgj/Suui+b1UfC/IwQJCkJExzQ
	 NYgPu6IDRdGhrxiI+RHOsYz4xRrvk7f51Kb1klI0gON0RpGBhEvvCLtJ9pLOl/aqsw
	 jPNbORDZbuoAjl0nS99PZFUiKuaF9/l0j/dCHGJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfA2L41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731554AbfA2Lt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121EC20989;
        Tue, 29 Jan 2019 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762596;
        bh=MEF+HOZp1V9qicfAxvz/hIeLmc5Rh1SQ9rgbyGZ9rSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hPk1Xhyigd0HbAkQhS49LCu5MLh/2ZnlmaqHsivtrXnBHKU5WyW5nzaexLtn+rm5A
         Gu5ArfIbt8ugVufp5i1QWgS8nNqAAwz1/CNsDgaAQQ5gnanjSSkPiHRRXb0WKLQbnt
         g4RCLbLs8V/QFmagMGwGCQXn87DOnKL3eqV+bKqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.14 60/68] ptp_kvm: probe for kvm guest availability
Date:   Tue, 29 Jan 2019 12:36:22 +0100
Message-Id: <20190129113137.327663178@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

From: Joao Martins <joao.m.martins@oracle.com>

commit 001f60e1f662a6dee1630a2915401aaf5959d479 upstream.

In the event of moving pvclock_pvti_cpu0_va() definition to common
pvclock code, this function would return a value on non KVM guests.
Later on this would fail with a GPF on ptp_kvm_init when running on a
Xen guest. Therefore, ptp_kvm_init() should check whether it is running
in a KVM guest.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Acked-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ptp/ptp_kvm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ptp/ptp_kvm.c
+++ b/drivers/ptp/ptp_kvm.c
@@ -178,6 +178,9 @@ static int __init ptp_kvm_init(void)
 {
 	long ret;
 
+	if (!kvm_para_available())
+		return -ENODEV;
+
 	clock_pair_gpa = slow_virt_to_phys(&clock_pair);
 	hv_clock = pvclock_pvti_cpu0_va();
 


