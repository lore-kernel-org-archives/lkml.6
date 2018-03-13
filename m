Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeCMS37 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:29:59 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56070 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751529AbeCMS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:29:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SzNS-Fx_1520965782;
Subject: Re: [PATCH] debugobjects: avoid another unused variable warning.
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20180313131857.158876-1-arnd@arndb.de>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <eb7b1ad3-2252-c788-ef85-4bbfab82b39a@linux.alibaba.com>
Date: Tue, 13 Mar 2018 11:29:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180313131857.158876-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/18 6:18 AM, Arnd Bergmann wrote:
> debug_objects_maxchecked is only updated in __debug_check_no_obj_freed(),
> and only read in debug_objects_maxchecked, unfortunately both of
> these are optional and depend on different Kconfig symbols. When both
> CONFIG_DEBUG_OBJECTS_FREE and CONFIG_DEBUG_FS are disabled, we get
> this warning:
>
> lib/debugobjects.c:56:14: error: 'debug_objects_maxchecked' defined but not used [-Werror=unused-variable]
>
> Rather than trying to add more complex #ifdef protections, this marks
> the variable as __maybe_unused so it can be silently dropped when
> usused.

Thanks for catching this.

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> Fixes: bd9dcd046509 ("debugobjects: Export max loops counter")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   lib/debugobjects.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 105ecfc47d8c..994be4805cec 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -53,7 +53,7 @@ static int			obj_nr_tofree;
>   static struct kmem_cache	*obj_cache;
>   
>   static int			debug_objects_maxchain __read_mostly;
> -static int			debug_objects_maxchecked __read_mostly;
> +static int __maybe_unused	debug_objects_maxchecked __read_mostly;
>   static int			debug_objects_fixups __read_mostly;
>   static int			debug_objects_warnings __read_mostly;
>   static int			debug_objects_enabled __read_mostly
