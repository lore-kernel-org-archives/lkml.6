Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E29C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EF120836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wKKJhp7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EF120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936117AbeFSWTR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:19:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40723 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935912AbeFSWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:19:15 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so496037pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+sERxtNUIBI5JSphQbyJXa+JULTDg0FWPDhfOqQu4O4=;
        b=wKKJhp7F73oCsiZErGNLU6/jvGCvGdFqJrMNvgZuD73PLQtt5ru/q/vn0dyMBhvSaZ
         +a4+3OL0kLRox6LJywg/qCUfWgKnFctwG2bNc+MbtkV/OfOKGolNRJe+Y7+FTdfZSAkk
         fMMoIp3r0N/oK6xGnOYIefX5I++EL6J7SD0a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+sERxtNUIBI5JSphQbyJXa+JULTDg0FWPDhfOqQu4O4=;
        b=qcI0MB6wigpxAIZ+/XfS3zfr9Vje61p6vk7/LahkMA1UydsHFtnnPO4DStSVw/o8oJ
         qTL9Xjx59ibI/+L/OrW2S2hP7WLDZxCXafpABinYk03ZYtvYZ0uiFCsqzGdM81EOmt6O
         O6fpWADOdhUn+NGetAcDjltSdB2u6XTz1MqxAifP1FKML4TnHtHkvGOkn2XjTdV1mEBO
         GoUhCrddiRPdq0YGmHV5BY6J0vWZJG/iHt10Tfoeef8CuCH3cuQSDxCvDXFSgH3Tr597
         PzKL2FmFBXTvQb2FdW5KMF0epSKbt1fz3VTomeY/0bVuleIdKQdYukdKvhyoULmkemKa
         UCDA==
X-Gm-Message-State: APt69E1ZaIpeMjUAzT8xbZhowIqQDl2ruBKo5w3SGT9e2zawOs5zjZ0Z
        Sbd72jHbFmSt+J2b1lEl6kphjQ==
X-Google-Smtp-Source: ADUXVKKM5MshOMkPdQc1/kRxokh6Bq8TOpBcn7thmRGsN2tnUTJu9WhRbfREronWM1KVIujC1pvjcQ==
X-Received: by 2002:a62:4e07:: with SMTP id c7-v6mr20064848pfb.149.1529446754863;
        Tue, 19 Jun 2018 15:19:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id s75-v6sm912543pfj.125.2018.06.19.15.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 15:19:14 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:19:14 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH 1/2] rcu: Assign higher priority to RCU threads if its
 rcutorture
Message-ID: <20180619221914.GB41539@joelaf.mtv.corp.google.com>
References: <20180619062215.221564-1-joel@joelfernandes.org>
 <20180619063421.GA221670@joelaf.mtv.corp.google.com>
 <20180619160024.GI3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619160024.GI3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:00:24AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 18, 2018 at 11:34:21PM -0700, Joel Fernandes wrote:
> > On Mon, Jun 18, 2018 at 11:22:14PM -0700, Joel Fernandes wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > rcutorture boost tests fail even with CONFIG_RCU_BOOST set because
> > > rcutorture's threads are equal priority to the default RCU kthreads (RT
> > > class with priority of 1).
> > 
> > Sorry for the weird subject line, I meant "rcu: Assign higher prio if
> > rcutorture is built into kernel". I have included the patch with the subject
> > line fixed up below (if you prefer to take that instead).
> > 
> > Also one question, incase rcutorture is a module, we can't raise the priority
> > of the kthreads because it would be too late to do at module load time. In
> > this case, do you have any ideas on what we can do? I was thinking we can
> > access the kernel command line from within rcutorture module and check if
> > 'rcutree.kthread_prio' was passed. And if it is and isn't sufficiently high,
> > then we avoid testing boost feature at all (and print a nice message telling
> > the user about the issue).
> 
> I do like the idea of checking and printing the message in this case.

Cool, I used this approach in the series I just sent. I agree its good to
report it.

> Another alternative would be to allow rcutree.kthread_prio to be changed
> at runtime.  But one caution: rcutree.kthread_prio applies to a number
> of kthreads, not just the boost kthreads, so this approach might have
> some unwelcome side-effects.

Yes, I was trying to avoid those complexities just because of rcutorture.

> > OTOH, we can just let rcutorture module loaders fail the test if you feel
> > very few automation tests do the module loading way of rcutorture and so a
> > boost test failure there is tolerable. For me, I will likely be running
> > rcutorture only as a built-in so I am Ok with not special casing it within
> > rcutorture.
> 
> I don't know of anyone using the module-loading approach.  Probably
> someone somewhere does it from time to time, though.

Oh Ok :). Then I guess the warning print from rcutorture is sufficient as I did.

thanks!

 - Joel

