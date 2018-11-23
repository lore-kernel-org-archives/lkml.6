Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5293C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED2320861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n6bSNdT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED2320861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeKXI74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:59:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36090 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeKXI74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 03:59:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so3540733pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tSzhgCt630THE9GUK2+HLehUtq7NDRnlvWXxDWD0us=;
        b=n6bSNdT/HbfBfdZlluqtyRQauRub0rrKbrnjbZm/kz6gNBcOWr0Px2x/yTlVuEqCN8
         j/3kc5lyjqVNlXKz9OaDi5/4tVlwAfVj1Dn6X/a/oZHsixz/Mm3KGxxNW1WWUKgfK3lb
         q2FlMYYrolI4B4UpfJt2Y4Z2ShjDyDOGpHPGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tSzhgCt630THE9GUK2+HLehUtq7NDRnlvWXxDWD0us=;
        b=Pp3h1nbPhbWFseZH0BoIBvtpKwlRv1IhYWx+igGGvkvlaCDQGiIfkApMvbtIJDoMvV
         voM5SuojpDYJUGKMLTvhyIWO+I5iODI1BsswIM6v8QrsxMIctb6kr+P6lD+5FroUZ/pq
         CmiN4xtl7Mcvv5CxxpDwVCIBLYOznWX3lPVCjhznYUhDm7gOdUMBD2BlRnrgtmQlmnEV
         iSkzElymzjY9Kcx7Xl2FaQ6RQ6RAFHMgyERLnK91E7p4Gejzo1OJZLOGb4N6E1Xrt5cW
         +qvSj7Y9eXSqPCgrqQvabswrUB0MMlYI9+3ZmJ37oRs0Lopexv6snGN+zR3cuwhFXC5V
         099w==
X-Gm-Message-State: AA+aEWZS3PFMGqaw84OICZ1h8Z2fsfqm2jgyC3DHi0NbYBmj7b1Zj10x
        //zkBsLxTEvALrxtf4q21e7n2g1JEVs=
X-Google-Smtp-Source: AFSGD/VWzJBkArOQKHV+V2AmnWnRc4XfJK3wo0rjAEUjWzEUE0VY9JSxe1sbAcLd1T7/bGvI7OhDYw==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr15227532pgp.46.1543011233183;
        Fri, 23 Nov 2018 14:13:53 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 85sm72752733pfw.17.2018.11.23.14.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 14:13:52 -0800 (PST)
Date:   Fri, 23 Nov 2018 14:13:50 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 06/14] fgraph: Move function graph specific code
 into fgraph.c
Message-ID: <20181123221350.GA203283@google.com>
References: <20181122012708.491151844@goodmis.org>
 <20181122012803.442190047@goodmis.org>
 <20181123061133.GA195223@google.com>
 <20181123125834.1ddc367e@vmware.local.home>
 <20181123131138.2a1b0472@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123131138.2a1b0472@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 01:11:38PM -0500, Steven Rostedt wrote:
> On Fri, 23 Nov 2018 12:58:34 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I think the better answer is to move it into trace_functions_graph.c.
> 
> I take that back. I think the better answer is to not call that
> function if the profiler is not set, nor have that option even
> available. Because it has no meaning without the profiler.

Agreed, that's better. Thanks,

 - Joel
