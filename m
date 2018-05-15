Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeEOUXF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:23:05 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45174 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEOUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:23:03 -0400
X-Google-Smtp-Source: AB8JxZpPs6KNBc+Evqju25hFinj8cjc+JGsifE66zPi+MqS+orToqRdwpU2uGIDoGmreG9pbTVJ/53N+VIXCKzAnQzw=
MIME-Version: 1.0
In-Reply-To: <20180515100304.3daa7929@bbrezillon>
References: <1525920400-11392-1-git-send-email-Jane.Wan@nokia.com>
 <20180510140311.02805561@bbrezillon> <CAHp75VcET7PZYfeRkmiP=n_xCnDzEFYS98ZLjszc1fHjdfDF2A@mail.gmail.com>
 <20180515093525.051856dd@bbrezillon> <CAHp75VevZCGOntYdj_B0T_SOKXFkWKLgyL2+1g2X9nRyhP5w=g@mail.gmail.com>
 <20180515100304.3daa7929@bbrezillon>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 May 2018 23:23:02 +0300
Message-ID: <CAHp75VeEhB=+x0toCtSvrq0zBLXVCASzN2BUDDgNParSYZc5BQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jane Wan <Jane.Wan@nokia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>, ties.bos@nokia.com,
        prabhakar.kushwaha@nxp.com,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        jagdish.gediya@nxp.com, Richard Weinberger <richard@nod.at>,
        Shawn Guo <shawnguo@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 11:03 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 15 May 2018 10:46:00 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Tue, May 15, 2018 at 10:35 AM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Mon, 14 May 2018 20:54:36 +0300
>> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

>> >> >                         for (k = 0; k < nbufs; k++) {
>> >> >                                 const u8 *srcbuf = srcbufs[j];
>> >> >
>> >> >                                 if (srcbuf[i] & BIT(k))
>> >> >                                         m++;
>> >> >                         }
>> >>
>> >> ...which is effectively hweightXX().
>> >
>> > No it's not.
>>
>> I don't see how "not". In the loop everithing except m and k are
>> invariants. What did I miss?
>
> We're not counting the number of bits set in an uXX var, but the number
> of set bits at the same position in different buffers.

...on big picture. The excerpt above is hweight() against srcbuf[i].

Let's rewrite it like this:

                    const u8 *srcbuf = srcbufs[j];

                    for (k = 0; k < nbufs; k++) {
                               if (srcbuf[i] & BIT(k))
                                      m++;
                    }

...and now it looks obvious:

m += hweight...(srcbuf[i])

_If_ nbufs is power of two we may use primitive helper.

-- 
With Best Regards,
Andy Shevchenko
