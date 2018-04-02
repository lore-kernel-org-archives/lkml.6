Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522651619; cv=none;
        d=google.com; s=arc-20160816;
        b=mP9JFQHD5V3hnPA2DcT2LwAAN0IzepeYxUXWr1GrGKtpIyzm4RWK9EKlX/oM7Anj+d
         C8GlVtppmXs+h8Y2ufKqcWzQjMDl4Rf92rjy+19Np6+ugWMs1Jb0W9uW+B4zHhxng+Zm
         aPRy6i1XsiramCqhE0M19WyVJIXnoc14o6qOBaep1WjibAZLcAdRmuaUNOMuA5XCrcT1
         QtThaVUnGSUx5xO21kPrhmGArLGkSmEi2PHMdoUJ8HBNBbvxuWaHfaOshxUUYc9orp3N
         T/Vje7Hld5kKoQJD/XGmyOZmGSALmFJ6dc27hGrxnY4/+nzGYswTXtAyGhDN+a9je2yB
         TFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=f7OeY9o4Kk2owqkxVIiXTk6oZC1+LDZPiAmiRAc8k5g=;
        b=Ig1pb6PnQRgw4wn13Z4YhFqoMBkXBL5BVVuI99QVAF4/hBCkJUFFnNMy2eLff6OWDy
         xAX++dT4PzZbktW/ArM1HOZ1Lw0fTx4ZPZS2v8/UjdzaCOu22tqJImWQXR0wMl/+LUvg
         WyTufUWvLmPzwFPAzLyT+LzoL6U+OHoXr42s+tc1I/SoY9rfMLEUWj7T+qR6B9IhBiDq
         jKXChCODeJFCEEHL1jZCsuJQVeuw4tFzZS+bgnUbyd+HahZKzOERPCoRJcBYMR2zEnPC
         N/6xjru3lBzq7tm32fWVS/+/ndZFndAzWJpIPhVexlj/TNUPCRQ+F7pkmhErVnW5LZed
         TB7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vVY7JiIB;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vVY7JiIB;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx4/DhRUB8P0qUVVGuE9F0zysqb+5lUOJCYL+/+paYsmsBRufEq0eKzEdL5YfgjzOiiYQ6yf65cHbFOy/IeN5y2w=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CADAEsF89WyoBA2vEadOUL6qeEQtGGMm5XFNpXRJh7FpZpJUneQ@mail.gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
 <2654052.UvzeiuBsVA@aspire.rjw.lan> <CAMuHMdXqLmyJF6qhyzgnPeU=T0TyxDpsw1PD8BiYiSXCZeTz=g@mail.gmail.com>
 <CADAEsF89WyoBA2vEadOUL6qeEQtGGMm5XFNpXRJh7FpZpJUneQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Apr 2018 08:46:58 +0200
X-Google-Sender-Auth: l-gvS-udm0f-9WemBIfkqX0Pc74
Message-ID: <CAMuHMdV42sNybiCv7kE+AjKCr1P4Zdw66S1xRxA+d-86nrNQMw@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1596615945124270759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ganesh,

On Mon, Apr 2, 2018 at 3:33 AM, Ganesh Mahendran
<opensource.ganesh@gmail.com> wrote:
> 2018-03-30 19:00 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>> On Fri, Mar 30, 2018 at 12:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Monday, March 5, 2018 9:47:46 AM CEST Ganesh Mahendran wrote:
>>>> single_open() interface requires that the whole output must
>>>> fit into a single buffer. This will lead to timeout when
>>>> system memory is not in a good situation.
>>>>
>>>> This patch use seq_open() to show wakeup stats. This method
>>>> need only one page, so timeout will not be observed.

>>>> --- a/drivers/base/power/wakeup.c
>>>> +++ b/drivers/base/power/wakeup.c
>>>> @@ -1029,32 +1029,77 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>>>       return 0;
>>>>  }
>>>>
>>>> -/**
>>>> - * wakeup_sources_stats_show - Print wakeup sources statistics information.
>>>> - * @m: seq_file to print the statistics into.
>>>> - */
>>>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>>>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>>>> +                                     loff_t *pos)
>>>>  {

>>>> +     list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>>>> +             if (n-- > 0)
>>>> +                     continue;
>>>> +             goto out;
>>>> +     }
>>>> +     ws = NULL;
>>>> +out:
>>>> +     return ws;
>>>> +}
>>>
>>> Please clean up the above at least.
>>>
>>> If I'm not mistaken, you don't need the label and the goto here.
>>
>> The continue is also not needed, if the test condition is inverted.
>
> Hi, Geert
>
> We need to locate to the last read item. What is your suggestion here?

I didn't mean to get rid of that logic, but to reorganize the code to make it
simpler:

        list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
                if (n-- <= 0)
                        return ws;
        }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
