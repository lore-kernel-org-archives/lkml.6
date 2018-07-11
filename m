Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48601C6778A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E57620BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E57620BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbeGKALn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:11:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732262AbeGKALn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:11:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA4B6818F703;
        Wed, 11 Jul 2018 00:10:10 +0000 (UTC)
Received: from [10.10.120.22] (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9EC5111DD02;
        Wed, 11 Jul 2018 00:10:10 +0000 (UTC)
Subject: Re: [PATCH] Check jvmti_agent snprintf return value to avoid build
 failures with GCC-8.1.1
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
References: <20180710182716.21801-1-wcohen@redhat.com>
 <20180710225824.GA11928@krava>
From:   William Cohen <wcohen@redhat.com>
Message-ID: <c738c33d-660d-a57a-2e8c-439f12378b5b@redhat.com>
Date:   Tue, 10 Jul 2018 20:10:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710225824.GA11928@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 00:10:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 00:10:11 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'wcohen@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 06:58 PM, Jiri Olsa wrote:
> On Tue, Jul 10, 2018 at 02:27:16PM -0400, William Cohen wrote:
>> Newer versions of GCC perform static analysis to determine whether
>> string truncation is possible with functions such as snprintf and
>> provide a warning if truncation could occur.  The make for
>> jvmti_agent.c uses the compiler option that treats any compiler
>> warnings as compiler errors.  For GCC-8.1.1 in Fedora 28 this causes
>> the build to fail.  The return value of the snprint is now checked to
>> ensure snprintf produced a NULL-terminated string.  If the string for
>> the path is invalid, the code does attempt to use the string.
> 
> hi,
> I posted fix for this recently:
>   https://lore.kernel.org/lkml/20180702134202.17745-1-jolsa@kernel.org/
> 
> it also covers the perf_regs.c, which was failing with gcc8 for me
> 
> should be pulled in soon
> 
> thanks,
> jirka

Hi Jirka,

Thanks.  I hadn't seen the patch, and this failing to build for the past week has been bugging me.  Glad to hear there is already a fix queued up.

-Will
> 
>>
>> Signed-off-by: William Cohen <wcohen@redhat.com>
>> ---
>>  tools/perf/jvmti/jvmti_agent.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
>> index 0c6d1002b524..30f14eafe4b3 100644
>> --- a/tools/perf/jvmti/jvmti_agent.c
>> +++ b/tools/perf/jvmti/jvmti_agent.c
>> @@ -227,7 +227,7 @@ void *jvmti_open(void)
>>  {
>>  	char dump_path[PATH_MAX];
>>  	struct jitheader header;
>> -	int fd;
>> +	int retlen, fd;
>>  	FILE *fp;
>>  
>>  	init_arch_timestamp();
>> @@ -249,7 +249,10 @@ void *jvmti_open(void)
>>  	/*
>>  	 * jitdump file name
>>  	 */
>> -	snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
>> +	retlen = snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump",
>> +			  jit_path, getpid());
>> +	if (retlen <= 0 || ((int) sizeof(dump_path)) <= retlen)
>> +		return NULL;
>>  
>>  	fd = open(dump_path, O_CREAT|O_TRUNC|O_RDWR, 0666);
>>  	if (fd == -1)
>> -- 
>> 2.17.1
>>

