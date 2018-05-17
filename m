Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEQDnv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 23:43:51 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38787 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeEQDnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 23:43:49 -0400
X-Google-Smtp-Source: AB8JxZrSGlaZFcAwLfZNO7ycO70sBUzYwO2Zwr6Q3I+f3IEGfklaDonspJ14OWrwmpxZMBnsj5k2oPCiO1oqfF5nX7I=
MIME-Version: 1.0
In-Reply-To: <20180516135500.GE3254@piout.net>
References: <20180420161433.3721192-1-arnd@arndb.de> <20180516135500.GE3254@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 May 2018 23:43:48 -0400
X-Google-Sender-Auth: PcjnyaZ0KNrDmcDtcYXihk6pxEc
Message-ID: <CAK8P3a0JG10ABKBV1XWWOaZJOZz7zR-0TDmPXtdZ1-JNzP5OkA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: vr41xx: remove mktime usage
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        y2038 Mailman List <y2038@lists.linaro.org>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 9:55 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Hi,
>
> On 20/04/2018 18:14:24+0200, Arnd Bergmann wrote:
>> This driver uses mktime() and rtc_time_to_tm() to convert between time
>> values. This works fine on 64-bit kernels over the whole supported
>> range, and the vr41xx chip is a 64-bit MIPS implementation, but it is
>> inconsistent because it doesn't do the same thing on 32-bit kernels that
>> overflow in 2106 or 2038.
>>
>> Changing it to use mktime64/rtc_time64_to_tm() should have no visible
>> impact on vr41xx but gets us closer to removing the 32-bit interfaces.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/rtc/rtc-vr41xx.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>
> I've applied the series a while ago.

Thanks! We should be able to remove mktime() in the near future then,
along with some other interfaces from linux/time32.h and linux/timekeeping32.h.

> It should be noted that mktime64
> will fail on 32bit platforms in year 21000 or so but I pretty sure it is
> not worth fixing. My understanding is that the kernel will fail in April
> 2262 anyway as ktime_t will overflow.

Right.

> Note that I will be following up with multiple series adding proper
> rtc HW range, removing set_mmss and rtc_time_to_tm/rtc_tm_to_time64.

Ok, looking forward to those patches!

        Arnd
