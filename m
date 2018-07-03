Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064AB24781
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064AB24781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeGCVA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:00:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45493 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeGCVA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:00:27 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faSOa-0002iO-3a; Tue, 03 Jul 2018 22:59:32 +0200
Date:   Tue, 3 Jul 2018 22:59:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        boris.ostrovsky@oracle.com, pbonzini@redhat.com
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <20180629085752.zkbxlwc2rzlm63lk@xakep.localdomain>
Message-ID: <alpine.DEB.2.21.1807032257330.1816@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de> <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com> <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
 <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com> <alpine.DEB.2.21.1806290925340.1578@nanos.tec.linutronix.de> <20180629085752.zkbxlwc2rzlm63lk@xakep.localdomain>
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

On Fri, 29 Jun 2018, Pavel Tatashin wrote:
> On 18-06-29 09:30:10, Thomas Gleixner wrote:
> For now, in my series, I would like check in tsc_early_init() if we are
> running xen, and set tsc_khz to 0 if so. Later in tsc_init() we will get
> a proper calibration. The question is how to make this check least
> intrusive.

By not having it at all. Talk to the XEN folks (IIRC there are a few
coworkers of you involved with XEN).

Thanks,

	tglx


