Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F70C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2BE2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2BE2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeHWL3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:29:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeHWL3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:29:40 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1438DC74;
        Thu, 23 Aug 2018 08:01:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.4 67/79] KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consumer
Date:   Thu, 23 Aug 2018 09:53:43 +0200
Message-Id: <20180823074923.544978272@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 9432a3175770e06cb83eada2d91fac90c977cb99 upstream.

A comment warning against this bug is there, but the code is not doing what
the comment says.  Therefore it is possible that an EPOLLHUP races against
irq_bypass_register_consumer.  The EPOLLHUP handler schedules irqfd_shutdown,
and if that runs soon enough, you get a use-after-free.

Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/eventfd.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -405,11 +405,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct
 	if (events & POLLIN)
 		schedule_work(&irqfd->inject);
 
-	/*
-	 * do not drop the file until the irqfd is fully initialized, otherwise
-	 * we might race against the POLLHUP
-	 */
-	fdput(f);
 #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
 	irqfd->consumer.token = (void *)irqfd->eventfd;
 	irqfd->consumer.add_producer = kvm_arch_irq_bypass_add_producer;
@@ -423,6 +418,12 @@ kvm_irqfd_assign(struct kvm *kvm, struct
 #endif
 
 	srcu_read_unlock(&kvm->irq_srcu, idx);
+
+	/*
+	 * do not drop the file until the irqfd is fully initialized, otherwise
+	 * we might race against the POLLHUP
+	 */
+	fdput(f);
 	return 0;
 
 fail:


