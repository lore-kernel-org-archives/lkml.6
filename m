Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F563C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDC720851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLcpzNHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfAQU7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:59:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36930 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfAQU7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:59:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so5415038pfb.4;
        Thu, 17 Jan 2019 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wnubO1lujWGA0YOWaVjKgFKf1tN0F6G5nRARQJOP2rI=;
        b=mLcpzNHGD3d89yoeoMgHrAJx1QiJ/X6btQFc5h0vzgFq5GZnL837St0z8eh3CZVGHV
         HjrnAG5hYttO9C/ESDm78D9maRQeWol8bGSa2x5Zj+3yCwp4RKZnaj/OR5rQjFpF5Hr0
         A44ejAVHdYr7Quae0j9JCvJPvTo/rWZGCAyzKrvyxXSnTP9eiSBDMYkrxl1ioAJf6qEw
         HAjWrQG78RjRY3QqyZBuepfne0kfAo55LewRZAZyt2fKgQslKmEYGlpxCcfstquw6kCA
         iZ8aNugoWVRUTp0wWstti8HavOQTLAz9M+lRT0Xps+XJfIblu57PYPiG7nGfxDwi8FIP
         wi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wnubO1lujWGA0YOWaVjKgFKf1tN0F6G5nRARQJOP2rI=;
        b=nKnitpCNZ/wV8jhP7eyxOxtmpx/ZNtc+ZjngzqpirNosr+uKnsUoC5zMAyryMf5IXd
         VsUg/fl4Jeo0zWNlBaTth5lzVPJDx+YJ9nPM5Zp2dOdGFgGeIbefp7qd5ISzoPKZ6PKb
         6F5/5OpBrqhnfMfQoMnEusw7uQnjl+vtzvCH9zaOcjqYizR0230DBtDAGoz1bfxsXorm
         52IjauqEQ/X+NG+Getgn9XFeULC7lsM9XDeyyBNwgFnOUthxvkkdUApjhFC/PEVZTFzm
         Pf5QEqCt49QI8yDbba0FBXjB2bxzr2R9VT3b7pP01LIai5Q+uwNDXexc8P7mBpcSC6r7
         RbCg==
X-Gm-Message-State: AJcUukccl68sB7Hxo0LsTLhPu7UulX8En5As2KT7wSmZfXse53j/26Yz
        uF0bDb0ajNeDg3fcYAAjnKo=
X-Google-Smtp-Source: ALg8bN7nHG4HlG/JQTJ74qMuX+s0deveSgJVPEEd6EFUmFBmxfSp0htuqOAgwcIUTgogWR4RQ4a5RA==
X-Received: by 2002:a63:ff62:: with SMTP id s34mr14958572pgk.325.1547758787915;
        Thu, 17 Jan 2019 12:59:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t24sm3355178pfh.21.2019.01.17.12.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:59:47 -0800 (PST)
Date:   Thu, 17 Jan 2019 12:59:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shunyong.yang@hxt-semitech.com,
        dongsheng.wang@hxt-semitech.com
Subject: Re: [PATCH v3 2/4] dt-bindings: hwmon: add dps650ab documentation
Message-ID: <20190117205946.GA11509@roeck-us.net>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <0527fcf7155ea12a2a1be680b3617691e6e26d72.1546918172.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0527fcf7155ea12a2a1be680b3617691e6e26d72.1546918172.git.xiaoting.liu@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:24:33AM +0800, Xiaoting Liu wrote:
> Bindings for Delta Electronics DPS-650-AB power supply.
> 
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v3:
>   Change patch commit message.
>   Add vendor delta to the compatible property.
> ---
> v2:
>   Change the patch subject.
> ---
>  Documentation/devicetree/bindings/hwmon/dps650ab.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/dps650ab.txt b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
> new file mode 100644
> index 000000000000..32d89e4f4956
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
> @@ -0,0 +1,11 @@
> +Bindings for Delta Electronics DPS-650-AB power supply
> +
> +Required properties:
> +- compatible : "delta,dps650ab"
> +- reg        : I2C address, one of 0x58, 0x59.
> +
> +Example:
> +	dps650ab@58 {
> +		    compatible = "delta,dps650ab";
> +		    reg = <0x58>;
> +	};
> -- 
> 1.8.3.1
> 
