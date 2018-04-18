Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDRNsf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:48:35 -0400
Received: from m15-29.126.com ([220.181.15.29]:25075 "EHLO m15-29.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbeDRNsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:48:33 -0400
X-Originating-IP: [182.150.161.194]
Date: Wed, 18 Apr 2018 21:48:22 +0800 (CST)
From: liuxiang <liuxiang_1999@126.com>
To: "David Miller" <davem@davemloft.net>
Cc: liu.xiang6@zte.com.cn, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v3] net: davicom: dm9000: Avoid spinlock recursion
 during dm9000_timeout routine
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
In-Reply-To: <20180416.110501.92472500114183248.davem@davemloft.net>
References: <1523695834-6261-1-git-send-email-liu.xiang6@zte.com.cn>
 <20180416.110501.92472500114183248.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <72770aae.bb31.162d9036874.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HcqowAA36pCnTNdanSTRAA--.36559W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiuwcssFpD5JAIeAAAs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3IDme5o004106


Hi,
Because the timeout task gets the main spinlock and disable the current cpu's irq, 
there is no other task on the same cpu can run, and tasks on the other cpus can not
enter the dm9000_timeout() again. So in the whole dm9000_timeout() routine, 
db->timeout_cpu can not be changed by other tasks. Although smp_processor_id() may change 
after preempt_enable(), these tasks always get the false result when call dm9000_current_in_timeout.
Only the timeout task get the true result. And if there is no timeout, all the tasks that want to 
do asynchronous phy operation get the false result. So I think this can avoid racy.


At 2018-04-16 23:05:01, "David Miller" <davem@davemloft.net> wrote:
>From: Liu Xiang <liu.xiang6@zte.com.cn>
>Date: Sat, 14 Apr 2018 16:50:34 +0800
>
>> +static bool dm9000_current_in_timeout(struct board_info *db)
>> +{
>> +	bool ret = false;
>> +
>> +	preempt_disable();
>> +	ret = (db->timeout_cpu == smp_processor_id());
>> +	preempt_enable();
>
>This doesn't work.
>
>As soon as you do preempt_enable(), smp_processor_id() can change.
