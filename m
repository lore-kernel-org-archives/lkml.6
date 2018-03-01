Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519906148; cv=none;
        d=google.com; s=arc-20160816;
        b=DMSvKvDeR5aWw0jYl04tyJ8XRwhDfbXqrN2ff6+1g6GkDawQX37+hpWEHvCTo1vn1u
         kOz0NfxC+0NHQJ+EyBLY44mbX32peirnKj+JQaEfpLD2hpxnaHGmDXJF5ns3cwrzOLY1
         XvepS+po9ebT2JWrOdB7PYjsS1/KVJgAbmsc3H7YoaUWYb+uFDoP7ILgcau7+pEkZH2h
         TeYqGzH6BEhYU5S7/GWJKh/5DEM2xKOe7UOvJVe3fNtP1hJErNOlJ2uzxP3g9nJaEaeD
         lLq7R8/Qh+l1Fr+fJ0hN1XAJGQOwGpj13FlMMjz6dY49YDVB0rc/XE2bOE9ojj1T6Ggl
         H5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=OpqNbP8xlimb6MyaorrBXDvf54KKAtVvtwemRKh5pGU=;
        b=A8FAiHlo0vltUjbWe47YN2mom+s4AU4emJNbnNyJ06C5YaS16ZeCmwSO10H2wM+8Cu
         4U/rou1KIjL1QaUKwfUPNPJ53QUe3D2gWxHu7yOiZnCFNv2JKKLBavMHT1farYebXLlD
         JxLD+PPqC3kkNk7CARFPlN80ckpjIClELJU5VBkBwWm9kTIJEibcm6LSDm9QDtK6q4CZ
         znpyDgHMe0MSlTrEuQJfWkFJ0xTHjETfgxUmNqQ6uGGS39/kdX7f/sdvHiQ7q++r8e+1
         a3WiTHiqFN7fpaAzQjL7vAZkk/2blfmYGf7pF3D90j6qsTcGScYrPDE0Cd21ZeWK+xzR
         TOYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NGA9NrQL;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NGA9NrQL;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtiGmKPzCfMZAKPAVd6zuq5u8xnLs9C+JZeLkIUBRi5yPcsMV7S+SuASG2iYn4XNfGmYL9r2PaOFCjQg951F8o=
MIME-Version: 1.0
In-Reply-To: <9ea2faf9c1cf8439f3a8ad495c6a2b49dacad7bd.1519889208.git.baolin.wang@linaro.org>
References: <9ea2faf9c1cf8439f3a8ad495c6a2b49dacad7bd.1519889208.git.baolin.wang@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 14:09:06 +0200
Message-ID: <CAHp75VcgUmOoo-jRbM-Gyp1JTY-2rJri8e7u2miYSvRM_4HmPg@mail.gmail.com>
Subject: Re: [PATCH v4] Input: gpio_keys: Add level trigger support for GPIO keys
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stephen lu <lumotuwe@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Joseph Lo <josephl@nvidia.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>,
	linux-input <linux-input@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593648786277200792?=
X-GMAIL-MSGID: =?utf-8?q?1593737108990764885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 9:36 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On some platforms (such as Spreadtrum platform), the GPIO keys can only
> be triggered by level type. So this patch introduces one trigger_type to
> indicate if the button's interrupt type is level trigger or edge trigger.

>                         button->irq =
>                                 irq_of_parse_and_map(to_of_node(child), 0);

AFAIU, 0 means NO_IRQ, thus,

> +                       if (button->irq)
> +                               button->trigger_type =
> +                                       irq_get_trigger_type(button->irq);

irq_get_trigger_type(NO_IRQ) should return 0.

Therefore, if (button->irq) is redundant.
Did I miss anything?

-- 
With Best Regards,
Andy Shevchenko
