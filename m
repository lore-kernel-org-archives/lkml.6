Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CB0218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbfA3V1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:27:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48289 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfA3V1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:27:54 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goxOf-00066m-0E; Wed, 30 Jan 2019 22:27:49 +0100
Date:   Wed, 30 Jan 2019 22:27:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch 2/2] proc/stat: Make the interrupt statistics more
 efficient
In-Reply-To: <20190130212443.GA15533@avx2>
Message-ID: <alpine.DEB.2.21.1901302227220.8094@nanos.tec.linutronix.de>
References: <20190130123130.785636313@linutronix.de> <20190130123615.592071954@linutronix.de> <20190130212443.GA15533@avx2>
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

On Thu, 31 Jan 2019, Alexey Dobriyan wrote:

> On Wed, Jan 30, 2019 at 01:31:32PM +0100, Thomas Gleixner wrote:
> > +static void show_irq_gap(struct seq_file *p, int gap)
> > +{
> > +	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
> > +
> > +	while (gap > 0) {
> > +		int inc = min_t(int, gap, ARRAY_SIZE(zeros) / 2);
> > +
> > +		seq_write(p, zeros, 2 * inc);
> > +		gap -= inc;
> > +	}
> > +}
> > +
> > +static void show_all_irqs(struct seq_file *p)
> > +{
> > +	int i, next = 0;
> > +
> > +	for_each_active_irq(i) {
> > +		show_irq_gap(p, i - next);
> > +		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
> > +		next = i + 1;
> > +	}
> > +	show_irq_gap(p, nr_irqs - next);
> > +}
> 
> Every signed int can and should be unsigned int in this patch.
> 

Indeed.
