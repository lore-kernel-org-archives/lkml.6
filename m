Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E210CC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F6D2509C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F6D2509C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933499AbeFXPps (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:45:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeFXPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:45:45 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8BA8E49F;
        Sun, 24 Jun 2018 15:45:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH 4.17 54/70] x86/ioapic: Use apic_ack_irq()
Date:   Sun, 24 Jun 2018 23:22:46 +0800
Message-Id: <20180624142743.813357957@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 2b04e46d8d0b9b7ac08ded672e3eab823f01d77a upstream.

To address the EBUSY fail of interrupt affinity settings in case that the
previous setting has not been cleaned up yet, use the new apic_ack_irq()
function instead of directly invoking ack_APIC_irq().

Preparatory change for the real fix

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <liu.song.a23@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tariq Toukan <tariqt@mellanox.com>
Link: https://lkml.kernel.org/r/20180604162224.639011135@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/io_apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1851,7 +1851,7 @@ static void ioapic_ir_ack_level(struct i
 	 * intr-remapping table entry. Hence for the io-apic
 	 * EOI we use the pin number.
 	 */
-	ack_APIC_irq();
+	apic_ack_irq(irq_data);
 	eoi_ioapic_pin(data->entry.vector, data);
 }
 


