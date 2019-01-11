Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7672FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3BF2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217829;
	bh=JsFE5TrM4RTg0FLb4KPM2kzymK4HPkFsLHxrPJl+eB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GUP0UpXUgTV0s8CVz/dWPqbyA4i+g1atsEIJ5uKBoRVhXZ7E6E9pCHkd6T0Ns2/+u
	 6v1Qq82Muk7huiIf2t5V9MUxigNQcjdzDKhSqGIYp5Kns1AMn2TCrfjjinKd8SUzBP
	 QA4TkJIR9F5OKvsgXv48wPPSoepOiuLAKzteY+Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404471AbfAKOns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbfAKOnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6E42063F;
        Fri, 11 Jan 2019 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217825;
        bh=JsFE5TrM4RTg0FLb4KPM2kzymK4HPkFsLHxrPJl+eB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srXtr1hkNdZhZszdkqO1YqvnE5sklDDmedTZb5/74K8S8Te+Fa7GY6FIZRtOxbIKP
         ad+WoOXEdOhcffzPmZuCoHPG1bwlPr/nSB/dJCzrzpirj+JsiSgnIGCzROiJ0DgzBW
         VjT1b6lgB13/a9E1v4YzSqtNdknOuSHJWcoquYfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 55/65] powerpc/4xx/ocm: Fix compilation error due to PAGE_KERNEL usage
Date:   Fri, 11 Jan 2019 15:15:41 +0100
Message-Id: <20190111131103.597360873@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@gmail.com>

commit d0757237d7b18b1ce74293be7c077d86f7a732e8 upstream.

This patch fixes a recent compilation regression in ocm:

  ocm.c: In function ‘ocm_init_node’:
  ocm.c:182:18: error: invalid operands to binary |
        (have ‘int’ and ‘pgprot_t’ {aka ‘struct <anonymous>’})
        _PAGE_EXEC | PAGE_KERNEL_NCG);
                   ^

  ocm.c:197:17: error: invalid operands to binary |
        (have ‘int’ and ‘pgprot_t’ {aka ‘struct <anonymous>’})
         _PAGE_EXEC | PAGE_KERNEL);
                    ^

Fixes: 56f3c1413f5c ("powerpc/mm: properly set PAGE_KERNEL flags in ioremap()")
Cc: stable@vger.kernel.org # v4.20
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/4xx/ocm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -179,7 +179,7 @@ static void __init ocm_init_node(int cou
 	/* ioremap the non-cached region */
 	if (ocm->nc.memtotal) {
 		ocm->nc.virt = __ioremap(ocm->nc.phys, ocm->nc.memtotal,
-					 _PAGE_EXEC | PAGE_KERNEL_NCG);
+			_PAGE_EXEC | pgprot_val(PAGE_KERNEL_NCG));
 
 		if (!ocm->nc.virt) {
 			printk(KERN_ERR
@@ -194,7 +194,7 @@ static void __init ocm_init_node(int cou
 
 	if (ocm->c.memtotal) {
 		ocm->c.virt = __ioremap(ocm->c.phys, ocm->c.memtotal,
-					_PAGE_EXEC | PAGE_KERNEL);
+					_PAGE_EXEC | pgprot_val(PAGE_KERNEL));
 
 		if (!ocm->c.virt) {
 			printk(KERN_ERR


