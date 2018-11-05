Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A13320825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A13320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeKETeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:34:44 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:56050 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeKETen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:34:43 -0500
X-Greylist: delayed 947 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2018 14:34:41 EST
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id wA59xoCH016436
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 10:59:50 +0100
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id wA59xoCr023185;
        Mon, 5 Nov 2018 10:59:50 +0100
Subject: Re: [PATCH v3] scripts/gdb: fix lx-version
To:     kieran.bingham@ideasonboard.com,
        Du Changbin <changbin.du@gmail.com>, kbingham@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Griffin <peter.griffin@linaro.org>
References: <20181017142442.7818-1-changbin.du@gmail.com>
 <6a1ec497-acd7-cd4d-4541-5960e03d955c@ideasonboard.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45fb570d-3703-7ed5-c831-5613fe85ba66@siemens.com>
Date:   Mon, 5 Nov 2018 10:59:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <6a1ec497-acd7-cd4d-4541-5960e03d955c@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.18 10:54, Kieran Bingham wrote:
> Hi Du,
> 
> Thank you for the updated patch,
> 
> On 17/10/2018 15:24, Du Changbin wrote:
>> For current gdb version (has tested with 7.3 and 8.1), 'lx-version'
>> only prints one character.
>> (gdb) lx-version
>> L(gdb)
>>
>> This can be fixed by casting 'linux_banner' as (char *).
>> (gdb) lx-version
>> Linux version 4.19.0-rc1+ (changbin@acer) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #21 SMP Sat Sep 1 21:43:30 CST 2018
>>
>> Signed-off-by: Du Changbin <changbin.du@gmail.com>
> 
> I'll update the upstream GDB bugzilla [0] regarding this issue - but I
> think we need a workaround here, and this is it.
> 
> Fixes: 2d061d999424 ("scripts/gdb: add version command")
> Reviewed-by: Kieran Bingham <kbingham@kernel.org>
> 
> And for reference, this already has an early LGTM from Jan as well.
> 
> [0] https://sourceware.org/bugzilla/show_bug.cgi?id=20077
> 

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

>> ---
>>   scripts/gdb/linux/proc.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
>> index 086d27223c0c..0aebd7565b03 100644
>> --- a/scripts/gdb/linux/proc.py
>> +++ b/scripts/gdb/linux/proc.py
>> @@ -41,7 +41,7 @@ class LxVersion(gdb.Command):
>>   
>>       def invoke(self, arg, from_tty):
>>           # linux_banner should contain a newline
>> -        gdb.write(gdb.parse_and_eval("linux_banner").string())
>> +        gdb.write(gdb.parse_and_eval("(char *)linux_banner").string())
>>   
>>   LxVersion()
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
