Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B0020835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bElBF0WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B0020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeJKEJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:09:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45395 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeJKEJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:09:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so3048552pgd.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=grAU+mvAMPuR1z0GzAD92IUgSPrsEfKSog7dWfyWDsM=;
        b=bElBF0WCGVi0F/AzPk8t43n2VPIOweTQqcs6T2XziTkoEd3GiETDyZnlvSY374QYbR
         KMxb4KHsb6ZRTPUanl0jkFQJk43ui5oYV0oMyaMXhta9e2HnfGgvbAYJoY0xWN2lnCNb
         r+1t3NUlFDF192N+/jpLbFKNhXgML0+8yyln4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=grAU+mvAMPuR1z0GzAD92IUgSPrsEfKSog7dWfyWDsM=;
        b=s6nWyGMoILzur3OBkhxD0T1EfKT+/30kp/TTXAX9suB4GGv8pPs+u9DtqTmgjINkyc
         oFrqpKYjUKjFbtGvCt8Xc41SOkE8mwkKYQAIApGm1bPmaJ1kF31Wol0AFhSCX5u2JooO
         SwRbQO+H8Z66qgqNtk3wxnw+MKN7V10fh/d2FeBZ6ldGBzITaIA3xTnuRvbYqIXNDAai
         hZxqlMwb+mjh1OnQohbtVQS/4BV0I0rTEy5IGu/UvsbBrM/kYTWFNG/i01unUumGbEMC
         aVK6hl3uTgyYbY4XpKjmKrskk1fjRAQ2Q1Mo+Xw54mLKmfCjg++dUlzhKbcehNPNL0eo
         ZljA==
X-Gm-Message-State: ABuFfojjYVrxCWRISQ7ug+d3O6SGn5xSqz7kRknTm0im7VmRq+iDLBe1
        Z3zuqr8gi5obkG1zSh/HtEHFHQ==
X-Google-Smtp-Source: ACcGV60DQxSxF6+dp9ei/i/BD4mYDbWzUGFysaHCH526YzBK9PcXKrNOrj3nThEoETl9y1rwf2xqXw==
X-Received: by 2002:a63:e347:: with SMTP id o7-v6mr11267570pgj.251.1539204320103;
        Wed, 10 Oct 2018 13:45:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 23-v6sm41181454pfy.156.2018.10.10.13.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 13:45:18 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:45:17 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Kees Cook <keescook@chromium.org>
Subject: Re: First coccinelle script, need some help.
Message-ID: <20181010204517.GA109962@joelaf.mtv.corp.google.com>
References: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.21.1810102217260.2479@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810102217260.2479@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:23:18PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 10 Oct 2018, Joel Fernandes wrote:
> 
> >
> > Hi!
> >
> > I am trying to determine if a function argument is used across the whole
> > kernel for a certain kernel function.
> >
> > I mustered up enough courage to write my first coccinelle script after a few
> > late nights of reading up about it :)
> >
> > Here is .cocci script. I am trying to find if address is used at all in any
> > possible definitions of pte_alloc():
> >
> > $ cat ~/pte_alloc.cocci
> > virtual report
> >
> > @pte_args depends on report@
> > identifier E1, E2;
> > type T1, T2;
> > position p;
> > @@
> >
> >  pte_alloc@p(T1 E1, T2 E2)
> >  {
> > ...
> > (
> > ...
> >  E2
> > ...
> > )
> > ...
> >  }
> 
> 
> In report mode, by default, the pattern has to match on all paths.  Also
> when you have ... before or after E2, there can be no occurrence of E2 in
> the code matched by the ...  So your rule requires that on every possible
> execution path through the function, there is exactly one occurrence of
> E2.
> 
> You can try the following instead:
> 
> virtual report
> 
> @pte_args depends on report exists@
> identifier E1, E2;
> type T1, T2;
> position p;
> @@
> 
>  pte_alloc@p(T1 E1, T2 E2)
>  {
>  ... when any
>  E2
>  ... when any
>  }

Thanks for the quick reply.
If I just add 'depends on report exists' to the rule, then my original
example works fine now. I did not need to add the 'when any'. Do you mind
taking my original simple test.c example and modify it and let me know under
what situation would it not work?

I even added address = 1 outside of the if block and it works fine, I see the
warning as I expect without 'when any' in pront of the "...".

struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
{
	 address = 1;
         if (condition()) {
		 while (1) {
			address++;
		 }
                return NULL;
        }
}
virtual report
-----
For your reference, I included the .cocci script below again. This time with
the 'depends on report exists' in the rule:

@pte_args depends on report exists@
identifier E1, E2;
type T1, T2;
position p;
@@

 pte_alloc@p(T1 E1, T2 E2)
 {
...
 E2
...
 }

@script:python depends on report@
p << pte_args.p;
@@
coccilib.report.print_report(p[0], "WARNING: found definition of
pte_alloc_one with address used in the body")
