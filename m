Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F83EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6F62089D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Li5VfmEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6F62089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbeHWQ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:29:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44930 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeHWQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:29:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so4559060wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ro0hnSFxwtJXPSSPYVqMvxxcW4O0TqJQDoUTJ8wP8IE=;
        b=Li5VfmEOG58SaZR/tr/HibFARthkL2WLYEu3kLn9m1n/A28bR4kZHqN1UGqhtUJCOb
         PRYJS6ttwfA3zP+TmsAjwjRrwwuym8eJ3N6TffJoy33dIk5ouhumndZagn//z1+/L8g3
         SUJBDf/9dGVQmoNnvElY0mYWADuO8KBTw6mE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ro0hnSFxwtJXPSSPYVqMvxxcW4O0TqJQDoUTJ8wP8IE=;
        b=V4Mzod1vS8t9yHe4z4UV3g8RVpEfORqr84Xc6Mp25GK6qtkA7FCV3invcNQlvdipcO
         Le9d8hJnWqyvR2+EcFsRfatgqss1+YWU/ElaRiay9fNmGDB5mjkRtZO4RGtX/FFVV+bN
         FSsH+NVPFgPruXxVgJpmlF1AZcToh8InkvcxhvD8luNznTD0Ny+23nmujiLWzV2B1FJn
         qyDr/qsYU8Zg4CjeCd0xqNAZf3TPbpVCSebfmt9ZdWa8BSotdvZbbTQ5YBvy35sHd7SD
         qzAZAutxnNi7HymMGvn/wE/VI2BMTrECMsXXYXeeYF8ePUUt9s9w7ViBQkzUCSZoNCss
         idNg==
X-Gm-Message-State: APzg51Bo3bcCJ549JsNsT9siWWx5pehA8DWgJfRbu45APHZsm2k8Rpta
        Jui08fki9S8MT72BlXUvUOCkhMQetkw=
X-Google-Smtp-Source: ANB0VdZ0VaolVevQEqQNX4u1oSIyqQHiGm9dgToCuqDcW2CV9pwEjZDo2iI7QlzjkrwSiupFL2xBJQ==
X-Received: by 2002:adf:9227:: with SMTP id 36-v6mr17223886wrj.275.1535029219575;
        Thu, 23 Aug 2018 06:00:19 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id g133-v6sm4770967wmf.44.2018.08.23.06.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 06:00:19 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABzShHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+wsF+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH87BTQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AcLBZQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <4fcac639-cba9-1a71-9b78-326ebb9242da@linaro.org>
Date:   Thu, 23 Aug 2018 16:00:18 +0300
MIME-Version: 1.0
In-Reply-To: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 08/02/2018 03:57 AM, Saravana Kannan wrote:
> This driver registers itself as a devfreq device that allows devfreq
> governors to make bandwidth votes for an interconnect path. This allows
> applying various policies for different interconnect paths using devfreq
> governors.
> 
> Example uses:
> * Use the devfreq performance governor to set the CPU to DDR interconnect
>   path for maximum performance.
> * Use the devfreq performance governor to set the GPU to DDR interconnect
>   path for maximum performance.
> * Use the CPU frequency to device frequency mapping governor to scale the
>   DDR frequency based on the needs of the CPUs' current frequency.

Usually CPUs and GPUs have dedicated cpufreq/devfreq drivers and i was
wondering if the interconnect support could be put into these drivers
directly?

> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/devfreq/icbw.txt |  21 ++++
>  drivers/devfreq/Kconfig                            |  13 +++
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/devfreq_icbw.c                     | 116 +++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>  create mode 100644 drivers/devfreq/devfreq_icbw.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/icbw.txt b/Documentation/devicetree/bindings/devfreq/icbw.txt
> new file mode 100644
> index 0000000..36cf045
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/icbw.txt
> @@ -0,0 +1,21 @@
> +Interconnect bandwidth device
> +
> +icbw is a device that represents an interconnect path that connects two
> +devices. This device is typically used to vote for BW requirements between
> +two devices. Eg: CPU to DDR, GPU to DDR, etc
> +
> +Required properties:
> +- compatible:		Must be "devfreq-icbw"
> +- interconnects:	Pairs of phandles and interconnect provider specifier
> +			to denote the edge source and destination ports of
> +			the interconnect path. See also:
> +		Documentation/devicetree/bindings/interconnect/interconnect.txt
> +- interconnect-names:	Must have one entry with the name "path".
> +
> +Example:
> +
> +	qcom,cpubw {
> +		compatible = "devfreq-icbw";
> +		interconnects = <&snoc MASTER_APSS_1 &bimc SLAVE_EBI_CH0>;
> +		interconnect-names = "path";

interconnect-names is optional when there is only a single path.

> +	};
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 3d9ae68..590370e 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -121,6 +121,19 @@ config ARM_RK3399_DMC_DEVFREQ
>            It sets the frequency for the memory controller and reads the usage counts
>            from hardware.
>  
> +config DEVFREQ_ICBW
> +	bool "DEVFREQ device for making bandwidth votes on interconnect paths"

Can this be a module?

> +	select DEVFREQ_GOV_PERFORMANCE
> +	select DEVFREQ_GOV_POWERSAVE
> +	select DEVFREQ_GOV_USERSPACE
> +	default n

There's no need to specify this default. It is 'n' by default anyway.
Also maybe you want to add something like:
	depends on INTERCONNECT=y

Thanks,
Georgi

> +	help
> +	  Different devfreq governors use this devfreq device to make
> +	  bandwidth votes for interconnect paths between different devices
> +	  (Eg: CPU to DDR, GPU to DDR, etc). This driver provides a generic
> +	  interface so that the devfreq governors can be shared across SoCs
> +	  and architectures.
> +
>  source "drivers/devfreq/event/Kconfig"
