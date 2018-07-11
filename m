Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9644CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DDC2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="agZY1h8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DDC2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeGKJim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:38:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeGKJim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=utJM/LzBZcFvCZM3dDV5mmkdS8IegMSfa7Oy6S75sZk=; b=agZY1h8Y0E2xDsnyLpUAyq/7F
        T6zEIQbDfQ83QQvavRckZrFj2L2dzW7CZNN4MuLOUOr+FAYsAo+cDIGHgM8v0SmEfaLvOpMoWMyZL
        0EQf1ww6oklr6qgZh7yV+8/YusN9dKbTDQA2j0qjbxcDW5hF+j8h1RoK9Us2qN8YH2mLp/Q/KFiQL
        uvRDtC59Mh/vPs+24+afBsY+Ujy/YYCw21LXYVu5jU4nWGzhyO5l/GApWFgNqVrc55NPL9mbJMs1o
        kfdLEFGZ1YxiOgtoqLvJfNLEIa8gr8GgkFrAjkZB9Hd3XwTPKoFXh1GmbAOnoMCG7AFWWkiDKe0rm
        y1pn5U8Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdBWS-0006DI-LJ; Wed, 11 Jul 2018 09:34:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C84F20291063; Wed, 11 Jul 2018 11:34:54 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:34:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 17/27] x86/cet/shstk: User-mode shadow stack
 support
Message-ID: <20180711093454.GX2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-18-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710222639.8241-18-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:26:29PM -0700, Yu-cheng Yu wrote:
> +/* MSR_IA32_U_CET and MSR_IA32_S_CET bits */
> +#define MSR_IA32_CET_SHSTK_EN		0x0000000000000001
> +#define MSR_IA32_CET_WRSS_EN		0x0000000000000002
> +#define MSR_IA32_CET_ENDBR_EN		0x0000000000000004
> +#define MSR_IA32_CET_LEG_IW_EN		0x0000000000000008
> +#define MSR_IA32_CET_NO_TRACK_EN	0x0000000000000010

Do those want a ULL literal suffix?
