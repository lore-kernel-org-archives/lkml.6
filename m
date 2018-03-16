Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221914-2-11120626296786568463
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221913; b=UHviWN9o+ANes1uQuNmlrHz7uLnR54zfZjeYSb3R6F5jsYN
    J8kc4O38CYjjLqyyCGQdn4PfrREnB6kwzGar4RPOru406gJy7GBkghQo1l/t/09P
    jX038ezgtf5EqcPlaOBk2WLmjXh1QD6pZ0HRdSPV9M2YhV7msg+3JDVSYYJt+3Lb
    pqpuPoEoZMEsO285sfyvHtU0eJ1V3liNkjezsZz2/8TkpezIFfnEaofrrm5Fe2iV
    Ep1pg0oSHTMXGcxlLB1U2WmJXkn3SRmudeF5E+ZiPSTG2A8QyZ58e233jdQQCFy4
    inuBH4IeTS73tdL1GOO72NnGqYzM6D++KT6O9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221913; bh=YLfRoK/XWR8gt70xwBzZI3zRmt
    60OAxW5c82RQ6EhVg=; b=ggjacsz0lsi5QFNFJ5Jw6Uuau0OJs9qPIzGSNpg6jA
    eCvra5ZZMu5NXJnDvxn013RXunNVlKX5LcSQB75cbdx6TH2VAYvkxkn+JgHvESQW
    cOxX5Tp7SsNKgwCn7W1q6BegE4fXMpJEwTl4e7+zsiDGq8N+6Xkymu1p+SiCXImd
    9KJlpF3aghp3lKV+xUrsbrzakaIK2YpIDSRhGL0a4rR+tU2V2cA/5M9bvH/Bgtly
    4u9J/bESyDzxxPeaJshlnraqgGUfvFpNSNk4O/XfBiWdVscaYSGLSyUL3FC/ZSIP
    n3Pe59wxdn5iyJDH5j4DK2UannRDxmH8hfHCB1iI6YZQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbeCPPXb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:23:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33046 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeCPPXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:23:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Justin Chen <justinpopo6@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 3.18 02/25] MIPS: BMIPS: Do not mask IPIs during suspend
Date: Fri, 16 Mar 2018 16:22:49 +0100
Message-Id: <20180316152232.852761751@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justinpopo6@gmail.com>

commit 06a3f0c9f2725f5d7c63c4203839373c9bd00c28 upstream.

Commit a3e6c1eff548 ("MIPS: IRQ: Fix disable_irq on CPU IRQs") fixes an
issue where disable_irq did not actually disable the irq. The bug caused
our IPIs to not be disabled, which actually is the correct behavior.

With the addition of commit a3e6c1eff548 ("MIPS: IRQ: Fix disable_irq on
CPU IRQs"), the IPIs were getting disabled going into suspend, thus
schedule_ipi() was not being called. This caused deadlocks where
schedulable task were not being scheduled and other cpus were waiting
for them to do something.

Add the IRQF_NO_SUSPEND flag so an irq_disable will not be called on the
IPIs during suspend.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Fixes: a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs")
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17385/
[jhogan@kernel.org: checkpatch: wrap long lines and fix commit refs]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/smp-bmips.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -159,11 +159,11 @@ static void bmips_prepare_cpus(unsigned
 		return;
 	}
 
-	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
-			"smp_ipi0", NULL))
+	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt,
+			IRQF_PERCPU | IRQF_NO_SUSPEND, "smp_ipi0", NULL))
 		panic("Can't request IPI0 interrupt");
-	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
-			"smp_ipi1", NULL))
+	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt,
+			IRQF_PERCPU | IRQF_NO_SUSPEND, "smp_ipi1", NULL))
 		panic("Can't request IPI1 interrupt");
 }
 
