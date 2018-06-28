Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF12DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A8A25735
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A8A25735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeF1Bv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:51:56 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:37312 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeF1Bvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:51:54 -0400
Received: by mail-ed1-f53.google.com with SMTP id v22-v6so4169575edq.4;
        Wed, 27 Jun 2018 18:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q6DVApFX3hiNe28Yqgt6dgCl1YcA+DE9KxGr2XoYfAU=;
        b=PbQxtxq5HPCNBxY0bKwS7jk1bLGVK890VRMDkcA5LU2Ji0cNYM0MCV9qq7cDSmeTy9
         WlmKOO+AU3G9sFE2Tj11zRw21FX1SmpKs12MXrJ+jQQSQdGIJTLwYLAsDLz/CfrThtZ5
         0wtnDPE8OOLz73odz9f/HIiUVbRhqvtw9Ot91ooRhHv3ngm8EX2AXrco/hEeARHyjoSg
         wOJ8QAFHemySLoTmtHwOBkkDpYsCj9XBBKgpY4qSRbhjg8aIMWXkrlDcqWF6nbc6rDIc
         cwrvwlc66vjqEA+Bcv49nJ9c7gNCM7730OFJuMpihAw61OqWsUwm/gxAoE24xWX/mZX8
         IHSA==
X-Gm-Message-State: APt69E2FdLgF0FqHWESKe95393Yt0LctMUuTGFyMSapOdlyIEpFv6y9H
        TwS34C9Bd8CRdDfS5GZL4DWoaG6f
X-Google-Smtp-Source: AAOMgpdpP2k+cVguZ7dstUoXBb8uVzbhIs43WpZV76GilbPMAzm2klXfkFLWppAHyBO2kFrgapcRTg==
X-Received: by 2002:a50:9756:: with SMTP id d22-v6mr7342693edb.153.1530150712174;
        Wed, 27 Jun 2018 18:51:52 -0700 (PDT)
Received: from mail-wr0-f181.google.com (mail-wr0-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id x41-v6sm3594670edm.59.2018.06.27.18.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 18:51:51 -0700 (PDT)
Received: by mail-wr0-f181.google.com with SMTP id u7-v6so3778151wrn.12;
        Wed, 27 Jun 2018 18:51:51 -0700 (PDT)
X-Received: by 2002:adf:ae09:: with SMTP id x9-v6mr6874430wrc.19.1530150711778;
 Wed, 27 Jun 2018 18:51:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 18:51:31
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-10-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-10-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 09:51:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v64EkVK+AEngEuadBzAZagyU7eyOhHhBh0iFrxS+-BbCYQ@mail.gmail.com>
Message-ID: <CAGb2v64EkVK+AEngEuadBzAZagyU7eyOhHhBh0iFrxS+-BbCYQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs if they don't have
 channel 0
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> TV TCONs (channel 1 only) are always connected to TV or HDMI encoder.
> Because of that, all output endpoints on such TCON node will point to a
> encoder which is part of component framework.
>
> Correct current graph traversing algorithm in such way that it doesn't
> skip output enpoints with id 0 on TV TCONs.

No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that don't
have channel 0, it must be skipped.

ChenYu
