Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56558C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001712089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1WMp5PF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001712089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeIZNxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:53:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36605 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeIZNxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:53:49 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so1616151itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BdMcqhi94wDs+nkXo92wOkigohDZu/vrLYzBBTqwaQ=;
        b=Z1WMp5PFEshirWojVG7UVNbdD8OirDkkML7KDd6HfuAg0Y9+ofDK4JCtZOl3F0+NU6
         0mcK0EOp5by1kYCyl93TMN8sixF0GG9P5evgrCsHBWnTiO4fu+toILJ1pZO5R98UknxW
         auW6JOE14a8ksapy754is+edcdVrn2Fpbqn5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BdMcqhi94wDs+nkXo92wOkigohDZu/vrLYzBBTqwaQ=;
        b=NgsNT/1yWLb+rwtmouZO+mB3X6RILaQaf3c0iSoaLiqqrPmQRyI6xivfRpirG0qRKh
         sTggFCZKpijmvK53adRplkoU+M7fzthPdMdoQ6ZVc3jpR2Xw7Z1VCDCjbbJJFxLoSy4d
         K+tzWbHx0yzEJp8N1XFxQjdsQCmGmM3T+qp25qB6NZa/CmSj7Jr6PZ8xjayLt9NiKgMl
         CdeduaRoHoCIRnJTyiKvE6pCwXYM94raBL+lHcXoR+iVF4IPXm0pthQwdEOZeMFh89SX
         Zjltmn7MjeDbXfOO3wYXVYEb15pf81KClNlDIGL7FI6YngMwmJ1G3T6Vj58+AKiL8Dze
         rTrA==
X-Gm-Message-State: ABuFfohfrNR2Y7w6/X7BhCgtocdGgaBP/PO/bauapEfoixkp6ZzxEOMM
        Ct9zHX7jHAH/V7hXHS+82IOSTdqhu1VUcyDERIlbqdXp
X-Google-Smtp-Source: ACcGV62VzCR/1qzEtLCJZvLpz3uYFjrFyF6DEA5mDhJHfqswUS9R6MqHMIpr83nkHdXFfcC6cJcQV7H8Yxyk+VapKic=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr4166279ite.16.1537947733205;
 Wed, 26 Sep 2018 00:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180925095556.19779-1-colin.king@canonical.com>
In-Reply-To: <20180925095556.19779-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:42:00 +0200
Message-ID: <CACRpkdZC9L78P-vXvXsKndLAwOmeLDgSjf0+VzVfua-j+3GcDQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: fix check on EINT_NA comparison
To:     Colin King <colin.king@canonical.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:55 AM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Currently, the check on desc->eint.eint_n == EINT_NA is always false
> because this is comparing a u16 to -1 which can never be true.  Fix
> this by casting EINT_NA to u16.
>
> Detected by CoverityScan, CID#1473610 ("Operands don't affect result")
>
> Fixes: fb5fa8dc151b ("pinctrl: mediatek: extend struct mtk_pin_desc to pinctrl-mtk-common-v2.c")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
