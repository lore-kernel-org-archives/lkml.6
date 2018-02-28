Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519829059; cv=none;
        d=google.com; s=arc-20160816;
        b=st2DpiT5JqXLyTue5TPNNY41dWImc2xZhykQOBjKGizPkDqWrNZIss4vqpXtQPE2CO
         6UySPZjD+9K7U9u4wjNBUY1Ka+T24uadvFGk3PD/HxUYXg3G3O6+aKCWPLAfLZCwga5A
         WeiTBWAxfytcMdwxlTFB0AO1F2ButNWfK1UVSWA0vES12SllEJDOKNV/QV+ntLdhJZ9M
         mOzGhq74y1gE2iegX1Vnfr1xp26XRyMEoT6b5XX8pzg7O8ornZ5Bx2FsIJB7gljX5nlP
         DYmeNnOBp7oKmPfY3C+yc9ybgIW9WHFl/3D+fNwT2S1X1jDKq4a8P2KpOPk4qNzwBYXK
         NPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=4k1Gm0adUpjoNVMmJ4aR6DxwHafZMge7dhfPPadrWcY=;
        b=UeqP6gI2ROZy0W8fz/dx86lKxMNfFtjRtk/oKbgRGH4JDuedIcQUNqRbfACfv6gpuD
         ggnMNkcd+9PzLaOPEnwppGEIc1KQJWd1Rkk7zeeLAb68hbXyrkut5PBm8DYjYeGyNXdt
         hyOSH+H19tVeO1o965RFTo8Y7d1zO3nO78hXHiEXurhP9hdhOIUq2HN1bsozRdImZT5h
         x/UvLtWk2E6cJ///BwRrLyilOu/4/SIYrvhdzuD0XO6F0ImWYZdVJbXhlFv6Xz2QRFJ/
         TbwaKGWpaoh3bGBsWENiDeiFgFORHsnCHhme7FLqL+SPiR2hHkWH8uwAf/gOBZnPdYGC
         qkew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lt0NPZPk;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lt0NPZPk;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELvyIYt+9VnY1AZt03obXQcQpgJARkD4wVGAB2OO68ZbLrvyZptvV0xeVg4DiQLAWcZ6Ew13RSQr1WlXrHPrLEY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
References: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Feb 2018 15:44:18 +0100
X-Google-Sender-Auth: 0sbNO82B9hP9x7lHaiuGd0-oA98
Message-ID: <CAK8P3a1v2GanneaFKpXWjWLt1YzibJ9Bh7vUcd_SH-4jGN_1+A@mail.gmail.com>
Subject: Re: [PATCH v3] Input: gpio_keys: Add level trigger support for GPIO keys
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, gregkh <gregkh@linuxfoundation.org>, lumotuwe@gmail.com,
	Arvind Yadav <arvind.yadav.cs@gmail.com>, josephl@nvidia.com,
	kstewart@linuxfoundation.org, Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593648786277200792?=
X-GMAIL-MSGID: =?utf-8?q?1593656275955077983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 1:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On some platforms (such as Spreadtrum platform), the GPIO keys can only
> be triggered by level type. So this patch introduces one property to
> indicate if the GPIO trigger type is level trigger or edge trigger.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v2:
>  - Use 'interrupt' property to indicate the irq type.
>
> Changes since v1:
>  - Diable the GPIO irq until reversing the GPIO level type.

I've looked at your patch in more detail now, and given it a bit more thought.

I wonder if you could move that logic into your gpiochip/irqchip driver instead.
It seems that what you do in the gpio-keys driver is to emulate edge triggered
behavior on a level triggered irqchip.

If you put the same logic into the gpio driver, you could simply make it
pretend to support an edge trigger on both edges and call into the interrupt
handler whenever the state changes.

        Arnd
