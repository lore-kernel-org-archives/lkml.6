Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CA9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E297F216FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E297F216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933953AbeGFRB6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:01:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55297 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933452AbeGFRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:01:56 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbU7F-0000ow-1v; Fri, 06 Jul 2018 19:01:53 +0200
Date:   Fri, 6 Jul 2018 19:01:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
cc:     KY Srinivasan <kys@microsoft.com>, Ingo Molnar <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
In-Reply-To: <SN6PR2101MB1120C1ACA2320EA5AEF5E590DC470@SN6PR2101MB1120.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1807061900110.1592@nanos.tec.linutronix.de>
References: <20180703230155.15160-1-kys@linuxonhyperv.com> <20180704161039.GA23658@gmail.com> <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com> <20180705153820.GA26768@gmail.com> <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705222302.GB5410@gmail.com> <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de> <MW2PR2101MB11131ACDDA6734BD588919F5A0470@MW2PR2101MB1113.namprd21.prod.outlook.com> <alpine.DEB.2.21.1807061052410.1664@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1807061240560.1664@nanos.tec.linutronix.de> <SN6PR2101MB1120C1ACA2320EA5AEF5E590DC470@SN6PR2101MB1120.namprd21.prod.outlook.com>
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

On Fri, 6 Jul 2018, Michael Kelley (EOSG) wrote:
> > -----Original Message-----
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Sent: Friday, July 6, 2018 3:42 AM
> > To: KY Srinivasan <kys@microsoft.com>
> > Cc: Ingo Molnar <mingo@kernel.org>; x86@kernel.org; gregkh@linuxfoundation.org; linux-
> > kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> > jasowang@redhat.com; hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>;
> > Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> > Subject: RE: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI enlightenment.

Can you please strip that useless duplication of the mail header from your
replies. Manualy if you can't teach your MUA to avoid that :)

> > On Fri, 6 Jul 2018, Thomas Gleixner wrote:
> > Applied it to x86/urgent and fixed up the '-1' sloppy hack as pointed out
> > by Vitaly and merged x86/urgent into x86/hyperv.
> > 
> > Please check both branches for correctness.
> 
> Changes look good to me.  Some pre-existing signed/unsigned type sloppiness is
> still there in that hv_cpu_number_to_vp_number() should be 'u32' instead
> of 'int', along with related local variables, but that's probably best to fix in
> linux-next on top of Vitaly's other changes.  This code will work.

Yes, delta patch is fine on top of x86/hyperv.

Thanks,

	tglx
