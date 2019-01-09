Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED02C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5766D20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gc82E8mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfAIACZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:02:25 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:39284 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAIACY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:02:24 -0500
Received: by mail-ed1-f42.google.com with SMTP id b14so5852597edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m9+WYIVyNxmgqLem1K5EceoV5fNoCdzLQqMQZD6WVMM=;
        b=Gc82E8moS/YlaP+5ub/BQCsMEB6xjWWCRlfWnLspsE61ZEBgV+bJZGzq/gWAuf1hgr
         YzgWHtS0rAu3IFU+0LmJJGXViP/KMm9NdxIMf62MkURJoNr9/dwCPN2slgg/6QP89EZK
         tHqkHZa7hPiYkVr2T6G1lq95KGQ7eXpMHnf6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m9+WYIVyNxmgqLem1K5EceoV5fNoCdzLQqMQZD6WVMM=;
        b=k/hI04s9lmgjOp9O/9XQvu9SucJ88uyrR684noKZ+GzAmOmg6KFprie5puUYpmiols
         +CTwg0UvdE3E2pzcQj6z7UlIw3WPQt0cY+bUuZ1+NfsgORnhrWmNIGdAA49T9U9O83ua
         KSX0yB6phKH/Xw1DaTCLKxfkSvHKCWhY//9iZlC8bSvE+9Gl/+c6oUYjtli5yEDCvRF3
         QYtXsGSjemeYgWBLf2p+vYlIocrXQg+bZTxCOj3eJuKCSEMnlK2fWQI2+y/wTpZSZ04/
         9jDtpmm6dDpWiTgkoFzTuUgSbv134m22sC7Wg+iOrsiEQYhI6OsBQGvsj2fRDEBEuC44
         2pNw==
X-Gm-Message-State: AJcUukey15TOvBSIsHDzs0b2CQ4XhtWB9rypqcUV+NtCNpbTkFG0EaL6
        xvDmoVlPQyEsnsYawCI8Rl6s2g==
X-Google-Smtp-Source: ALg8bN6axoeGkvsjAxPetyG6lvstCoPFLV87jbSydc0+hUGLkp53KR/EtKOfXxA5/478ImLrbgOPxQ==
X-Received: by 2002:aa7:c6d1:: with SMTP id b17mr3982459eds.249.1546992142463;
        Tue, 08 Jan 2019 16:02:22 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id n10sm445016edq.33.2019.01.08.16.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 16:02:21 -0800 (PST)
Date:   Wed, 9 Jan 2019 01:02:14 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Anatol Pomozov <anatol.pomozov@gmail.com>
Cc:     fw@strlen.de, Dmitry Vyukov <dvyukov@google.com>,
        paulmck@linux.ibm.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190109000214.GA5907@andrea>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anatol,

On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> Hello folks,
> 
> A bit of context what I am doing. I am trying to port KTSAN (Kernel
> Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> and makes sure it is accessed in a thread-safe manner.

Interesting!  FYI, some LKMM's maintainers (Paul included) had and
continued to have some "fun" discussing topics related to "thread-
safe memory accesses": I'm sure that they'll be very interested in
such work of yours and eager to discuss your results.

Cheers,
  Andrea
