Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BBAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA0520883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iVjA7z6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA0520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeGKFaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:30:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44640 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeGKFaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:30:01 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so8646313pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M3W1r47VZurNJ/XXRAqhvTGE38Ungef2IhvvIqsi3hc=;
        b=iVjA7z6BHFBEIg11z5ra2ogjCKcYrFgXirvoSbxKUjU5lOjCOrZ9WZzU1jHjRNphX7
         wU/6460VKsrOSDLRXDwUcB9W1T5u4YquNrmXRXtuCSCbqAepsWoGjwYcf0Ov4TIqcfYC
         cjB8ozURQnd56GxSCu1R0MbCGoqRFuAKx10MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M3W1r47VZurNJ/XXRAqhvTGE38Ungef2IhvvIqsi3hc=;
        b=TcEPqno5SQdTBZotWfGq2faN3dlJIpOyQWtltsV58dAd70vpb1tlsDv1rHh0qBeHnm
         JaVX7Q2PiUJJdGEanyIFifGC+PStboIdNruIiRVL+1MSQhr14PpCM+ZzUMoy7XJbPsZJ
         p02M8o6FNriQ8WbL5e6wtCViGNnGSZxqxQcpFXcFjbq2TGx9F99sNVDOG/V3/XqIh/uU
         G/3ebUYa79EAzHKPwjKOOhRxT7uSW8fqEHVmUt8g55azD4aEM9YLlmbsWG9W98iGjx9c
         1k/simeHDw3PRpcGrNqJzJBUlL5rBUPQ2q/OrpodcofANn6+BuREjaGNcAfshMw7wAoD
         Ikiw==
X-Gm-Message-State: APt69E0+lduUbaHweVclFr0dnebpCCbz9KP9daPXEDEMPDDa8ylSH6UX
        S2HyLT+1s8ka32bDtW/OaCRawA==
X-Google-Smtp-Source: AAOMgpczZCibiV+wi+yRpPhaTvZ7tRZplu6YvARM0w59h69XYHXPtu8MDjgeOFjfeXWKzK2CjN31JA==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24-v6mr27452226plo.250.1531286851657;
        Tue, 10 Jul 2018 22:27:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id 4-v6sm13224034pgj.22.2018.07.10.22.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 22:27:31 -0700 (PDT)
Date:   Tue, 10 Jul 2018 22:27:30 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 7/7] kselftests: Add tests for the preemptoff and
 irqsoff tracers
Message-ID: <20180711052730.GB11372@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-8-joel@joelfernandes.org>
 <20180710204958.22910589@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710204958.22910589@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:49:58PM -0400, Steven Rostedt wrote:
> On Thu, 28 Jun 2018 11:21:49 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Here we add unit tests for the preemptoff and irqsoff tracer by using a
> > kernel module introduced previously to trigger atomic sections in the
> > kernel.
> > 
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> This looks fine. The only patch that needs to be changed and resent is
> patch 6 and 7. Just send 6, and this one again because it depends on
> patch 6.
> 
> I'll go ahead and apply 1-5 and kick off my other tests.

Sounds good, I'll resend those shortly with the changes you suggested.

Thanks!

- Joel
