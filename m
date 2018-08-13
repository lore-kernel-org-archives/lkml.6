Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A830BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F02921755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cx4KA3kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F02921755
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeHNAbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:31:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33674 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeHNAby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:31:54 -0400
Received: by mail-yw1-f67.google.com with SMTP id c135-v6so14758396ywa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2P0RwmOqoSTgFF12VsYF4fhPiPt2ayTCfTvFliwooFE=;
        b=Cx4KA3kBF7c1ThLa/UauR64e/5+gDPiUN12PunJfMjzosGnSfTIaV1vq5vzjuoTgHP
         Rm90h8QajVUTyb//uNSOASfG4tY2gSV9a2TH3dZCP1anMr1Ex2hGemDg63dBQAZs0Tzy
         fALFY+vzGpBwxYPYbmmNngcUEes4GFA6J5Seo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2P0RwmOqoSTgFF12VsYF4fhPiPt2ayTCfTvFliwooFE=;
        b=beECXnH/X1gORV+f7TZirY0qsfNHOq2/tJEq0w4gWWBwuxuWVit4Irnp0GIOZCjh2V
         L2pRNspY4Pok8H8Y0yImOE5UpwP9WfWpIKkQR1d5To0G/KEPrk4L8BerfyYp0W+64JAM
         l4ACtKmcfHb5Q9g0CAY3nOujml+wjQjaRCghB6Vm+EkeaswWVcrljzjUGdBqluAnAxDp
         8lZ8D0EkCgesHuSLXbCvJoeOApte3+XJv/BsQanGGU4/PJoW2p5GlLef50RM4eIqd/Dg
         0KFdLE1DI5S1isDi1tR57J86pJZkyILdbsUmDum8qvKsEftnukSQzIpWU4fWLCvw+wIg
         K7Jg==
X-Gm-Message-State: AOUpUlE3i4Bszr1Wp3CcAIQ5+pbxCQItdz0p9ZCcQjDTiOFulVFzn44K
        CHcn8hghQiqs+9mfhxMA0fOUZjrZM1WxHkRQoaSpdQ==
X-Google-Smtp-Source: AA+uWPxS2924+UEMWpDOCkgGRwBsvu0WG/rFbbxJ3Zp7yTxUqzdQqYqoVGind3EoKTXIbkOA/Kuz0jQyA5xjOIqA//0=
X-Received: by 2002:a25:cf51:: with SMTP id f78-v6mr3343123ybg.496.1534196871215;
 Mon, 13 Aug 2018 14:47:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e716:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 14:47:50
 -0700 (PDT)
In-Reply-To: <20180813212700.2681499-1-arnd@arndb.de>
References: <20180813212700.2681499-1-arnd@arndb.de>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 13 Aug 2018 14:47:50 -0700
Message-ID: <CACKFLi=6s-mpTiD4KwJPjFexCdVC6aiKSexhY4wr43ouTWKzXg@mail.gmail.com>
Subject: Re: [PATCH] bnxt_en: avoid string overflow for record->system_name
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 2:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The utsname()->nodename string may be 64 bytes long, and it gets
> copied without the trailing nul byte into the shorter record->system_name,
> as gcc now warns:
>
> In file included from include/linux/bitmap.h:9,
>                  from include/linux/ethtool.h:16,
>                  from drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:13:
> In function 'strncpy',
>     inlined from 'bnxt_fill_coredump_record' at drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:2863:2:
> include/linux/string.h:254:9: error: '__builtin_strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]
>
> Using strlcpy() at least avoids overflowing the destination buffer
> and adds proper nul-termination. It may still truncate long names
> though, which probably can't be solved here.
>
> Fixes: 6c5657d085ae ("bnxt_en: Add support for ethtool get dump.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

Acked-by: Michael Chan <michael.chan@broadcom.com>
