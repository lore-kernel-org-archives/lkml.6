Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FA0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C21124866
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kyiYjcrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C21124866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeFVUFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:05:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43766 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeFVUFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:05:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so3688057pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wtQha2qNtSo28+3QEux0US+AA/eCvtpLD42pccUtn9w=;
        b=kyiYjcrkju9eUE7ykaRp2pF5KHG8IurSZDb+4aVvr1waXCodVn8RWhmI4zxHAToyaK
         0ih7266c1a9hyT6Rt8xI3bN2WxZp3+OUIisXgx9nDiUmGIwghEDFLa+TiMPqwTR4mNCX
         jipywk3XPuoQE6c5kOQtQwIS+rrlJVk/5gOxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wtQha2qNtSo28+3QEux0US+AA/eCvtpLD42pccUtn9w=;
        b=PUma2Stv/B+0O92XPUMxAg/6sX956hmFD4nbeBFCz3fGz3/ZMf3PGA42ZBpiMJ9uPH
         26/Ge2rZ3jG29Pmn5eqPvuvWTy1oq35lCCGkNmEihw4IMKBOUNbzUAiVC932nBt0Lkin
         2GQlJ31I7ulbBwu/kLBNTgowEvx+cVI+b41fNsv068VH9fIiIjwkOqebbNzUUy6C5Z8G
         dH9Ah5hVZs6jb/uJ1L5pm9dJ7/MbPTMAwnIy3PWqOGMOrG+qWeGEaHJnzK/3Mz/9152C
         pGk+FbZMl+Gtm9jApWyWX1RaCfEkj0FlDRzaNVqnqs3SxeoIGxE2ruv4E5oGLLNgrUGd
         Lmrw==
X-Gm-Message-State: APt69E15UwxqYVl7ejSxpGRiLHm2bNw0fBOPgER6iRpViI0oVk9XbE0w
        rSLK7rUbgVVw84M0Vl7jTMo2tg==
X-Google-Smtp-Source: ADUXVKIwb4Vg9imWiWQV4uLbkWHs6CxOi1nThPFrK636gnFnMQeEHe4cxYeCdm8i2PDhx4tydJEdsw==
X-Received: by 2002:a63:6092:: with SMTP id u140-v6mr2615499pgb.433.1529697949312;
        Fri, 22 Jun 2018 13:05:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id k12-v6sm12643316pff.31.2018.06.22.13.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 13:05:48 -0700 (PDT)
Date:   Fri, 22 Jun 2018 13:05:48 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180622200548.GA114655@joelaf.mtv.corp.google.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622143247.781028b1@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:32:47PM -0400, Steven Rostedt wrote:
> On Fri, 22 Jun 2018 11:19:16 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Sure. So in a later thread you mentioned "usermode helpers". I took a closer
> > look at that subsystem, and it seems you can execute usermode helpers from
> > atomic sections with help of UMH_NO_WAIT flag.
> > 
> > Then I checked where this flag is used and it turns out its from the
> > mce_work_trigger function in x86/kernel/cpu/mcheck/dev-mcelog.c which can be
> > called infact from an interrupt context (mce_notify_irq).
> > 
> > Is this the usecase you remember causing this weird transitions to userspace?
> 
> But this case still looks like it uses work queues, it just doesn't
> wait for the result.
> 
> I'll have to look at the code from what it looked like back in 2011, to
> see if there was an actual issue here back then.

Good point Steve. So I guess in the current kernel sources, there's no code
that uses UMH in IRQ context AFAICT. I'll go through the google group thread
Paul pointed as well to study the history of the problem a bit more.

thanks,

- Joel
