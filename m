Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936020AbeCHR1b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:27:31 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.94]:11684 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935740AbeCHR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:27:29 -0500
Subject: Re: [PATCH] video: fbdev: via_aux_vt1632: remove VLA usage
To: Emil Velikov <emil.l.velikov@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <20180307195415.GA666@embeddedgus>
 <CACvgo5055A0yVCY4vFp1zN+gW0XVu+DbrmrL4dEXoR7PqDXFmA@mail.gmail.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <469f6c0d-186e-aaf7-469f-3d5b416b2b3f@embeddedor.com>
Date: Thu, 8 Mar 2018 11:27:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACvgo5055A0yVCY4vFp1zN+gW0XVu+DbrmrL4dEXoR7PqDXFmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1etzKA-0020Xd-IB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:52988
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

On 03/08/2018 05:58 AM, Emil Velikov wrote:
> Hi Gustavo,
> 
> On 7 March 2018 at 19:54, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with a fixed-length array instead. Also, remove variable 'len'.
>>
> What is the reason behind adding -Wvla? Is there a thread some that I
> can read up on?
> 

Sure. This is the thread: https://lkml.org/lkml/2018/3/7/621

>> Notice that no new IDs have been added in seven years.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/video/fbdev/via/via_aux_vt1632.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/via/via_aux_vt1632.c b/drivers/video/fbdev/via/via_aux_vt1632.c
>> index d24f4cd..0cd0d2a 100644
>> --- a/drivers/video/fbdev/via/via_aux_vt1632.c
>> +++ b/drivers/video/fbdev/via/via_aux_vt1632.c
>> @@ -35,10 +35,10 @@ static void probe(struct via_aux_bus *bus, u8 addr)
>>                  .addr   =       addr,
>>                  .name   =       name};
>>          /* check vendor id and device id */
>> -       const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
>> -       u8 tmp[len];
>> +       const u8 id[4] = {0x06, 0x11, 0x92, 0x31};
>> +       u8 tmp[4];
>>
>> -       if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
>> +       if (!via_aux_read(&drv, 0x00, tmp, 4) || memcmp(id, tmp, 4))
> 
> Generally, hard coding a bunch of numbers like that makes for
> confusing and fragile code.
> 

You are correct.

> A lot simpler and more obvious solution is like the following.
> It silences the compiler warning (-Wvla - pedantic) you while keeping
> the original clarity.
> 
>          const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
> -       u8 tmp[len];
> +       u8 tmp[ARRAY_SIZE(id)]; // Using len causes a Wvla warning
> 

Yeah, this works just fine.

There are a total of four instances of this same issue in other files 
for the VIA component. I'll fix them and send a single patch shortly.

Thanks for the feedback.
I appreciate it.
--
Gustavo
