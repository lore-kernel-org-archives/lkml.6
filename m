Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E127DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B6320666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVNHaEVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B6320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeI1WfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:35:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35624 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbeI1WfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:35:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so4820196pgb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=UGERV6c6Esm9VZNCOyoPxprsFTqZGgm9xgQYAqHXrSQ=;
        b=dVNHaEVJW2pepdiKEgPCQwnPrzZp1MjQ79GimG1AauVOxlneLmoVWvqLZumzYgzISg
         4pRlJDNF//oogbKid0TNPTHar4op9tPp+D8lfFX9BLkLfkAbPVMbdQtmoAnKspKEetF7
         JBk4AOXfpw4Wmc1/6UJU7oNR1B3jLlx8CgG4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=UGERV6c6Esm9VZNCOyoPxprsFTqZGgm9xgQYAqHXrSQ=;
        b=kSHl74b0U1rsea7aCq4YeqT4RicumHA69uijUUzlQyzACBfKe2cDQ7IU8NkustWOca
         7L35Bz84wd38hLQSo4lA8OpW54+8XGYbYMT9UZUhJn3X3imx95iTOZAiJfFJ0L83BnxB
         n3wTE/+DjcOtzPKRY6GCfR5JqjuF/B2uxeSKBignwaHSFd8NXBQT/yzBWnOnSD+tVGVp
         BzvW8Q3k8MMglmYPHzna9PiGwxSlcg6UrcS/dN4MjcgBGxY2OfV2w4fnwpHWMkylov9Z
         eAL/cc5eabNZCcoURuoIfHOrfDKnq16l8FDPSyjt4GqqaHRFdHXrtxFeGn0jvFiUHBg0
         Xslw==
X-Gm-Message-State: ABuFfoiTndnh7nD6oCg2TJdr/ECCkl+tC+h7/K8vsrhzrOT1GLavwq+a
        tcMoGrGpxbfWphExU/v/zcZDuA==
X-Google-Smtp-Source: ACcGV6263HGdFBiBxTBbmHVhxiYxRQ4/PNarq0yD/9eJvsNi2rvDkW83lAj+KxObHvto+LOAVmZZag==
X-Received: by 2002:a17:902:b7cb:: with SMTP id v11-v6mr2584600plz.79.1538151051546;
        Fri, 28 Sep 2018 09:10:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id c1-v6sm6213157pgp.34.2018.09.28.09.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 09:10:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180626170654.96831-1-swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
References: <20180626170654.96831-1-swboyd@chromium.org>
Message-ID: <153815104962.119890.13155451003978822980@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] Bluetooth: hci_qca: Replace open-coded msleep()
Date:   Fri, 28 Sep 2018 09:10:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-06-26 10:06:54)
> These three lines make up what msleep() already does, i.e. setting the
> task to uninterruptible, sleeping for so many jiffies, and then
> schedule() already puts the task state back to TASK_RUNNING when it
> returns. Make things clearer by just calling msleep() instead.
> =

> Cc: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Marcel, can you pick this patch up?

>  drivers/bluetooth/hci_qca.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> =

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 51790dd02afb..ef2b00bdf06d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -908,9 +908,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uin=
t8_t baudrate)
>          * controller will come back after they receive this HCI command
>          * then host can communicate with new baudrate to controller
>          */
> -       set_current_state(TASK_UNINTERRUPTIBLE);
> -       schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
> -       set_current_state(TASK_RUNNING);
> +       msleep(BAUDRATE_SETTLE_TIMEOUT_MS);
>  =

>         return 0;
>  }
