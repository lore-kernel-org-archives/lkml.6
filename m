Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeDLBaz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:30:55 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37662 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeDLBax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:30:53 -0400
X-Google-Smtp-Source: AIpwx4/wGgVPYr78q4V8gnqyBb9OWsM5GqQXi2e6l4NrcOtjo2MS+YVKxZlC0Mewe+P7NvGH6i/d/Q==
Subject: Re: [PATCH v2] dec: tulip: de4x5: Replace mdelay with usleep_range in
 de4x5_hw_init
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        davem@davemloft.net, stephen@networkplumber.org,
        johannes.berg@intel.com, arvind.yadav.cs@gmail.com,
        dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523461182-5897-1-git-send-email-baijiaju1990@gmail.com>
 <1523463379.3221.18.camel@HansenPartnership.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <8bac3385-97c6-fff1-17c6-11f5e98a039a@gmail.com>
Date: Thu, 12 Apr 2018 09:30:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1523463379.3221.18.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/12 0:16, James Bottomley wrote:
> On Wed, 2018-04-11 at 23:39 +0800, Jia-Ju Bai wrote:
>> de4x5_hw_init() is never called in atomic context.
>>
>> de4x5_hw_init() is only called by de4x5_pci_probe(), which is only
>> set as ".probe" in struct pci_driver.
>>
>> Despite never getting called from atomic context, de4x5_hw_init()
>> calls mdelay() to busily wait. This is not necessary and can be
>> replaced with usleep_range() to  avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
> Did you actually test this?  The usual reason for wanting m/udelay is
> that the timing must be exact.  The driver is filled with mdelay()s for
> this reason.  The one you've picked on is in the init path so it won't
> affect the runtime in any way.  I also don't think we have the hrtimer
> machinery for usleep_range() to work properly on parisc, so I don't
> think the replacement works.
>
> James
>

Hello, James.
Thanks for your reply :)

I agree that usleep_range() here will not much affect the real execution 
of this driver.

But I think usleep_range() can more opportunity for other threads to use 
the CPU core to schedule during waiting.
That is why I detect mdelay() that can be replaced with msleep() or 
usleep_range().


Best wishes,
Jia-Ju Bai
