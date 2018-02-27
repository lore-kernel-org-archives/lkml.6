Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeB0XXq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:23:46 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:38661 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbeB0XXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:23:44 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 217.50.39.238) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH RFC v3] auxdisplay: charlcd: Fix and clean up handling of
 x/y commands
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, w@1wt.eu,
        geert@linux-m68k.org, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
References: <20180227220952.57wc3wpc26b2fdyq@gmail.com>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <68c24a6f-3a48-3672-8b16-0b46d880d0e3@robertabel.eu>
Date: Wed, 28 Feb 2018 00:23:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227220952.57wc3wpc26b2fdyq@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20180227232342.5527.82746@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 2018 23:09, Miguel Ojeda wrote:> @@ -469,24 +543,11 @@ static
inline int handle_lcd_special_code(struct charlcd *lcd)
>  	}
>  	case 'x':	/* gotoxy : LxXXX[yYYY]; */
>  	case 'y':	/* gotoxy : LyYYY[xXXX]; */
> -		if (!strchr(esc, ';'))
> -			break;

Might want to keep this. It's in line with all other cases and prevents
calling parse_xy with input that has no chance of being correct due to
missing final ';'.

> +		/* If the command is valid, move to the new address */
> +		if (parse_xy(esc, &priv->addr.x, &priv->addr.y))
> +			charlcd_gotoxy(lcd);

While not in the original code, the inputs are now not clamped to width
and height.
That means for a two-line display ^[[Ly02; will actually end up on line
y = 1, not y = 2 % 2 = 0, because the four-line display logic bumps the
address up.
The same goes for going over lcd->width/lcd->bwidth in the x coordinate.
For four-line displays that ends up going to the line y + 2, because the
buffer is split in the middle.
The distinction between lcd->width and lcd->bwidth depends on whether it
makes sense to put the cursor outside the visible area or not.

Regards,

Robert
