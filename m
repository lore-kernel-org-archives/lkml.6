Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB8C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3274620899
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JGHetoWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3274620899
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeG0QZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:25:13 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41997 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbeG0QZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:25:12 -0400
Received: by mail-yb0-f195.google.com with SMTP id c10-v6so2107953ybf.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6E2ocujsy+qFwidm3Vq0JiRWkhuR/rV5dKEavZPoia0=;
        b=JGHetoWWQnEAcCqKnGigRqgllGFgFxrCXU4mwUbcOB9ThUPiE/9kaaJ/G5FPkbIv3y
         whSayC/PSB9jo1TgHy3DdrtGlvouWichtoIZyFzfZhv65oqrC/ULVNqqpIo47l9RoBPv
         pTqh2FkkhN8cBWpn1s6gI6TayQG7zoJNLMar0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6E2ocujsy+qFwidm3Vq0JiRWkhuR/rV5dKEavZPoia0=;
        b=Zho4WhliznIyg98WLPRPaABJ5FY8vMu8PdJDDIpJhoHiiwcrEBKOknjlOjJOGqnHyH
         89Ntp2CaFP1IBcXTTruLO0yjLJwRTLzK9+Kjb+GlkZkk54LTom/vXfdXpZpOobabni7i
         zVFIQuG/8G4Vr5qgSRTMjzO1zHgYHeTHs8PQtEziqaDxaRYtNjh0JVeqDHPMWPke15v9
         2Wdv4OdTSVvW/+dM6VdwNrfztwkL+3+BVdcwyRqfHoU3FBfFNjB5UEKzZtH5ctUUzxD6
         yd0edHjbzSCieeyFcMWSiUsXvVuE0KxnBguAZh2sB164jUH+xHtRKvXc9Dz2PX90m4dk
         Z2gg==
X-Gm-Message-State: AOUpUlF0JIVe6xPmwTD/g03hPdoBxVhNm8hDHgasdkdIDBI7LBF2qrv5
        EXkforbC4oshBcn9kZeGXJIPF94FnyxaCkkMI4Gorw==
X-Google-Smtp-Source: AAOMgpeAc1VMhDtCZn07jDJcauTiLN9gjDc7LAcVUGV6XLTrt5VqoOOUAms15PDGEi53NXkKasnSNlddrzsSDw4Rwh8=
X-Received: by 2002:a25:4754:: with SMTP id u81-v6mr3740099yba.54.1532703772812;
 Fri, 27 Jul 2018 08:02:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e716:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 08:02:52
 -0700 (PDT)
In-Reply-To: <20180725111459.10800-1-yuehaibing@huawei.com>
References: <20180725111459.10800-1-yuehaibing@huawei.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Fri, 27 Jul 2018 08:02:52 -0700
Message-ID: <CACKFLim+u+KPfJjj2fZ2BBDdzNDiKLV-hdeF8jJ0R-pW7G9nfw@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: combine 'else if' and 'else' into
 single branche
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 4:14 AM, YueHaibing <yuehaibing@huawei.com> wrote:
> The else-if branch and else branch set mac_ok to true similarly,
> so combine the two into single else branch.
>
> Aslo add comments to explain the two conditions, which
> from Michael Chan and Vasundhara Volam.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Michael Chan <michael.chan@broadcom.com>

Thanks.
