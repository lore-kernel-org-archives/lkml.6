Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04DEC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B98204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B98204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeKDCeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:34:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60303 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeKDCeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:34:06 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIzcb-0006YB-U7; Sat, 03 Nov 2018 18:22:06 +0100
Date:   Sat, 3 Nov 2018 18:22:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     Michael Kelley <mikelley@microsoft.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
In-Reply-To: <11f82d95-539c-b680-183b-b6c5c60468a8@suse.com>
Message-ID: <alpine.DEB.2.21.1811031817570.3160@nanos.tec.linutronix.de>
References: <1541093374-10496-1-git-send-email-mikelley@microsoft.com> <11f82d95-539c-b680-183b-b6c5c60468a8@suse.com>
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

On Fri, 2 Nov 2018, Juergen Gross wrote:
> On 01/11/2018 18:30, Michael Kelley wrote:
> > pit_shutdown() doesn't work on Hyper-V because of a quirk in the
> > PIT emulation. This problem exists in all versions of Hyper-V and
> > had not been noticed previously. When the counter register is set
> > to zero, the emulated PIT continues to interrupt @18.2 HZ.
> > 
> > So add a test for running on Hyper-V, and use that test to skip
> > setting the counter register when running on Hyper-V.
> > 
> > This patch replaces a previously proposed patch with a different
> > approach. This new approach follows comments from Thomas Gleixner.
> 
> Did you consider using a static_key instead? You could set it in
> ms_hyperv_init_platform(). This would enable you to support future
> Hyper-V versions which don't require avoiding to set the count to zero.

Duh. Now that you say it it's more than obvious. Instead of checking for
running on hyperv have a quirk check in that function and set it from
hyperv. Not necessarily a static key required as this is not a fast path,
so a simple ro_after_init marked variable is good enough

Michael, sorry for guiding you down the wrong road. Juergens idea is much
better.

If you redo that, could you please make sure, that your mail series is
properly threaded? i.e. the 1..n/n mails contain a

	 Reference: <message_id_of_0/n>

Thanks,

	tglx


