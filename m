Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DEA2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DEA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJEAOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:14:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37032 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeJEAOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:14:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id o13-v6so9937148otl.4;
        Thu, 04 Oct 2018 10:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y51pMsA3fwj06TA1z3K0Ik230Z25HrWwKcwavXb1d3E=;
        b=UAu2vKwO76jOpnjsiIChmlEuNyBk1pKfMtKBVPYsbBF4sorUcaU5PxsHUO3LoQaH8Y
         J5Rxx/ehcPlSxM3Fxpbu4BG1NUkgSIs7WLij0hAmyYaq0Q/CWZ4lKVtN40epG6Y/HxPZ
         mRIzrOauqJwNqh9y/+yWQyM6/wtSnyHUgQxpp8xgCoRJLFtJ+pAMSazHSw16ymQHcvws
         TUKbTir9DFwhC+xIBZPgEbP71Ge1TbesGkrZp08PGYwVDekofsFLmNwsDaAqUuilQ9vN
         NQL3MH/aLSgMJhkzIWONES9C5bRDKYyab1ZGE6KNBbvz0OvL5l0JU1WN2rFFac8NCbo5
         pp1w==
X-Gm-Message-State: ABuFfogAfXCqDl0GSFj3H9HrslWzSBzKETPcnuY1hnFNiY3fFo5xO+jq
        Ey4bs5W/b0lOogXYpuISqIxJl1y6esycNDv4OARqf48L
X-Google-Smtp-Source: ACcGV62yI3Ufv8x7dNrsqmecgO46UV1R4Dvj6OTjwz4vlqwesmTGOl5Nvsk5ASXiC+lFd+SsH2yHDsyUwTZvp3Fn/co=
X-Received: by 2002:a9d:7594:: with SMTP id s20-v6mr4449702otk.258.1538673594044;
 Thu, 04 Oct 2018 10:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <3510260.hvypppS8Bs@aspire.rjw.lan> <4130376.2FFt7p4687@aspire.rjw.lan>
 <20181004145116.GB1881@mai>
In-Reply-To: <20181004145116.GB1881@mai>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 19:19:41 +0200
Message-ID: <CAJZ5v0h1Z7MKjq9XY0-tn9U4J3CdycYPbGkM3fjH7-FzaJ=uJA@mail.gmail.com>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from menu_select()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 4:51 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Rearrange the code in menu_select() so that the loop over idle states
> > always starts from 0 and get rid of the first_idx variable.
> >
> > While at it, add two empty lines to separate conditional statements
> > one another.
> >
> > No intentional behavior changes.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> This code is becoming a bit complex to follow :/
>
> May be I missed something, but it is not possible to enter the condition without
> idx != 0, no ? (I meant the condition if ((drv->states[idx].flags &
> FLAG_POLLING))

Not sure what you mean.

We start with idx = -1, i = 0.  If state[0] is enabled, idx becomes 0.

If the target residency or exit latency of state[0] are already beyond
the limits, we just bail out and state[0] will be returned.

If not, we go to i = 1, but idx is still 0.  If the target residency
of state[1] is beyond predicted_us (which is the interesting case), we
check (drv->states[0].flags & FLAG_POLLING) and so on.

Currently, the polling state must be state[0] (if used at all) anyway.

> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>

Thanks!
