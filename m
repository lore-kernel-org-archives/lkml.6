Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5CCECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B038B21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AQShdXAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B038B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeJSQ1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:27:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeJSQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9AvHN4WfO/HcdEky1Ll3eXeISmMbyq+jQYgIjB7CBQs=; b=AQShdXAgid2sp/IhTrwu3IM3i
        I7Kv4JnYUb9qvvhQ41WNq7fAxpW4C7lYuPevs9NNy82TgsWB04/XhGzhd5yQZBuAOOXAnf+KfvYft
        xA7Mc3juDtY00QEM1AuJlySotwkeORyRb6eWWhUwAQ/iN2IPxbNSyz6jYVOSmA8qGvX9sBtrIcoks
        1sYWsVLaX8ibmeOhJrWNAzsyCjRMWAbDe79n9VesTlA+6qxnlboLyxd5HmXEMmn/t3L5fK7HOR3Rj
        dGBiSw9rIVPm94INl3PkVMm2nzdfhdKn+iEkr5FJL3rZkKTuo/MXZWEYwr9e2rgLpVCHs8EiCGI1C
        8FBIY5N9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDQ2m-0006AH-10; Fri, 19 Oct 2018 08:22:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89C692029856B; Fri, 19 Oct 2018 10:22:02 +0200 (CEST)
Date:   Fri, 19 Oct 2018 10:22:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, daniel@iogearbox.net,
        guro@fb.com
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Message-ID: <20181019082202.GB3121@hirez.programming.kicks-ass.net>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
 <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
 <20181019050051.bs2kk4sagu7hpwxx@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019050051.bs2kk4sagu7hpwxx@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:00:53PM -0700, Alexei Starovoitov wrote:
> > 
> > >
> > > Another example is __BPF_PROG_RUN_ARRAY(), which also uses
> > > preempt_enable_no_resched().
> > 
> > Alexei, I think this code is just wrong.
> 
> why 'just wrong' ?

Because you lost a preemption point, this is a no-no.

> 
> > Do you know why it uses
> > preempt_enable_no_resched()?
> 
> dont recall precisely.
> we could be preemptable at the point where macro is called.
> I think the goal of no_resched was to avoid adding scheduling points
> where they didn't exist before just because a prog ran for few nsec.
> May be Daniel or Roman remember.

No, you did the exact opposite, where there previously was a preemption,
you just ate it. The band saw didn't get stopped in time, you loose your
hand etc..
