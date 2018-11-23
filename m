Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4E20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA4E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504556AbeKXAJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:09:30 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:29339 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390938AbeKXAJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:09:30 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wANDP6Qj091173;
        Fri, 23 Nov 2018 22:25:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Fri, 23 Nov 2018 22:25:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wANDP5v3091167
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 23 Nov 2018 22:25:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Make printk_emit() local function.
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <1542898768-5732-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181123122405.3iqc6bvdxkngntzl@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d2dd8a02-4e1d-7e9b-4639-fe3a640a2742@i-love.sakura.ne.jp>
Date:   Fri, 23 Nov 2018 22:25:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181123122405.3iqc6bvdxkngntzl@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/23 21:24, Petr Mladek wrote:
> On Thu 2018-11-22 23:59:28, Tetsuo Handa wrote:
>> printk_emit() is called from only devkmsg_write() in the same file.
>> Save object size by making it a local function.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>  include/linux/printk.h |  5 -----
>>  kernel/printk/printk.c | 31 +++++++++++++++----------------
>>  2 files changed, 15 insertions(+), 21 deletions(-)
>>
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -752,6 +752,20 @@ struct devkmsg_user {
>>  	char buf[CONSOLE_EXT_LOG_MAX];
>>  };
>>  
>> +static __printf(3, 4) __cold int devkmsg_emit(int facility, int level,
>> +					      const char *fmt, ...);
> 
> There is no need for the forward declaration. __printf(3, 4)
> and __cold could be part of the function definition.
> Or do I miss anything?

If you meant below one, it fails with "error: expected ',' or ';' before '{' token".
Attributes annotation needs to be done as the prototype definition.
(Though I don't know whether __cold here makes sense...)

static int devkmsg_emit(int facility, int level, const char *fmt, ...)
__printf(3, 4) __cold
{
        va_list args;
        int r;

        va_start(args, fmt);
        r = vprintk_emit(facility, level, NULL, 0, fmt, args);
        va_end(args);

        return r;
}
