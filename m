Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC84EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D67420657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IFndXT+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D67420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJaBDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:03:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35161 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJaBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:03:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id d7-v6so9316887lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNl8GG+YFi7wmWA1B4JUWH8UU/EN2iPSsMsgahrcogs=;
        b=IFndXT+x84X8DNvXE9pHZ8W00UlSxu9+qL+q3jhvxNYBXkGnA2M5lRz8vuz7O7Mshm
         WCjgK2pCWzpjpmUCt1yOF4L7g3easNIu8iVeDsRnOQhXwwS0GTAGESUFLXc4kCswKIyn
         zt2fiwIq/M0L4/kevI6LShJW0EsjEuBDt3C20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNl8GG+YFi7wmWA1B4JUWH8UU/EN2iPSsMsgahrcogs=;
        b=smIfmMnX92aPGUE85B10QZhOGLtlxbbSQHupJjDW8vYTiENlTSeRbbT8BHM8ezFcRX
         vgVjVGcycY1ywhB/4vc05cSQG81T39u9Phw5fI8EnKKQ+Z2mw+J7ArOglzwlovVmQr5Z
         tJrqZ9xRh3Y/LZ3pZua6tqHY8tPN3mbSAkB1CcM3EMhPKdyzjoRUfBjQAnAhoa3Nvxfn
         N0LdNmEjvQPgFGg6d5soQI1g4lSgZlbBl2p2ZTR1aJwkTmbV9dzxOhyRHzDbvKUlK1I4
         76Mq5zwZbqhjihyYrodwf+SWpOwTUvmyWiGW8rUMpQewXdQQ4SpVDFJm7TU0muMZ7p0+
         zd1g==
X-Gm-Message-State: AGRZ1gLUfdaCKHcqi6QTjhylN3XVd66ps+QsiiuxbZntHcaBiCGmww1Y
        Zt2IiR9HjNhk7hS5vmbxdN5aDKUrKQ/9Zg==
X-Google-Smtp-Source: AJdET5eVDqcCNq6sBrmoipEIcFzPLRd+pgPGptMVz+NLSWjqIfkqFgGEDfbNOe0kZpIL2mUY0UrTdw==
X-Received: by 2002:a19:a086:: with SMTP id j128mr2177877lfe.93.1540915769726;
        Tue, 30 Oct 2018 09:09:29 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p19-v6sm1073145ljb.47.2018.10.30.09.09.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:09:29 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id i26so4996412lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:09:28 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr2277582lfa.106.1540915768131;
 Tue, 30 Oct 2018 09:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0g7iRUA2=fi3+rkJcsx38YTE6fx26bnnpjeMHwv_CSMVw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g7iRUA2=fi3+rkJcsx38YTE6fx26bnnpjeMHwv_CSMVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 09:09:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyRsCfBqOo6F0SEq-fO=euSfHbmW2dWifgmVXSXaNwTA@mail.gmail.com>
Message-ID: <CAHk-=wgyRsCfBqOo6F0SEq-fO=euSfHbmW2dWifgmVXSXaNwTA@mail.gmail.com>
Subject: Re: [GIT PULL] More power management updates for v4.20-rc1
To:     Rafael Wysocki <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 1:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> These remove a questionable heuristic from the menu cpuidle governor,
> fix a recent build regression in the intel_pstate driver, clean up
> ARM big-Little support in cpufreq and fix up hung task watchdog's
> interaction with system-wide power management transitions.

Pulled,

                 Linus
