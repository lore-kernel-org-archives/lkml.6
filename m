Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F78C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D16621829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D16621829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeHMKmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:42:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41141 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHMKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:42:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so25748433oiw.8;
        Mon, 13 Aug 2018 01:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/saEVxGbS3k5A4i6SGFNmFZkf2bD61q/wgEVGHf2mNA=;
        b=PhTVg3aqE2cv0zU+hEmwcvDJZ2gXEjDXwvrs/vn0yAmM6g2nVR6PDTgGiWx6mEsoQC
         /Ys/2qbDWg69/bN80RE9rusezMzeknV8zROPV1fj6QJSdJ1bHGONwC/AkgPfPT8PMaJO
         roh9F8bfz5AwSynT3FokLsQsVPeyG1dJaJEZjB68t2MoCG98P90gANG8qYW7QrNSXygs
         rIgh18yCnhUROxrS7riaLcqPJVGkSCkc4/yGr6qC0k2JQ9l1XLNFS0pmpm8V8SlgWcft
         B/zjRpuVh8w8EYG8gGkjqxUXNYunwR5ZGU+1/PKJyHUEA4keXmans+oAXFjEC7Cqw3J5
         vjfw==
X-Gm-Message-State: AOUpUlGApPYY/VOZ56ty4uDI824ie9nY0ME8z7cpAiPMC9RjrKX6eOjY
        IyNx4aR9q2bYVcY9ZNOtmdBhfy0ewcO/O+TPYHk=
X-Google-Smtp-Source: AA+uWPxmoUiiRhVCsO5WsazswCJtQxgA9iFDB0LFQbykpDgYrvVQcZCnat7e70VX3cq8vCKdVq6t9qLykImnBbY7DPA=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr18365461oie.233.1534147292042;
 Mon, 13 Aug 2018 01:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org> <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s> <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
 <20180810084906.GD11817@leoy-ThinkPad-X240s> <20180810090327.GE11817@leoy-ThinkPad-X240s>
 <CAJZ5v0gM+PNnMH=Myn5yRLYg4SVV3JnF-htO_gueJp4odivT6w@mail.gmail.com> <20180812160740.GC28966@leoy-ThinkPad-X240s>
In-Reply-To: <20180812160740.GC28966@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Aug 2018 10:01:20 +0200
Message-ID: <CAJZ5v0g-ZaUe1AJ=4tixtacaGB-roMXLXj5HNHBqMk+jf3aYnA@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 6:07 PM <leo.yan@linaro.org> wrote:
>
> On Sun, Aug 12, 2018 at 01:12:41PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 10, 2018 at 11:03 AM <leo.yan@linaro.org> wrote:

[cut]

> >
> > Assuming shot noise wakeups, if
> > drv->states[drv->state_count-1].target_residency is less than
> > TICK_USEC, the tick will be stopped for CPUs more often on average
> > with the patch applied (simply because the idle duration range for
> > which it will not be stopped is narrower then).
>
> Yes, good point, so in the new approach I try to change the code
> to compare with next tick delta rather than TICK_USEC, it can keeps
> running tick for the tick with long expire time (similiar with
> comparing with TICK_USEC) but we also can stop tick if the tick is likely
> to break idle residency.

We tried something similar and the results were not encouraging.
Please see https://lore.kernel.org/lkml/079e16b6-2e04-2518-0553-66becab226a6@tu-dresden.de/
