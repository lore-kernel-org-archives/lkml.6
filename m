Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C930219F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFXbJL29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C930219F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeHFLqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:46:10 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35567 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeHFLqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:46:09 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so21079973oic.2;
        Mon, 06 Aug 2018 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SyZxqYKMRVFjzuEbMoI6Rrpj7H0UWOnVi5KYNPDzUBg=;
        b=HFXbJL29Tdmm1/0PtrHOR330+49z7AlNsN3XjUEa5A8c/5zd11xRNvQOd0/JlOXUBA
         W2NkCKR5rQESPUDt2KGyksn4J23BUnsfnN9xLxAmMS2FNq9ofFhPqn6w8xGKNk0YW7LU
         Hu0E0Xha6dNYS+hbX48U40OhFnsu17Bh+BgNn7PpCHAT3KdLuzd4zDdYkn8ttukQFvBG
         VmnI5K52uevYIv4g3xqEfoBz9hCLD2MLO59u/XYV/QlnhFMiLghcicZU6HMyQhaBoUMO
         2qiMWBCevDoRS9Tkc+k+vymDnpfZ1wgTgBKTkG+iJQ+d6iHO9bI9G9VMpJ89j6GlPQJd
         HcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SyZxqYKMRVFjzuEbMoI6Rrpj7H0UWOnVi5KYNPDzUBg=;
        b=pvq0dXYeff6/hKjzTgN4gBSMTzbg2fDQirKqgeYlAx8ujpLZD//SlP6V8Rpl9Vzepv
         7RThO7oGOW+sIVODu/5WWza8pweszVkclnDXCZnc7qmV3k/8gJnEMhgA0/8Yge5u75B7
         uNavLxF1NknjVpPtjsuto80yWE1pv1aVPPgYoz5NhDLUvwydh2TitFJGyGPdYil/H1A6
         EJpPvv6qGvSumGZkgXvaXK/sEdHgzdv7iUumIzPeEcsyYcco2m6FAVFYzu7uGf3ODGFH
         /pqgAMktXU0MKI842I8LzbtR2y2f4Aw1ppFjuBFP/NIxSz4ub++6KSmYPgVBVz5yD8AG
         UOmQ==
X-Gm-Message-State: AOUpUlHuQhnMVr0pemfvCRCbo2IsaOXJaL9TaJqcnJeMfaG/Xp8CdPpr
        oyLx4AHi3wRFP5ySf1eSmr5tbIzjtTo+gv52zgY=
X-Google-Smtp-Source: AA+uWPyKfC5V+QJYgjKKEl0tls/7WQFNIFzNZGTYr3tKXeWHNkOZMze6SOCzl2vCyk+VznIQpFM0GMjolTbvN+6mGoU=
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr13147132oib.120.1533548275567;
 Mon, 06 Aug 2018 02:37:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 02:37:55 -0700 (PDT)
In-Reply-To: <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan> <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan> <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Aug 2018 11:37:55 +0200
X-Google-Sender-Auth: H14bSO5pjzQIiWspJj7KLuSnis0
Message-ID: <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 1:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>
>>> Assuming that I have got that right, there are concerns, mostly regarding
>>> patch [07/26], but I will reply to that directly.
>>
>> Well, I haven't got that right, so never mind.
>>
>> There are a few minor things to address, but apart from that the general
>> genpd patches look ready.
>
> Alright, thanks!
>
> I will re-spin the series and post a new version once 4.19 rc1 is out.
> Hopefully we can queue it up early in next cycle to get it tested in
> next for a while.
>
>>
>>> The $subject patch is fine by me by itself, but it obviously depends on the
>>> previous ones.  Patches [01-02/26] are fine too, but they don't seem to be
>>> particularly useful without the rest of the series.
>>>
>>> As far as patches [10-26/26] go, I'd like to see some review comments and/or
>>> tags from the people with vested interest in there, in particular from Daniel
>>> on patch [12/26] and from Sudeep on the PSCI ones.
>>
>> But this still holds.
>
> Actually, patch 10 and patch11 is ready to go as well. I ping Daniel
> on patch 12.
>
> In regards to the rest of the series, some of the PSCI/ARM changes
> have been reviewed by Mark Rutland, however several changes have not
> been acked.
>
> On the other hand, one can also interpret the long silence in regards
> to PSCI/ARM changes as they are good to go. :-)

Well, in that case giving an ACK to them should not be an issue for
the people with a vested interest I suppose.
