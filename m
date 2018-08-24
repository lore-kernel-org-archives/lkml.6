Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20EAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7055B20847
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SEmYQh3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7055B20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeHXKUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:20:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45335 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeHXKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:20:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so4062391pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=4HNGH/jq1m2R/NywDYkNQH4QhDL7s/dA2d6k6a3T5/g=;
        b=SEmYQh3x1VYgOXRa5Qw6B0cPPa/vZwbn/K7gNSzDSqqtHJyhXjqI35Bj2FBmslKUaW
         XNHQ5AGrrxRL+nzoV7pHVbwQJjW8h0602EACkcC3vTvnjrmMToCc2DLTBF9oRRqjjjth
         UoDzs3xoazHHdBJkeD5p6+P+3vVdSPTZoyaBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=4HNGH/jq1m2R/NywDYkNQH4QhDL7s/dA2d6k6a3T5/g=;
        b=FjjFp8+ahpKsqrJq8MRYVPhnXH0wbhDd5bIylmdmYQ7h9M/2rHbgg5XD1LskXeHt9G
         STTwqpAnm4wfoKDkuYPmYdiENmbos0c96tuopEJKGBRdPqegrD/ntAlmcDB2oov0JQxW
         wlhNkmUIea7He9ChjUwe0UxWVE83QRmjFGFc8CpXS7hqeOX2tQig9hgZdzyRKVbXI0Zd
         /L4otgEuCmnqlLOUmp0L2XyTqpShJj9dUZVBNMKr5RRqYqGs1lDjito7hh5JBJlMoa/i
         RR1TCucGtEq0XZv+HD0B3zJCYcuaiNrTfQaNQvMdUpip2CbHTl1VsGvtf7leaCQBcGu7
         yB9g==
X-Gm-Message-State: APzg51Ccw9CXRdTXLcUjMHH58F02J/dgTjZLrR/hGZ0mTuxFeyIpGjjd
        J/wPZ655h3Fj66gRiL0Rh6b6DA==
X-Google-Smtp-Source: ANB0VdYJBVmSE1OzkE+IxUCjOLZC2gYDEL6VqqtoPG6UeIKtxfbOGxSX4Q9huRCbW6+fJ7X9lrwn2w==
X-Received: by 2002:a63:2a0b:: with SMTP id q11-v6mr388760pgq.36.1535093246682;
        Thu, 23 Aug 2018 23:47:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id h85-v6sm8373659pfk.71.2018.08.23.23.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 23:47:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        johan.hedberg@gmail.com, marcel@holtmann.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180823112935.17342-2-bgodavar@codeaurora.org>
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
References: <20180823112935.17342-1-bgodavar@codeaurora.org>
 <20180823112935.17342-2-bgodavar@codeaurora.org>
Message-ID: <153509324560.28926.8058929411568681471@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_qca: Add poweroff support during hci down
 for wcn3990
Date:   Thu, 23 Aug 2018 23:47:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Balakrishna Godavarthi (2018-08-23 04:29:35)
> This patch enables power off support for hci down and power on support
> for hci up. As wcn3990 power sources are ignited by regulators, we will
> turn off them during hci down, i.e. an complete power off of wcn3990.
> So while hci up, we will call vendor specific open/close and setup which
> will turn on the regulators, requests BT chip version and download the
> firmware.
> =

> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> =

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e182f6019f68..98d33c6b8909 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -595,6 +595,9 @@ static int qca_close(struct hci_uart *hu)
>         struct qca_serdev *qcadev;
>         struct qca_data *qca =3D hu->priv;
>  =

> +       if (!qca)
> +               return 0;

Does this happen? If it does it seems like a failure in the caller to
know what's going on.

