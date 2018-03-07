Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520423838; cv=none;
        d=google.com; s=arc-20160816;
        b=YusPvjL3QUWV+TJhz+ZfmjfvsA3joUsZ1n+rfRQM2akqjPIXnrq2UOTtNZWNsua5Wo
         QENjvLDWWAMYxdtgcoamTPsUoMBn0NgKl+uFPUVWS5j9Qa16JYmUP6CmvUgM831wZwDz
         O9kFhjWkaSaE0/QrDyIntrwRHhL4dk4piwaDtfiK7uDMI7RaKOepe5PtnDmIKWCh8y59
         REUvevkl1M3u/pKgyyEAChU1V4gzfIWvTCF6EHUiIChHQmNosVubkrBRp+Gs8l4hRf81
         DTjI93+uwTAOBUh1S8EbG6kJNUaTFQpzEU59pq/yGZN9+mPSkpbfNnRlq6FaZoROzwAG
         Phag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=dD9lUSFXnJlPOfoKLvWtTjzJNYtb48Y88z96oC8xSew=;
        b=NhtSRZ06ydT8OUEPMy8IC940ZysVdMydGdlHqZBG7bbv3fjsN9p1QXCcGI/oLN4eC1
         nGjbg+OZNsjYakelIeBOJemn05pTubHbdTkO02F5ujgsSF7uXFXQWxY+FfkozEM2CeX/
         TP+nBZd5SU75iHUAI4HraI9Kj/U8fPGD5m0Q7b9t6fJhgy5JpDkQPdJe3/YzSrAHRtPx
         CYGPUa+Wbc8NvwUXL8vp8I4FqCT9yuEwqBNDWCIX+Vqj91ZKUJMqVyVNE2NkwH2z3jSc
         1OoAy+ov7P8uBcbEpAnK35IOQEHFLIDDEK5H2neWlDpdgwgpfcuNdwXzFX3IZ9zwxRDJ
         sLLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qb8Sixyy;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qb8Sixyy;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvaQEUoe1hf+DDCYKVep4nNDB4kq9ZagzhuUWFZ38xMJLrY5Uc36kwVbSfaP/7ooNAa5qZwZ+4bQOzPDXPf4r8=
MIME-Version: 1.0
In-Reply-To: <20180306074418.8879-2-jeffy.chen@rock-chips.com>
References: <20180306074418.8879-1-jeffy.chen@rock-chips.com> <20180306074418.8879-2-jeffy.chen@rock-chips.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 Mar 2018 13:57:17 +0200
Message-ID: <CAHp75VcmbHbnD8FnTHXAqGajhs10wA7Z7U_D6SY9=j=y+GLLPA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Input: gpio-keys - add support for wakeup event action
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, briannorris@google.com,
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	Dmitry Torokhov <dtor@google.com>, Douglas Anderson <dianders@google.com>,
	devicetree <devicetree@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, linux-input <linux-input@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594279946955786833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 9:44 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Add support for specifying event actions to trigger wakeup when using
> the gpio-keys input device as a wakeup source.
>
> This would allow the device to configure when to wakeup the system. For
> example a gpio-keys input device for pen insert, may only want to wakeup
> the system when ejecting the pen.

> +       bool wakeup_enabled;

> +                       if (bdata->wakeup_enabled) {

This is redundant. IRQ core keeps track on this information already.

Check below as an example
aef3ad103a68 ("serial: core: remove unneeded irq_wake flag")


-- 
With Best Regards,
Andy Shevchenko
