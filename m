Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbeBZXAq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:00:46 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:41109 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeBZXAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:00:45 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.26.24) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        eldad@fogrefinery.com, me@tobin.cc, corbet@lwn.net,
        pantelis.antoniou@konsulko.com
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
 <CAHp75Vcrx2rLDsJduWx75Wa57yTRqtQ1dqZMkCGv64K0bOYLiQ@mail.gmail.com>
 <CANiq72m6fDBAg9b5XdYxAtM8gHuCS7bTtJnFSLJ7=GyvSZAhHA@mail.gmail.com>
 <CAHp75Ve+idUc_HFyBAmGYRSJKDM=hrtNXxqSGBY2+FBqkhrp5Q@mail.gmail.com>
 <CANiq72k-bztnMoDR6D_n-ZnK2mFmpUOvNn1ttpPFq=suxrYPig@mail.gmail.com>
From: Robert Abel <rabel@robertabel.eu>
Message-ID: <1b66ecb1-5951-35f3-3dd2-4448628d3fbc@robertabel.eu>
Date: Tue, 27 Feb 2018 00:00:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANiq72k-bztnMoDR6D_n-ZnK2mFmpUOvNn1ttpPFq=suxrYPig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20180226230044.11896.51608@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @ll,

this is a discussion stemming from drivers/auxdisplay about the usage
and possible deprecation of simple_strto* set of functions found in
lib/vsprintf.
I cc'ed everybody who signed off and also everybody who
signed/authored/added/removed more than 20% of lib/vsprintf.

This has come up, because some auxdisplay functionality was broken by a
well-intentioned patch to switch from simple_strtoul to kstrtoul in
129957069e6af42a6e021d90679c56662c95f7e1
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=129957069e6af42a6e021d90679c56662c95f7e1)
and now there is discussion about whether the simple_strto* functions
are really obsolete.

On 26 Feb 2018 18:26, Miguel Ojeda wrote:
> On Mon, Feb 26, 2018 at 6:09 PM, Andy Shevchenko wrote:
>> On Mon, Feb 26, 2018 at 6:54 PM, Miguel Ojeda wrote:
>>> On Mon, Feb 26, 2018 at 12:44 PM, Andy Shevchenko wrote:
>>>> Perhaps instead of dancing around kstrtox() better to switch to
>>>> simple_strtoul() ?
>>>
>>> It seems deprecated:
>>>
>>> /* Obsolete, do not use.  Use kstrto<foo> instead */
>>> extern unsigned long simple_strtoul(const char *,char **,unsigned int);
>>
>> It has been discussed several times. The comment is simple wrong.
>>
>> Because of the requirement of kstrtox() to have a \0 or \n followed by
>> \0 as "end of field".
>> simple_strto*() is suitable to be run in place.
> 
> I agree that in-place versions of these kind of string functions are
> very useful, don't get me wrong! But unless someone changes the
> "official" comment, we shouldn't add new code relying on them.

So can we get clarity in form of a patch here, or not?
I'm hesitant to move back to simple_kstroul, because to me it seems that
general consensus (at least when the comment was put there) was to
remove it:

> commit 462e471107624fe9bd8b6353ac13e06305c3f3fd
> Author: Eldad Zack <>
> Date:   Mon Dec 17 16:03:05 2012 -0800
> 
>     simple_strto*: annotate function as obsolete
> 
>     Update the documentation for simple_strto* to reflect that it has been
>     obsoleted and advise the usage of kstrto*.
> 
>     Signed-off-by: Eldad Zack <>
>     Cc: J. Bruce Fields <>
>     Cc: Joe Perches <>
>     Cc: Randy Dunlap <>
>     Cc: Alexey Dobriyan <>
>     Cc: Rob Landley <>
>     Signed-off-by: Andrew Morton <>
>     Signed-off-by: Linus Torvalds <>

One big advantage simple_kstro* functions have over their kstrto*
cousins is that strings don't need to be null-terminated. Instead, they
will be parsed as far as they can be and a pointer to the end of the
respective number will be returned.

Regards,

Robert
