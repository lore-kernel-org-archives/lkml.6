Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeDXQKU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:10:20 -0400
Received: from thoth.sbs.de ([192.35.17.2]:52275 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeDXQKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:10:19 -0400
Subject: Re: [PATCH] kmemleak: Report if we need to tune
 KMEMLEAK_EARLY_LOG_SIZE
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <288b0afc-bcc3-a2aa-2791-707e625d1da7@siemens.com>
 <20180424155504.frbxmzq4dw3veudu@armageddon.cambridge.arm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Openpgp: preference=signencrypt
Message-ID: <c248c83e-e9c1-6b4d-050e-9aa30cd14669@siemens.com>
Date: Tue, 24 Apr 2018 18:10:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180424155504.frbxmzq4dw3veudu@armageddon.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 17:55, Catalin Marinas wrote:
> On Tue, Apr 24, 2018 at 05:51:15PM +0200, Jan Kiszka wrote:
>> ...rather than just mysteriously disabling it.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  mm/kmemleak.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 9a085d525bbc..156c0c69cc5c 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -863,6 +863,7 @@ static void __init log_early(int op_type, const void *ptr, size_t size,
>>  
>>  	if (crt_early_log >= ARRAY_SIZE(early_log)) {
>>  		crt_early_log++;
>> +		pr_warn("Too many early logs\n");
> 
> That's already printed, though later where we have an idea of how big the early
> log needs to be:
> 
> 	if (crt_early_log > ARRAY_SIZE(early_log))
> 		pr_warn("Early log buffer exceeded (%d), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE\n",
> 			crt_early_log);
> 

Well, that's good, but where you read "detector disabled", there is no
hint on that. I missed that because subsystems tend to not do any
further actions after telling they are off.

BTW, my system (virtual ARM64 target) required 26035 entries, which is a
few orders of magnitude above the default and pretty close the the
limit. What's causing this? Other debug options?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
