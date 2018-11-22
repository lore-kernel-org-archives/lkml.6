Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F3FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D09720684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p18GK26E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D09720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437934AbeKWCdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437920AbeKWCdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:33:07 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52CCB20684;
        Thu, 22 Nov 2018 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542901991;
        bh=vuB0UNwI5an4gTdFUJ+KwREbpNCHQLN55zwycFcVvq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p18GK26E4BKEAtAgW16B4rpfu7wXnlw02Du4cXnHvqxnrcu703qPE0ljTvLY92nqU
         0lWppUW20ifI0vnZO26114VtroTMoF1z+4EJLaM/QmfH4/GzvUC4ufAUV/G4jApaNJ
         Rar8qGS9q3R5nrwGTrNEC1L7CgPzjWilWdYXJzJo=
Date:   Thu, 22 Nov 2018 10:53:07 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shawn.c.lee@intel.com, Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>, cooper.chiou@intel.com,
        Lee@phenom.ffwll.local, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH AUTOSEL 4.9 08/17] drm/edid: Add 6 bpc quirk for BOE
 panel.
Message-ID: <20181122155307.GA6667@sasha-vm>
References: <20181113055223.79060-1-sashal@kernel.org>
 <20181113055223.79060-8-sashal@kernel.org>
 <20181121093126.GJ4266@phenom.ffwll.local>
 <CAKMK7uG=Z_GkNR3J2hdYbEfa9nr6UcMx-HanJ6j85jv1beJsVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKMK7uG=Z_GkNR3J2hdYbEfa9nr6UcMx-HanJ6j85jv1beJsVw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:33:18AM +0100, Daniel Vetter wrote:
>On Wed, Nov 21, 2018 at 10:31 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>> On Tue, Nov 13, 2018 at 12:52:14AM -0500, Sasha Levin wrote:
>> > From: "Lee, Shawn C" <shawn.c.lee@intel.com>
>> >
>> > [ Upstream commit 922dceff8dc1fb4dafc9af78139ba65671408103 ]
>> >
>> > BOE panel (ID: 0x0771) that reports "DFP 1.x compliant TMDS".
>> > But it's 6bpc panel only instead of 8 bpc.
>> >
>> > Add panel ID to edid quirk list and set 6 bpc as default to
>> > work around this issue.
>> >
>> > Cc: Jani Nikula <jani.nikula@intel.com>
>> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > Cc: Gustavo Padovan <gustavo@padovan.org>
>> > Cc: Cooper Chiou <cooper.chiou@intel.com>
>> > Signed-off-by: Lee, Shawn C <shawn.c.lee@intel.com>>
>> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> > Link: https://patchwork.freedesktop.org/patch/msgid/1540792173-7288-1-git-send-email-shawn.c.lee@intel.com
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> Given that I'm not a fan of AUTOSEL at all: This one here is correctly
>> cherry-picked for stable, ack.
>
>An idea that just crossed my mind: Could we integrate this into 0day
>and suggest cc: stable before the patch even gets merged? Or is the
>heuristics not good enough for that kind of automation?

Yes! I've actually tried it before but it seemed that the response rate
was quite low (even for commits that are obviously stable material) so I
turned it off to avoid spamming too much.

If you'd like to be the guinea pig for this, I could enable it for
drivers/gpu/drm/i915/ which I currently completely ignore. If at any
point you want it back off that's easy to do.

If this works well we can extend it to more subsystems where maintainers
might find it useful.

--
Thanks,
Sasha
