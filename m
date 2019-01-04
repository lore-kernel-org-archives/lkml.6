Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A00C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91B921871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emoMlOLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfADE0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:26:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40491 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfADE0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:26:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so16847396plq.7;
        Thu, 03 Jan 2019 20:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YAFjuamF01SdWSKq6DMQw5rJG64gFLf+Cnk41ioq/qE=;
        b=emoMlOLuAXa1qkK/ItiYZlwbLkVFJ3RO7Sm8JsyWMv45iLBA11bqA2pn15FMVFsqdE
         Y34p0k8D+IIU3Eu2ptizl7nnj91Ps6rU5f4JJ9zXfxhVj8Q81yBzBTtneH7BuKhUL2gF
         qFQNsUkmeUYgQTvCwjG33n04vHiywl0f+uIa5VRGwEDiyvVWZcqp0lfIEgs6jK1qdFRj
         P57ZGdU7itSAzLK3krYR7+HNNi9VOt0xeVlfvy3MrcdUMghua+WrY3nEeeHjW2EZeLA7
         wkFFkbrSPFlOroysSk5MwTDsCAcV/4FULLfE0l7WjT24b3pAyFwOenrZkN19nB3dex8v
         lHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YAFjuamF01SdWSKq6DMQw5rJG64gFLf+Cnk41ioq/qE=;
        b=ky0GV8sP+zDK5ZTHq6senEtkVKc/OHFzISc3eFBBOB0huBgpJ0KgrYG71I+8JayyuI
         GIX6hBGeGo5/q2Jg9uC+BEsRGuJUiO8V/GVs6ZBQ+NeOebYVb3lagU6KECqaoqoKVv0u
         OVHNfYnnm2ujD4ZmmlkFKrVlUEKoSO+n9iin+ygugSWRpeO/ZF0PRK4DJ7gxbW6dhDME
         7vVee8gqFwaGItJ1krTk5dUEggR5WcWooy7Fq7uBqlXgYoXZtxy1Ls80XCnZIvF4MMJZ
         ksp4Oj56K8Ezx9CxAP8UH62CMIc5IzuOexAnTa59m9MNsJmsafu/puGywsLcywnS+NPD
         MAFg==
X-Gm-Message-State: AJcUukeilEiFz2W53F/VJM3vTQiaCfwaedRAL2Vv3SRdBgYs/Z/NvhYz
        zp/KwwvHfP2H6zPWXy1kUtA=
X-Google-Smtp-Source: ALg8bN6pQtPliKoiP7SFHcQ2X2MdxPVXcAALcPLeHXmHeuDe3lTTDz7dZLLZubgaY6/m1PvezXxPBQ==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr47188130plq.278.1546575998060;
        Thu, 03 Jan 2019 20:26:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm81426202pfi.118.2019.01.03.20.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 20:26:37 -0800 (PST)
Date:   Thu, 3 Jan 2019 20:26:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] devicetree: hwmon: Add bindings documentation for
 HIH6130
Message-ID: <20190104042636.GA22831@roeck-us.net>
References: <20181227151349.29753-1-andreas@kemnade.info>
 <20181227151349.29753-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227151349.29753-3-andreas@kemnade.info>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 04:13:49PM +0100, Andreas Kemnade wrote:
> Add bindings documentation for HIH6130 driver.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/hih6130.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/hih6130.txt b/Documentation/devicetree/bindings/hwmon/hih6130.txt
> new file mode 100644
> index 000000000000..2c43837af4c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/hih6130.txt
> @@ -0,0 +1,12 @@
> +Honeywell Humidicon HIH-6130 humidity/temperature sensor
> +--------------------------------------------------------
> +
> +Requires node properties:
> +- compatible : "honeywell,hi6130"
> +- reg : the I2C address of the device. This is 0x27.
> +
> +Example:
> +	hih6130@27 {
> +		compatible = "honeywell,hih6130";
> +		reg = <0x27>;
> +	};
