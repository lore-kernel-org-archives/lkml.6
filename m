Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1072C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A813020C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dW5Bo9UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A813020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJINMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:12:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39055 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeJINMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:12:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so255171plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=inzA/yGeZ9aiC3VA2i1tkm+Tkpl7/w8C3is8FRDdUxk=;
        b=dW5Bo9UGk275LYTyGf4nmVoR0ggE3MFHkF5jgcqdnUU3jUVa57QlyTOR/TxBxMH9J5
         ny0NMuW+FcR1x3Ug+JCS27hLNazQy35SbFkG8cncuh8pcuIXwreq+kGt1PnyPx0QNTR9
         G7t6sOYSegG6oFKpRny8Pe3qwEmcaaERzU/i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=inzA/yGeZ9aiC3VA2i1tkm+Tkpl7/w8C3is8FRDdUxk=;
        b=eYuULXour0Cs1RX2N2aNcgZuGRVr8ZeESQztSrZn7N9JDGRo7lQiCsit4cL7yJkwm4
         TdG9DAHyfY9ETA4miFOSwd/PgmlLOY0DETA5iwlSA6wmZh2U6sVaZ0821RjA09aiwPUJ
         d/YrEPMa7k8N7SmihMDP6wcdV9k4rsmk5AOUV6NPp77B9Qdp60DhRIcMXaoimeZdd4op
         9oGEIhzi5PMpuQN8pm462lFB4hMwgZkvglf0id88VoWQiEbN/7Ca2lIQehZQwv2Pw2hX
         TRwB+LIhvnK3PrD2yU4jQQwYRe5bCyFMTOI6qNkied63o2WVEgNCbkVzpJ0cKgUgs2qb
         wqBg==
X-Gm-Message-State: ABuFfoj6Yu6b4+1Dlo2IZcjz6PsgzmHfvWUT+IGeoFun5BlF70N6VVT2
        V40TKUt89rxLRbEolUJFS6mSrA==
X-Google-Smtp-Source: ACcGV6356/jriVRzzMA4+sFDA3yg2mLRX9PHTqD75D2WrP0MRe0Bn7sRVA7Q9gxxdfuXiemBfYWoiA==
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr27022168plp.130.1539064646238;
        Mon, 08 Oct 2018 22:57:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id d2-v6sm23617607pfn.118.2018.10.08.22.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 22:57:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180925210255.172734-1-mka@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20180925210255.172734-1-mka@chromium.org>
Message-ID: <153906464468.119890.12038987094612660933@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] dt-bindings: Add bindings for aliases node
Date:   Mon, 08 Oct 2018 22:57:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-09-25 14:02:55)
> Add a global binding for the 'aliases' node. This includes an initial list
> of standardized alias names for some hardware components that are commonly
> found in 'aliases'.
> =

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/aliases.txt | 47 +++++++++++++++++++

Any chance we can get a documentation update for the devicetree spec as
well?

>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/aliases.txt
> =

> diff --git a/Documentation/devicetree/bindings/aliases.txt b/Documentatio=
n/devicetree/bindings/aliases.txt
> new file mode 100644
> index 000000000000..d64ed1c7eb34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/aliases.txt
> @@ -0,0 +1,47 @@
> +The aliases node
> +----------------
> +
> +The aliases node contains properties that represent aliases to device tr=
ee
> +nodes. The name of the property is the alias name, the value is the path=
 of
> +a the device tree node that corresponds to the alias. The path may be

s/a //

> +specified as a string or a phandle.
> +
> +Alias names are often suffixed with a numeric ID, especially when there =
may
> +be multiple instances of the same type. The ID typically corresponds to =
the
> +hardware layout, it may also be used by drivers for a stable mapping of
> +device names and hardware entities.

Indicate the numeric ID is a u32 or something like that?

> +
> +Alias names
> +-----------
> +
> +The devicetree specification doesn't require the use of specific alias
> +names to refer to hardware entities of a given type, however the Linux
> +kernel aims for a certain level of consistency.
> +
> +The following standardized alias names shall be used for their
> +corresponding hardware components:
> +
> +  bluetoothN           Bluetooth controller

Can we use syntax like:

	bluetooth<N>

to indicate that <N> is an unsigned integer?

> +  ethernetN            Ethernet interface
> +  gpioN                        GPIO controller
> +  i2cN                 i2c bus
> +  mmcN                 MMC bus
> +  rtcN                 Real time clock
> +  serialN              UART port
> +  spiN                 SPI bus
> +  wifiN                        Wireless network interface
> +
> +The above list is not exhaustive and will be extended over time. Please
> +send patches to devicetree@vger.kernel.org if you think a hardware
> +component and its alias name should be on the list.
> +
