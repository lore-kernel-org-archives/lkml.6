Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D8BECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34E82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKBp+W4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34E82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeGRGvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeGRGvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:51:05 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B548920850;
        Wed, 18 Jul 2018 06:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531894493;
        bh=SYr/TQGDjCP2ZueP0RqN6wK9pTSWuzVN/TYiBJwjyw0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HKBp+W4yEI/94mDMfmJHWdO+oaxWAjb1GaoD2WeKs3F+KXrmL8hzvN0i6eb0B5hnA
         CqnVXzRlCLTTGwA0L/1K22nrgZGflgO+yoo7WMWOdJoDWgNCkDV1UP8SuziC04kdXT
         hLfouGnmGvhENmzbDj7hbvK+uFTNfUrT6q3p7fyw=
Received: by mail-wr1-f54.google.com with SMTP id c13-v6so3369736wrt.1;
        Tue, 17 Jul 2018 23:14:52 -0700 (PDT)
X-Gm-Message-State: AOUpUlFLisEznMMMs+XpSMFQjoU+alFpkvjcR+U9GLDxVkgZa4nDXW9k
        tWl45dB+BggUYJBdMvnt6mrrsUcV1ghtkraFYv4=
X-Google-Smtp-Source: AAOMgpc+hMOdRNfH52l6yGfU3YH5xdq54gSGsGpHppzZk0LhO4w0b2m2Ns6ldj30SVy8du4jNx5FMr8237dKqVOC0A8=
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr3414629wre.12.1531894491251;
 Tue, 17 Jul 2018 23:14:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 23:14:50
 -0700 (PDT)
In-Reply-To: <20180717214739.GA19410@embeddedor.com>
References: <20180717214739.GA19410@embeddedor.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Jul 2018 08:14:50 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc3vss1=gYy+6ej6J2LNz+RtBoHFEN84j18wd0yy_NaDg@mail.gmail.com>
Message-ID: <CAJKOXPc3vss1=gYy+6ej6J2LNz+RtBoHFEN84j18wd0yy_NaDg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max77693_charger: fix unintentional fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 July 2018 at 23:47, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> It seems that a *break* is missing in order to avoid a fall-through.
> Otherwise, the calculation of *data* makes no sense.
>
> Addresses-Coverity-ID: 1271172 ("Missing break in switch")
> Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/power/supply/max77693_charger.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
