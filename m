Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B658AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7783225988
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7783225988
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeF1B5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:57:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45437 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeF1B5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:57:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id x22-v6so4171120edq.12;
        Wed, 27 Jun 2018 18:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/GhkEQARb1ISUY8FpWTryLEQJS5xBCRPJgDn3YoO3EU=;
        b=rh7kdjBS1vXiM7FG8zUlojh6PwqDsYaigHDeLNRt6MxTtnZQsLrSQEK1KmUaHacvme
         n7M2uMVHRB+Cx5cO73U6IRHXEVER8yBkh8MmlcfRLKGxRChEXEPbFsurqviXpbVV+oWs
         ypAvBjQQ8Pn1ZQyDdFizACDf+mX1Ppbl6nckK2/ybrLdTqipLhBS+NQ9eQpCOz6A1cKg
         0dVaXYbw3NUSr+57+zqld9W8aQMq9Qk2JHlRj1rtrgAd2EWCt7gAE/9OdhQnGsrNRRWX
         1X5Gb7YJGlYQBznbOeVLF2wDRnD0z605XNUswsAbbBkHbSgBbjnZgisJT3o9UhcL/Zi8
         D8Sg==
X-Gm-Message-State: APt69E0O1fKzme5bzQn1DDyADbN+YXd2SvnjXajI+7OfUDoNAb410g76
        T+tTnFKrCNlEnuSv4TOHsV0F1Hi1
X-Google-Smtp-Source: AAOMgpdsjtE+AtjeOu8/89yBfhtEZB1DhfzcKsIfkhhMmahsNiS3GvHWAq512XAHIlywqkoFt6p9FA==
X-Received: by 2002:a50:8466:: with SMTP id 93-v6mr7441579edp.304.1530151052965;
        Wed, 27 Jun 2018 18:57:32 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id t20-v6sm2353061edd.93.2018.06.27.18.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 18:57:31 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id v16-v6so7773938wmv.5;
        Wed, 27 Jun 2018 18:57:30 -0700 (PDT)
X-Received: by 2002:a1c:bf0c:: with SMTP id p12-v6mr6300726wmf.120.1530151050645;
 Wed, 27 Jun 2018 18:57:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 18:57:10
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-9-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-9-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 09:57:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65+L9rTFZ4+zNXvCX4=Ni8mHzkFYCPK2GcBmTELh34Ojw@mail.gmail.com>
Message-ID: <CAGb2v65+L9rTFZ4+zNXvCX4=Ni8mHzkFYCPK2GcBmTELh34Ojw@mail.gmail.com>
Subject: Re: [PATCH v3 08/24] drm/sun4i: Add support for traversing graph with
 TCON TOP
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
> TCON TOP is different from other nodes in graph by having 3 input and 3
> output ports. Additionally, connection to TV TCON might lead back to
> HDMI mux input port, creating loops.
>
> Add support for traversing such graph.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
