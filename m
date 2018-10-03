Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB6AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720C72098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720C72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJCOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:21:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42724 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:21:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id n2-v6so4374060edo.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43ifib7ypSd2V53d9a28LJVezvVvL18XUDyY9WlTsjA=;
        b=UhxWt2dd3kusk+2k5/3lshnJJjTSZ1iMpfSIk1oUgjpTB0ljPMczXkZiF51GxI+24D
         g1bt1LNAStfr7Q4u+TPAd4smALP08nrWphriQ19p0C3WT/X1gHy4spkr1TnuDKjFPqic
         l1mwcigapxnsDJt4va1pUqZbdDjjXKCKCwpUHu/v6/wB88W1T16UAfteVc8JJBYdMeMg
         kJ/5Wh1Lw2usQaV7wGRRTCXtwj2Pal39Xs7h8NBrp5PlisnkQ3mItiEZTHaptk+WkdcU
         f7GqYA1DGmJoMp/7TDBO0BkpWL86n+KZTOnh85KGWLF9uttgu/WgyEBRGikkmEPIzYGN
         zGfQ==
X-Gm-Message-State: ABuFfohcYHViTeJGimxMcsEupvVQ96We8lVhQaci0vfQTekKJAmKtzA6
        VP2BpW7sZGzeN6Td1jTFTR+4z//N
X-Google-Smtp-Source: ACcGV61ghkuhek+MYqK+mSAUtFBz9WK3QrA4p07GmTI7XXGuyc7WTrcJA5wkmNx1Z5otDbO2Y9FFEQ==
X-Received: by 2002:a50:9386:: with SMTP id o6-v6mr843264eda.248.1538552064623;
        Wed, 03 Oct 2018 00:34:24 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id c18-v6sm135191ejz.68.2018.10.03.00.34.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 00:34:24 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 143-v6so4616910wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:34:23 -0700 (PDT)
X-Received: by 2002:a1c:8dd1:: with SMTP id p200-v6mr497362wmd.145.1538552063478;
 Wed, 03 Oct 2018 00:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181001093612.GA13672@mwanda> <20181002215917.1849-1-giulio.benetti@micronovasrl.com>
 <20181002215917.1849-2-giulio.benetti@micronovasrl.com>
In-Reply-To: <20181002215917.1849-2-giulio.benetti@micronovasrl.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 3 Oct 2018 15:34:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mEqBYfeX_j_pj1Uu4OUfeESBQwXmQeqoqfEHP-CW3dQ@mail.gmail.com>
Message-ID: <CAGb2v66mEqBYfeX_j_pj1Uu4OUfeESBQwXmQeqoqfEHP-CW3dQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/sun4i: tcon: prevent tcon->panel dereference if null
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 5:59 AM Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> If using tcon with VGA, tcon->panel will be null(0), this will cause
> segmentation fault when trying to dereference tcon->panel->connector.
>
> Add tcon->panel null check before calling
> sun4i_tcon0_mode_set_dithering().
>
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
                      RGB565/RGB666 LCD panels")

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
