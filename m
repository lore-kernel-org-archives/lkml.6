Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7727ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740B420673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740B420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbeGSObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:31:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33147 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbeGSObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:31:51 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fg9IG-0000CX-0p; Thu, 19 Jul 2018 15:48:32 +0200
Date:   Thu, 19 Jul 2018 15:48:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: NULL pointer dereference in msi_set_mask_bit
In-Reply-To: <ed32c159-1629-68e5-26e2-b1770a43acc3@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1807191541130.1602@nanos.tec.linutronix.de>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de> <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.21.1807181646280.1568@nanos.tec.linutronix.de> <6339fdef-a335-b833-4022-23725fd86d9e@molgen.mpg.de>
 <alpine.DEB.2.21.1807181722020.1568@nanos.tec.linutronix.de> <178bb701-56af-06cf-4836-1a26e74f2b07@molgen.mpg.de> <alpine.DEB.2.21.1807182058110.1689@nanos.tec.linutronix.de> <7660f2f2-0c37-a617-ecdc-949cd4ecc060@molgen.mpg.de>
 <ed32c159-1629-68e5-26e2-b1770a43acc3@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Thu, 19 Jul 2018, Paul Menzel wrote:

> I had to copy the files, and then was able to create an archive with
> non-zero files. Please find the tar archive attached.

Thanks for providing the data. All looks normal there.

Just for clarification. Did this happen exactly once, or did it just not
happen again after you plugged in a serial cable?

One thing you might try is to disable irqbalanced when the machine is up
and then stress the affinity setter mechanism with scripting.

Something like

while true; do
 for I in {0..3}; do echo $I > /proc/irq/$IRQ/smp_affinity_list; done
done

might be able to trigger it. But don't ask me which interrupt was involved,
so you have to iterate through the ones which are MSI based.

'cat /proc/interrupt | grep MSI' will tell you.

Thanks,

	tglx


