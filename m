Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98431C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5526C20875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="espy/a5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5526C20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeFUAZr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:25:47 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39024 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFUAZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:25:30 -0400
Received: by mail-pg0-f66.google.com with SMTP id w12-v6so557115pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=anwE8MLr/z0p9+77NosJbUaM6khG49rw9iD0EFfeq0o=;
        b=espy/a5cl+UMrQPjNzgSIPMIYtRPf3FX4Ne/W9GeEmRSPq5qBBsm6soJf+pqhGiY4C
         RaXnKfuo/ZkHMLg6UNcz7pUmB0uWvCYFQA8tWGpzP35sMSa6hyNkE7hF9L+fcWnJCGUm
         6pYv3uLiJMaoKzbO1TtKQdVb+Kq6BHPpdnVl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=anwE8MLr/z0p9+77NosJbUaM6khG49rw9iD0EFfeq0o=;
        b=DEOmlE8foj6xZ+DFKIL/n5qpfNTfJ3A4YYhC/a+WZT1mZaKL1E7AAM82OXOPY2kIr1
         ECQ9kz1N7j30oYGFdvLgyWTJRUhhgXtymq9i6gUjr/cNVFSdHFXsYw6DmZpYgVEWHi/k
         ja8/f2Kty908evciWPBgprRLnDnGVrYTrRTBUyjw4BP4VKD1XvGclHT5SMnEjZ6fHMls
         TcZ9hO04EtFJCU5O41L9ettkhVYZFi1T5LMAxU+BSW/AVMIKxKD8KbLk5o+zb+ntIN7b
         ej0TteBYdmexu6GmW/Z3Xzup1RmIdXIAxB4TLwWYncauNWgiOre1RRc6bQX0T/i1xKu8
         29Gg==
X-Gm-Message-State: APt69E136Sqy7+RRN6kguCrY8AZO2RXCdWdNE6DGS1qUmi5FZzaDD/qv
        Jy/Fd6ju0qVtG3mCD7fCPTnQybzrCKY=
X-Google-Smtp-Source: ADUXVKLhyektPH4G4gtaPoBywCMG1Ntp3wEX7ZEj6Q/WqXMrao9dMmZD5S9pqijQdrzikw3IDo79Yw==
X-Received: by 2002:a63:a401:: with SMTP id c1-v6mr4331782pgf.147.1529540729983;
        Wed, 20 Jun 2018 17:25:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id z82-v6sm6778153pfk.30.2018.06.20.17.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 17:25:29 -0700 (PDT)
Date:   Wed, 20 Jun 2018 17:25:29 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/3] rcu: Assign higher prio to RCU threads if
 rcutorture is built-in
Message-ID: <20180621002529.GA201296@joelaf.mtv.corp.google.com>
References: <20180619221419.41340-1-joel@joelfernandes.org>
 <20180620171041.GY3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620171041.GY3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:10:41AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 19, 2018 at 03:14:17PM -0700, Joel Fernandes wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > rcutorture boost tests fail even with CONFIG_RCU_BOOST set because
> > rcutorture's threads are equal priority to the default RCU kthreads (RT
> > class with priority of 1).
> > 
> > This patch checks if RCU torture is built into the kernel and if so,
> > assigns a higher priority to the RCU threads. With this the rcutorture
> > boost tests pass.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I queued all three for testing and further review.  I reworked the commit
> logs a bit and also pulled the error string onto one line to make it
> easier on people grepping for the message.  Please let me know if I
> messed anything up.

I double checked it and it looks good to me, thanks Paul!

Regards,

 - Joel
