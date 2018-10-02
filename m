Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7015AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2047D21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkUsreOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2047D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJBXtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:49:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40647 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeJBXto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:49:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so279832pfj.7;
        Tue, 02 Oct 2018 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BI4lChhY0O251pzLmTSviGYKdch6FPZR0ZEqgLvntBY=;
        b=YkUsreOfLETMQrcVMNoIMDHfkClWpgFd79xIQuns/X60JguYGLEckTW0WSnbwSmOA2
         qascexTqyYotMVfxxQF/mZ8A8Kye6sscC9mMN3iT83KT0LfZkwpn/qfWdXm8e4F5Ud+k
         4xSlbY3mkNqbFFt8X6dIczwCNfm9gFL6B9aQhtXeucJ1/17yVZgyeGCjsYZ73s2FvOpF
         DpzYFwPmkgCPpNpN3LbOGQfecRruJA8Ic81eJizYXpZ9EemwX83vCiDcHr/xZ4iNlpj2
         qx0gh9Qmj1KjJfVAxAbeWMvAvW2GTfzq4qi8zd+/+7qZW5RoMajpwyOimPd7c+bk3/ye
         TfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BI4lChhY0O251pzLmTSviGYKdch6FPZR0ZEqgLvntBY=;
        b=GZa84xcTHegXDAvOhCyFr3aJsjufZnpstkIhyzSBRPt7Re4P46V0Im4YYE6rzG+KMj
         Y9a70YUJaYbSCo8GCiRw+28Oh051y0YvrOX4JCdoM5sIXjrtJW9OCUw4RM093pkWiLgo
         LLn2XMRfHYxr5jpCtDzPmuqvgiGO0hX9Bq61mg63GBkxzFA2U76TYV6TrIF89x+6l7o0
         8UaO+VDvve6k1Mq30vgD8HTK3kSsO5lOpCjxNyMQvo5Kj6kS0xLa1kSgYKSgDuOaep2C
         Vroa1N+nZ5E2kCvBpGuGPS93GOglpm2k7Oa94o1LOr1GnjYojj7qrHqQvmL4XP7CLJKR
         WxDw==
X-Gm-Message-State: ABuFfognidcnLw5BEhAwf58Om47gSr6k5se/F0O2tXyfBWDh3yQf52LG
        3TJLWlk1zK5RZkShLFYot4Fze86L
X-Google-Smtp-Source: ACcGV62gcIQCp/BG4heTZ5ejgISRol0T+8w0eWrNfAm0B+vEVpd5ukPK3dFMnvssqDaIzBK3F8tAdA==
X-Received: by 2002:a63:5153:: with SMTP id r19-v6mr15274586pgl.419.1538499921506;
        Tue, 02 Oct 2018 10:05:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o24-v6sm10175032pfa.90.2018.10.02.10.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 10:05:20 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:05:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20181002170518.GA27236@roeck-us.net>
References: <20181002010523.2019-1-nicoleotsuka@gmail.com>
 <20181002010523.2019-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002010523.2019-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Mon, Oct 01, 2018 at 06:05:22PM -0700, Nicolin Chen wrote:
> Texas Instruments INA3221 is a triple-channel shunt and bus
> voltage monitor. This patch adds a DT binding doc for it.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---

This version of the series looks good to me. I'll add both patches to
hwmon-next, with the understanding that I may pull them if Rob has
bindings related concerns.

Thanks,
Guenter

> Changelog
> v7->v9:
>  * N/A
> v6->v7:
>  * Restored three channel examples and merged them with the parent one
> v5->v6:
>  * Removed status property as no need to explicitly list it.
>  * Combined all examples into a complete one.
> v4->v5:
>  * Replaced "input-id" with "reg" and added address-cells and size-cells
>  * Replaced "input-label" with "label"
>  * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
> v3->v4:
>  * Removed the attempt of putting labels in the node names
>  * Added a new optional label property in the child node
>  * Updated examples accordingly
> v2->v3:
>  * Added a simple subject in the line 1
>  * Fixed the shunt resistor value in the example
> v1->v2:
>  * Dropped channel name properties
>  * Added child node definitions.
>  * * Added shunt resistor property in the child node
>  * * Added status property to indicate connection status
>  * * Changed to use child node name as the label of input source
> 
>  .../devicetree/bindings/hwmon/ina3221.txt     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> new file mode 100644
> index 000000000000..a7b25caa2b8e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> @@ -0,0 +1,44 @@
> +Texas Instruments INA3221 Device Tree Bindings
> +
> +1) ina3221 node
> +  Required properties:
> +  - compatible: Must be "ti,ina3221"
> +  - reg: I2C address
> +
> +  Optional properties:
> +  = The node contains optional child nodes for three channels =
> +  = Each child node describes the information of input source =
> +
> +  - #address-cells: Required only if a child node is present. Must be 1.
> +  - #size-cells: Required only if a child node is present. Must be 0.
> +
> +2) child nodes
> +  Required properties:
> +  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
> +
> +  Optional properties:
> +  - label: Name of the input source
> +  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> +
> +Example:
> +
> +ina3221@40 {
> +	compatible = "ti,ina3221";
> +	reg = <0x40>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	input@0 {
> +		reg = <0x0>;
> +		status = "disabled";
> +	};
> +	input@1 {
> +		reg = <0x1>;
> +		shunt-resistor-micro-ohms = <5000>;
> +	};
> +	input@2 {
> +		reg = <0x2>;
> +		label = "VDD_5V";
> +		shunt-resistor-micro-ohms = <5000>;
> +	};
> +};
> -- 
> 2.17.1
> 
