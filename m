Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280F1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B0C20833
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B0C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeKAWUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:20:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57497 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:20:35 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gICqm-0004HB-H5; Thu, 01 Nov 2018 14:17:28 +0100
Date:   Thu, 1 Nov 2018 14:17:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eial Czerwacki <eial@scalemp.com>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Shai Fultheim (Shai@ScaleMP.com)" <Shai@ScaleMP.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        X86 ML <x86@kernel.org>, 'Oren Twaig' <oren@scalemp.com>
Subject: Re: [PATCH] x86/build: Build VSMP support only if selected
In-Reply-To: <a8f2ac8e-45dc-1c12-e888-6ad880b1306f@scalemp.com>
Message-ID: <alpine.DEB.2.21.1811011416090.1642@nanos.tec.linutronix.de>
References: <20181030230905.xHZmM%akpm@linux-foundation.org> <9e14d183-55a4-8299-7a18-0404e50bf004@infradead.org> <alpine.DEB.2.21.1811011032190.1642@nanos.tec.linutronix.de> <SN6PR15MB2366D7688B41535AF0A331F9C3CE0@SN6PR15MB2366.namprd15.prod.outlook.com>
 <a8f2ac8e-45dc-1c12-e888-6ad880b1306f@scalemp.com>
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

On Thu, 1 Nov 2018, Eial Czerwacki wrote:

> Greetings,
> 
> On 11/01/2018 12:39 PM, Shai Fultheim (Shai@ScaleMP.com) wrote:
> > On 01/11/18 11:37, Thomas Gleixner wrote:
> > 
> >> VSMP support is built even if CONFIG_X86_VSMP is not set. This leads to a build
> >> breakage when CONFIG_PCI is disabled as well.
> >>
> >> Build VSMP code only when selected.
> > 
> > This patch disables detect_vsmp_box() on systems without CONFIG_X86_VSMP, due to
> > the recent 6da63eb241a05b0e676d68975e793c0521387141.  This is significant
> > regression that will affect significant number of deployments.
> > 
> > We will reply shortly with an updated patch that fix the dependency on pv_irq_ops,
> > and revert to CONFIG_PARAVIRT, with proper protection for CONFIG_PCI.
> > 
> 
> here is the proper patch which fixes the issue on hand:
> >From ebff534f8cfa55d7c3ab798c44abe879f3fbe2b8 Mon Sep 17 00:00:00 2001
> From: Eial Czerwacki <eial@scalemp.com>
> Date: Thu, 1 Nov 2018 15:08:32 +0200
> Subject: [PATCH] x86/build: Build VSMP support only if CONFIG_PCI is
> selected
> 
> vsmp dependency of pv_irq_ops removed some years ago, so now let's clean
> it up from vsmp_64.c.
> 
> In short, "cap & ctl & (1 << 4)" was always returning 0, as such we can
> remove all the PARAVIRT/PARAVIRT_XXL code handling that.
> 
> However, the rest of the code depends on CONFIG_PCI, so fix it accordingly.
> 
> Signed-off-by: Eial Czerwacki <eial@scalemp.com>
> Acked-by: Shai Fultheim <shai@scalemp.com>

Nice cleanup!

Acked-by: Thomas Gleixner <tglx@linutronix.de>
