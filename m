Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E490C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99092064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6e04E+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99092064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJBPtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:49:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51258 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJBPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:49:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so1422626wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T+Rz3WdRBT4t8rpJAavJ80egcc7RJhyuLQ/wzFViB+A=;
        b=c6e04E+6uDcd6K3SVEkJZNwsSA3gLLHVj9oE58k170ynKgr1u/V4NcO2q8WSoawzOQ
         EpirdRfm6rrtiLw01zEoNQvdpq+I0fUDR9Aj8SizoAOC67mOyTjmZsb2NSBSMqid8p8Q
         9Zy6xTiCrPTmylEjYJGc8q5pf9wmHswgGo0/rK5FJ5Umg0XUWrEsV3xww4buKX9Kcf4i
         RmoovEwRbrtyHIU6MhzWzsb4Zz6FMVyndTjn4tR0QnssjPJy+uCqk1t4ROWVcealxGCM
         xdfIkb+D+fGEfdQm/HVwanj8iJMfYA0fX+rasEnIBgZlfrK0/PLuqlIm0oQ7ct4Gvbiy
         Do8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+Rz3WdRBT4t8rpJAavJ80egcc7RJhyuLQ/wzFViB+A=;
        b=gLL/E/CfVOCHOFc+syBG4Dyw9Mu07+9q7ktbSrmKOj7Vnu2MGSMzOZXYg1ylXChgei
         oB+V2SxIxPV627DDMesA3iEfYpUWIXAR2r1Pmba1iOMDL42hE3G0dpDAmWgcmO/xhDE2
         PwviPAs0PvHuJgMBSGf1cgt91U2tX8Ndefj7afhT705PemHM18FAwUCcCr8tTjgiHduS
         +ttXaD0abjpg7mBq+r4IQb1jDRUVdN7EsI30MPcbwKuV7wd56LLIDZQD6JaoE105pXqW
         If3LBKwbACB9wENzJHH65NuFxOADW0tMKEsl/6f0oRhDR6ws63O6y2bpSekxgqwCGXY4
         6F8g==
X-Gm-Message-State: ABuFfogDkZdNTpIL+MoK991gfDPFJntY1RbozVP9zBlAfrWl2z+EDgn+
        xJ7j9XejYqs/YMgjwQhMO7U=
X-Google-Smtp-Source: ACcGV61rLd8lPEQYyy6o73ZAPs1VIiIWSa/hQAeizBtJzC8VfS9vNfA4y07M5CRVRuvib2Qly6LVLQ==
X-Received: by 2002:a1c:9908:: with SMTP id b8-v6mr1138291wme.59.1538471215358;
        Tue, 02 Oct 2018 02:06:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l67-v6sm1679602wma.20.2018.10.02.02.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:06:54 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:06:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] locking/lockdep: Improve lockdep performance
Message-ID: <20181002090652.GC116695@gmail.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538157201-29173-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> Enabling CONFIG_LOCKDEP and other related debug options will greatly
> reduce system performance. This patchset aims to reduce the performance
> slowdown caused by the lockdep code.
> 
> Patch 1 just removes an inline function that wasn't used.
> 
> Patches 2 and 3 are minor twists to optimize the code.
> 
> Patch 4 makes class->ops a per-cpu counter.
> 
> Patch 5 moves the lock_release() call outside of a lock critical section.
> 
> Parallel kernel compilation tests (make -j <#cpu>) were performed on
> 2 different systems:
> 
>  1) an 1-socket 22-core 44-thread Skylake system
>  2) a 4-socket 72-core 144-thread Broadwell system
> 
> The build times with pre-patch and post-patch debug kernels were:
> 
>    System      Pre-patch     Post-patch    %Change
>    ------      ---------     ----------    -------
>   1-socket      8m53.9s        8m41.2s      -2.4%
>   4-socket      7m27.0s        5m31.0s      -26%
> 
> I think it is the last 2 patches that yield most of the performance
> improvement.

Impressive speedup!

Mind including the non-lockdep numbers as well, for reference?

Thanks,

	Ingo
