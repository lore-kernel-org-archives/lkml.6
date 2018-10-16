Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0CFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC6520866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC6520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeJPMD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39944 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbeJPMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so19915241edd.7;
        Mon, 15 Oct 2018 21:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMiCZ2pEihOPxSKm4hFWryYBLOs0UYYkcNi1xZHzCBI=;
        b=IXHGuN+D/UGQuKnmeEtHSqavws/mdKyTobCSM4NI8cGEZbLWwppZ/2Bv825yOjt54r
         PDQC2oir2Yxt2YDa4/AdacKb4vNx8Cy2w1QJXcCH+vGZQNkaKu/iHkLOZn0x+6iuDftZ
         wXy0QJy0ukzP5vWFQrKwsKXibDjzlTnCWK8TmTyAHE8M+UGQkocMJH8gnAJBs/6K9e3B
         6uGUErqo/75Tr1DnxfYbrV+NsE1dhwqlr4ameAETCq6JXlJBDjKF9DeKDYOBqkzuKof/
         ICyXWmmSP5d0Jm3t9/byCulJGwOTWGMuuqX6ZCtt3O7+l6lk6Kxkr1cGEB2TkPWkI+lq
         3OzQ==
X-Gm-Message-State: ABuFfoh6E8MaSKp6hAIP/f6siRj6AaNq0PUltYGnWnwhJk1D3iNrP8bh
        8jUqVQWhnh2GODzgjVKKsheZTp9GYos=
X-Google-Smtp-Source: ACcGV61TNmN+BBEaYRwPBt5U6lcn1z6AFSYL2G5MHM7xJsS813zBa4BXsjnmskV47r5OiiLr7SJzDQ==
X-Received: by 2002:a17:906:6454:: with SMTP id l20-v6mr21206350ejn.73.1539663332152;
        Mon, 15 Oct 2018 21:15:32 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id e21-v6sm5740253edb.22.2018.10.15.21.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 21:15:31 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id z204-v6so21738332wmc.5;
        Mon, 15 Oct 2018 21:15:31 -0700 (PDT)
X-Received: by 2002:a1c:1d6:: with SMTP id 205-v6mr15479434wmb.151.1539663331214;
 Mon, 15 Oct 2018 21:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-7-oskari@lemmela.net>
In-Reply-To: <20181013080848.29894-7-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 16 Oct 2018 12:15:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v678XQtLwu8RqCHT8pf4dS+7viyP6dOihgKd5AFZTJxYVg@mail.gmail.com>
Message-ID: <CAGb2v678XQtLwu8RqCHT8pf4dS+7viyP6dOihgKd5AFZTJxYVg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] mfd: axp20x: Add AC power supply cell for AXP813
To:     oskari@lemmela.net
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> As axp20x-ac-power-supply now supports AXP813, add a cell for it.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
