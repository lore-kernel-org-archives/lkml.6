Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AE7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A5020877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGcfFeK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A5020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeJED2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJED2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:28:00 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF7520877
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 20:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538685185;
        bh=1UUooz/fRuRcam298BYDbg/j4xYcekEvFJ439UZ+w9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kGcfFeK2QJ0T9xc1BTXJZkCFnXZ++UkHQ1yt/ZiWr+T3+AdnjgzR471q454jb4qy6
         TazwoUSS2dJZDypwPs990Tb+JXa8csH2YsV5hvZ1OtoJrMgs8+e4DWrNOhBK4I5bJX
         o6KwJ3TE8Rb+CFFJNwpLH5jeDQj9EPyiXyItDLMo=
Received: by mail-wm1-f48.google.com with SMTP id y140-v6so2332366wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 13:33:04 -0700 (PDT)
X-Gm-Message-State: ABuFfojb6DQcQhZOyIIkyJMzEOMh3TA1HBdeTaEFtsFMUEswfoCcUyda
        LivHtJWh1/8J//4rCwc3YmQQAtcGT3VK8oldqSjFtg==
X-Google-Smtp-Source: ACcGV631paTYZW3s0KtatqZ+vFMqn5MgIAqQdji9rsSMThLS/hsPgZU/SyYL/JL12WHAcwjDPiUHJd5mvdsoVyEOeTI=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr5852770wmf.19.1538685183104;
 Thu, 04 Oct 2018 13:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180914125006.349747096@linutronix.de>
In-Reply-To: <20180914125006.349747096@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Oct 2018 13:32:51 -0700
X-Gmail-Original-Message-ID: <CALCETrUii1XGHhe7BN+LG0_jjyjOcHHnBgcOvh-wZXGxdMotPg@mail.gmail.com>
Message-ID: <CALCETrUii1XGHhe7BN+LG0_jjyjOcHHnBgcOvh-wZXGxdMotPg@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> implementation, which extended the clockid switch case and added yet
> another slightly different copy of the same code.
>
> Especially the extended switch case is problematic as the compiler tends to
> generate a jump table which then requires to use retpolines. If jump tables
> are disabled it adds yet another conditional to the existing maze.
>
> This series takes a different approach by consolidating the almost
> identical functions into one implementation for high resolution clocks and
> one for the coarse grained clock ids by storing the base data for each
> clock id in an array which is indexed by the clock id.
>
> This completely eliminates the switch case and allows further
> simplifications of the code base, which at the end all together gain a few
> cycles performance or at least stay on par with todays code. The resulting
> performance depends heavily on the micro architecture and the compiler.

tglx, please consider this whole series Acked-by: Andy Lutomirski
<luto@kernel.org>

Please feel free to push it top tip:x86/vdso, as long as you pull in
tip/x86/urgent first.  Once it lands, I'll email out a couple of
follow-up patches.

--Andy
