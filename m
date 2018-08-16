Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D494C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C56214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C56214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbeHPKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:23:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38897 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbeHPKXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:23:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so6384134oie.5;
        Thu, 16 Aug 2018 00:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZ9y2sYJ1Wfm8H0xQnUEJDKShQYzLJw3wrSOVfEWD/8=;
        b=nR5XR+kcjFN9BOuFDQIC0k6WlhGGER47z4NVwqqKv+O4hP5yMc2lIFOPMZErs20N7/
         pE/tlRUvcQblsKc7ubOevQInSHXfgzEe2eKk9o8I0z87AhU/KUmgLpbVuBwgNEhrN4Xf
         rTH8j/iPUUea+/tnp3NjJzd2yCuzhEVlrQL5WSUxlmm5EISDi1bnXzWLmm+JKpMeLNGq
         GWXexRIOahg5FjPOoBQx+aJSHq8+oOBTU2iHyuzz7bIYggiJkYj0j/dzB7xzTU8jPUUw
         dBJ85SkyeC25zsUuDLXXMtJrFdgNQglxt8KI/Oc3Tb0su4QmJ7T+xHxBzLEhhUYD977S
         nUcw==
X-Gm-Message-State: AOUpUlHNPVrie9O7TnWEKd4iYHnK9ixX5jIFb1tymP8tCmsjqziclWEB
        NJLn9O42QtYbip3C2gowyO7QgBQ9Ouq2+bEraBQ=
X-Google-Smtp-Source: AA+uWPw2IqlKOay9UxcbM86iWZ1jtIPzYLvESpB+0/xudxwTsrEFmI2d8HEc0KvivsLGp0YXSDjLHIQIWawbvAnU2k0=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr28644260oif.358.1534404412492;
 Thu, 16 Aug 2018 00:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwfms8_zJ=xB5wJ0Sgr6gu9-mFnqwEz2cUR-sOHdEV5zqQ@mail.gmail.com>
In-Reply-To: <CAB4CAwfms8_zJ=xB5wJ0Sgr6gu9-mFnqwEz2cUR-sOHdEV5zqQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Aug 2018 09:26:41 +0200
Message-ID: <CAJZ5v0gKfyB7=5ZGj9uXejoBjkuf2snsKwYJM2Ar1_Vg8A8SCg@mail.gmail.com>
Subject: Re: Keyboard lost after exit s2idle on ASUS UX433FN
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 4:45 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> Hi,
>     We recently hit a weird problem on the ASUS laptop UX433FN with
> latest Intel Core i7-8565U CPU on kernel 4.18. The keyboard stops
> functioning after exit s2idle. It stops firing interrupts after resume
> on any keypress. We thought it should be something wrong with i8042
> driver or even atkbd driver, so we tried to skip the suspend/resume
> path of i8042 and input devices but no luck.
>
>     Then we tried to hack the s2idle code to fail right before it goes
> into the idle state to find out which code really cause the keyboard
> broken. It comes with an interesting finding that if it aborts s2idle
> before cpuidle_resume() in s2idle_enter(), the keyboard is fine. If it
> aborts after cpuidle_resume, then the keyboard down. At least it
> proves that even with dpm_noirq_begin() and
> dpm_noirq_suspend_devices() executed, the keyboard is still alive.
> There should be something wrong with the cpuidle.
>
>     Going deeper into intel_idle_s2idle() which is invoked by
> cpuidle_enter_s2idle(), we found that the keyboard interrupt will no
> longer function after mwait_idle_with_hints() which just simply
> executing intel monitor and mwait instructions. So I don't know what
> should be the next step I can take. Can anyone give some pieces of
> advice?

It may indicate that the deepest C-states used by s2idle simply don't
work correctly on the affected system.

To verify this, you can try to disable the deepest C-states via sysfs
using the "disable" attribute under
/sys/devices/system/cpu/cpuX/cpuidle/stateX/

Is s2idle the default suspend method on that system?  If so, have you
checked whether or not suspend-to-RAM works too?

Thanks,
Rafael
