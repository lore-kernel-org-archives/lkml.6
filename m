Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BEBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29772080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549451713;
	bh=Z5R2qJFnEXEwqcHmT3jaena56ZwfcpxWBptoLFDd3XQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mVvK49/g+xHnYTcpfcnmXqcfk93txhk+ad/KCEA7edNfQb8bO3i5XtdaXhbuuNdvb
	 yCjrbkHLRYmHAydk39a5HKuihLMp6sNIsm8zqQpzYzGrhHU06DaKYGcT2w/lRvMxDl
	 qoZCN96WdZR/rHjNJS3UPFp26HO9QbAwAogmrGS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfBFLPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:15:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfBFLPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:15:10 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C22218AD;
        Wed,  6 Feb 2019 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549451709;
        bh=Z5R2qJFnEXEwqcHmT3jaena56ZwfcpxWBptoLFDd3XQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e7AVy+uJM+0ctg5+IFRxh1O/6xQVlNKQbWPQTZ0EZdg2PS7CzyB/6SEuhZLReaQE6
         1PfDSRviGd7tw9lCHC8RF8y/GPzjFoOTFF9ZontuKrUMjlmLS54JVzcIJeCZW/1aDb
         osUOLQ7UAMDCgG+Wzy7vaZ+mhP+S/rZW+5XzRy+c=
Received: by mail-lj1-f178.google.com with SMTP id v14-v6so2872365ljv.1;
        Wed, 06 Feb 2019 03:15:09 -0800 (PST)
X-Gm-Message-State: AHQUAuYnjL9pphJiO5x516IBJFhUCGkF3rD8zrwAVSnARw7YV0/ciAHb
        F7cMzhooBS9L40Oc44Ql15ucPFLIj4tspfmoaxU=
X-Google-Smtp-Source: AHgI3IYB+tFWYnyzMq1DVEcT7wW3+DZ/r9VkK9/rLE7HxxFPXFMPs/8JBBb2bn9tcYVpUu9ZG+9pOWw+rLGPUzCbW2o=
X-Received: by 2002:a2e:81da:: with SMTP id s26-v6mr6079294ljg.183.1549451707342;
 Wed, 06 Feb 2019 03:15:07 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
 <20190205211622.GA5891@kozik-lap> <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
 <20190206100549.GO3837@imbe.wolfsonmicro.main> <CAJKOXPejBO_9iBHg1R8M2=tcuTck72DjxTYEUyQOp8cPV-0xTg@mail.gmail.com>
 <20190206105955.GP3837@imbe.wolfsonmicro.main>
In-Reply-To: <20190206105955.GP3837@imbe.wolfsonmicro.main>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 6 Feb 2019 12:14:56 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcQfsNnuns1BprEPy4=ggW7fU+_-O_VksrWuT4GPPgAwg@mail.gmail.com>
Message-ID: <CAJKOXPcQfsNnuns1BprEPy4=ggW7fU+_-O_VksrWuT4GPPgAwg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dapm: Check for NULL widget in dapm_update_dai_unlocked
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 at 12:00, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Feb 06, 2019 at 11:22:33AM +0100, Krzysztof Kozlowski wrote:
> > On Wed, 6 Feb 2019 at 11:05, Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > >
> > > DAIs linked to the dummy will not have an associated playback/capture
> > > widget, so we need to skip the update in that case.
> > >
> > > Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >
> > > Ok so that all makes sense, this patch is probably the best fix?
> > >
> > > Thanks,
> > > Charles
> >
> > For this particular issue (NULL-pointer):
> > Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > However now I see bug sleeping in atomic context:
> >
> > [   64.000828] BUG: sleeping function called from invalid context at
> > ../kernel/locking/mutex.c:908
>
> Does this probably definitely get fixed by reverting my patch?
> It's just a bit odd as this seems to be complaining about a clock
> operation in i2s_trigger and I don't think my patch should have
> any affect on the trigger callback. It should get run from either
> the dai_link DAPM event or hw_params, neither of which should
> happen in an atomic context.

Before this fixup, probably NULL pointer happened before any of this.
I tried it now few times and the possible deadlock and sleeping in
invalid context did not appear. It might be random/racy or totally
unrelated to your change.

Best regards,
Krzysztof
