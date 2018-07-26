Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F0EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993C020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993C020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbeGZQHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:07:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:35882 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbeGZQHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:07:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 07:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,405,1526367600"; 
   d="scan'208";a="76162846"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2018 07:50:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A9B56149; Thu, 26 Jul 2018 17:50:08 +0300 (EEST)
Date:   Thu, 26 Jul 2018 17:50:08 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dmitry Malkin <d.malkin@real-time-systems.com>
Cc:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180726145008.ccmeklqx4ofb4456@black.fi.intel.com>
References: <f1fb3e5e-f18a-9f89-84c5-1dc73e08ceef@real-time-systems.com>
 <20180725212122.f2m3cfiqb4az3cb7@black.fi.intel.com>
 <a3e428be-0875-3b64-7680-252cd61b52c9@real-time-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3e428be-0875-3b64-7680-252cd61b52c9@real-time-systems.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:10:42AM +0000, Dmitry Malkin wrote:
> 
> 
> On 07/25/2018 11:21 PM, Kirill A. Shutemov wrote:
> > On Wed, Jul 25, 2018 at 05:26:02PM +0000, Dmitry Malkin wrote:
> > > there may be some other reasons which may cause undefined behavior (reboot
> > > for example):
> > > 
> > > in arch/x86/boot/compressed/pgtable_64.c in function paging_prepare():
> > > 
> > > 1. structure "paging_config" allocated on stack without setting default
> > > value for flag "l5_required":
> > > > > struct paging_config paging_config = {};
> > > l5_required is set only if CONFIG_X86_5LEVEL is defined
> > Hm? C99 initializer zeros the structure.
> https://elixir.bootlin.com/linux/latest/source/Makefile#L366
> Here I only see std=gnu89.

gnu89 support C99-style initializers. The syntax above would clear fields
that not initialized explicitly, in this case all of them.

> > > 2. reading from memory which may be reserved in case of EFI systems:
> > > > >     ebda_start = *(unsigned short *)0x40e << 4;
> > > > >     bios_start = *(unsigned short *)0x413 << 10;
> > > Also, on EFI system without CSM it will results in all zeros. Which will
> > > place trampoline_start to 0x9d000. And it also may be reserved memory. In
> > > fact I have such system and it is causes instant reboot (when code starts
> > > copying to "trampoline_start").
> > Could you show dmesg from such system?
> Sure, here it is (please note than not both pages are reserved but only
> second one: 0x9e000-0x9ffff):

Well. That's bad.

I don't see much options but parse e820 in decompression code. I hoped to
avoid this.

Let me see what I can do there.

-- 
 Kirill A. Shutemov
