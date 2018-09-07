Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05807C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE62075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBE62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeIGXyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:54:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36912 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGXyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:54:20 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyMAh-0008Um-CY; Fri, 07 Sep 2018 21:11:59 +0200
Date:   Fri, 7 Sep 2018 21:11:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Philipp Eppelt <philipp.eppelt@kernkonzept.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: x86/apic: MSI address malformed for "flat" driver
In-Reply-To: <d407ee89-3d6c-b55d-d633-abf7644e9766@kernkonzept.com>
Message-ID: <alpine.DEB.2.21.1809072012310.1402@nanos.tec.linutronix.de>
References: <d407ee89-3d6c-b55d-d633-abf7644e9766@kernkonzept.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018, Philipp Eppelt wrote:
> 
> The "flat" driver defines the MSI addressing scheme to be used as
> logical addressing in flat mode. The MSI msg address is composed
> accordingly, but sets MSI_ADDR_REDIRECTION_CPU which is a zero at bit[3].

Correct. That's what it means:

  * When RH is 0, the interrupt is directed to the processor listed in the
    Destination ID field.

So for DM:

  * If RH is 0, then the DM bit is ignored and the message is sent ahead
    independent of whether the physical or logical destination mode is
    used.

which is means that the delivery does not do any magic redirections,
because the Redirection Hint is off. If RH is set, then the delivery can
redirect according to the rules in the DM section. We are not using that
because we want targeted single CPU delivery.

The interpretation of the DID field is purely depending on the local APIC
itself by matching the APIC ID against the DID field. And the local APIC ID
of CPU0 is 1 << 0, i.e. 0x1 which matches the MSI message you see.

> Currently, irq_msi_compose_msg composes for the "flat" driver an address
> like 0xfee0'1004 for a 64-bit single-core system without IO-APIC and MSI
> remapping and no ACPI (a virtual system).

The DM field is irrelevant if RH is 0. If RH is one and DM is 1 then you
can do group stuff and other magic, but we don't use that for 'external'
interrupts.

Where it _is_ used though is in the IPI delivery so that IPIs to multiple
CPUs require only a single APIC write, while with physical mode it's
necessary to write a single message to each CPU.

Hope that helps.

Thanks,

	tglx
