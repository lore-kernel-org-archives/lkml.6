Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA74AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9115120663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqywoKhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9115120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeKZWbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:31:04 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:39298 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKZWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:31:04 -0500
Received: by mail-io1-f44.google.com with SMTP id k7so3766916iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 03:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XwYANmgHfcI6YQtgJc52IlBnoMOIe7KeYXOfPHsP9vY=;
        b=VqywoKhx6Mecj6d0abAo+RK+NmjALMmEjxpeTvkJBZsyo/y+2tDcBWog33v3NY/7m4
         nw1+OIcmCI1Y0A9n7fki166zGVR/BgiqYaAqDfnwStCJShj02fDLhuTqG38WilRTxkOd
         obwvJ5ddcETErs8IB42XSYJ7MUQwYaDlf8Mcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XwYANmgHfcI6YQtgJc52IlBnoMOIe7KeYXOfPHsP9vY=;
        b=IBIYBT2h7xf1vyuswoGkBaWl35fqzr95oHTcjQ20aq0f49MxhA8PLay7C8pM5SPkoC
         mxgXCTzH+VNxENiFi4Vo83Gw7t3+JCKjaXv8LPlcgXvGWaspcyc+yc/j4VpKMqFkjrm/
         /2O2V7/jN3mJi/tGicK0GHvKpLtXCVhyfbAloKsZDXvxa4wSW++5lXa7tLfJB+oAvPiy
         vI+/Qu26AbkJBGCfoFkAvQ2qtkbAaeh8Td/VVLDkMlbg/+ZfD/9DtEkCrum5+lPCiokB
         NOmql7HCk34JP6Jdj0PC35HD44ydSDvJ055+Sq6cG3Rm5sVWbqfEiAidCeAAMMBdEPqW
         MpNw==
X-Gm-Message-State: AA+aEWYu/21vz9pthxw+6dyAqaXNwbqC78FMW555T6ye7Vc6YHRTAMtR
        03Pl43MrQFxj7Auj9bfC+aaK9ODXzKZt9v0Od6tkPQ==
X-Google-Smtp-Source: AFSGD/Wdqty6UQ/utu+ofhcCJ/oe+J/lDecphNBTpnYzGO2TTgiGBTT35U2ePN9TxPUmvf+9xpgt4I1gibTs6fX7D2c=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr19666356ioh.294.1543232231796;
 Mon, 26 Nov 2018 03:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20181121223453.GA4016@andrea> <20181126093051.GV2131@hirez.programming.kicks-ass.net>
In-Reply-To: <20181126093051.GV2131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Nov 2018 12:37:00 +0100
Message-ID: <CAKfTPtDm49JS7thuUn0--ocqpn2Du4qi8qsUeeHzGrAG_F2epw@mail.gmail.com>
Subject: Re: [Question] atomic_fetch_andnot() in nohz_idle_balance()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     andrea.parri@amarulasolutions.com, Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 at 10:30, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 21, 2018 at 11:34:53PM +0100, Andrea Parri wrote:
> > Hi,
> >
> > The comment for the atomic_fetch_andnot() in nohz_idle_balance() says:
> >
> >   "barrier, pairs with nohz_balance_enter_idle(), ensures ..."
> >
> > which, well, does sound a note of warning... ;-)
> >
> > I see that nohz_balance_enter_idle() has an smp_mb__after_atomic() but
> > the comment for the latter suggests that this barrier is pairing with
> > the smp_mb() in _nohz_idle_balance().
> >
> > So, what is the intended pairing barrier for the atomic_fetch_andnot()?
> > what (which memory accesses) do you want "to order" here?
>
> I can't seem to make sense of that comment either; the best I can come
> up with is that it would order the prior NOHZ_KICK_MASK load vs us then
> changing it.
>
> But that would order against kick_ilb(), not enter_idle.
>
> Vincent?

I can't come with a good explanation.
After looking into my email archive, the only explanation that i have
is that the comments remains from a previous iteration of the feature
that was based on a nohz.stats_state mechanism
