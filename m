Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3746C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF45218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550431233;
	bh=YpjJij2lEH9h84xnVJ7UzxSrkxlG9bssYB6nr54xtVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rOGR0Ol8ykSoPtVqeIsI8RxMZc5AgcuOzrwJ+6oAWWGWQufdnLP+U6c4hBvwq8F5H
	 YME2DmumhqZ6WSmB6e76obtGiLqJy01xEVxG3RUGhVES/tVt/G6tZWt8bX+uMQJ0b6
	 DbO8mrNRlUCAw67IuA1Baq0h6ir1tAoq3ltrgHY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfBQTUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:20:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfBQTUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:20:31 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E1E2186A;
        Sun, 17 Feb 2019 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550431231;
        bh=YpjJij2lEH9h84xnVJ7UzxSrkxlG9bssYB6nr54xtVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBl3TZcaaMjCL3DrXO6LncnXaFG5xOUMYXP3yT5kW5e2sxLuvYAO1p2/pOINmAJN5
         FuhDCshCwgOZfdQhu0nrXc+fsx7Z69rTtYO96xGNFJaO9KioJhGlcJbBfQrHgJRqf1
         DoZ6XMZTs0q6Mp14WDQlFFn4n0dgcz2n/oBBk/Ms=
Date:   Sun, 17 Feb 2019 14:20:29 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     David Long <dave.long@linaro.org>
Cc:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19 00/17] V4.19 backport of more 32-bit arm spectre
 patches
Message-ID: <20190217192029.GM10616@sasha-vm>
References: <20190213213223.916-1-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:32:06PM -0500, David Long wrote:
>From: "David A. Long" <dave.long@linaro.org>
>
>V4.19 backport of spectre patches from Russell M. King's spectre branch.
>Patches have been kvm-unit-test'ed on an arndale, run through kernelci, and
>handed off to ARM for functional testing.
>
>Julien Thierry (10):
>  ARM: 8789/1: signal: copy registers using __copy_to_user()
>  ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
>  ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
>  ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
>  ARM: 8793/1: signal: replace __put_user_error with __put_user
>  ARM: 8794/1: uaccess: Prevent speculative use of the current
>    addr_limit
>  ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
>  ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
>  ARM: 8797/1: spectre-v1.1: harden __copy_to_user
>  ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc
>
>Russell King (7):
>  ARM: make lookup_processor_type() non-__init
>  ARM: split out processor lookup
>  ARM: clean up per-processor check_bugs method call
>  ARM: add PROC_VTABLE and PROC_TABLE macros
>  ARM: spectre-v2: per-CPU vtables to work around big.Little systems
>  ARM: ensure that processor vtables is not lost after boot
>  ARM: fix the cockup in the previous patch

Queued for 4.19, thank you.

--
Thanks,
Sasha
