Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB172ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D04A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D04A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeJRBCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:02:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60772 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJRBCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:02:38 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCpGh-0003Ud-Bj; Wed, 17 Oct 2018 19:05:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, linux-kbuild@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: [PATCH 3/3] kvm: don't redefine flags as something else
Date:   Wed, 17 Oct 2018 19:05:54 +0200
Message-Id: <20181017170554.18841-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017170554.18841-1-bigeasy@linutronix.de>
References: <20181017170554.18841-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function irqfd_wakeup() has flags defined as __poll_t and then it
has additional flags which is used for irqflags.

Redefine the inner flags variable as iflags so it does not shadow the
outer flags.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 virt/kvm/eventfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index b20b751286fc6..d15a51622d53e 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -214,9 +214,9 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 
 	if (flags & EPOLLHUP) {
 		/* The eventfd is closing, detach from KVM */
-		unsigned long flags;
+		unsigned long iflags;
 
-		spin_lock_irqsave(&kvm->irqfds.lock, flags);
+		spin_lock_irqsave(&kvm->irqfds.lock, iflags);
 
 		/*
 		 * We must check if someone deactivated the irqfd before
@@ -230,7 +230,7 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 		if (irqfd_is_active(irqfd))
 			irqfd_deactivate(irqfd);
 
-		spin_unlock_irqrestore(&kvm->irqfds.lock, flags);
+		spin_unlock_irqrestore(&kvm->irqfds.lock, iflags);
 	}
 
 	return 0;
-- 
2.19.1

