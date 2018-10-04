Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DEC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ABD2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATEJu4vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ABD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJEFLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeJEFLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:11:13 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 285E92148C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 22:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538691346;
        bh=gpxVl8get5J3ShBiarg7bfbAnWeHxrQx3/LBC20aTGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ATEJu4vWkiQUiBUZx+rCzpx8PDLV87Mic1JMFSWGJ9I2fFHQ9pyBVA7oCGJnTPowg
         5Bl2g5mFdwQGD6keWEHLXkW04jxnBE9I+H+bKbFMvRD+HDlZS18Is8wK94Ncg0VRjV
         jZ0XeVrnu4aMeYJUVAk4tzTh/sop72s8B29T32WI=
Received: by mail-wr1-f50.google.com with SMTP id q5-v6so11513019wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 15:15:46 -0700 (PDT)
X-Gm-Message-State: ABuFfogP+8nlcairl20Ir8ShN/1fE1XwlQUD0eqA993HTgamr8ClW5ud
        nDNWhlE8RqkK5mOoQgKPd9MB8/QE1YijiP5QL2/Skg==
X-Google-Smtp-Source: ACcGV63CW/+1P1kkoXpED83F2XQ6dvXP1zIcj5F7oiWjDnl487DTFd1riOcSG+QaAZujqOY8E+sHVG78E85T2AyHWCU=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr5949453wrc.131.1538691344440;
 Thu, 04 Oct 2018 15:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <87sh1ne64t.fsf@vitty.brq.redhat.com> <20181003190617.GC21381@amt.cnet>
 <87k1mycfju.fsf@vitty.brq.redhat.com> <20181004081100.GI19272@hirez.programming.kicks-ass.net>
 <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net> <20181004193150.GQ19272@hirez.programming.kicks-ass.net>
 <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
In-Reply-To: <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Oct 2018 15:15:32 -0700
X-Gmail-Original-Message-ID: <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
Message-ID: <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better or for worse, I'm trying to understand this code.  So far,
I've come up with this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/vdso-tglx&id=14fd71e12b1c4492a06f368f75041f263e6862bf

Is it correct, or am I missing some subtlety?
