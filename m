Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA8FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657FA214AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657FA214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeGEWq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:46:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeGEWq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:46:26 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbD13-0005s7-Sb; Fri, 06 Jul 2018 00:46:22 +0200
Date:   Fri, 6 Jul 2018 00:46:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     KY Srinivasan <kys@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
In-Reply-To: <20180705222302.GB5410@gmail.com>
Message-ID: <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de>
References: <20180703230155.15160-1-kys@linuxonhyperv.com> <20180704161039.GA23658@gmail.com> <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com> <20180705153820.GA26768@gmail.com> <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705222302.GB5410@gmail.com>
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

On Fri, 6 Jul 2018, Ingo Molnar wrote:
> * KY Srinivasan <kys@microsoft.com> wrote:
> > I am confused. The label ipi_mask_done was introduced in this patch
> > (the patch under question fixes a circular dependency in this patch):
> > 
> > commit 68bb7bfb7985df2bd15c2dc975cb68b7a901488a
> > Author: K. Y. Srinivasan <kys@microsoft.com>
> > Date:   Wed May 16 14:53:31 2018 -0700
> > 
> >     X86/Hyper-V: Enable IPI enlightenments
> > 
> >     Hyper-V supports hypercalls to implement IPI; use them.
> > 
> >     Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >     Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > 
> > This patch was committed by Thomas some weeks ago and is in linux-next.
> > This patch is also in 4.18-rc3.
> 
> And then that name was changed to a different label in:
> 
>   4bd06060762b: x86/hyper-v: Use cheaper HVCALL_SEND_IPI hypercall when possible
> 
> So maybe you were testing on an older kernel. Could you try the latest -tip?

The problem is that the wreckage is in Linus tree and needs to be fixed
there, i.e. via x86/urgent.

Now we have the new bits queued in x86/hyperv already which collide. So we
need to merge x86/urgent into x86/hyperv after applying the fix and mop up
the merge wreckage in x86/hyperv.

I'll have a look tomorrow morning unless you beat me to it.

Thanks,

	tglx
