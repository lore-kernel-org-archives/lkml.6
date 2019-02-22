Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E9B20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550849795;
	bh=2tsMo3fJjHVlCCfzWeRcLkm3h7Sv+8c18cLhZ5RDE6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DcBXmyKNVySwFJwz36eh2l/uRcgfw7fczGvr6v15FLsyJYGdNzTPtlYgo899Rw1XJ
	 zsVvnFyokrPt5liTrfsf8IhhrPwOWkmblYudG89KPCxgys3DYbmBIM8z2N+Kic2tX4
	 PccijREim5Q3anOIR3DGuVJdqeid1LU2x58jq06w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBVPge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:36:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37853 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:36:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so2195976otp.4;
        Fri, 22 Feb 2019 07:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gWUY0Let0I+lvwa9sHJxZsOtmzR5eJ28+VWDVZqZMQA=;
        b=OPwO5WB+bhTD8hiknGIGOji5cGL1gJB1WOfEX8uV0jl7PtgrLCFK9shr8cbsRN6zaW
         qfpHIwYRXW9RggH9mzOCJIuGgkxlI64AIpZVdOPxtBVvvz0cvlX6Lmh97JfVskOuRcA3
         8YWwuujp0ATywYDbI/m50RrbDlFeeWhupUDH3YzH8Mq++wMvmdZgXo3PY4LPZJt2m33U
         mu6p5pR3smO/zGC6VX2gvwU7eZBuXELyKfs1V/YxUUVZWiDHTv5dXZaO15IU6UBi+5XE
         r7Xgj/4P+6kViz34vI1NoysxEUKY/sfkE6H69JizyjwAvT4LCaVCMnCDSz8GPxtq2kDn
         kWGQ==
X-Gm-Message-State: AHQUAubn2Su5usedfayz2Pkka6fGtpmb9d5ZIi8eLb7h1f3WWXhGUrC4
        SQ14mhGOssDhh2t06LjlofcF8cg=
X-Google-Smtp-Source: AHgI3IYG27+ctXfoD2S+OeRPhhvlgW57BJTDLAb4uiT9/naxRcSTTGZ4w8DrG3qpaiG9NXbzjtNw8g==
X-Received: by 2002:a9d:6381:: with SMTP id w1mr2905041otk.15.1550849792653;
        Fri, 22 Feb 2019 07:36:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 97sm703564otn.39.2019.02.22.07.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:36:32 -0800 (PST)
Date:   Fri, 22 Feb 2019 09:36:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org
Subject: Re: [RFC v9 2/5] dt-bindings: pstore-block: new support for blkoops
Message-ID: <20190222153631.GA2612@bogus>
References: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1550577170-18761-3-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550577170-18761-3-git-send-email-liaoweixiong@allwinnertech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+boot-architecture list

On Tue, Feb 19, 2019 at 07:52:47PM +0800, liaoweixiong wrote:
> Create DT binding document for blkoops.
> 
> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> ---
>  .../devicetree/bindings/pstore/blkoops.txt         | 53 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pstore/blkoops.txt
> 
> diff --git a/Documentation/devicetree/bindings/pstore/blkoops.txt b/Documentation/devicetree/bindings/pstore/blkoops.txt
> new file mode 100644
> index 0000000..5462915
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pstore/blkoops.txt
> @@ -0,0 +1,53 @@
> +Blkoops oops logger
> +===================
> +
> +Blkoops provides a block partition for oops, excluding panics now, so they can
> +be recovered after a reboot.
> +
> +Any space of block device will be used for a circular buffer of oops records.
> +These records have a configurable size, with a size of 0 indicating that they
> +should be disabled.
> +
> +At least one of "block-device" and "total_size" must be set.
> +
> +At least one of "dmesg-size" or "pmsg-size" must be set non-zero.
> +
> +Required properties:
> +
> +- compatible: must be "blkoops".
> +
> +Optional properties:
> +
> +- block-device: The block device to use. Most of the time, it is a partition of
> +		device. If block-device is NULL, no block device is effective
> +		and the data will be lost after rebooting.
> +		It accept the following variants:
> +		1) <hex_major><hex_minor> device number in hexadecimal
> +		   represents itself no leading 0x, for example b302.
> +		2) /dev/<disk_name> represents the device number of disk
> +		3) /dev/<disk_name><decimal> represents the device number of
> +		   partition - device number of disk plus the partition number
> +		4) /dev/<disk_name>p<decimal> - same as the above, that form is
> +		   used when disk name of partitioned disk ends on a digit.
> +		5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing
> +		   the unique id of a partition if the partition table provides
> +		   it. The UUID may be either an EFI/GPT UUID, or refer to an
> +		   MSDOS partition using the format SSSSSSSS-PP, where SSSSSSSS
> +		   is a zero-filled hex representation of the 32-bit
> +		   "NT disk signature", and PP is a zero-filled hex
> +		   representation of the 1-based partition number.
> +		6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in
> +		   relation to a partition with a known unique id.
> +		7) <major>:<minor> major and minor number of the device
> +		   separated by a colon.

No.

I didn't suggest to go look at PARTUUID to copy it into the binding, but 
rather to point out that the kernel can already mount by UUID. 
Specifying the UUID in DT is also not what I suggested. My suggestion is 
to define a known UUID so that the kernel (and bootloaders, userspace, 
the world) can just know the UUID. Just like the EFI system partition. 
Now this means you have to get it defined in the UEFI specification 
(or maybe EBBR[1]). If you want help with how to do that, the 
boot-architecture list is a good place to start.

major/minor numbers are a Linux thing, so they don't go in DT.
/dev/* is Linux thing, so it doesn't go in DT.

You can always define all these parameters as kernel command line 
options and avoid DT. That would also make this work on *all* systems, 
not just DT based systems. (Though I still believe that the partition 
should be discoverable.)

Rob

[1] https://github.com/ARM-software/ebbr


