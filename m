Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EDDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352A821A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352A821A5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeHFVpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:45:34 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39409 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeHFVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:45:34 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3C74D3004D18E;
        Mon,  6 Aug 2018 21:34:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 01E102FE97; Mon,  6 Aug 2018 21:34:57 +0200 (CEST)
Date:   Mon, 6 Aug 2018 21:34:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org,
        Karol Herbst <karolherbst@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 3/8] drm/fb_helper: Introduce hotplug_suspend/resume()
Message-ID: <20180806193457.GA7028@wunner.de>
References: <20180731003954.19962-1-lyude@redhat.com>
 <20180731003954.19962-4-lyude@redhat.com>
 <20180806084322.GK3008@phenom.ffwll.local>
 <4e72a10062166d646ebd3eb28b6c186d4c00a63f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e72a10062166d646ebd3eb28b6c186d4c00a63f.camel@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:15:31PM -0400, Lyude Paul wrote:
> You did mention in the review of one of my other patches that we should avoid
> disabling polling during runtime suspend, and you're definitely right. I feel
> a bit silly for not remembering that since I was the one who made it so that
> i915 does polling in runtime suspend for chips without RPM HPD detection in
> the first place because it was causing people's displays not to come up on
> vlv...
> Anyway: I think if we just leave output polling enabled during runtime suspend
> that might actually fix all of the fb_helper locking issues since we won't
> need to wait on any of the output poll workers to finish, at least I think it
> should: I'll confirm this when I get into the office

Quoth Imre Deak:

   "In i915 polling is on during runtime suspend only if there are outputs
    without hotplug interrupt support. A special case is when an output has
    working HPD interrupts when in D0, but no interrupts when runtime
    suspended. For these we start polling (from a scheduled work) in the
    runtime suspend hook and stop it in the runtime resume hook (again from
    a scheduled work)."
    https://lkml.org/lkml/2018/2/12/330

nouveau only uses runtime PM on discrete GPUs in dual GPU laptops.
Resuming the GPU from D3cold to D0 every few seconds to poll the
outputs would waste too much power on such machines.

The question is, why is polling running at all, since all modern
laptops have HPD-capable ports such as DP?

Thanks,

Lukas
