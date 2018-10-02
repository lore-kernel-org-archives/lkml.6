Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB45C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D719A2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gdMizk7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D719A2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJBTPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:15:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41765 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeJBTPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:15:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so1880240edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tIrwtXICFxLC6HbT3shDwrUbXd/Uc1OI4T4vdixqc+o=;
        b=gdMizk7TqaoL3YX2+hcQmRMAZaQJlyj8SvsssMrzWsoi9SMBD4PC1D0x8Al7zFMakW
         GtqkHBOlDNYEAqN4fDpI7DntFXPhv5i0IsBODbJ2vZphYKxKN28NO/RABEXikMP6adVE
         N6YuJouvfz4HjX6WX+ZOx5zQbt1sPA+Cau3eE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIrwtXICFxLC6HbT3shDwrUbXd/Uc1OI4T4vdixqc+o=;
        b=S+A3PIYUtV/h1r5DIToxWWbf9ohlkoDjLrukP6I37e21Bqz6G4uMm0oepCzBbsZyHx
         5Qo/JF//eev55XmPVrFz6hifW9vp5INfNNAbHMfpskqKF+LknsEo/BUP8WfEg3jf2hfF
         CXNcJVESHET8havNxnDJPJY4s0lTwfvARjyWOg7iNkhTgkECVbKOr60U3pyFcYoqq//p
         aYeW4vObGG/5WKb0SXah6TcUdvpzjihIp1aCeTzNeBgkKd7QGYDut9WH4AGRKZAY/mpR
         kX/inLFakdjy5LNh6oXDzEnbUgqqMud8VmZewqEUCmykkIQmhvoqSeDHDW9yoDziClDT
         DL0w==
X-Gm-Message-State: ABuFfohyrCUy678W5MmN8S9tJio/bFCSbGE+ebfZwS0X/8Z/CWeg8DWu
        Qq6T0mkBRQFwh5GX38v6W8kd894pz2TGJw==
X-Google-Smtp-Source: ACcGV63Fynzf9vGaDkNHGb5MUeyJtliWyeC38yarBjPkm/pxiOvCt1XNLEepqsiEHUvnlr/BIHVOIQ==
X-Received: by 2002:a50:a2a6:: with SMTP id 35-v6mr23726211edm.276.1538483519681;
        Tue, 02 Oct 2018 05:31:59 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id h8-v6sm5482471edi.68.2018.10.02.05.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 05:31:59 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:31:52 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20181002123152.GA10055@andrea>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20181001171700.GC13918@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001171700.GC13918@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> consider this scenario with your patch:
> 
> 1. CPU0 sees a locked val, and is about to do your xchg_relaxed() to set
>    pending.
> 
> 2. CPU1 comes in and sets pending, spins on locked
> 
> 3. CPU2 sees a pending and locked val, and is about to enter the head of
>    the waitqueue (i.e. it's right before xchg_tail()).
> 
> 4. The locked holder unlock()s, CPU1 takes the lock() and then unlock()s
>    it, so pending and locked are now 0.
> 
> 5. CPU0 sets pending and reads back zeroes for the other fields
> 
> 6. CPU0 clears pending and sets locked -- it now has the lock
> 
> 7. CPU2 updates tail, sees it's at the head of the waitqueue and spins
>    for locked and pending to go clear. However, it reads a stale value
>    from step (4) and attempts the atomic_try_cmpxchg() to take the lock.
> 
> 8. CPU2 will fail the cmpxchg(), but then go ahead and set locked. At this
>    point we're hosed, because both CPU2 and CPU0 have the lock.

Thanks for pointing this out.   I am wondering: can't we have a similar
scenario with the current code (i.e., w/o these patches): what prevents
the scenario reported below, following Peter's diagram, from happening?

  Andrea


  CPU0		CPU1		CPU2		CPU3

0)						lock
						  trylock -> (0,0,1)
1)lock
    trylock /* fail */

2)		lock
		  trylock /* fail */
		  fetch_or_acquire -> (0,1,1)
		  wait-locked

3)				lock
				  trylock /* fail */
				  goto queue

4)						unlock -> (0,1,0)
		  clr_pnd_set_lck -> (0,0,1)
		  unlock -> (0,0,0)

5)  fetch_or_acquire -> (0,1,0)
6)  clr_pnd_set_lck -> (0,0,1)
7)				  xchg_tail -> (n,0,1)
				  load_acquire <- (n,0,0) (from-4)
8)				  cmpxchg /* fail */
				  set_locked()
