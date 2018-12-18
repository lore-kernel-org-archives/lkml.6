Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF52D21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545147505;
	bh=6RNzlora3yEGlhJT7A20D0CM5WxGyxKVt/F9gKTkZoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SKlyPj+0OW28oR6U4JTAXG6F9cWbztuVgR1nkN7PnoHNPOQscWlZc7KUOw71yZY4G
	 az5RfIYJIqqrGwjbWUzRBVCzxoQxy2GI8WQBfcM8cLwqAYb1ri7h3PF75f4zfgX36i
	 CI24nUe236846ngYhEEOLODF3ZzqM8ifTFiu3FfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeLRPiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:38:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36125 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:38:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so16065212otk.3;
        Tue, 18 Dec 2018 07:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RNzlora3yEGlhJT7A20D0CM5WxGyxKVt/F9gKTkZoM=;
        b=VY5978mhPbiIvdy413cJLbIJv3vwNznNoQ/j5cmn4U29r3D7vddQd/aL/PkMDds042
         hrP/Xclg1GphPirETnA85cLSPEANrJbtRVbUYEzNxpG06ARW03PRnSHK0CEGCbtRxL6y
         55tAEFR9jv3aeeLmfhzGB5iirkOo3HIv14UinV0lqdancWE3pkwz4ZfPJo/5UnYM1Dg9
         npOlTzbF3cd2qnNcEKGQGO13CLb+ZOFL6Pw+rvfwZNi5uXgz7e+ai+171HTRGxap9DBe
         7rwt5Y7X0YvpRSyYLakrGM2x/BTHnMa6M2dKTGcw7ZMQbnde4X8PTBBfkQmZgPhtSNUO
         5rTw==
X-Gm-Message-State: AA+aEWZnuKcyJs1C2GSZfrV9qHwADTOxN9Ymj3Df/gnPuQLbyGGzhtoP
        6oG2f/ZANyIDzoegkPg3CwtUGyQL+PPNtTTZs98=
X-Google-Smtp-Source: AFSGD/Xw3emyUFn6e6x6ZXoHsSKFmY3J499mLF37yoBjxY6DU+L73UBzWz+wQZuozYfRogc/VClDa54ojBMu6Wzy5No=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr11814796otq.119.1545147502891;
 Tue, 18 Dec 2018 07:38:22 -0800 (PST)
MIME-Version: 1.0
References: <000001d496e6$e968c8f0$bc3a5ad0$@net>
In-Reply-To: <000001d496e6$e968c8f0$bc3a5ad0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Dec 2018 16:38:11 +0100
Message-ID: <CAJZ5v0jWzzVJ1ZsY588Z=y6r+-us7Jx3kYHUbRjTrZJRU=ywpA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: New timer events oriented governor for tickless systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, hu1.chen@intel.com,
        Quentin Perret <quentin.perret@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, Dec 18, 2018 at 4:32 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> Just typos, not already pointed out by Quentin:
>
> On 2018.12.18 03:09 Rafael J. Wysocki wrote:
>
> > The venerable menu governor does some thigns that are quite
>
> s/thigns/things
>
> > time frame in which no timer wakeups are possible (becuase it knows
>
> s/because/because
>
> > +obtain the the *sleep length*, which is the time until the closest timer event
>
> s/the the/the
>
> > +increased when when the given idle state "matches" the sleep length only and the
>
> s/when when/when

Thank you!
