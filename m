Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F3AC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FC120861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FC120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbeIMTQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:16:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731264AbeIMTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:16:07 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 98D5FD3B;
        Thu, 13 Sep 2018 14:06:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.18 195/197] x86: kvm: avoid unused variable warning
Date:   Thu, 13 Sep 2018 15:32:24 +0200
Message-Id: <20180913131849.356446411@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 7288bde1f9df6c1475675419bdd7725ce84dec56 upstream.

Removing one of the two accesses of the maxphyaddr variable led to
a harmless warning:

arch/x86/kvm/x86.c: In function 'kvm_set_mmio_spte_mask':
arch/x86/kvm/x86.c:6563:6: error: unused variable 'maxphyaddr' [-Werror=unused-variable]

Removing the #ifdef seems to be the nicest workaround, as it
makes the code look cleaner than adding another #ifdef.

Fixes: 28a1f3ac1d0c ("kvm: x86: Set highest physical address bits in non-present/reserved SPTEs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org # L1TF
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6516,14 +6516,12 @@ static void kvm_set_mmio_spte_mask(void)
 	/* Set the present bit. */
 	mask |= 1ull;
 
-#ifdef CONFIG_X86_64
 	/*
 	 * If reserved bit is not supported, clear the present bit to disable
 	 * mmio page fault.
 	 */
-	if (maxphyaddr == 52)
+	if (IS_ENABLED(CONFIG_X86_64) && maxphyaddr == 52)
 		mask &= ~1ull;
-#endif
 
 	kvm_mmu_set_mmio_spte_mask(mask, mask);
 }


