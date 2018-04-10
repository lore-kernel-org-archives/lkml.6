Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523368218; cv=none;
        d=google.com; s=arc-20160816;
        b=mSr5yEmpeKcujriZupBsMaPA+BKXLcBJXeHYtEYfTQ3S4Seym1yMfKq1np3VA/bZxC
         wWyqmUcdC3+11jytZKqaO7UfHDxlp4IFEGw87Yu4y9KmzBpFK0vIOm97NL3s4GI55M1l
         qeYGgq5zGuVC8mt4e6gNzmq56TvCZfV6U81Y5+2Elc8CShp75JX7Q9FPiZOYRHCgxIXW
         x9se7lA5u29Sx/7Fo4KEEBVI7d4YFQ2r9LWKVwAkoanR/0vd32Q8gYzccWa9ztBPwN7V
         SYWzbruCCP7rUWdjEwXh6pH5Ku++tzPJA8zl19gp42fQOtbvN4EoE7ggZ5NRjUWUNwcC
         zWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Iti/zi2szXuJCNRvQ0R/il1lDUZCXQCzQ5IxfUMD6kM=;
        b=bRa7OtrEvn4T6auNumHTk+fzer7a6WT1ZRmnS3Uy7ZywLpQktqOdoioDcl+ExM6GqT
         92SV8elqjOTXpgkZp4sj28UrIBqcHaySCvGnNKf0DCIP3bLuS+YtyVeTeHKiEX4daNdH
         4vOppM8HIQ2Vtx2B7pzcXFQwMKvu2e7F1m+/RsSMQOfvnUOjm6QzyI8sSCCxS2A/4+fx
         JKP5MBwC/psQ4j6jel9tHKdEjBp+kCXq9zjT9RmRq+aApXvuRWzsIUJqbKYs+Oc78C1t
         T1LczB5fTrvW85fovT3ebd4q3m2v/aj9xJ0arK52g8/wfiW7HDKhn69ki9fAs+Ifh/St
         /aEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+3ovLNAYvy8gyqz871rs8WRxNFRRzq9C4Xbyj2dsYitenff07UQloejW9E/q8FsvcUO1qPYg==
Date: Tue, 10 Apr 2018 08:50:17 -0500
From: Rob Herring <robh@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: sre@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
	mchehab@kernel.org, gregkh@linuxfoundation.org,
	linus.walleij@linaro.org, akpm@linux-foundation.org,
	rdunlap@infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] adp5061: New driver for ADP5061 I2C battery charger
Message-ID: <20180410135017.7sikebbbdsdxjsxs@rob-hp-laptop>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596802855517909169?=
X-GMAIL-MSGID: =?utf-8?q?1597367352728591151?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 11:17:12AM +0300, Stefan Popa wrote:
> This patch adds basic support for Analog Devices I2C programmable linear
> battery charger.
> 
> With this driver, some parameters can be read and configured such as:
> * trickle charge current level
> * trickle charge voltage threshold
> * weak charge threshold
> * constant current
> * constant charge voltage limit
> * battery full
> * input current limit
> * charger status
> * battery status
> * termination current

Don't you need to describe all these parameters of the battery used? 
Charger bindings are never this simple.

> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ADP5061.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/power/supply/adp5061.txt   |  17 +

Please split bindings to a separate patch.

>  MAINTAINERS                                        |   8 +
>  drivers/power/supply/Kconfig                       |  11 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/adp5061.c                     | 745 +++++++++++++++++++++
>  5 files changed, 782 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adp5061.txt
>  create mode 100644 drivers/power/supply/adp5061.c
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adp5061.txt b/Documentation/devicetree/bindings/power/supply/adp5061.txt
> new file mode 100644
> index 0000000..7447446
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adp5061.txt
> @@ -0,0 +1,17 @@
> +Analog Devices ADP5061 Programmable Linear Battery Charger Driver
> +
> +Required properties:
> +  - compatible:		should be "adi,adp5061"
> +  - reg:		i2c address of the device
> +
> +The node for this driver must be a child node of a I2C controller, hence
> +all mandatory properties described in
> +Documentation/devicetree/bindings/i2c/i2c.txt
> +must be specified.
> +
> +Example:
> +
> +	adp5061@14 {
> +		    compatible = "adi,adp5061";
> +		    reg = <0x14>;
> +	};
