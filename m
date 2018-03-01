Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519929995; cv=none;
        d=google.com; s=arc-20160816;
        b=Z+Y3ylDtLgbBPparMMTZqQbNdoGhNqgD8wa1EcoChmer+G3EAW8d/qLlc4IAYq9bX4
         cyBAELi8sJhKdDu58OMAnDZ+jumHvQ/AQlwH7eMU6ihyQSnBOd519VtF4lSFSlUaNi0e
         v0SpEXTA7dA6tiiaOHspYtzC79WzNbichJwZXLQSptaRSkWJ6v40MvW3/Xdzp8sVYSIM
         XmuSoAKCJn7fpwLf08IdYom97zIJwCDlYHdApMKES8hNI9VxtTOn9VNepGeyK36JdyTw
         1HkFwOaRcUYc4BQiCg6Zz8ltukOZX4AKy4bSwqzNK6X7OCUi/Isdq0khQb84jVQCw5OJ
         mMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=L7LI7IpLCjvN2rImBDu75OZ+r3r+LTwphHw2A72CNHQ=;
        b=LQni8D68gvtBMWaURBhQKVCrt5l5p6Qiwg/YT6c3XOOj5qRhN9jF0sg+NDelXZwmIS
         rpXIRc0wJzL/3TA+pI7aP7EWPZhXv0q84c0RkGGaUeDQgCqPB2jozX0lfPi2fQ9ss4qy
         07GoSfUu57D7+MsswDCzwr2O6/Ir/HMS6iSAFTWUUDdSBhJQn1hlkoOGqeCZhY5nhcjQ
         KSOCHYNCDfJiNRbP7Dt0bTYXGbBAXacwUH83J05+Hqa2vwDsAkFHYkzonTpDisWuPmn8
         mRW+bQ4fcCymQ4TWk1o1dvAZnVOaE+3jnYOi6l5sHOEJNODQCeqYdvZfvhy0QnUjcnZK
         uHdw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ANt7Qxa5;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ANt7Qxa5;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtdU8lfxzHFV5UF06SG24M/r373PX4AtvxnIwsSsjsZ0MNkcFn9kQfBfoyJhhzTU5HrtnAVAAXu1ApAoRWO9bk=
MIME-Version: 1.0
In-Reply-To: <20180301182028.237856-1-djkurtz@chromium.org>
References: <20180301182028.237856-1-djkurtz@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 20:46:34 +0200
Message-ID: <CAHp75VcZSkQHFgfAgePQsfsYOZOZxsgz3-+W7X42Gw2hrxODEg@mail.gmail.com>
Subject: Re: [PATCH] earlycon: Allow specifying a uartclk in options
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593760477138517104?=
X-GMAIL-MSGID: =?utf-8?q?1593762115302694903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 8:20 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Currently when an earlycon is registered, the uartclk is assumed to be
> BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
> options, then 8250_early's init_port will program the UART clock divider
> registers based on this assumed uartclk.
>
> However, not all uarts have a UART clock of 1843200.  For example, the
> 8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
> cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
> on such a device will result in incorrect divider values and a wrong UART
> clock.
>
> Fix this by extending the earlycon options parameter to allow specification
> of a uartclk, like so:
>
>  earlycon=uart,mmio32,0xfedc6000,115200,48000000
>
> If none is specified, fall-back to prior behavior - 1843200.

It needs to be discussed.

First of all, if you are going to do this you need to add a parse of
human readable formats (IIRC kernel has helpers), i.e. "48M", "38.4M"
and so on.

Next, I was under impression that purpose of earlycon (in difference
to earlyprintk) is to re-use existing drivers as fully as possible.

So, what exactly happens in your case? Are your driver lacks of
properly set clock? Or earlycon does simple not utilizing this
information?

-- 
With Best Regards,
Andy Shevchenko
