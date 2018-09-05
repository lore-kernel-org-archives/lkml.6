Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88677C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FA820645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JTGeafCP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JTGeafCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FA820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIFD7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:59:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeIFD7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:59:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 95DAF605BD; Wed,  5 Sep 2018 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536190029;
        bh=179maZzWo08TIaue7WJHIp59MvWk5ZoZ1JhweW4496w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JTGeafCPThj7vScbD6eVRi9xzhQrshUPKBDyYfhmZAF/x+149xNONn1RMU/ZWTLEd
         nomIwGN3SK+66r6JpPkVM/wdKwJULuMowGFjhp6bRf/0TDx6k1/gZpfh+ESLBD4Hhn
         buWVaD8bFhuyVUD4bCFAQdHNMKIH31YMVI1JJnTY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4DBE5601D9;
        Wed,  5 Sep 2018 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536190029;
        bh=179maZzWo08TIaue7WJHIp59MvWk5ZoZ1JhweW4496w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JTGeafCPThj7vScbD6eVRi9xzhQrshUPKBDyYfhmZAF/x+149xNONn1RMU/ZWTLEd
         nomIwGN3SK+66r6JpPkVM/wdKwJULuMowGFjhp6bRf/0TDx6k1/gZpfh+ESLBD4Hhn
         buWVaD8bFhuyVUD4bCFAQdHNMKIH31YMVI1JJnTY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Sep 2018 16:27:09 -0700
From:   pheragu@codeaurora.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCH] genirq: Avoid race between cpu hot plug and irq_desc()
 allocation paths
In-Reply-To: <alpine.DEB.2.21.1809052022110.1416@nanos.tec.linutronix.de>
References: <1536167131-20585-1-git-send-email-pheragu@codeaurora.org>
 <alpine.DEB.2.21.1809052022110.1416@nanos.tec.linutronix.de>
Message-ID: <819e8a811ebf49366d75676922903368@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-05 11:23, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, Prakruthi Deepak Heragu wrote:
> 
>> One of the cores might have just allocated irq_desc() and other core
>> might be doing irq migration in the hot plug path. In the hot plug 
>> path
>> during the IRQ migration, for_each_active_irq macro is trying to get
>> irqs whose bits are set in allocated_irqs bit map but there is no 
>> return
>> value check after irq_to_desc for desc validity.
> 
> Confused. All parts involved, irq allocation/deallocation and the CPU
> hotplug code take sparse_irq_lock to prevent exavtly that.
> 
Removing the NULL pointer check and adding this sparse_irq_lock
that you suggested will solve this issue. The code looks like
this now. Is this okay?
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 9409b55..f2ef76e 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -185,14 +185,10 @@ void irq_migrate_all_off_this_cpu(void)
  {
  	struct irq_desc *desc;
  	unsigned int irq;
-
+	irq_lock_sparse();
  	for_each_active_irq(irq) {
  		bool affinity_broken;
-
  		desc = irq_to_desc(irq);
-		if (!desc)
-			continue;
-
  		raw_spin_lock(&desc->lock);
  		affinity_broken = migrate_one_irq(desc);
  		raw_spin_unlock(&desc->lock);
@@ -202,6 +198,7 @@ void irq_migrate_all_off_this_cpu(void)
  					    irq, smp_processor_id());
  		}
  	}
+	irq_unlock_sparse();
  }

  static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned 
int cpu)

> Thanks,
> 
> 	tglx

Thanks,
Prakruthi Deepak Heragu
