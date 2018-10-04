Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE41C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9490020877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9490020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJDTSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:18:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeJDTSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:18:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 683A48830C;
        Thu,  4 Oct 2018 12:25:31 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD6C84A7;
        Thu,  4 Oct 2018 12:25:30 +0000 (UTC)
Subject: Re: [PATCH v2] kdb: Use strscpy with destination buffer size
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Toppins <jtoppins@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
References: <20180920125914.17920-1-prarit@redhat.com>
 <9192af58-7966-c023-8b19-5b291839a228@linaro.org>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <78793735-c2ce-62f6-d745-5fc06a17beb1@redhat.com>
Date:   Thu, 4 Oct 2018 08:25:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9192af58-7966-c023-8b19-5b291839a228@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 04 Oct 2018 12:25:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2018 11:53 AM, Daniel Thompson wrote:
> On 20/09/2018 13:59, Prarit Bhargava wrote:
>> gcc 8.1.0 warns with:
>>
>> kernel/debug/kdb/kdb_support.c: In function ‘kallsyms_symbol_next’:
>> kernel/debug/kdb/kdb_support.c:239:4: warning: ‘strncpy’ specified bound
>> depends on the length of the source argument [-Wstringop-overflow=]
>>       strncpy(prefix_name, name, strlen(name)+1);
>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/debug/kdb/kdb_support.c:239:31: note: length computed here
>>
>> Use strscpy() with the destination buffer size, and use ellipses when
>> displaying truncated symbols.
>>
>> v2: Use strscpy()
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Jonathan Toppins <jtoppins@redhat.com>
>> Cc: Jason Wessel <jason.wessel@windriver.com>
>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: kgdb-bugreport@lists.sourceforge.net
>> ---
>>   kernel/debug/kdb/kdb_io.c      | 15 +++++++++------
>>   kernel/debug/kdb/kdb_private.h |  2 +-
>>   kernel/debug/kdb/kdb_support.c | 10 +++++-----
>>   3 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
>> index ed5d34925ad0..6a4b41484afe 100644
>> --- a/kernel/debug/kdb/kdb_io.c
>> +++ b/kernel/debug/kdb/kdb_io.c
>> @@ -216,7 +216,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>>       int count;
>>       int i;
>>       int diag, dtab_count;
>> -    int key;
>> +    int key, buf_size, ret;
>>           diag = kdbgetintenv("DTABCOUNT", &dtab_count);
>> @@ -336,9 +336,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
>>           else
>>               p_tmp = tmpbuffer;
>>           len = strlen(p_tmp);
>> -        count = kallsyms_symbol_complete(p_tmp,
>> -                         sizeof(tmpbuffer) -
>> -                         (p_tmp - tmpbuffer));
>> +        buf_size = sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
>> +        count = kallsyms_symbol_complete(p_tmp, buf_size);
>>           if (tab == 2 && count > 0) {
>>               kdb_printf("\n%d symbols are found.", count);
>>               if (count > dtab_count) {
>> @@ -350,9 +349,13 @@ static char *kdb_read(char *buffer, size_t bufsize)
>>               }
>>               kdb_printf("\n");
>>               for (i = 0; i < count; i++) {
>> -                if (WARN_ON(!kallsyms_symbol_next(p_tmp, i)))
>> +                ret = kallsyms_symbol_next(p_tmp, i, buf_size);
>> +                if (WARN_ON(!ret))
>>                       break;
> I'm getting confused by having two different branches on ret.
> 
> Don't get a WARN_ON() when ret == -E2BIG?
> 
> 

Should we WARN on a really long symbol?  I don't think we should as we're
handling that by truncating the output and adding ellipses below.

P.

> Daniel.
> 
> 
>> -                kdb_printf("%s ", p_tmp);
>> +                if (ret != -E2BIG)
>> +                    kdb_printf("%s ", p_tmp);
>> +                else
>> +                    kdb_printf("%s... ", p_tmp);
>>                   *(p_tmp + len) = '\0';
>>               }
>>               if (i >= dtab_count)
