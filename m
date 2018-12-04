Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C969CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D0F20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koyJQjvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D0F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbeLDJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:33:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:33:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so15117352wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/L+Nothtj0/irGbapL65oAuoEL0J39co1kH1poDXbvs=;
        b=koyJQjvuESQv7RzcOwG8XRkDPzW6IlJObYZGzzmB2Rsb/Q4ALjFL53zkmQpz4/77/7
         h4JnhVme666tPGJxWYwAXTySGd+gxHklWaAs2B/t0qeJXDvOSpAaPlQS1L8m+30ByUNz
         aO3Fn6lIPdOWTHWLdtdjiTq6u/GxZR7nJDmkE+vufZy+2QttTWmJERR3/O2kFKUsHfuC
         w+TkZdHn4LF6wn8Gkl+ZKGdfW8FdroX/SuMAM5GynTDfascr7aTv34BSPpj73EYy16fb
         6iwuxdVFA7/E/2NCt6qMfoUZHWNpsvOZEwKZxg53S0vCZWQZ2DmvG02pdWZpfpsmfOQa
         KWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/L+Nothtj0/irGbapL65oAuoEL0J39co1kH1poDXbvs=;
        b=XKFa3COr0XOMBkZqVRQo0EA4lioDb9wTGhFtb/P2hBex9dI56HfTun+F3NCcdRxLDE
         9b8CRYLDAbdJLj6mfrzD7rb5bY3ONSSQhAw9WmCBLbilhpD0IMY52j1PtsnAIfpfY0EW
         q06UE0V9yFI99mZ/u7rJdtp3sf7epNcGWh/kZVsQnsTgJjyygfmpCJ6uhMsj4B2zJWOS
         uCPWU3aEWHY+/AjfcqGTBwXp6pevJJqxJXnO3K5MiPF7Dia+3z2F2M43LVInFCa6rS22
         nr8qjJ5KSjzjBexYSm4bFeStV+VkFXXwtqEFdQaTnDptjJn4aPpRPZNASJzGU8hZJFXb
         MtfA==
X-Gm-Message-State: AA+aEWYZzLmoo24QiTHJ2HtlxAlY/9ZkVY3yAo8nP4lNUqTbotNP0xDE
        dIwl1244x8uHZxgTsYokqck=
X-Google-Smtp-Source: AFSGD/UK1fzF/z09oAcNe1mfeiiO+v0Wehs67eLOMrLTTINcR3suHt1nngnR2gkbil4iykuA/eUC7w==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr16660352wrw.323.1543915993168;
        Tue, 04 Dec 2018 01:33:13 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d2sm12409357wrs.97.2018.12.04.01.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:33:12 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:33:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181204093310.GE73770@gmail.com>
References: <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
 <20181204090228.GC73770@gmail.com>
 <20181204091020.GD1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204091020.GD1286@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Hocko <mhocko@kernel.org> wrote:

> I dunno. I do not use hibernation. I am a heavy user of the suspend 
> though. I s2ram all the time. And I have certainly experienced cases 
> where suspend has failed and I onlyi found out later when I've picked 
> up my laptop from my heat up bag. Nothing fatal has resulted from that 
> but this is certainly annoying.

Hm, so I (mistakenly) thought freezing was mostly limited to hibernation 
and to a few weird cases when in flight DMA must not be suspended - but 
I'm wrong and in practice we always freeze tasks during s2ram, right?

And indeed:

 config SUSPEND_FREEZER
        bool "Enable freezer for suspend to RAM/standby" \
                if ARCH_WANTS_FREEZER_CONTROL || BROKEN
        depends on SUSPEND
        default y

which is essentially always enabled on x86.

TIL ...

s2ram is obviously a huge deal.

Just a newbie question: any chance to not do any freezing at all on 
modern laptops when doing s2ram, or at least only warn if it fails and 
try to suspend?

Because in practice losing power due to failed freezing *will* result in 
data loss, in about 90% of the time ...

So I don't even know what we are trying to protect against by refusing to 
freeze - avoiding a 0.001% data loss risk against a 90% data loss risk?

Thanks,

	Ingo
