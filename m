Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC21C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDAA24192
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umjpR2Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDAA24192
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeGEHTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:19:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55737 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeGEHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:19:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so9232155wmv.5;
        Thu, 05 Jul 2018 00:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iEXfRHZi06muwO8SVWb4jgNkhm7Ecu7NHa7NV+pQuRg=;
        b=umjpR2Uy2kCnqbmhUWcAJtG/WCUuSmzpxDZaF2al6TfYsFY1RxtPQxgKXytXHoubEg
         SCY2x8SmEgHEFKFQDEbO9Rj3YGSD6M6EiHYgoCPdFevyHFC4ijSE4g6bs0gsTwguAiTO
         yLmuoGOSvXaYWLL16WTOrPUBCpPI23JfKwh0B4TSzwYeZs7QMghhY+/H6epyZHsmKEaw
         Qz+lNZRUpsqpGVcpPraAcHXiiLgCdLwzhyOBgpgfD27yvBtz2jmSZ9aaAEZe7HLeqPT3
         4JxM5XcyKEz188YSoKOIncghqndi3rzMBeO9EOtEplCdXI0ZdT6/o4MqNmFaQEhekCXQ
         U2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iEXfRHZi06muwO8SVWb4jgNkhm7Ecu7NHa7NV+pQuRg=;
        b=KNkswlHUu+1YWlLVC8duelUbaRHeZEbrakLrNE1+yhmM3HFQF/pxDrzoVoJHuweNIg
         uw8TvMFW/YGM6JengIp53ltw3CvcqfHS4afVAOy9UIxDjA269XGjm9ymWAyWa4SZF75/
         uE5hslloJceoB4t4teTfSMr++3hcULk0lPt42Dj617pDROrciGx89liTnPB6g1MaqplX
         4N/ewxeoarCjBmCuKxn91PKIDbRx6pCThDKq87pdCx2hTiGZU6HMoP28OMhv/lhAUket
         R2NzgmcstZlaEV5q4y96kyZ7n4uyjvJmxqKarSknct4d75scS5CcZtXyQ+gBrMSoxyF4
         Eb1A==
X-Gm-Message-State: APt69E20llIMmbH0u6oQCTyX1FJNabsz2DxGYIN8JhsYC4cp3g/aFxtA
        JN8kNsWYKYlcN8cho/aH7Xo=
X-Google-Smtp-Source: AAOMgpdq6mM0nxOUf8LWWwmnk9MeQ2Pj609cPgNtXWxbq1Ms/nNTIwUFstwB1ay5JV+q6StlzcwYqg==
X-Received: by 2002:a1c:7eca:: with SMTP id z193-v6mr3257380wmc.139.1530775180461;
        Thu, 05 Jul 2018 00:19:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z62-v6sm4177512wmc.10.2018.07.05.00.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 00:19:39 -0700 (PDT)
Date:   Thu, 5 Jul 2018 09:19:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        linux-mm@kvack.org, linuxram@us.ibm.com, shakeelb@google.com,
        shuah@kernel.org, Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 234/279] x86/pkeys/selftests: Adjust the self-test
 to fresh distros that export the pkeys ABI
Message-ID: <20180705071937.GA2636@gmail.com>
References: <20180618080608.851973560@linuxfoundation.org>
 <20180618080618.495174114@linuxfoundation.org>
 <fa4b973b-6037-eaef-3a63-09e8ca638527@suse.cz>
 <20180703114241.GA19730@kroah.com>
 <877emakynf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877emakynf.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael Ellerman <mpe@ellerman.id.au> wrote:

> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Jul 03, 2018 at 01:36:43PM +0200, Vlastimil Babka wrote:
> >> On 06/18/2018 10:13 AM, Greg Kroah-Hartman wrote:
> >> > 4.16-stable review patch.  If anyone has any objections, please let me know.
> >> 
> >> So I was wondering, why backport such a considerable number of
> >> *selftests* to stable, given the stable policy? Surely selftests don't
> >> affect the kernel itself breaking for users?
> >
> > These came in as part of Sasha's "backport fixes" tool.  It can't hurt
> > to add selftest fixes/updates to stable kernels, as for some people,
> > they only run the selftests for the specific kernel they are building.
> > While others run selftests for the latest kernel on older kernels, both
> > of which are valid ways of testing.
> 
> I don't have a problem with these sort of patches being backported, but
> it seems like Documentation/process/stable-kernel-rules.txt could use an
> update?
> 
> I honestly don't know what the rules are anymore.

Self-tests are standalone tooling which help the testing of the kernel, and it 
makes sense to either update all of them, or none of them.

Here it makes sense to update all of them, because if a self-test on a stable 
kernel shows a failure then a fix is probably missing from -stable, right?

Also note that self-test tooling *cannot possibly break the kernel*, because they 
are not used in the kernel build process, so the normally conservative backporting 
rules do not apply.

Thanks,

	Ingo
