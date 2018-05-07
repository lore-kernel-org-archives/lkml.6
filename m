Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AB8JxZozt+gHOXOh/Z8h+jlS4lZ5smAyO0bCoAVH6PtK1V27Wsg1b0NRfrEoC0dAZ6nkTmna1Lko
ARC-Seal: i=1; a=rsa-sha256; t=1525700286; cv=none;
        d=google.com; s=arc-20160816;
        b=pBEElIxzzMjBp6+Jj5ULi167hNkGYfmsKKP/txzrPWpD3i0zjC3rJ2HlXv3w5fIk0O
         jIylc+15oWjmim4+SmSltysJVx4c8voV3nOpaNr21Ei7CgLU5ymvd+zUa4L1tzVrJ2V3
         7CR6aOKZsG+diiESpxJZXxRr+23uYLcY786/Uas+ge5P+xymB3y+8VqrND20/zLZ7NHV
         yP4UhV2M485XvitkavHlPURKg9UpjSGzT8FKbUKI4S8nvmO78fJ5A8t5VrkboECQKpEq
         iPe8FCXT9XuIxmmVlwKlt5veUAeEMEWDJkGghooz6EkwlkJHdMCCLncXDay5E2kV9u6X
         UudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Y5nHTDH+9/qLBVS0KB9DCN7S+SASsFMFaRYYL6OTmLA=;
        b=kjeQP6abXeWDGJBMKFNMp8wPLP0kqbJ8n6jOYsab+7MPO2EFFv0Pm2faHNBEvQmURQ
         y3o7iAojeg8uWc8pslPIPPo4xkc4sSkhzu8ktB/e94AhYrd5ZgbVbPBCps9lRNjLAG+k
         8mS5UwL2J7Ex9d9fF7PRTZj18Vr1qNLSRB8SiF9hEmI1VLwLoy1Q/okuwiBK+00o4z/D
         oB1HYvLMaz+ErwUiGxklNP5wqp07Qyuy1zTeJuFeDw1DAgTsdGYgTpNyIkoGqk+wbiiY
         09Y3br4WiBJ1FkJvgwKX7S6oXTFoy06htZplv2JAIC/HrRQ3FguRIW5ao9+eB+pbSiyd
         lMHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wAWyczcH;
       spf=pass (google.com: domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wAWyczcH;
       spf=pass (google.com: domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
In-Reply-To: <20180505012513.GJ13402@sirena.org.uk>
References: <20180501213114.20183-1-robh@kernel.org> <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
 <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
 <74d495d8-04e2-fb7d-7d07-0905fbc8a6cf@arm.com> <20180505012513.GJ13402@sirena.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 May 2018 08:37:44 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+WDrx6Jfoa5drutK-LaVE9xSfttFSGrsgNxPG60DmWJQ@mail.gmail.com>
Message-ID: <CAL_Jsq+WDrx6Jfoa5drutK-LaVE9xSfttFSGrsgNxPG60DmWJQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Mark Brown <broonie@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	boot-architecture@lists.linaro.org, Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
	Alexander Graf <agraf@suse.de>, Grant Likely <grant.likely@arm.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599812703137882489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 4, 2018 at 8:25 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 02, 2018 at 07:49:57PM +0100, Robin Murphy wrote:
>
>> I guess there's also the possibility that a single driver may want multiple
>> behaviours, if e.g. if SoC variants A and B have some identical peripherals
>> but slightly different pinctrl/IOMMU/etc. hardware such that A has workable
>> default behaviour and can be treated as optional, whereas B absolutely must
>> be controlled by the kernel for the consumers to function properly, and they
>> *should* defer forever otherwise. I think that would pretty much demand some
>> sort of explicitly-curated white/blacklist setup at the subsystem or driver
>> level.
>
> Different board variants, and possibly even different bootloaders might
> also be an issue here - a vendor bootloader might do pinmuxing that an
> upstream bootloader doesn't for example.  In some cases the pinmuxing
> even depends on the boot method with things only getting configured if
> the bootloader wanted to use them.

I think this is going to be too big of a hammer for pinctrl at least.
My current thought is to define a pinctrl DT property to indicate pins
are configured already which the OS can use to decide if pinctrl is
optional or not. I'd prefer to keep it simple and be a per pin
controller flag even though this is quite possibly a per client or pin
group state (as you say, the bootloader may only configure what it
uses). Making this per pin group could be a lot of nodes and difficult
to really get right without testing. Making it per pin controller
could make drivers fail in less predictable ways if their pins are not
configured.

Rob
