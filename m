Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3DCC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D831520827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xs5fUYIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D831520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJ3TDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:03:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45812 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJ3TDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XhjwoH8+GWRr9XXZHE455Tgdoy/5aq911Rln+JBJLFo=; b=Xs5fUYIjEeq4A48Ki5QEecCX6
        jRRlB+fSYqGu/oVTVjXx3OeOITN0VzerRSF4vpbyPYNRDwHStHm3uNZwn4BO0LkBG2E/SnZumcFay
        mxmcCfY71ifxIwRDw9FnVPKxz1rohN5/7KbI8s42U19dLpcBhdUB1Ikugdr9hM/fmWtNX2edRPGIn
        42rpTN0YidmvDvrWuch5rYOBe2P9p3tQFnX4hVfShh+LLikUQYueBbEAr32YYaXgkRQJPLSefO9KF
        nBaQRRq7kn5QT/9fp/ZEtWFQs6uszUA0Es3qUmMCYMR0hYzjK/420w4wNaYWWsgo0O+pQK+jNgas/
        Ja1LVAlaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHQyD-00021w-O4; Tue, 30 Oct 2018 10:09:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28A1E2029FA14; Tue, 30 Oct 2018 11:09:54 +0100 (CET)
Date:   Tue, 30 Oct 2018 11:09:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     zhenzhong.duan@oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, konrad.wilk@oracle.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, srinivas.eeda@oracle.com,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michal Marek <michal.lkml@markovi.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] retpolines: Only enable retpoline when compiler
 support it
Message-ID: <20181030100954.GF744@hirez.programming.kicks-ass.net>
References: <e63900bc-d7af-4a57-aa96-f6cc84b89e09@default>
 <CAK7LNAQG62vzFpDC_xoTEh6CuxmRVU7jAtVe7YpVmqou1hEagQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQG62vzFpDC_xoTEh6CuxmRVU7jAtVe7YpVmqou1hEagQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 06:39:24PM +0900, Masahiro Yamada wrote:
> Hi,
> 
> 
> 
> On Tue, Oct 30, 2018 at 3:57 PM Zhenzhong Duan
> <zhenzhong.duan@oracle.com> wrote:
> >
> > Since retpoline capable compilers are widely available, make
> > CONFIG_RETPOLINE hard depend on it.
> >
> > Change KBUILD to use CONFIG_RETPOLINE_SUPPORT to avoid conflict with
> > CONFIG_RETPOLINE which is used by kernel.
> >
> > With all that stuff, the check of RETPOLINE is changed to
> > CONFIG_RETPOLINE.
> >
> > This change is based on suggestion in https://lkml.org/lkml/2018/9/18/1016
> >
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > ---
> 
> 
> Instead of adding another CONFIG option,
> does it make sense to add compiler support checks
> to 'depends on' syntax ?
> 
> 
> config RETPOLINE
>          bool "Avoid speculative indirect branches in kernel"
>          depends on $(cc-option,-mindirect-branch=thunk-extern
> -mindirect-branch-register) || \
>                     $(cc-option,-mretpoline-external-thunk)
>          default y
>          select STACK_VALIDATION if HAVE_STACK_VALIDATION

That seems to be what we did for stackprotector, which is similar in
that it used to fail the build. So yes, this seems sane.
