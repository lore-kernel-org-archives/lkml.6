Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B98CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D31F20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R3/cJmh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D31F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeLJQcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:32:47 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35588 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJQcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:32:46 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so7024898vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UG0Qi2CcStYayokU/Y2opuNZ6/I15WCEuy8Vm6uYJ+U=;
        b=R3/cJmh0miqKHbnEV9bRYkVs8tAORpeVnYxvq64b5OwD6rUl3SaeHJnUBeRNVwyAt7
         bjuwJVMBTBxmMCrmqSm4xhCTiW5+fgk9Bi7+ViNg6vGAYgET7QLqszADnqM/CGChvIM/
         tlWSgM32z44ErFWT1gcNtw4J4dtBbs1d0ybXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG0Qi2CcStYayokU/Y2opuNZ6/I15WCEuy8Vm6uYJ+U=;
        b=Ixf8RvNESv5GKtlpuCGgoPkdbOWf/R1h2JV6ZBZC2QPYmr/GUH8dddhd7No8B1otIg
         b3BB9ZHnBe0INyP8UW4/0Z0c17nH8e37FO6w208pKNugEkERxX9o5iK/30/E7j//3v/0
         EUac7dejZq7MJ4MKb8JEWc5HpBTmF/AuNiFT/LbI/mBodD+02jjPp1nfyeuQxascBQ4y
         l/GGLIWNsvP/PlIyBzyfITqinh24I+3BidG1RwsJoS5szghlELDuk3ElPtrl38J3LQhc
         UJpGE5msvHyBQrnGoJqghLim5L5IFNKK/rs5cnMEyiujZO7IZg8lcyNXdOnRxsLw0fw+
         kwXQ==
X-Gm-Message-State: AA+aEWaAif0LcDv++4SGAAnlxqFyu43GAMQD9rpM0rXGHMcJlHCMz2SK
        a94mznZ04f0UDcUgii5nwftJ+23H31Y=
X-Google-Smtp-Source: AFSGD/XFth1nOzznUCcX48kuRvz0Gy5JPuat9AuYncgq8HevXOu7qGi2nNiixaAgV8UrVu/W8ejBMQ==
X-Received: by 2002:a67:6f82:: with SMTP id k124mr5645684vsc.42.1544459564995;
        Mon, 10 Dec 2018 08:32:44 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id h84sm3752446vsi.28.2018.12.10.08.32.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:32:44 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id p74so7026771vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:32:44 -0800 (PST)
X-Received: by 2002:a67:f598:: with SMTP id i24mr5661309vso.87.1544459563516;
 Mon, 10 Dec 2018 08:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20181206222318.240401-1-dianders@chromium.org> <20181210154311.GF6307@sirena.org.uk>
In-Reply-To: <20181210154311.GF6307@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 10 Dec 2018 08:32:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X33+-TiBohnwN6+2R26iwxW0Rcthp16-3XYy+01hW4nw@mail.gmail.com>
Message-ID: <CAD=FV=X33+-TiBohnwN6+2R26iwxW0Rcthp16-3XYy+01hW4nw@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Clean enabling always-on regulators +
 their supplies
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Evan Green <evgreen@chromium.org>, masneyb@onstation.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Mon, Dec 10, 2018 at 7:43 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 06, 2018 at 02:23:18PM -0800, Douglas Anderson wrote:
> > At the end of regulator_resolve_supply() we have historically turned
> > on our supply in some cases.  This could be for one of two reasons:
>
> This doesn't apply against current code, please check and resend.

Can you clarify?  See below where it's applying cleanly to "for-next" for me:

$ git remote -v | grep linuxregulator
linuxregulator
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
(fetch)
linuxregulator
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
(push)

$ git fetch linuxregulator

$ git log --oneline -1 linuxregulator/for-next
f00e93a1224f (linuxregulator/for-next) Merge remote-tracking branch
'regulator/topic/coupled' into regulator-next

$ git checkout linuxregulator/for-next
[ ... cut ... ]
HEAD is now at f00e93a1224f Merge remote-tracking branch
'regulator/topic/coupled' into regulator-next

$ pwclient git-am -p lkml 1022439
Applying patch #1022439 using u'git am'
Description: regulator: core: Clean enabling always-on regulators +
their supplies
Applying: regulator: core: Clean enabling always-on regulators + their supplies

Thanks!

-Doug
