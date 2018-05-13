Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526250008; cv=none;
        d=google.com; s=arc-20160816;
        b=TQeJnC/3xc6uKz0xIGXnetnMXVQnMLMDyG604bh2mqZayVbjL61EafHBCIGENCw534
         Xlm1am5s7AcAoNT9Slm0qJ2e+KQhKCK2DJwkO3QXyT9xxUIK/9qjTh4cAFwk5XMOAenH
         uW7499XN+E3w7equ14+7uWwekF0A8aCy/xMpl5oiw1TpgI5mFQma4BfhghOA3GdJbHZu
         VMLKMiZjhFCAVc38EREPmT/EGlg15aOL+9/HGv8IyB3BAPNC1KV1JTA/Cf5gmtr7aJ7g
         dmm2c3S108OfzcahNB1B/O+v7KnOPAJzPz8YBHB9Bnxg/6e7tcSRF8aY8mir1++aAU9F
         NwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DupyX5oikYw5MGNsSyGeUnsWzCZ8WEB2sOBs8PaEYRg=;
        b=hbdFtpSrP8rETY0Q9T7JZngMMZfNLOxnR8goB4nmFCWHQ3LGmz+wz6RT1FcK9i2Giu
         fPj2iPVxS8+On9JU+gCVl4fFvkqNHKL9uyUG+fOphgyJ7PIE1+6at1vhbvgPIza/QUF0
         LcnSd9TBNvnbjCYYJMpFjL74IxarSExP3euWXlMJu2DKn6te/hDxw9GY5sxMIvkCO2VN
         GRDssCKBj+sllsfZ7vq87TKgPcb5i9Y8/4XAvdoatlEgqVdD9r4Xb7hD+bBuSxeYK1c9
         szggZl8iwAQbUGZQkfZHjOxS9IbvYYKn/A6ekGSA5xlKO/dzyNT2BkSeqEz7xn5QfAHr
         oz0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oE6156w1;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oE6156w1;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrZqpKRkvepjiSTfP//Y2iSjK/Gf1zuxI3JO+6eoeS7hRB0dBqiuX8rPmQl2TY+C0uSYUJJQ6be07GTn/vt+Eo=
MIME-Version: 1.0
In-Reply-To: <662ce972-56a9-9daa-d332-faa08b89c05a@kapsi.fi>
References: <20180508114403.14499-1-mperttunen@nvidia.com> <20180508114403.14499-7-mperttunen@nvidia.com>
 <CAHp75VfYF_u2bZ+temGbReEB9K-t3A75aUNYwffyv9-=zEi0Lw@mail.gmail.com> <662ce972-56a9-9daa-d332-faa08b89c05a@kapsi.fi>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 01:20:07 +0300
Message-ID: <CAHp75VeJcqaiWUVr=oXEH5YurY3yCDdE1eeoWumo6jCa_4PWEQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] serial: Add Tegra Combined UART driver
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>, araza@nvidia.com,
	devicetree <devicetree@vger.kernel.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-tegra@vger.kernel.org,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896478847127946?=
X-GMAIL-MSGID: =?utf-8?q?1600389129067724368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 13, 2018 at 9:04 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> On 05/13/2018 05:16 PM, Andy Shevchenko wrote:
>>
>> On Tue, May 8, 2018 at 2:44 PM, Mikko Perttunen <mperttunen@nvidia.com>
>> wrote:
>>>
>>> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
>>> multiplexing multiple "virtual UARTs" into a single hardware serial
>>> port. The TCU is the primary serial port on Tegra194 devices.
>>>
>>> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
>>> are part of Tegra HSP blocks that are already controlled by the Tegra
>>> HSP mailbox driver.

>>> +static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned
>>> int mctrl)
>>> +{
>>
>>
>>> +       (void)port;
>>> +       (void)mctrl;
>>
>>
>> Huh?
>
>
> The serial core calls these callbacks without checking if they are set. They
> don't make sense for this driver so they are stubbed out.

My question why do you need these ugly lines? I'm pretty sure no other
driver with stubs using such style.

>>> +}

>>> +               if (written == 3) {
>>> +                       value |= 3 << 24;
>>> +                       value |= BIT(26);
>>> +                       mbox_send_message(tcu->tx, &value);
>>
>>
>>> +               }
>>
>>
>> (1)
>>
>>> +       }
>>> +
>>> +       if (written) {
>>> +               value |= written << 24;
>>> +               value |= BIT(26);
>>> +               mbox_send_message(tcu->tx, &value);
>>> +       }
>>
>>
>> (2)
>>
>> These are code duplications.
>
>
> Indeed - the length of the duplicated code is so short, and the instances
> are so close to each other, that I don't find it necessary (or clearer) to
> have an extra function.

It makes sense. Consider to refactor other way w/o duplication then.

>>> +static void tegra_tcu_uart_set_termios(struct uart_port *port,
>>> +                                      struct ktermios *new,
>>> +                                      struct ktermios *old)
>>> +{
>>> +       (void)port;
>>> +       (void)new;
>>> +       (void)old;
>>> +}
>>
>>
>> Remove those unused stub contents.
>
>
> Sure. I had these here so that we don't get unused parameter warnings, but I
> can just as well remove the parameter names.

What warnings? How did you get them? We have them disabled as far as I
know even with W=1.

>
>>
>>> +       return uart_set_options(&tegra_tcu_uart_port, cons,
>>> +                               115200, 'n', 8, 'n');
>>
>>
>> Can't it be one line?
>
>
> It would be a total of 81 characters in length on one line, so no.

So, yes. 1 character doesn't prevent us make the readability better.
Please, put to one line.

-- 
With Best Regards,
Andy Shevchenko
