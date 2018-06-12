Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D34D2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940232089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940232089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933963AbeFLTn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:43:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42230 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933328AbeFLTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:43:54 -0400
Received: from p4fea5fc6.dip0.t-ipconnect.de ([79.234.95.198] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fSpCm-0003N0-Kn; Tue, 12 Jun 2018 21:43:48 +0200
Date:   Tue, 12 Jun 2018 21:43:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     =?ISO-8859-15?Q?Andreas_Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, quilt-dev@nongnu.org
Subject: Re: [PATCH 0/3] sched/swait: Convert to full exclusive mode
In-Reply-To: <CA+55aFx81igOjFZcvO03mvDFd3=pxsq2QuNrWrPW+4pvJy780A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806122134410.1592@nanos.tec.linutronix.de>
References: <20180612083449.100099222@infradead.org> <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com> <CAHpGcMJSb4pqWF7X3K7yrk+N=FwcSrbjWm9xvprpaLRGgdE24A@mail.gmail.com>
 <CA+55aFx81igOjFZcvO03mvDFd3=pxsq2QuNrWrPW+4pvJy780A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1222144824-1528832628=:1592"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1222144824-1528832628=:1592
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 12 Jun 2018, Linus Torvalds wrote:
> On Tue, Jun 12, 2018 at 11:52 AM Andreas Grünbacher
> <andreas.gruenbacher@gmail.com> wrote:
> >
> > Quilt uses those Content-Disposition headers to preserve the patch
> > filenames;
> 
> That' what I was assuming, but does anybody really care?

People might have scripts using it but I doubt anyone still relies on that
because git mail never did that inline/filename dance so scripts which
convert mboxes to quilt need to have a mechanism to create filenames
anyway. My personal script uses the subject line to create the filenames
and I never tried to use the inline filename as those filenames are often
enough complete garbage.

> (Even if they use quilt to manage patches, maybe they don't _send_
> them that way?)

Many quilt users still do.

> How long has quilt been doing it?

Forever.

> Also, note that I'm not at all sure that it's _just_ the
> 
>     Content-Disposition: inline
> 
> that triggers this. There might be something else in those emails that
> triggers it but that's the thing that stands out.

It is. There is nothing else in the headers which could cause that. quilt
mail format is pretty simplistic.

> > I'm not sure whose workflows would break if we kill those headers
> > altogether, but maybe we can omit them by default.
> 
> That would be lovely at least for my case.

No objections.

Thanks,

	tglx
--8323329-1222144824-1528832628=:1592--
