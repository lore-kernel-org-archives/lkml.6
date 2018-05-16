Return-Path: <sboyd@kernel.org>
X-Google-Smtp-Source: AB8JxZpBT+yC8TryVCU7FQfP0GWqTna65WLeUBtlj5DTrA/bAYEPbbfT8SKMmpKhVaEc6ePdBAYv
ARC-Seal: i=1; a=rsa-sha256; t=1526452789; cv=none;
        d=google.com; s=arc-20160816;
        b=pew1IfIllELnG4B3TcZph4VMGbfKldgp9J/kl20Zf6hncalP9AfeA4ne4DABQA0xAo
         AFk0JJL9CaBocodVbr5YSLfTnSJAgBg2/hSFr0jLPhU4NzqNkQPvVQx36kDYg4Q6PqE2
         mc0jxpT2aEjZ6RZbJQ0m4sfwwVG8jYap9UVOpy0Iu+86Q3TQeig5rx/l/7yUSQeobkTH
         AiuqyZYb9m4YhIY9k//IC4RQrA06E80djoDuwywcI7yFLEEshw1Xu+YzQs0I+4cRkl2T
         MMbdjjPrzRG13+O5M4V2zVx9gcFJ9WM86Nsi4kgy3NJeBYEDhM6ObTuWT/HhuJ7cbVuP
         MhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:subject:user-agent:message-id:references:cc:in-reply-to:from
         :to:content-transfer-encoding:mime-version:dkim-signature
         :arc-authentication-results;
        bh=KRxQlj4QEKgcI4Agb76VR+UKoU9wZbR2ki3Ox0M1zK4=;
        b=HsF2EZrHvieabP1QW4fZ1VaEkP+Z+Vo3Pi/3ypIn7789iqdNAMED+Cu3q2BATMGP1A
         jYwD1UZ9ThWefpe85mOa9ziT68sjJX/s6tBQbOlhLTOWhvbhPTqN3YfMRzGXessiNAQC
         qvgv0Re0dK1GLELV0qgin9FKo+MjcJvWdDLSsAa/pZ+PdvJBlYwz+CNvjVY/ywt67xkM
         CkyO77AfH6BJWoeymrKn8HXCBZEOq0L4MJZOopOYr3dAwWaHdzsvw3pEuTz7kPwN81ov
         xu3+6mjQ2maH4pFUPPYM7HgxcPMWQSZ6j3iNQIYSIYa8FfSADiPPThKHBsZV74IrmsgW
         MsmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NGL3PJBi;
       spf=pass (google.com: domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NGL3PJBi;
       spf=pass (google.com: domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcin Ziemianowicz <marcin@ziemianowicz.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180429190111.14247-1-marcin@ziemianowicz.com>
Cc: Marcin Ziemianowicz <marcin@ziemianowicz.com>, stable@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180429190111.14247-1-marcin@ziemianowicz.com>
Message-ID: <152645278298.237094.13637070780064221668@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V4] clk: at91: PLL recalc_rate() now using cached MUL and DIV
 values
Date: Tue, 15 May 2018 23:39:42 -0700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599108323974311236?=
X-GMAIL-MSGID: =?utf-8?q?1600601759403622084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Marcin Ziemianowicz (2018-04-29 12:01:11)
> When a USB device is connected to the USB host port on the SAM9N12 then
> you get "-62" error which seems to indicate USB replies from the device
> are timing out. Based on a logic sniffer, I saw the USB bus was running
> at half speed.
> =

> The PLL code uses cached MUL and DIV values which get set in set_rate()
> and applied in prepare(), but the recalc_rate() function instead
> queries the hardware instead of using these cached values. Therefore,
> if recalc_rate() is called between a set_rate() and prepare(), the
> wrong frequency is calculated and later the USB clock divider for the
> SAM9N12 SOC will be configured for an incorrect clock.
> =

> In my case, the PLL hardware was set to 96 Mhz before the OHCI
> driver loads, and therefore the usb clock divider was being set
> to /2 even though the OHCI driver set the PLL to 48 Mhz.
> =

> As an alternative explanation, I noticed this was fixed in the past by
> 87e2ed338f1b ("clk: at91: fix recalc_rate implementation of PLL
> driver") but the bug was later re-introduced by 1bdf02326b71 ("clk:
> at91: make use of syscon/regmap internally").
> =

> Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> ---

Applied to clk-next
