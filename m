Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E2DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5702082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVdtg/Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5702082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeLERuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:50:39 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46623 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLERuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:50:39 -0500
Received: by mail-vk1-f195.google.com with SMTP id j23so4857389vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkiLiBeZmI9yMsS9hUYuHxjpxxrYJ8kD4vfh4dnAkVo=;
        b=ZVdtg/BprjK1QQjZdKEr7uiEFLqmsSCI5T1tneIfnAcw1FFECc4F+mYpBZ+xEomMGT
         2hTx+VLqm7b00jV/4H2Krqx/3PtHadS+hJZCcrPqri58+aigulKt+sJRZnwTFrSMU7sF
         nJwllZ4Eqf+oOAi4jvXWPu3jwjMn7EhHjjJ1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkiLiBeZmI9yMsS9hUYuHxjpxxrYJ8kD4vfh4dnAkVo=;
        b=syPGE7O6amSglZdOhhQokVsaz1L3PJewvqokl5jzyq1LIzvEGKk859vQxOygFDqOMW
         xRQPQABzuMChxLbJ15pTtDnfSrwyJKY7ZJO5MDXUeLzp58JY+vFaEDyxS+Ka0u5e9jtz
         HkG7mkdJfdm326K/vLFGwurgfETQqKTE5YRlgXAJS8nnGtgI/UnvXSKDO/ZqQ+ZKjcwL
         Og13A8hVFuX4uPI1ELFr5DMzHZ3fZFhiDk9e7WNv50eRS9fbfp8iXGWsmaXM8iwsOLM3
         zdIf0p04CQGgjATyIemYlhTeYesdOMB4hqbCqndKNDkMUMrjixAWGW1KK1/0vfj5P1Lf
         4RHw==
X-Gm-Message-State: AA+aEWZaANx25IO3elLuHmDKHpwD0RLQJoSKB5oo+8I5EIawY4rRNBg4
        OfAUL1Vp2+hyKYnzxI6DxqnmYPtLjEU=
X-Google-Smtp-Source: AFSGD/WJgpDENHWXBb/ZMPTL2JJasB63JyvyttvyRQuh7Jn6UxFkmCc2liSA6NKEi/Hqhl3tgY7upQ==
X-Received: by 2002:a1f:a597:: with SMTP id o145mr11419564vke.67.1544032237919;
        Wed, 05 Dec 2018 09:50:37 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id n136sm6926397vka.20.2018.12.05.09.50.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:50:36 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id z11so7416195uaa.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:50:36 -0800 (PST)
X-Received: by 2002:ab0:7251:: with SMTP id d17mr11941438uap.0.1544032235923;
 Wed, 05 Dec 2018 09:50:35 -0800 (PST)
MIME-Version: 1.0
References: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
 <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com> <AM5PR1001MB099412DDC3B33069BCFDC38B80AF0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <50cffd9e-74f4-b0af-5eed-3dad5f32d8f9@amd.com> <AM5PR1001MB0994CDEC9FB92DBCEB83892280A80@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20181205112832.GA6205@sirena.org.uk>
In-Reply-To: <20181205112832.GA6205@sirena.org.uk>
From:   Daniel Kurtz <djkurtz@chromium.org>
Date:   Wed, 5 Dec 2018 10:50:29 -0700
X-Gmail-Original-Message-ID: <CAGS+omCSrt_Fe5=qQc28Dc4GZB-jUH-7kVQ3-Cq6E15tTarxZQ@mail.gmail.com>
Message-ID: <CAGS+omCSrt_Fe5=qQc28Dc4GZB-jUH-7kVQ3-Cq6E15tTarxZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: DA7219: Implement error check on reg read and write
To:     Mark Brown <broonie@kernel.org>
Cc:     Adam.Thomson.Opensource@diasemi.com,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Alexander.Deucher@amd.com, Support.Opensource@diasemi.com,
        Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 4:28 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Dec 05, 2018 at 10:21:04AM +0000, Adam Thomson wrote:
>
> > If the previous I2C access failed, how can we be sure that the write back to HW
> > of 0xFF even succeeds? More importantly these error returns won't necessarily
> > stop subsequent calls to controls within the Codec I believe, so you could still
> > see unwanted writes to HW via I2C, if I2C is sporadically operational. Again I
> > don't see this update resolving that. The key thing is to resolve why even just
> > one I2C transaction fails.
>
> Right, it's just not clear what we can constructively do if the I2C bus
> falls to bits other than log things and the I2C controllers will
> generally do that themselves.  There's no guarantee what made it
> through to the device or what will in future make it through to the
> device.

I agree, there is no guarantee here once things have gone wrong, and
the concerns above are reasonable.  However, in the real world, I2C
transactions do sometimes fail for various reasons.  The I2C (and
other bus) APIs have ways of reporting up their errors so callers can
take appropriate action.  This codec driver can run on all kinds of
hardware that can experience transient I2C errors, thus it sounds like
a reasonable idea to have the driver do some error checking on the
APIs it calls and take whatever action it can.  Just ignoring the
errors and proceeding like nothing is wrong is one option, but we can
probably do a little better by at least checking for errors, abort the
current operation, and pass up errors to higher layers when an i2c
transaction failure is detected.  If nothing else, this would enable
higher policy layers to take appropriate corrective action - for
example, if there is an i2c error when configuring a codec, it seems
advisable to report this up so that a machine driver would know to
abort and not turn on downstream amplifiers [I am assuming here that
something like this would happen, I don't know if the sound stack
really works this way].

Once the default "check, abort and report" error checking is in place,
we could perhaps think about actions that the driver could take to
recover from various failures, such as resetting the device or
unwinding previous transactions before aborting, or retrying....  but
those are all policy, and this patch is more mechanism that enables
policy.

As for this patch itself, I would recommend using
snd_soc_component_read rather than snd_soc_component_read32() which is
fundamentally broken and afaict should be removed, since there is no
way to distinguish between its error return "(u32)-1" and the valid
register value 0xffffffff.  (Edit: I notice that you did this in v2,
so please ignore, but still replying here since this seems to be where
the active discussion is).

-Dan
