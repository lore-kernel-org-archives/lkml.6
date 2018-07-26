Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D2C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVUTNyS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D2C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeGZH7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeGZH7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:59:39 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28ABA20673;
        Thu, 26 Jul 2018 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532587459;
        bh=A0qMUhXgb3jXdHP2GYnh0y7i/OSOj/qSgnsOTtkG49E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HVUTNyS9iaeBwlhjjMixZHr0bTiTerWlCAF0a6xdIN2VoquuMwD1+qeeZ/e/invLs
         JA3cVjDG1RbkmZZKtTKuy1Z4myilJpnnMG68bo2XZqD2gi0DAr3ZZ1nr39mC/1zUHv
         s6t3cONsbr+vbs2e+im1NcKDkHQ0fPtJ2oF/gbQo=
Received: by mail-wm0-f54.google.com with SMTP id y9-v6so782467wma.5;
        Wed, 25 Jul 2018 23:44:19 -0700 (PDT)
X-Gm-Message-State: AOUpUlFyLWGqD1nDTLx2rjzRkz1Rh4JmSAkKSC+mUb8yqCgW3YiyokhE
        SlgyyGs5052D04Soes5FvzHsCgm0Pz04KwQnmaU=
X-Google-Smtp-Source: AAOMgpcpGrM50P/TQk2bW1W8WHJZqlBMZYF8U5MdU1sc4lv3rQlzny5Ny/JVW1NMk712TvSOJFdTzrvCuSSS99EkP2c=
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr605440wme.135.1532587457699;
 Wed, 25 Jul 2018 23:44:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 23:44:17
 -0700 (PDT)
In-Reply-To: <20180725194630.10414-2-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca> <20180725194630.10414-2-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 26 Jul 2018 08:44:17 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdJZU38CHkM-3zEtBpA92supwVcj4z_kEF5XMxOj3_TKg@mail.gmail.com>
Message-ID: <CAJKOXPdJZU38CHkM-3zEtBpA92supwVcj4z_kEF5XMxOj3_TKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] power: bq25890_charger.c: Add debugging output of
 failed initialization
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> To ease adding a new part variant some debugging is handy
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
