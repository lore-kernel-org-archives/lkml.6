Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554ABC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A6C2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A6C2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeISSIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:08:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeISSIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:08:48 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2bd4-000184-0X; Wed, 19 Sep 2018 14:30:50 +0200
Date:   Wed, 19 Sep 2018 14:30:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com, sivanich@hpe.com
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
In-Reply-To: <20180919121720.GA47424@gmail.com>
Message-ID: <alpine.DEB.2.21.1809191421500.18945@nanos.tec.linutronix.de>
References: <20180904151141.20264-1-msys.mizuma@gmail.com> <20180918133026.gzyix3oyrfcsrdcx@gabell> <20180919121720.GA47424@gmail.com>
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

On Wed, 19 Sep 2018, Ingo Molnar wrote:
> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
> > Ping...
> > I would appreciate if someone could review it because this patch
> > fixes the real memory hotplug issue...
> 
> Yeah, so I generally try to resist random new boot options that
> work around real bugs, so please convince me that this patch
> is the best option:
> 
> > 
> > On Tue, Sep 04, 2018 at 11:11:40AM -0400, Masayoshi Mizuma wrote:
> > > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > 
> > > If each node of physical memory layout has huge space for hotplug,
> > > the padding used for the physical memory mapping section is not enough.
> > > For exapmle of the layout:
> > >   SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
> > >   SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
> > >   SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
> > >   SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
> > > 
> > > We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
> > > however, the needed padding size depends on the system environment.
> > > The kernel option is better than changing the config.
> > > 
> > > Change log from v2:
> > >  - Simplify the description. As Baoquan said, this is simillar SGI UV issue,
> > >    but a little different. Remove SGI UV description.
> 
> Could you please explain it a bit better where the higher padding requirement comes from?
> 
> 'system environment' is very opaque.

As I understand it, it's depending on the actual physical characteristics
of the machine. So setting a fixed value in Kconfig might work for one, but
not for others and having a command line option allows to tweak that at
boot time and having a common kernel image.

Ideally we would calculate that from SRAT, but AFAICT SRAT is not available
at the point where this needs to be done.

Thanks,

	tglx
