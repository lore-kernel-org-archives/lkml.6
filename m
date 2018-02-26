Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBZW3T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:29:19 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:41401 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeBZW3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:29:18 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.26.24) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Andy Shevchenko <andy.shevchenko@gmail.com>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
 <CAMuHMdW4i0-22zakETxEaio9rvVNuvvbQEwwehBfze=jeQLnHQ@mail.gmail.com>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <7fb01791-929a-540c-1ad7-395d38d2e419@robertabel.eu>
Date: Mon, 26 Feb 2018 23:29:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW4i0-22zakETxEaio9rvVNuvvbQEwwehBfze=jeQLnHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <20180226222916.8286.4909@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 26 Feb 2018 09:46, Geert Uytterhoeven wrote:
>> +
>> +               nxt_cmd = *esc++;
>> +               nxt_esc = esc;
>> +
>> +               while ('\0' != *esc) {
>> +
>> +                       cmd = nxt_cmd;
>> +                       esc = nxt_esc;
>> +                       nxt_esc = strpbrk(esc, "xy;");
>> +                       if (NULL != nxt_esc) {
>> +                               nxt_cmd = *nxt_esc;
>> +                               /* terminate current sequence with NUL */
>> +                               *nxt_esc++ = '\0';
>> +                       }
> 
> So if none of "x", "y", or ";" is found, nxt_cmd will still contain
> the current command?
> Shouldn't it be reset to '\0' or so?

I originally had a comment there, but it then felt kinda silly.
Since one of the conditions of the code is that a semicolon ';' is
detected at the end of the stream, the situation you describe never
occurs until the end of the command string.

nxt_esc == NULL only when cmd == ';' and *esc == NULL. Since there is
nothing to terminate and the code won't run again (due to while (*esc)),
I didn't reset nxt_cmd. Other than that, I also don't know that there is
a sensible reset value.

Regards,

Robert
