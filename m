Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8096EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DC4214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DC4214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbeHBOZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:25:48 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:28045 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbeHBOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:25:48 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171])
        by mwinf5d24 with ME
        id JCal1y0093iUoqR03Calbh; Thu, 02 Aug 2018 14:34:46 +0200
X-ME-Helo: mail-qk0-f171.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Thu, 02 Aug 2018 14:34:46 +0200
X-ME-IP: 209.85.220.171
Received: by mail-qk0-f171.google.com with SMTP id v17-v6so1362537qkb.11;
        Thu, 02 Aug 2018 05:34:45 -0700 (PDT)
X-Gm-Message-State: AOUpUlGJ0RtiFbPwBZrZ7ZqUGXi1moEX3KxzaLTufmoH3ovL5tbvrErv
        ngMDy/ok6/8LIiqZyg7AuYFhCT705kCellsiLus=
X-Google-Smtp-Source: AAOMgpfsDOWE97V8j+3oW+9u4UM3DVPGMP4tvC5dRYcHfjIPoeQqo5Q7ON8G0ZEKbnBezk4HVOIsvSJQXnc094qZEkQ=
X-Received: by 2002:a37:b446:: with SMTP id d67-v6mr2293163qkf.104.1533213285136;
 Thu, 02 Aug 2018 05:34:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:278a:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 05:34:44 -0700 (PDT)
In-Reply-To: <744700e43aed3880807f86abde0caf3df1127e60.camel@baylibre.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-5-maxi.jourdan@wanadoo.fr> <744700e43aed3880807f86abde0caf3df1127e60.camel@baylibre.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Thu, 2 Aug 2018 14:34:44 +0200
X-Gmail-Original-Message-ID: <CAHStOZ6B-R7=5utGqb49OsFBsUsMVsn=WMrzNK8Wk-zcgbnPuA@mail.gmail.com>
Message-ID: <CAHStOZ6B-R7=5utGqb49OsFBsUsMVsn=WMrzNK8Wk-zcgbnPuA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/meson: convert to the new canvas module
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

2018-08-02 10:39 GMT+02:00 Jerome Brunet <jbrunet@baylibre.com>:
> I looks like the consumer of your 'canvas' devices must know how the canvas
> device is organized internally. Maybe something better can be done ?
>
> Your canvas driver could provide a consumer API, for example:
> meson_canvas_get(): to translate for struct device_node to whatever abstract
> pointer you would need.
> meson_canvas_alloc(), setup(), etc ...
>
> ... This is just adding a bit of indirection but it would help hide the plumbing
> of your canvas driver from the consumers (and repeat this code in each). This
> might be usefull if you ever to make this canvas driver evolve.

Overall the inner workings are hidden as there is an ops struct
instead of public functions.

I agree that the "fetch the node" boilerplate code could be put behind
a helper, but at the same time this code helps remind the developer
that there needs to be a canvas node in the dts, and that it has to be
linked in your own device node.

I would like to keep it that way if that is okay with you.
