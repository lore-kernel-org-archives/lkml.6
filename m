Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeB0X3l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:29:41 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:57697 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeB0X3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:29:40 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 217.50.39.238) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Willy Tarreau <w@1wt.eu>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
 <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
 <50a2fd51-8bdb-d2b7-c2b3-7df638fdedde@robertabel.eu>
 <20180227051905.GA26781@1wt.eu>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <911beeb5-529f-09bb-0e5a-c5b626adba60@robertabel.eu>
Date: Wed, 28 Feb 2018 00:29:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227051905.GA26781@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20180227232939.5785.60843@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On 27 Feb 2018 06:19, Willy Tarreau wrote:
> Well actually I don't see a problem there at all. The principle is simply
> to accept any sequence assigning x or y or both. If you write x4y2x6, it
> simply means that you changed your mind regarding x and that the last
> value (6) is the one you want. Just as if you wrote "^[[Lx4;^[[y2;^[[x6;".
> The while loop doesn't even try to do anything clever, it simply parses
> everything matching x and y followed by digits. I think the only reason
> for having both x and y processed in the same loop was to call
> charlcd_gotoxy() only once for both axes.

I didn't say it is a problem. It is however an edge case that incurs a
lot of code for little to no functionality.
I'd much prefer if we broke backwards compatibility here and actually
only parse the format that is indicated in the comment:

>         case 'x':       /* gotoxy : LxXXX[yYYY]; */
>         case 'y':       /* gotoxy : LyYYY[xXXX]; */
>  

Exactly one x command followed exactly by zero or one y command or
vice-versa.

If somebody changes their mind during the escape sequence, they can just
issue a new one instead of appending to the current one.

I'll post an example patch.

Regards,

Robert
