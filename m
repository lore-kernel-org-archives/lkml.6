Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF4C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9857D2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550091027;
	bh=v9IW1VeNJ0uyyg1yeqkCkIBA59xN+2s8Le7x292Qlww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t4bKaReAEReC+ZKD+jlOcUl3PJAbRmeZBOWoHsZSQJ3loNuvyGHUAeYUCKsUgMFyL
	 jvQNwRsPPL9mk1Ns7SBl32OD7ctyyC8OANUkLmtVfTWhv9u+l5PD7+pYyb8o41aIch
	 tKMVHPVfn2/+gckwdAU2h+ZuZyRctbStlJhKBs90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394633AbfBMUu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:50:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40828 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfBMUu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:50:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so6704676oth.7;
        Wed, 13 Feb 2019 12:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S0duX/bi01Fll7tfcpxZyWNbTI3ZxJWetAXicxcp1pw=;
        b=eWIiFBRJu0R4267gv9WWdX+nLOKS8EYlMlWWkXrLIW5Mma6r4/+RBL/LL6Y83qmpa1
         Cn1XFUzt7XqM6Epr2MPcnthRAf0/07UuBkbdpVF8MRBbNSJ8Z9OgROffACn7vqUemKKs
         yR021h3HXuxYN1oFgrqhGt57OY/o0zcLxoJTfUVxOGnKgbBvQtz4LKI+O6Ch4JbIHfbn
         iGbZBA58AYHPtPGuYt0Gztm8mdzXFdPR1RThAYUarsVhTUpSeNnINYHSSNCW7Kcj9dj8
         YgSMSziKuXGygXlrzHuO4Qz2dT0I1x32KVjZCVQ5urnw63zHeqgZygCnOwjnnP07lIZz
         XVQg==
X-Gm-Message-State: AHQUAubSx8VxfjMAG9B5Xftk8BASdJm8qZjNdmk1NxMMu9RJ+YGV0TxD
        UFe7+RYm+686bLKJwnaQgA==
X-Google-Smtp-Source: AHgI3IZJBbvlIj26nDdEceWGsG5JIBSIoZW1QtPf03UjV4RgY1N8dYPZcMVF19VroEqGNJlyEuCYNg==
X-Received: by 2002:a9d:dc3:: with SMTP id 61mr25762ots.345.1550091024776;
        Wed, 13 Feb 2019 12:50:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 39sm211002ota.11.2019.02.13.12.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:50:24 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:50:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 04/11] dt-bindings: input: add DT bindings for max77650
Message-ID: <20190213205023.GA8340@bogus>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213134335.10838-5-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:43:28PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the onkey module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
> new file mode 100644
> index 000000000000..37c80898be4d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
> @@ -0,0 +1,26 @@
> +Onkey driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The onkey controller is represented as a sub-node of the PMIC node on
> +the device tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-onkey".
> +
> +Optional properties:
> +- linux,code:		The key-code to be reported when the key is pressed.
> +			Defaults to KEY_POWER.
> +- maxim,onkey-mode:	Must be "push" or "slide" depending on the type of
> +			button used by the system. Defaults to "push".

Perhaps just a boolean for 'slide' mode.

> +
> +Example:
> +--------
> +
> +	onkey {
> +		compatible = "maxim,max77650-onkey";
> +		linux,code = <KEY_END>;
> +		maxim,onkey-mode = "slide";
> +	};
> -- 
> 2.20.1
> 
