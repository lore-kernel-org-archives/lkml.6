Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3903C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937EE20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937EE20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJIROu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:14:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38188 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJIROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:14:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so1248652wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4UrOOXbZaAM+Hwqsonce9DPd9+3p4vFhqVV1B8J19k=;
        b=M9ygXI7XswWurMuqTG9K1fQ30B3+naOBWPklROg9sqAS5XLa3u2xlCSl95ijCIN9lM
         M7a1ILr6OKujq6w+uI1vL/yWHa3ZFpNriLdwf6D5C7ol9J4annwJE9YAnrNmzitX0mgi
         VD+ZOdv4gi65PJCglzcEk4ZpJWiLyNZ07Pp+VkhL/Zu/o2bsfzTA51RyL8Y2v95pQaJf
         UfjCayHB6HvMKvyK6CdpVup83SYA6ZYny1hsY7i9qi5uA3UjpVeHlZer7tOjgN8F8C5/
         JxNn1PxBD93gFdvfqzC7YMFzw1ZoMXghNR50ScxqUiurVvXvbX1Mgg2ib1acMiQ+R/2P
         mFDw==
X-Gm-Message-State: ABuFfoi3HSYle4+cSJPjiaiPed0bF7yVX257vwRBJYPVO0REDJdeDV7b
        2q/nuU7nTQTapFI14zoAVRRW6g==
X-Google-Smtp-Source: ACcGV61jcwICDLKfWU4gML2G8W21dFvm/BUCEYK15BG9FH14t1nib4rzwLAnw6owcR8G5hKq8y+bhg==
X-Received: by 2002:a1c:7408:: with SMTP id p8-v6mr1385445wmc.74.1539079121545;
        Tue, 09 Oct 2018 02:58:41 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id y138-v6sm10528988wmd.2.2018.10.09.02.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:58:40 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:58:35 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181009095835.GE9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009094441.GI5663@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009094441.GI5663@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/18 11:44, Peter Zijlstra wrote:
> On Tue, Oct 09, 2018 at 11:24:26AM +0200, Juri Lelli wrote:
> > The main concerns I have with the current approach is that, being based
> > on mutex.c, it's both
> > 
> >  - not linked with futexes
> >  - not involving "legacy" priority inheritance (rt_mutex.c)
> > 
> > I believe one of the main reasons Peter started this on mutexes is to
> > have better coverage of potential problems (which I can assure everybody
> > it had). I'm not yet sure what should we do moving forward, and this is
> > exactly what I'd be pleased to hear your opinions on.
> 
> Well that, and mutex was 'simple', I didn't have to go rip out all the
> legacy PI crud.

Indeed.

> If this all ends up working well, the solution is 'simple' and we can
> simply copy mutex to rt_mutex or something along those lines if we want
> to keep the distinction between them. Alternatively we simply delete
> rt_mutex.

Ah.. right.. sounds *scary*, but I guess it might be an option after
all.

> Thanks for reviving this.. it's been an 'interesting' year and a half
> since I wrote all this and I've really not had time to work on it.

n/p, it has been a long standing thing to look at for me as well. Thanks
again for sharing your patches!
