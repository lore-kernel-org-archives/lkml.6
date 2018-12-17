Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5426C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B581B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545048002;
	bh=CJ1TQn4yAcJLE04RPlZD1B5r6ftc4PorkCAtw6bZ4eM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j/F+bhAgBPnwe7aj6nKipEZt1LXTsAK7AHurnFsx18gHOPtiBhhmj6OHEbB99R+re
	 5VeBtsbqD/2rywambthD0W4SCIVIgAJK7HMKY3ir9HWftgxygLq2ZTppblCtqpbZOf
	 +17wYPtFXX12IYMzaVFAewzq//Upn1r4mEwEm2j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbeLQMAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:00:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39852 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeLQMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:00:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so9920255oia.6;
        Mon, 17 Dec 2018 04:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nH9Wl8Ldv5pJ1DQDWlAzrp8ExUR5L7BPXmHdnn+WCy0=;
        b=OoXg//KFNSMTCLuu+46ejEkCUCKG7GYfaLdvEsQDbNkHnohMT2Ynui3yMT6wk8JfJw
         G641yvbfg8grVsq68cSBQMaXNqsSfQg6O8xlTv7SPkSYLNRAeFS9iuApxqlsbShogsHj
         MXMtRcTp9V5RP2hWNgEJUP3LR18PUdISmCux3ai2XrdI/0wpIPDUxoWIV5MmVLbYC9Qz
         0/OV70Jv53HodgaRjAokP2YzRYgrbCWr5L1Wkb+E+foFkp5Nvv9z8PpEpG7U11BNwwbY
         6UfbDWphKfbBtihlWYQ8jyq5sJ3naEpsmcmO66lwHIHzA8ke19gIDcH8HzBHat7OhH7Q
         Tbbw==
X-Gm-Message-State: AA+aEWY2uZB6AVpt8BLko6xfSWgcVqMErV2CWaiseUEcK1+AO/v+V5UK
        dr05bmaLU4PRH0TI8UMARzP9lXj4p8duWQD/Sjg=
X-Google-Smtp-Source: AFSGD/VoixgqPUOLeo6KOSjXnji6ZdlQJW2M+sYelUeQ9RayH6W5VPPtrJdf0NCBzpikASSub1VsWpfkwfdiBoc0CsY=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr5414646oia.95.1545048000369;
 Mon, 17 Dec 2018 04:00:00 -0800 (PST)
MIME-Version: 1.0
References: <000001d495ab$5c16eea0$1444cbe0$@net>
In-Reply-To: <000001d495ab$5c16eea0$1444cbe0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Dec 2018 12:59:48 +0100
Message-ID: <CAJZ5v0hg3pGoptF4oC4+=1n5y8cGsqOSoJeSaRzC-6tmvqEnjA@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor
 for tickless systems
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

On Mon, Dec 17, 2018 at 2:53 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2018.12.11 03:50 Rafael J. Wysocki wrote:
>
> ...[snip]...
>
> > With this version of the TEO governor I'm observing slight, but consistent
> > performance improvements in some different benchmarks on a few different
> > systems with respect to menu
>
> Same here.
>
> > and the corresponding power draw differences
> > appear to be in the noise.  The idle power doesn't seem to change either.
>
> Same here.
>
> > Also the "above" and "below" metrics (introduced by a separate patch under
> > discussion) indicate changes in the "good" direction.
>
> My graphs now include the "above" and "below" metrics.
> In particular see Idle State 1 "above" (was too deep) graphs in the links below.
> However, performance is up and power about the same, so O.K.

Thanks a lot for the comprehensive results, much appreciated as always!

This basically confirms my own observations, so my overall conclusion
is that what we have here is as good as it can get without changing
the approach entirely or adding complications that would be difficult
to justify in general.

> > Overall, I like this one, so I may consider dropping the RFC/RFT tag from the
> > next submission. :-)

And so that's what I'm going to do.

Cheers,
Rafael
