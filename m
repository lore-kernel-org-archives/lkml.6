Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeCDPIr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 10:08:47 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38266 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751989AbeCDPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 10:08:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=qixuan.wu@linux.alibaba.com;NM=1;PH=DW;RN=9;SR=0;TI=W4_5166270_DEFAULT_0AC264B0_1520174018960_o7001c1422;
Date: Sun, 04 Mar 2018 23:08:23 +0800
From: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>
To: "linux-kernel-owner" <linux-kernel-owner@vger.kernel.org>
Cc: "Petr Mladek" <pmladek@suse.com>, "Jan Kara" <jack@suse.cz>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        "caijingxian" <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Reply-To: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>
Message-ID: <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFdvdWxkIHlvdSBoZWxwIHRvIHRlbGwgd2h5IGFzeW5jIHByaW50ayBzb2x1dGlvbiB3?=
  =?UTF-8?B?YXMgbm90IHRha2VuIHRvIHVwc3RyZWFtIGtlcm5lbCA/?=
X-Mailer: [Alimail-Mailagent revision 948139][W4_5166270][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>,<20180304130151.GA483@tigerII.localdomain>
In-Reply-To: <20180304130151.GA483@tigerII.localdomain>
x-aliyun-mail-creator: W4_5166270_DEFAULT_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTNfMCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzY0LjAuMzI4Mi4xNjcgU2FmYXJpLzUzNy4zNg==vN
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w24F8qAE020267

Hi Sergey, 

Thank you for your fast reply. 
 
On (03/04/18 21:02), Sergey Senozhatsky wrote:

> On (03/04/18 20:10), Qixuan.Wu wrote:
>>    Hi Sergey, petr, and Jan,
>>      I find you wrote a patch set of "[PATCH v12 0/3] printk: Make printk()
>>    completely async"(https://lkml.org/lkml/2016/5/13/275), and many people
>>    have reviewd. But I did not see them be taken to upstream kernel. Would
>>    you please help to tell me the reason ? Is it just only because of the
>>    LOG_CONT scenario (4th patch) ?
> 
> Hello,
> 
>   Thanks for your email, we desperately need more feedback from
>  people who are facing printk() related issues. While, certainly, I'm not
>  happy to hear that printk() causes troubles on your side.

>   Regarding the async printk patch set. It's still "work in
>  progress", and probably will take some time (due to various reasons,
>  LOG_CONT is not one of them).

It's fine. People know the prink is important and used in the kernel at many 
many place, and it's difficult to cover all the scenario, so it's predictable there 
are some places to be improved. 
For async printk patch set, would you help to know when they can be finished.
I think it should be very useful to avoid softlockup or RCU stall.  

>   Yes. 4.16 has Steven's patch which tweaks printk() in a very smart
>  way and addresses some of the issues printk() has. If you can't test 4.16
>  (quite possible), then the commits you'd want to take a look at are
> (Linus's tree):
>  dbdda842fe96f89  printk: Add console owner and waiter logic to load balance console writes
>  c162d5b4338d72d  printk: Hide console waiter logic into helpers
>  fd5f7cde1b85d4c  printk: Never set console_may_schedule in console_trylock()
>  c14376de3a1befa  printk: Wake klogd when passing console_lock owner

Thank you for your suggested solution wrote by Steven. I looked through it, the 
thought is good. I think it can mitigate 99.999% the softlockup problem in the 
scenario.  But I have a comment for it, actually maybe it's not correct. 

Suppose there is one scenario that the system has 100 CPU(0~99). While CPU 0 is 
calling slow console, CPU 1~99 are calling printk at the same time. And suppose 
CPU 1 will be waiter, as per the patch, 2~99 will return directly. After CPU 0 finish 
it's log to console, it will return when it finds CPU 1 are waiting. Then CPU 1 need 
flush all logs of CPU(1~99) to the console, which may cause  softlockup or rcu 
stall. Above scenario is very unusual and it's very unlikely to happen. 

> If you can backport those, test and tell us about your experience - would be
> great and very much appreciated.

Anyway the code in 4.16 is also very useful to the problem. We will think over to 
try to backport. If any other problem occur, will inform you again. 

Thanks & Regards
Qixuan
