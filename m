Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2D9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E893020657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QTwGdeXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E893020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbeKADfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:35:36 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37444 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbeKADfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:35:36 -0400
Received: by mail-yw1-f65.google.com with SMTP id v77-v6so6886541ywc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gpsKMomm+GrwtRyJAOCXyuHRERr88MbuDosKAbF5u+Q=;
        b=QTwGdeXh+dkfNtq+grhyiYFNttpNehW40M6FOwgG3o6+i4JlA4Hc3STgvdklW18bYj
         R0OIx7fHJlWrdetcQ05N/zEvmnrpXKwDhaIqUYMM+Z41xH65zinBMFBfi+9j7l2eKBeb
         xicsDFETy+9dpgloJgAzKvzot3xOt/376LG2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gpsKMomm+GrwtRyJAOCXyuHRERr88MbuDosKAbF5u+Q=;
        b=JgNLGoqDBooIRjkG4AVj0p+5ir6UvktmvkvmKzCOfMBZh78tz9F1eYqpTPkCenbha3
         aA/H7ioveMrlv6ABNR0ebycGfaT8xhrTUwv4ut947vVldevi1QpBKLOy7VmnOWTgJ5sV
         tF9Kd9ErJ7ZlQGUcfKflzSYnttSk6KytzUPdZBY3I0AjM1rsK6HpBdHSNwpWK8YHc1uY
         Otci2Xo9QIJoh7Hh/TABrPH06ObpvHj/2duRQHU9P8x641GA2GZ5ztoywhAZ41LuMJmj
         VJZ52DIP74337jX77PTjOeiYdmjw8wBhVwKrnyk8UQZmClweAPrMYkY2SISYJrzN7CFT
         vD4g==
X-Gm-Message-State: AGRZ1gKufkRVtEx4E6x0ioPEkZabIDl3lo8U0JaOiNgDxPZXIQDZnVFK
        YYJ0pmEJ2+aOU/xq0Mc8GWbeofpaaKU=
X-Google-Smtp-Source: AJdET5dPLo1Bqr6yFbh/HwDGBTlP1bvBaqfFOw/KtSB1TuxNQGJfdGUnPYN956rjLimPrA7qmBIxbw==
X-Received: by 2002:a81:1701:: with SMTP id 1-v6mr4349825ywx.120.1541010982637;
        Wed, 31 Oct 2018 11:36:22 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id k85-v6sm6900617ywa.76.2018.10.31.11.36.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:36:20 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id t13-v6so928993ybb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:36:19 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr4393880yba.410.1541010978747;
 Wed, 31 Oct 2018 11:36:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 11:36:17
 -0700 (PDT)
In-Reply-To: <20181031182107.726051323@linutronix.de>
References: <20181031182107.726051323@linutronix.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 31 Oct 2018 11:36:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK7gjBGe8MWmmoG+wkdfc_wKL5u7ce6Kfbd7+cyBeaUSA@mail.gmail.com>
Message-ID: <CAGXu5jK7gjBGe8MWmmoG+wkdfc_wKL5u7ce6Kfbd7+cyBeaUSA@mail.gmail.com>
Subject: Re: [patch 0/9] time: Add SPDX identifiers and cleanup boilerplates
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        John Stultz <john.stultz@linaro.org>,
        Peter Anvin <hpa@zytor.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        David Riley <davidriley@chromium.org>,
        Colin Cross <ccross@android.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:21 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Add SPDX identifiers to all files in kernel/time and remove the license
> boiler plates.
>
> Aside of that use the chance to get rid of (stale) file references and tidy
> up the top of file comments as they are touched anyway by this work.
>
> This work is based on a script and data from Philippe Ombredanne, Kate
> Stewart and myself. The data has been created with two independent license
> scanners and manual inspection.

Looks good! I need to do this for some of my trees too... too much
boilerplate in the tree! :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
