Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18BC20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18BC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeK3G2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:28:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35774 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeK3G2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:28:49 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gSRt9-0007nG-S0; Thu, 29 Nov 2018 20:22:16 +0100
Date:   Thu, 29 Nov 2018 20:22:10 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     Nadav Amit <nadav.amit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
In-Reply-To: <87bm68i099.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1811292021290.1657@nanos.tec.linutronix.de>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-2-vkuznets@redhat.com> <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com> <20181127184835.GA5147@rkaganip.lan> <8A215F49-BB8F-4E93-AC62-EC33B4734F24@gmail.com>
 <87a7ltjxnz.fsf@vitty.brq.redhat.com> <alpine.DEB.2.21.1811281404230.1532@nanos.tec.linutronix.de> <B310522C-8D67-4143-8281-2C870A881F6B@gmail.com> <87bm68i099.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1619686258-1543519335=:1657"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1619686258-1543519335=:1657
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 29 Nov 2018, Vitaly Kuznetsov wrote:
> Nadav Amit <nadav.amit@gmail.com> writes:
> 
> >> On Nov 28, 2018, at 5:07 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> 
> >> On Wed, 28 Nov 2018, Vitaly Kuznetsov wrote:
> >> 
> >>> Nadav Amit <nadav.amit@gmail.com> writes:
> >>> 
> >>>> On a different note: how come all of the hyper-v structs are not marked
> >>>> with the “packed" attribute?
> >>> 
> >>> "packed" should not be needed with proper padding; I vaguely remember
> >>> someone (from x86@?) arguing _against_ "packed".
> >> 
> >> Packed needs to be used, when describing fixed format data structures in
> >> hardware or other ABIs, so the compiler cannot put alignment holes into
> >> them.
> >> 
> >> Using packed for generic data structures might result in suboptimal layouts
> >> and prevents layout randomization.
> >
> > Right, I forgot about the structs randomization. So at least for it, the
> > attribute should be needed.
> >
> 
> Not sure when randomization.s used but Hyper-V drivers will of course be
> utterly broken with it.
> 
> > To prevent conflicts, I think that this series should also add the
> > attribute in a first patch, which would be tagged for stable.
> 
> As the patchset doesn't add new definitions and as Paolo already queued
> it I'd go with a follow-up patch adding "packed" to all hyperv-tlfs.h
> structures. The question is how to avoid conflicts when Linus will be
> merging this. We can do:
> - Topic branch in kvm
> - Send the patch to x86, make topic branch and reabse kvm
> - Send the patch to kvm
> - ... ?
> 
> Paolo/Thomas, what would be your preference?

As Paolo already has it, just route it through his tree please.

Thanks,

	tglx
--8323329-1619686258-1543519335=:1657--
