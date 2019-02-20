Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D72205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661411;
	bh=ssLvLIn4D90hRpsKckIwz0mxjsasIE5O5mC+1XzSrpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z6aU7Jz5Urk9ni7BNRRmhCxHLuT6mkJx4/XJHJL4quwwfJ8MBO4jh/3KJK8uBK7p3
	 N3vx00+grj7XcHr807sZRlypNyYZiXdoJ6uBgLarLSyHXiPIgMiTUbvI91iJeFhlmj
	 n4Ih3TceKrtaCMVsZnOH/D0RWWOGKcRE2AEOTCsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfBTLQt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:16:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42876 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfBTLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:16:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so39470917oto.9;
        Wed, 20 Feb 2019 03:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=55LREwQIv0cNYvZOxzHBO8fr+JYV0bKQKbawM3aD7Eg=;
        b=YVNTUN8iR59tTxzUudz6kubrw5E25GbkjLP3q8mqkDJ11yzTZ5CFueCuien/oLB3ZO
         Ln9+GMOQKoOiovd24peTf2yoSvUZ4Cne7E46q/2kLEFZf0geh4zoHKkkvPrxmec9+Kkb
         RcecXmOJKsvptBk2dITTGYPv1lgZMvgsn1cCdk4uErIuo8q7eE7FyXRHVSFGrbQyhhhB
         YHHWpwVriSxOToMAFyrX/p5r2bcT8ZE9CRTv6oyHaUfSWCkfsSJoERUrd38hEcnTNfDB
         jdwpOO1cCKIF5vkDEoaOBL3yk9/ebUjv+ov/AJDJ1WWUiC7wqn+29tmciwZl3OtjoeAn
         68cQ==
X-Gm-Message-State: AHQUAuYGXJ3PYrVbyloh/hCAJXCn5ocMip2VjRRvulKklP9afmVgyRTA
        m7tk0dlLEQKEt9l9XSDPXz9ETu/g5bWDjhOK5sI=
X-Google-Smtp-Source: AHgI3IaBsk1wppX2bYJ/wHAdgeyUK3jI7vcwmBW9cJMHZ7YbidC/LuW/UuNOyaAYPaPo6t7V6grZ4B0rz092GcryX9o=
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr5644428oih.76.1550661408015;
 Wed, 20 Feb 2019 03:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20190220101017.19587-1-e.velu@criteo.com> <CAJZ5v0i5BVFRKsCVxDwG90vBAuS3QYB=-GkC0pbGLy5DWDXuMg@mail.gmail.com>
 <1d9ff7a8-5f05-6554-d019-9665536aea84@criteo.com>
In-Reply-To: <1d9ff7a8-5f05-6554-d019-9665536aea84@criteo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 12:16:37 +0100
Message-ID: <CAJZ5v0iHh2VC1b90G+bXP0WpBmJ__Ba=yAjjCifkMRmd5xrmuw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Report if CPU doesn't report boost technologies
To:     Erwan Velu <e.velu@criteo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erwan Velu <erwanaliasr1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:52 AM Erwan Velu <e.velu@criteo.com> wrote:
>
>
> Le 20/02/2019 à 11:41, Rafael J. Wysocki a écrit :
> > On Wed, Feb 20, 2019 at 11:11 AM Erwan Velu <erwanaliasr1@gmail.com> wrote:
> >> There is some rare cases where CPB (and possibly IDA) are missing on processors.
> >> This is the case fixed by commit f7f3dc00f612 ("x86/cpu/AMD: Fix erratum 1076 (CPB bit)") and following.
> >>
> >> In such context, the boost status isn't reported by /sys/devices/system/cpu/cpufreq/boost.
> > So I'm not really sure why the extra message is needed.  It looks like
> > this message will always be printed (with debug output enabled) if the
> > current cpufreq driver is acpi-cpufreq and the boost attribute is not
> > present in sysfs, which only is the case if CPB/IDA aren't there.
> >
> > Does it provide any additional information, then?
>
> When you know and read the code, yes this patch is too obvious.
>
> As a user when I was troubleshooting why the boost entry was _not_
> populated on one CPU and was populated on another.
>
> Running acpi-cpufreq with dyndbg, I would have found useful to get that
> hint.
>
> So that could helps users that never read that part of the code and
> which are tricked into that configuration.

OK, I see your point.

I'll queue up the patch, but I guess I'll change the message.
