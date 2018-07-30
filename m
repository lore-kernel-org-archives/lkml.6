Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D8BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA3420840
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKI6RF8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA3420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeG3UN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:13:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43148 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeG3UN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:13:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so5927992plv.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+c6fC8XaMuxu5vKlTucYYstGfNC96qyAJMSwFuv+3o4=;
        b=QKI6RF8lchTUBxQYgsJeyDg5XwARKtbK8WF+ux0Lh/TDkLUoaKkX9qZ3FxhHAXjoBB
         cdm02Q+ypup7EMjpTW6uSgLAj3TV+IuBkDoVwH4eZlu8Tfu33DK0YOf5C2j1BLtqiK4T
         dPzLkreixZ/fWOfJTyaecPwHPVrmyM8DoCPvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+c6fC8XaMuxu5vKlTucYYstGfNC96qyAJMSwFuv+3o4=;
        b=eM+yZ/aUMpeeQehcDtB1drPyfhgiCqeOCAFIqCirTicYdXPxeM/qjMQHshljYvCSq0
         6bE4wLisL+vbT+4g8gYdOREuiqzUH+41jmzk/rUFMKQg3ftvSDaj7BLgFnpA86e4PlzT
         8m4daJyJd3BHjKEbqRfKNGFimVl+ZxnR9jBzg+kcEqPh6dpJBXWS4F9FoplEWSvHZ62S
         FyrRdQBsL+bAGj0rS3US0rOZer/whZ0Flh/zkhGCtVGSOrVQB89UMjzSZw+VpfVPYHac
         XvGZfagDsGDy4Sm0ulOpbVjf6oeJ4QBAdDl6NqyrgyPCZzpO1VBAMN+FeQT60UEuSDU9
         enbQ==
X-Gm-Message-State: AOUpUlGJT5xMgwp7gp2k00oeWYjZpwdBWw2OEHYVcfdmd1vn3M6nDcDs
        eOc0BsHrqQ6Xw9HUbApjQvuRiQ==
X-Google-Smtp-Source: AAOMgpctyfNzmifnmIg/2QA0w4MHDuMnY6ZI7/Hyjga8Ew7Y4bs5BwAdbzn1XgtCY6gcHbaboyLTrA==
X-Received: by 2002:a17:902:599b:: with SMTP id p27-v6mr17171763pli.191.1532975829311;
        Mon, 30 Jul 2018 11:37:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j71-v6sm21423550pgd.23.2018.07.30.11.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:37:08 -0700 (PDT)
Date:   Mon, 30 Jul 2018 11:37:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH v11 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
Message-ID: <20180730183708.GA68975@google.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
 <20180727141320.25218-4-bgodavar@bgodavar-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727141320.25218-4-bgodavar@bgodavar-linux.qualcomm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 07:43:16PM +0530, Balakrishna Godavarthi wrote:
> From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> 
> Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
> SoC, to use the same function instead of duplicating the function.
> Added new arguments soc_type and soc_ver to the functions.
> 
> These arguments will help to decide type of firmware files
> to be loaded into Bluetooth chip.
> soc_type holds the Bluetooth chip connected to APPS processor.
> soc_ver holds the Bluetooth chip version.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v11:
>       * added error log in qca_read_soc_version() instead of qca_setup() 
> ---
>  drivers/bluetooth/btqca.c   | 23 ++++++++++-------------
>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>  drivers/bluetooth/hci_qca.c | 10 +++++++++-
>  3 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c5cf9cab438a..b2163bf75b95 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -85,6 +85,12 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
>  out:
>  	kfree_skb(skb);
>  
> +	if (!err && *soc_version == 0)
> +		err = -EILSEQ;

nit: better do this right after assigning SoC version. No need to
respin the series just for this though.
