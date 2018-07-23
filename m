Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7458ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6115320875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eux7e6ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6115320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbeGWSmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:42:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42414 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbeGWSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:42:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id z7-v6so520528plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UIKH7mt6f5ImH5PUBNtJLKEl453d44EJRbuAtE7fNck=;
        b=Eux7e6oxjqiXIxDr2yyvoiNdZz+cUPXMmM50vMZaEc9QSNvmTeEMkXj6Ip1ek8fb+Q
         PMBhjRYZOEMQLegbX3AhjGI0RAEbHVGpIy/a68H+X3N9L+MYS52JHKNw0CieB3aBsJ3k
         1XOy+hh+QRPf/IcSSr9YF5XPXYfAY/uaahTbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UIKH7mt6f5ImH5PUBNtJLKEl453d44EJRbuAtE7fNck=;
        b=Bb/sLxblC+z3atlykBANd0Q4z8eqOGOytDMSJbTQkSoAtgwBpELsbQErhwCFHBmo0O
         RJYO8aZA+Tjkyi9oPq0ZmCNRUNSCKvoNTY10n130wT5q6ZM1xZ5o/SxL5DL9dJCgZXFe
         chvs/SwH0fM6P3zlNRCdNHkTCNNLGHpJIHFPmPUHgGCE7k9YgZpaq5CRqoQiQW70VK5P
         sYP/uupeFXvnZGCg55Lt2C5lYOjQfx55WSuEhjQTXvO1v08azNdppIfjfVF2B099UF94
         oMnDQTmuSJOjvsfCUBpOoBiGkUF5n1XQjpjderDsS4i1Iw71KsL9RfTFBeDSIAiXgd1I
         qTTQ==
X-Gm-Message-State: AOUpUlGhvcK7rO2UQSnPE5R+G9HRtRiIEk4bjZ55zeKYvwKVVQH19GZ2
        +ECnWi3gH4lGvHFZOTqWthKOVA==
X-Google-Smtp-Source: AAOMgpevA2AgWSJbpnPuzQGoYwxWTNK8IFye/DQ+1bpJ0FiCaZicBJSYoX4jYQUqAKtdJYCyWmDEvA==
X-Received: by 2002:a17:902:a58b:: with SMTP id az11-v6mr5826067plb.36.1532367619709;
        Mon, 23 Jul 2018 10:40:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14827526pgf.52.2018.07.23.10.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:40:19 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:40:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
Message-ID: <20180723174018.GK129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720133243.6851-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 07:02:39PM +0530, Balakrishna Godavarthi wrote:
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
>  drivers/bluetooth/btqca.c   | 20 +++++++-------------
>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>  drivers/bluetooth/hci_qca.c | 10 +++++++++-
>  3 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c5cf9cab438a..b556710ee1bd 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -85,6 +85,9 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
>  out:
>  	kfree_skb(skb);
>  
> +	if (err < 0 || *soc_version == 0)
> +		bt_dev_err(hdev, "QCA Failed to get version (%d)", err);

You also have to set 'err' if soc_version is 0, so the caller can skip
the check for soc_version == 0

I'd suggest:

  // directly after setting soc_version
  if (*soc_version == 0)
    err = -EILSEQ; // or should it be a different error code?

  ...

  if (err)
    bt_dev_err(hdev, "QCA Failed to get version (%d)", err);

You could also limit the error log to the 'if (*soc_version == 0)'
branch, for all other errors there will already be a more specific log
entry.

> +
>  	return err;
>  }

Cheers

Matthias
