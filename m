Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753523AbeDSPrw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:47:52 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.85]:48028 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753475AbeDSPrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:47:18 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] mmc: sdhci-cadence: fix logically and structurally dead
 code
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180419135316.GA14790@embeddedor.com>
 <CAK7LNATQSOtJs6xcYXyRqXdAL-x-CBLVmfAozEEZGnZpzURR8g@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <35a4de52-a6c9-d65c-6446-b86044287db0@embeddedor.com>
Date: Thu, 19 Apr 2018 10:47:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATQSOtJs6xcYXyRqXdAL-x-CBLVmfAozEEZGnZpzURR8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.6.211
X-Source-L: No
X-Exim-ID: 1f9BmH-003HVt-6h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.175.6.211]:50926
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got it.

I'll send v2 shortly.

Thanks for the feedback, Masahiro.

--
Gustavo

On 04/19/2018 10:42 AM, Masahiro Yamada wrote:
> Hi.
> 
> 
> 2018-04-19 22:53 GMT+09:00 Gustavo A. R. Silva <gustavo@embeddedor.com>:
>> Currently, the code block inside the for loop will never execute
>> more than once, because the function returns inmediately after
>> the first iteration, hence the execution of the code at the second
>> iteration is structurally dead and, code at line 281: return 0; is
>> never reached.
>>
>> Based on the code comments, it seems that the actual intention is
>> to execute the code inside the for loop twice instead of once.
> 
> Thanks for the report.
> 
>> So, fix this issue by removing the return statement inside the for
>> loop and replace the "return 0" with "return ret".
>>
>> Addresses-Coverity-ID: 1468009 ("Logically dead code")
>> Addresses-Coverity-ID: 1468002 ("Structurally dead code")
>> Fixes: 213fae74318b ("mmc: sdhci-cadence: send tune request twice to
>> work around errata")
> 
> 
> Probably, this Fixes tag will dangle.
> 
> Ulf usually repeats git-rebase to build-up his pull-request.
> 
> The addressed commit was already rebased,
> and its commit ID will change a few more times
> since it is now -rc1.
> 
> 
> A clean solution would be, to squash a fix-up into the original patch.
> (This patch is not what I want, though.)
> 
> If you want to claim contribution in a separate patch,
> please rewrite the code as I suggested,
> and drop the Fixes tag.
> 
> 
> 
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/mmc/host/sdhci-cadence.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
>> index bc30d16..facbad8 100644
>> --- a/drivers/mmc/host/sdhci-cadence.c
>> +++ b/drivers/mmc/host/sdhci-cadence.c
>> @@ -275,10 +275,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>>                                           !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
>>                                           0, 1);
>>
>> -               return ret;
>>          }
>>
>> -       return 0;
>> +       return ret;
>>   }
>>
>>   static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> --
> 
> No.
> I want to confirm that the operation succeeds twice.
> 
> Your code hides any error in the first loop.
> 
> 
> 
> My intention is like follows:
> 
> 
> 
>   --- a/drivers/mmc/host/sdhci-cadence.c
>   +++ b/drivers/mmc/host/sdhci-cadence.c
>   @@ -275,10 +275,9 @@ static int sdhci_cdns_set_tune_val(struct
> sdhci_host *host, unsigned int val)
>                                            !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
>                                            0, 1);
>   -
>   -               return ret;
>   +               if (ret)
>   +                       return ret;
>           }
> 
>           return 0;
>    }
> 
>    static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
> 
> 
> 
