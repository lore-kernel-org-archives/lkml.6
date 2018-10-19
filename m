Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE4C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C9520C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xckwqF9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C9520C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeJSJbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:31:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39412 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeJSJbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:31:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so15025575pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 18:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKFhgH3/F8G99ClT0GhiKaoexzY9BTl1bxJm2dsagMU=;
        b=xckwqF9GVGjx2A8lLsM/Xa02KOoGvNUPlkbTBzoWhsGEw2Ylzq51k8fC4qnsrpJEuS
         XfwZBX1FwBvColB8DvAbbxSzTIh7OBso+q9AxwEpjmz1iLCg4JTQmNwD6X6n18WdTeyj
         Tto1A8h2gHAUxBa/YS+IuEceEA1ZAsj0pnxjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKFhgH3/F8G99ClT0GhiKaoexzY9BTl1bxJm2dsagMU=;
        b=py8x8ekTy29AQr5py7Pur1rkigYG12EzHKLyR1dLbpm40auDQcq9JKToIlMhMQiOI5
         QnoKwvVP9NP8SNo6Ah3u8MHJb0ZRn/DE3sKkzo43BIdbkl7YgeDsUaFWj28Z4ybQz+aI
         QCZ8vZlLlVzLsQ+IkKzqS5WPgCOurCjftZy/pUJKI1Ou3oAzMRUOidgAT7aOjFt6Ylg3
         QVCjpU35jl+yj6/BM5LuT35Py+KIX5xZ5LW7E/aRPW44uVY8bQxYdqkz0b+dTD+mgeCz
         cY/e5/4p+3Mx/G3RwUbp30le9kb/MBpTp/VINwHa6rKyg94moW6P1/Gef0JM+w1QUEse
         RA/g==
X-Gm-Message-State: ABuFfoh0PXtXIjbfXF4omzkM+dX2MH0ZGb1UOhBrxrJo5SSAvfgBC0aT
        13vbk65AKVJq6bT84yODmAqrRQ==
X-Google-Smtp-Source: ACcGV6196JmE96Ph3cjoEUxg7JuUXMYuCXvaCR9EFcXQ135DpfIHBBIp/fm/rOqoxkhGTU6Mj4+H7w==
X-Received: by 2002:a63:2f42:: with SMTP id v63-v6mr16433344pgv.202.1539912472547;
        Thu, 18 Oct 2018 18:27:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id h6-v6sm29618671pgn.84.2018.10.18.18.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 18:27:51 -0700 (PDT)
Date:   Thu, 18 Oct 2018 18:27:50 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181019012750.GD89903@joelaf.mtv.corp.google.com>
References: <20181016112611.GA27405@linux.ibm.com>
 <20181016204122.GA8176@joelaf.mtv.corp.google.com>
 <20181017161100.GP2674@linux.ibm.com>
 <20181017181505.GC107185@joelaf.mtv.corp.google.com>
 <20181017203324.GS2674@linux.ibm.com>
 <20181018020751.GB99677@joelaf.mtv.corp.google.com>
 <20181018144637.GD2674@linux.ibm.com>
 <20181019000350.GB89903@joelaf.mtv.corp.google.com>
 <20181019001932.GR2674@linux.ibm.com>
 <20181018211245.10baf496@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018211245.10baf496@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:12:45PM -0400, Steven Rostedt wrote:
> On Thu, 18 Oct 2018 17:19:32 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> > I figured that whoever calls preempt_enable_no_resched() is taking the
> > responsibility for permitting preemption in the near future, and if they
> > fail to do so, they will get called on it.  Hard to hide from the latency
> > tracer, after all.  ;-)
> 
> Correct, and doing a search of preempt_enable_no_resched() I see
> there's one in the ftrace ring buffer code, that was added a long time
> ago (2008) to fix a recursion bug that no longer exists, and this now
> can leak a preemption point.
> 
> I'll have to go fix that :-(

Cool! Glad you found this issue in the code while we are discussing it ;)

thanks,

- Joel

