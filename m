Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21495C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40D92081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kiHjQbuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40D92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeK2Hs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:48:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39024 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeK2Hs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:48:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so25974edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qkIU8ANFxK92+K1ZAwkgAqqJJ/gVt3nrYv81jkIB5V0=;
        b=kiHjQbuORkZnW8mi5sY+q9KzsQsjj7rpmm0TwgXSDiGJm/jvPC3wGsitkrCIYrv/G/
         2dTuaH8+htMFh9vHZS+uN4lhEez68TcGTREWAW6V4+gOcO4U1ScejTeKlibQF+JJL4TP
         q1haE0vSuXUgXbPyld1OOjFCXMM+/97E/qmI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qkIU8ANFxK92+K1ZAwkgAqqJJ/gVt3nrYv81jkIB5V0=;
        b=pNxL/hGO9LAUfIYisyQqzHIFH7xqkwPvEFtoA5dePf6Xa0xfTDZOpg8uKZw02FeMpA
         QS1XOJel2AQAF3xZNCJvfAO2ArACMnQGE+P0Ag9OMAoC/Z7fO1F+kbITcgek4aJwxHnL
         hdLUIPTFfv0V/D0mu0zjpKXMfn3Fa1PjgE7zlxXqApEO2Zkm9WeCotIwXdhblBEeuWFz
         jqjCGjeuzpx9tjbsIWA+IQCQqwbmJ4Afo6ZEukZs1YNC1sr82RK7Jj+NDDgBiI3NNB37
         V9wYe2lJ1K/HZWnZs1GIP19dTmq1PcKbPo5sj7O92kk41tbS6TTccM2vrIwDSt2Vjl+r
         8XZA==
X-Gm-Message-State: AA+aEWZ0F74K325mP0C5ssDEyAp6suhMs/kSS9ilWgCDf0MzzuFGdwG+
        hRiXwgihTl1e2GmAYKmAGOdRvA==
X-Google-Smtp-Source: AFSGD/XWInGAEazhNJhmwLiEK/dSVhdOq3h6VzDM+qvxLoQOxq//BAyobDLbXn1WtPUaN8oZwEdk5g==
X-Received: by 2002:a50:ba3d:: with SMTP id g58mr31879434edc.35.1543437931570;
        Wed, 28 Nov 2018 12:45:31 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id j21-v6sm1805ejz.51.2018.11.28.12.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 12:45:30 -0800 (PST)
Date:   Wed, 28 Nov 2018 21:45:23 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     David Howells <dhowells@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        gregkh@linux-foundation.org,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        viro@zeniv.linux.org.uk, sandeen@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fscache: Fix race in fscache_op_complete() due to
 split atomic_sub & read
Message-ID: <20181128204522.GA3183@andrea>
References: <20181126165606.GA11282@andrea>
 <20181017164848.GA9795@andrea>
 <20181017151134.GA8966@andrea>
 <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
 <153978621809.8478.2198040871218302573.stgit@warthog.procyon.org.uk>
 <14408.1539790333@warthog.procyon.org.uk>
 <26942.1543249596@warthog.procyon.org.uk>
 <4283.1543416204@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4283.1543416204@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sure.  My point was: those operations are currently not atomic _and_
> > they provide no ordering; I think that the above commit message does
> > a good work in explaining *why* we need atomicity, but can't say the
> > same for the memory-ordering requirement.
> 
> Having discussed it with Paul McKenney and thought about it some more, I think
> relaxed is probably okay since there isn't a pair of variables that need
> ordering.

Count several troubled, and exiting!, weekends spent "processing" (my)
conversations with Paul...  so been there! ;-)

Makes all sense to me of course, thank you for the clarification.

  Andrea


> 
> David
