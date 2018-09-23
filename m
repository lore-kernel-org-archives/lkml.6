Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599BBECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0079B214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqYnJakH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0079B214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeIWLPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 07:15:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41467 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIWLPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 07:15:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so7692375plr.8;
        Sat, 22 Sep 2018 22:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VM426jHig6EMNU7/B/06S+HvWnhSzCR4A88qRP84PQ4=;
        b=KqYnJakHBOENe/JvYdyHTLHvY29kkeBYL1+uoUzs7SIiNm3WtoaA/sBjAiDwKy13D8
         Go1iob9Ip/6AVwJkD2gnL0rlvFkYHVW51o0++oMJzL8ZEWZjrINLzsnTj33m+dB5BMU+
         hnsrdE001f3FvOtDx4z9Z6EgO7AdmOoawHlJQ/H1r9YlQ8svp6374/Up4iEmmUn7Ygau
         APmnvF6Fpda32ax2DrC+orF2T7ovcSK7WrHP+EZp59ma3CO72PgsX/yox7CCr4iMCw9Y
         h76deBgd2ydYXhOdTnlBD4ubcHwUVThbuxSayQ/cjFOejE4nzAwu8kFAyXxY/J3Tcnpa
         y/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VM426jHig6EMNU7/B/06S+HvWnhSzCR4A88qRP84PQ4=;
        b=iUHMYSOJGVbYFGfrCCNpiS6s2SVJIb2GBVipW6AoH7rNKXDTiWRAX/NlhIvv7IpPr7
         iGQCa0DwSGnAT+fBVNO7uxccgGFXoHnBYY688JejZ1vUbtjbi52LfbHh0qRB/qJC/662
         KRjTvazTxqlL0RbYm9oDjX0A9YX/jXrVaKgKI0WSg2siub2A4W9oTYnaPbg9Pb2brHzT
         8Y8kXIzw5n/qNU5BUtv6anQ/EXsICs3EyTjex37maXrZ8gf8k1W9NCdzNo9AIysBRj3h
         8/xMOkLZGjWkX+H5Sw1Q3o3ekvx3m/dOUsCzBc+KldJD0uAtgSegp8Df0RvQoMc5cIhi
         nh2g==
X-Gm-Message-State: ABuFfojU43jXK+27szIjeoFu3X3qjyHVxy0j45YS6HelvXMs1mfHIT/R
        6ivjyJWlXp/6meaisSFwtztgpzfN
X-Google-Smtp-Source: ACcGV60i0drj6Ez+mHoDZzukLr2LPxNYQPBL2PN2HEWynPibHtzixJwBs2VACoL/1QT0XOpWUcnq9w==
X-Received: by 2002:a17:902:b40e:: with SMTP id x14-v6mr4957088plr.314.1537679984501;
        Sat, 22 Sep 2018 22:19:44 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l6-v6sm42885989pfl.169.2018.09.22.22.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 22:19:43 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add ina3221 documentation
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
 <20180923041118.8743-2-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <353ccbbd-94c8-72eb-eb98-8a0507431e15@roeck-us.net>
Date:   Sat, 22 Sep 2018 22:19:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923041118.8743-2-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/2018 09:11 PM, Nicolin Chen wrote:
> Texas Instruments INA3221 is a triple-channel shunt and bus
> voltage monitor. This patch adds a DT binding doc for it.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog
> v3->v4:
>   * Removed the attempt of putting labels in the node names
>   * Added a new optional label property in the child node
>   * Updated examples accordingly
> v2->v3:
>   * Added a simple subject in the line 1
>   * Fixed the shunt resistor value in the example
> v1->v2:
>   * Dropped channel name properties
>   * Added child node definitions.
>   * * Added shunt resistor property in the child node
>   * * Added status property to indicate connection status
>   * * Changed to use child node name as the label of input source
> 
>   .../devicetree/bindings/hwmon/ina3221.txt     | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> new file mode 100644
> index 000000000000..7d90bfe34adb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> @@ -0,0 +1,42 @@
> +Texas Instruments INA3221 Device Tree Bindings
> +
> +1) ina3221 node
> +  Required properties:
> +  - compatible: Must be "ti,ina3221"
> +  - reg: I2C address
> +
> +  = The node contains optional child nodes for three channels =
> +  = Each child node describes the information of input source =
> +
> +  Example:
> +
> +  ina3221@40 {
> +          compatible = "ti,ina3221";
> +          reg = <0x40>;
> +          [ child node definitions... ]
> +  };
> +
> +2) child nodes
> +  Required properties:
> +  - input-id: Must be 1, 2 or 3
> +
> +  Optional properties:
> +  - input-label: Name of the input source
> +  - shunt-resistor: Shunt resistor value in micro-Ohm
> +  - status: Should be "disabled" if no input source
> +
> +  Example:
> +
> +  input1 {
> +          input-id = <0x1>;

We'll have to find a better name for this. Feel free to look up examples in the
existing devicetree descriptions. The one that seems to be used most of the time
to indicate a channel index or id is "reg". It should also start with 0 - there
is no real reason for it to start with 1; it only makes the code more complex.

> +          status = "disabled";
> +  };
> +  input2 {
> +          input-id = <0x2>;
> +          shunt-resistor = <5000>;

I would suggest shunt-resistor-micro-ohms as per
Documentation/devicetree/bindings/property-units.txt.

> +  };
> +  input3 {
> +          input-id = <0x3>;
> +          input-label = "VDD_5V";
> +          shunt-resistor = <5000>;
> +  };
> 

