Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2732C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BDF218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xpmid0th"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfAaSGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:06:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36189 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfAaSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:06:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so1687121pgm.3;
        Thu, 31 Jan 2019 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ISBQSLV4QRFn7QOf1TiE/kOFO4Fqazqa5WY1TB5FDo=;
        b=Xpmid0tha9yESo2oCnvIWtlNZEaT58OjZI2ly2tigUh3OIB6/6/a1TuQbMFNPBUcQ7
         VzxzjXLwtsIn7zdUDq49ipfG7VVAdNvklHFE0iNEHzn9ncssaWImwswatQytRqfip8hM
         EmV/E1/yKgsb/DnTl4RS0/KOZ27kthiwE88e15RkTUztDIEWrfuNg47pmjYcqufZ3s+i
         wqfIwPX3+xE85hJQ0brciFNyVy7sHcX/OEHopgu3mXsNA2X6idi9f3K91fBXVv0YSipp
         i8lGNKB8rmmUJqjiDxfx3Qx9Dhq3fcKxE5c/BMd4ywNjvIKRudalnqZhrT66dsyU1/Fg
         V/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ISBQSLV4QRFn7QOf1TiE/kOFO4Fqazqa5WY1TB5FDo=;
        b=iU0HRyEpQHjvLnUrSlwBrZP4HoAVQ9ICkG0bYbWyN/53MLTXIJnl7vudZTyxpMYP3Z
         mQ31Vnia7tUaFo/bWPARbSCPyKO8qwC6E3SNUyFFLGAUg8gXjGsAAggWJ2yHiw0er/ar
         EBQgBTEw6XxaxdYvr+SZg4zm8dHsRPmnL3S3WQHqBJPcWX5fvQvJbIljtFHSTz3Jw2wm
         G5DH4nIBEkcFZx/LrnmMa2CGDPtE6ZgLthpBF3ma4jb2IGxcgRDeYozGBXyuhQ2a16Q9
         d4coqj2eiFHknrcz3VN8x2BcOCnyQNFMbPjrWGh2a4njcqQ4YoDfMq/VdTanm5fis9Y0
         l6ew==
X-Gm-Message-State: AJcUukc2b3ygggtua3xyFBRoF2nvRJLr/+Tw79VRqgiZM9NdP16JGoD8
        54/qLfNSzzKMw5gK9TB873Y=
X-Google-Smtp-Source: ALg8bN5u9uyXpc5qFOq1KV7QHDxYcDGODy8igV3xdUri3X/lg7NIQP03FC0ki8TCyVF625utGAgFBg==
X-Received: by 2002:a62:7504:: with SMTP id q4mr35080600pfc.180.1548957980920;
        Thu, 31 Jan 2019 10:06:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13sm7780367pfa.132.2019.01.31.10.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:06:20 -0800 (PST)
Date:   Thu, 31 Jan 2019 10:06:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH] dt-bindings: hwmon: Add lm75 documentation
Message-ID: <20190131180619.GA17074@roeck-us.net>
References: <20190129065623.6771-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129065623.6771-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:26:23PM +0530, Jagan Teki wrote:
> Add dt-binding documentation for lm75 hwmon sensor.
> 
> Currently documented for national,lm75 and st,stlm75 and
> rest might add when required.

Why ? The various properties are already implemented in the driver.
I don't see the value documenting only two of them.

I do see though that nxp,lm75, and nxp,lm75a are used but _not_
referenced in the driver.

If we start cleaning that up I think it would make more sense
to clean up everything, not just part of it.

Thanks,
Guenter

> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/hwmon/lm75.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
> new file mode 100644
> index 000000000000..e384a3765f10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.txt
> @@ -0,0 +1,15 @@
> +*LM75 hwmon sensor.
> +
> +Required properties:
> +- compatible: one of
> +	"national,lm75"
> +	"st,stlm75"
> +
> +- reg: I2C address
> +
> +Example:
> +
> +sensor@48 {
> +	compatible = "st,stlm75";
> +	reg = <0x48>;
> +};
