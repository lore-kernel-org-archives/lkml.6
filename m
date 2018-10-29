Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC042064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YpeMC0Yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC042064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeJ2ODQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:03:16 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:33755 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeJ2ODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:03:16 -0400
Received: by mail-ed1-f41.google.com with SMTP id f1-v6so6146310edi.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 22:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L8BmDcfIMNiHcYqq+EUNU6oRwocIp+IIN3LOuA/7ZIQ=;
        b=YpeMC0YhLurmQEdtsF7TPTr5KQLDXyqOUusmVfCynFSFT8AQ25xz0/NZC2/XsKGXLK
         KTODxi9MRyPD2Nu8T/hjDyVtLI7b6GMxSXhMa954BySqCfWBz1d2oiyqiujg5rP2lmM4
         rXHPlHkqjyDJaLEk36W4y3pC1PY1U/2LOUAAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8BmDcfIMNiHcYqq+EUNU6oRwocIp+IIN3LOuA/7ZIQ=;
        b=cIjBgQjo5QQtXUdk2uX242QerlGo4c8/QSZw0gFzMISoCZJGxhcGXvE1e7e1eNBSH9
         RoPv7uD63LtvV63g6UsdEBuROIXb29ijgX8r3oAGxartp2Bl33h8OS/x5pJA1yDtk2gV
         MlYwRYi6I5po0/ZKWAlqUYQCVPS3LxRo9HaUu27x5Emx86LplOtYaY6Q80pGX0HMXaap
         c3fsWNad+4pOnPYCxhBCNrrF3OTzrJsxS2cGoQwLs66pKQYrLtj5+kby8lnk1Wif4iBL
         idMaY7oGQ+bNLnBgWfRXF/N4iLclVDt428hbZVy3yK29Fk1O1+M3K/4TT9BHGaVIbkjo
         ZmUw==
X-Gm-Message-State: AGRZ1gIjFWJin9JFcmPrsVKubEkdvq+7iyKgfRtQwf8kkDwo2/XroGVt
        AnYUiZJJ6MP4GwNZ+HQmvtpAHNwfFafcPw==
X-Google-Smtp-Source: AJdET5cCXwnZ+FquqWm+n8IYqOKTTWP2WUdVdPXaBuor4LVmci/QhEio5kn69ADMxyhZzUN88reMXw==
X-Received: by 2002:a17:906:3fd3:: with SMTP id k19-v6mr4275714ejj.158.1540790170555;
        Sun, 28 Oct 2018 22:16:10 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id b7-v6sm5386581edd.43.2018.10.28.22.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 22:16:09 -0700 (PDT)
Date:   Mon, 29 Oct 2018 06:16:02 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFR] Store tearing
Message-ID: <20181029051602.GA3358@andrea>
References: <20181028230627.GA3420@andrea>
 <20181028231003.GA4021@andrea>
 <20181029012042.GR4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029012042.GR4170@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 06:20:42PM -0700, Paul E. McKenney wrote:
> On Mon, Oct 29, 2018 at 12:10:03AM +0100, Andrea Parri wrote:
> > Hopefully, with Paul's proper email address this time,
> > 
> >   Andrea
> > 
> > On Mon, Oct 29, 2018 at 12:06:27AM +0100, Andrea Parri wrote:
> > > Hi,
> > > 
> > > memory-barriers.txt says:
> > > 
> > >   [on "store tearing"]
> > > 
> > >   "In fact, a recent bug (since fixed) caused GCC to incorrectly use
> > >    this optimization in a volatile store.".
> > > 
> > > I was wondering if you could help me retrieve some reference/discussions
> > > about this?
> 
> This was quite some time ago, but it involved a 32-bit volatile store
> of a constant such as 0x10001.  The machine in question had a narrow
> store-immediate instruction, so the compiler emitted  a pair of 16-bit
> store-immediate instructions.  This bug was fixed, though only after
> significant screaming and shouting.

That does sound like an interesting discussion. ;D  Thanks for the info,

  Andrea


> 
> 							Thanx, Paul
> 
