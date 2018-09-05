Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56155C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE1620861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eaRE4f1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE1620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIETzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:55:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36555 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:55:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so6410824edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GMKU+EQ6NRL4FG/KWbBi5V5KZLsTBvKTdBtcZBX0qRQ=;
        b=eaRE4f1lHSCIKWkkN3WG1wXqPqr6A9L4rpRvdSbQvO8tTcEcp3+XbTFe+7OWqZDZiF
         y0ptAv28PJ62xc7XUEIQ49/GQ334rtn4NObLZkeawEtSPtxVmMg/3LUwVnmnMgp3B/8u
         tszG8Qs5Y8rN3ylH/HHwcm8nePPbUPQ5b0usw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GMKU+EQ6NRL4FG/KWbBi5V5KZLsTBvKTdBtcZBX0qRQ=;
        b=iQ8kaWifRFB9lTfw+dRfAn7uDWHXV5TkBUu2xe/pZGh159SpH+4SlYGW33cL2aYTF/
         NETODl72B+VKoMrcMLS2Mhauy/Si5naT3u5RR7O3JvpgRfQpDwqAwCT6E/2h89119VO1
         dDoYrZDnl5XYDg9cu9buWxp8Mx7Uow98CuiKxbX0CwsQMa0flFIrRJY71G5zJETw442g
         HcEvLwZwg1AZ09+AUNu1HOEgRCVtlGW2bWZbWgIa6w5ZNvdJk+iL5T4KAK6tL3dNgb/O
         lDyIlPorne8fP3Yv9qdS/x0+aGqrDuUvdZ42P3gSCOyZu11ONuHZuB7bsG1pD5R1xv9B
         MxAg==
X-Gm-Message-State: APzg51AFsoO5et7poa0X2tU+GSCDQU6FLKRkUddwI9guwx93ANvjvnKL
        3/L0y3/nC1F5/GgIDJBeqhddGA==
X-Google-Smtp-Source: ANB0VdYx9xtJgxb7i8gHCOu7b4dh24w0ma+/GSUvJpICR0L/NSRuG5/HPsVKlaDv6IxRpoN1e9SV6w==
X-Received: by 2002:a50:a7e2:: with SMTP id i89-v6mr42364739edc.176.1536161073548;
        Wed, 05 Sep 2018 08:24:33 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id d56-v6sm1226501edb.7.2018.09.05.08.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 08:24:32 -0700 (PDT)
Date:   Wed, 5 Sep 2018 17:24:18 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180905152418.GA8874@andrea>
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
 <20180905072151.GA3185@andrea>
 <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
 <20180905150042.GA8820@andrea>
 <e8dbdd89-ff65-31ea-8d04-7e84b64a98b0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8dbdd89-ff65-31ea-8d04-7e84b64a98b0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>> Do you have any concrete suggestions (i.e., some actual text) for 
> >>>> improvements to the patch description?  Earlier in your message you 
> >>>> mentioned that Will's comment:
> >>>>
> >>>> 	LKMM offers stronger guarantees that can portably be relied upon
> >>>> 	in the codebase.
> >>>>
> >>>> would make a good addition.  Suitably edited, it could be added to the
> >>>> description.  I can think of a few other things myself, but I'd like to 
> >>>> hear your thoughts.  Anything else?
> >>>
> >>> Yes: I do sometimes have the impression that your "rules" for trimming
> >>> text in emails/replies are too aggressive...
> >>
> >> Andrea, by saying "Yes:", do you mean you have something else to be added?
> > 
> > Indeed (examples in the trimmed text).

"examples" of "concrete suggestions" (pros or cons) to amend the log.


> 
> So, you mean just amending commit log does not work for you?

I can't really answer this...; let's see the revisited log first.

  Andrea


> 
> > 
> > 
> >> I don't think you do, but want to make sure.
> >>
> >> I'm a bit surprised to see all you wanted was the amendment of the
> >> commit log...
> > 
> > Well, I said that it was my only current constructive argument...
> 
> This thread is getting quite hard for me to follow...
> 
>    Akira
> 
> > 
> >   Andrea
> > 
> > 
> >>
> >>   Akira
> >>
> >>>
> >>>   Andrea
> >>>
> >>>
> >>>>
> >>>> Alan
> >>>>
> >>
> 
