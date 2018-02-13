Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933090AbeBMBTj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:19:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56469 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932736AbeBMBTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:19:37 -0500
Subject: Re: [PATCH V2] auxdisplay: use correct string length
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>
References: <1516095490-83827-1-git-send-email-wangxiongfeng2@huawei.com>
 <CANiq72=AeytaT5KBtujTBUkfbNTFFxMPAeToqzmZJOr790R6yw@mail.gmail.com>
CC: Dan <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <a1034df8-246d-e979-e2ee-2974ae31dde7@huawei.com>
Date: Tue, 13 Feb 2018 09:19:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CANiq72=AeytaT5KBtujTBUkfbNTFFxMPAeToqzmZJOr790R6yw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.32.209]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/2/12 20:53, Miguel Ojeda wrote:
> On Tue, Jan 16, 2018 at 10:38 AM, Xiongfeng Wang
> <wangxiongfeng2@huawei.com> wrote:
>> From: Xiongfeng Wang <xiongfeng.wang@linaro.org>
>>
>> gcc-8 reports
>>
>> drivers/auxdisplay/panel.c: In function 'panel_attach':
>> ./include/linux/string.h:245:9: warning: '__builtin_strncpy' specified
>> bound 12 equals destination size [-Wstringop-truncation]
>>
>> We need one less byte or call strlcpy() to make it a nul-terminated
>> string.
>>
>> Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
>> ---
>>  drivers/auxdisplay/panel.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
>> index ea7869c..d288900 100644
>> --- a/drivers/auxdisplay/panel.c
>> +++ b/drivers/auxdisplay/panel.c
>> @@ -1506,10 +1506,10 @@ static struct logical_input *panel_bind_key(const char *name, const char *press,
>>         key->rise_time = 1;
>>         key->fall_time = 1;
>>
>> -       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
>> -       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
>> +       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str) - 1);
>> +       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str) - 1);
>>         strncpy(key->u.kbd.release_str, release,
>> -               sizeof(key->u.kbd.release_str));
>> +               sizeof(key->u.kbd.release_str) - 1);
> 
> Are you sure about this patch? `kbd` says "strings can be non null-terminated".
> 
> Willy, maybe those should just be memcpy()s? (unless the remaining
> bytes, if any, must be 0).
Sorry, my apologies. I think I made a mistake. I meant to use strlcpy(), but this
also decrease the destination storage size by one.
I think, if the strings can be non null-terminated,  we can just use memcpy().
This may suppress the gcc warning.

Thanks,
Xiongfeng

> 
> Thanks,
> Miguel
> 
>>         list_add(&key->list, &logical_inputs);
>>         return key;
>>  }
>> --
>> 1.8.3.1
>>
> 
> .
> 
