Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC58AC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779F1208DE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1W2HWXuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779F1208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHJQ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeHJQ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:28:39 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433D7208A1;
        Fri, 10 Aug 2018 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533909518;
        bh=YU8luSuUQ5m++6vUttEGVUDRfY9cUuemwkpRSwYm7x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1W2HWXuzwu5Jb4aEfvzRweYf1P2mhXXrTNfGSkXRXWpELv4FPG6TyyOQ39bLsAXTs
         ZdWZg6z3fIjSb8vPThh7POleddpetybE7V9TFJcfm1jXS2gid+b9jIHvWo4ttwNS5H
         G2PWmmIkrQaMdErpIuhC4Fg2l0c/4UtdnxaODOkE=
Date:   Fri, 10 Aug 2018 08:58:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     joeyli <jlee@suse.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Claim the resources of firmware enabled IOAPIC
 before children bus
Message-ID: <20180810135837.GI113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180724110144.16442-1-jlee@suse.com>
 <20180806214807.GE30691@bhelgaas-glaptop.roam.corp.google.com>
 <20180808155318.GE13767@linux-l9pv.suse>
 <20180808212322.GF49411@bhelgaas-glaptop.roam.corp.google.com>
 <20180810092501.GP13767@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810092501.GP13767@linux-l9pv.suse>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 05:25:01PM +0800, joeyli wrote:
> On Wed, Aug 08, 2018 at 04:23:22PM -0500, Bjorn Helgaas wrote:
> ...

> The lspci log shows "Normal decode" on the bridge, I think that means
> positively decode.

Right.

> hm... I have another question that it may not relates to this issue. I
> was tracing the code path of PCI hot-remove/hotplug. Base on spec, looks
> that the RST# should be asserted when hot-remove. And the memory decode
> bit must be set to zero after RST# be asserted. But I didn't see that
> any kernel PCI/ACPI code set RST#. The only possible code to set RST# is
> in POWER architecture. Do you know who assert the RST# when hot-remove?    

RST# is a conventional PCI signal (not a PCIe signal).  In any case, I
would expect signals like that to be handled by hardware, not by
software.  What section of the spec are you looking at?  I wouldn't
expect any requirements for doing things to a device when the device
is being hot-removed, since the device may already be inaccessible,
e.g., physically unreachable.

On a hot-*add*, there would of course be requirements about how the
device powers up and comes out of reset.  For native drivers like
pciehp/shpcpd/etc, there are often ways for software to control power
to the slot, e.g., the "Power Controller Control" bit in the PCIe Slot
Control register.

For ACPI-mediated hotplug (as in your situation), the actual hardware
details are handled by the firmware and all the OS sees are things
like ACPI Notify events and it uses methods like _STA and other things
mentioned in ACPI v6.2, sec 6.3.

> > What are the chances of getting a firmware fix?  Has this firmware
> > already shipped to customers?
> 
> The good news is that the machine has not shipped yet. As I know
> that manufacturer is also finding the root cause for why firmware
> enabled memory decode bit and also set the wrong addresses.

I don't think it's necessarily a problem that firmware enables the
IOAPIC.  This is ACPI-mediated hotplug and it looks like it adds CPUs,
memory, and I/O.  I wouldn't be surprised if the firmware has to make
the IOAPIC operational to make some parts of the hot-add work.

The address conflict is the real problem.

Bjorn
