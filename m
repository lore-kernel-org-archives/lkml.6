Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721B72086B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPmtN43P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721B72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbeKNBmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:42:32 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39974 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731439AbeKNBmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:42:32 -0500
Received: by mail-yb1-f196.google.com with SMTP id g9-v6so5541476ybh.7;
        Tue, 13 Nov 2018 07:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bFMh3QKUJlc38kknui2bNuEA1AJIdxyJQX4fmBz4djQ=;
        b=NPmtN43PH6DhKus0hlh51X8Z/k3gg9A1AjLV0L7u7rOOSqLiKlFpbp+/163RD0emVN
         sjFvpcrQNY64FGZTkaH66iM9J+zpxHR36H17h0b2gO0QikfB2AmJbhvXGmcfZrWb2eoh
         rLNtOW0CFVjte8f4CAGQR9zKSP3XiKoafsWc8BtRDZbtaw4V3Pzu45bT2kQyGu3+kWju
         ph6LAcs1hlmbQAsIhXa/yk5puVWaVMUiWdb0SwwcBM3bA+59+6qFDut7OpSs3JuPPy57
         sg4r8A0H9yDzk50zhh0JaSGF/V2SV9pJufcP66AAg4gCXdw19KkxnB0UnAslrcDoGPjr
         p4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFMh3QKUJlc38kknui2bNuEA1AJIdxyJQX4fmBz4djQ=;
        b=MOU6J/fSphfNxlDGJgQuuRsxm7yGFtc1oHgj5GMyIHM/5JQWKMbCdvcJyzH9kkI2/F
         j+AzsK53D3sNUV3851OpV8J2eQBo7cuCil4CieBtEezi71QeCkgcLmNfrBOPXFZ1agC2
         8Nyo4/FJ9JIVKL8sj5oWBqcpfBgUq1Qh4xwMbLJPe6WzMGkAzKD5paVr6BQimNBt1x+q
         i1DeCqwV6sstmWDdK8E4e3jIh9LKwOUnXSpcjbM+OGDFRUyrzU0AjClzAi+oFCPJw1Sk
         EiO9tM+cGH1gqDD57mS+imw8qJNgp9eyUYaq0ziEFe75XSJ+PcJwgfMsI5ytM+a2e+ha
         iaqA==
X-Gm-Message-State: AGRZ1gJY45tb3i62cU2xmOEAMIKNo81HSGabHlzycdwarQOQvbrROzB1
        tK951BfnUbW2zMfm9FxJPFGGGTkg
X-Google-Smtp-Source: AJdET5eKfPuApZdM36EPitecNwoK3vCGif4cgpb+k9aUoUGgesnmT4Qs3veIkkH0xS8BkMZLj7Tukg==
X-Received: by 2002:a25:d64d:: with SMTP id n74-v6mr5311766ybg.204.1542123832993;
        Tue, 13 Nov 2018 07:43:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id i189-v6sm4810742ywb.23.2018.11.13.07.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:43:52 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:43:49 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guroan@gmail.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Message-ID: <20181113154349.GF2509588@devbig004.ftw2.facebook.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com>
 <20181113153700.GB30990@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113153700.GB30990@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Oleg.

On Tue, Nov 13, 2018 at 04:37:01PM +0100, Oleg Nesterov wrote:
> On 11/12, Roman Gushchin wrote:
> >
> > This patch implements freezer for cgroup v2. However the functionality
> > is similar, the interface is different to cgroup v1: it follows
> > cgroup v2 interface principles.
> 
> Oh, it seems that I actually need to apply this patch to (try to) understand
> the details ;) Will try tomorrow.

Yeah, it's a bit of a head spin like everything in signal delivery /
ptrace paths.

...
> OK, please forget for now, but perhaps it would be more clean to add
> JOBCTL_TRAP_FREEZE to the JOBCTL_PENDING_MASK check in recalc_sigpending()
> and change get_signal to check JOBCTL_TRAP_MASK | JOBCTL_TRAP_FREEZE; and
> I am not even sure cgroup_freezer_enter() should live in do_jobctl_trap().

I'm sure you're aware of the context but just to refresh - one thing
which was really broken about cgroup1 freezer was that it piggybacked
on hibernation freezer and put frozen tasks in a state which is
undefined when seen from userspace - they're just stuck in D sleep
somewhere in the kernel.  That's fine when the whole system is not
gonna be running, but not when only a subportion is being frozen.

So, the primary goal of cgroup2 freezer is putting the tasks in an
equivalent state as jobctl stop.  It's a jobctl stop but controlled by
cgroup frozen state, meaning that they can be killed, PTRACE_SEIZE'd
and INTERRUPT'ed (PTRACE_ATTACH doesn't work as signal delivery should
be blocked but that's fine) and so on.

Thanks.

-- 
tejun
