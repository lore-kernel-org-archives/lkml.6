Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F11C04ABA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C682146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nb4NLS4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C682146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeIRQDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:03:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60316 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbeIRQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:03:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8IASsSV072047;
        Tue, 18 Sep 2018 10:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=10bH5/xseMmGseViZTpswYAGjEDXmeBi4i6PAw7UsLc=;
 b=Nb4NLS4zcFavU84myd/gNlqYkQ+V+89wuEz/GXN8+1jBPd6FGk9uEF10+n3PdJOog/7O
 sKZCTIR3DuDqBHQwoMwEV2YDVUkXUUbQlpJFsrof/CaWRjEAHpTCphlCir6r22xLg9mW
 UjIpsEWTRw9u8JyJil1qmc4M0Ko+tCV1sgGwPgrMMwYQzM8An6uiqt2subJVm62iNNPN
 wyIYG/SIVzL6rZOnMPnu+0V0m5Sts4gl4Mmj5pCNddfjUP+CnDFb/tfOy+N4PrNBz27C
 InFr/dreMcBFlCYnFBuvpGRhbfICSmBweiQSVQJSPDdMvyVvnSYQCoMeZDXrhJ4sUWA9 iw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mgsgtkgss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 10:30:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8IAUrlR023975
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 10:30:53 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8IAUq7f005306;
        Tue, 18 Sep 2018 10:30:52 GMT
Received: from [10.191.4.183] (/10.191.4.183)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Sep 2018 03:30:52 -0700
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] x86/speculation: Use AMD specific retpoline for inline
 asm on AMD
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, dwmw@amazon.co.uk,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        bp@suse.de, hpa@zytor.com, dhaval.giani@oracle.com
References: <87411705-893f-46d3-b899-b09ed9fa8d1b@default>
 <20180918095015.GE19234@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <3fcc1453-1618-9a79-71c9-5eede0023775@oracle.com>
Date:   Tue, 18 Sep 2018 18:31:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918095015.GE19234@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 17:50, Peter Zijlstra wrote:
> On Mon, Sep 17, 2018 at 10:17:30PM -0700, Zhenzhong Duan wrote:
>> Lfence is preferred than general retpoline on AMD, add this option
>> in C / inline asm just as the ASM code does.
>>
>> For x86_64, it still help to have minimal retpoline for kernel even
>> if gcc doesn't support it, change the inline asm for x86 so that it
>> could also be used by x86_64.
>> Add ANNOTATE_NOSPEC_ALTERNATIVE for i386 to avoid below warning:
>> "warning: objtool: .altinstr_replacement+0x10: unsupported
>> intra-function call"
>> "warning: objtool: If this is a retpoline, please patch it
>> in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE."
> 
> This Changelog is almost unreadable, please rewrite.
Sorry, I'll rewrite it.

> 
> Reverse engineering the patch you add RETPOLINE_AMD support to the
> inline-asm CALL_NOSPEC so that they match the asm CALL_NOSPEC.
> 
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> ---
>>   arch/x86/include/asm/nospec-branch.h |   23 ++++++++++++++++-------
>>   1 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
>> index fd2a8c1..2d49eab 100644
>> --- a/arch/x86/include/asm/nospec-branch.h
>> +++ b/arch/x86/include/asm/nospec-branch.h
>> @@ -170,21 +170,26 @@
>>    */
>>   # define CALL_NOSPEC						\
>>   	ANNOTATE_NOSPEC_ALTERNATIVE				\
>> -	ALTERNATIVE(						\
>> +	ALTERNATIVE_2(						\
>>   	ANNOTATE_RETPOLINE_SAFE					\
>>   	"call *%[thunk_target]\n",				\
>>   	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
>> -	X86_FEATURE_RETPOLINE)
>> +	X86_FEATURE_RETPOLINE,					\
>> +	"lfence;\n"						\
>> +	ANNOTATE_RETPOLINE_SAFE					\
>> +	"call *%[thunk_target]\n",				\
>> +	X86_FEATURE_RETPOLINE_AMD)
>>   # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
> 
> That's OK.
> 
>>   
>> -#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
>> +#elif defined(CONFIG_RETPOLINE)
> 
> This doesn't make any sense..
This change is used for x86_64 to have minimal Retpoline support when 
CONFIG_RETPOLINE is defined but RETPOLINE isn't defined, or I missed 
something?

> 
>>   /*
>>    * For i386 we use the original ret-equivalent retpoline, because
>>    * otherwise we'll run out of registers. We don't care about CET
>>    * here, anyway.
>>    */
>>   # define CALL_NOSPEC						\
>> -	ALTERNATIVE(						\
>> +	ANNOTATE_NOSPEC_ALTERNATIVE				\
>> +	ALTERNATIVE_2(						\
>>   	ANNOTATE_RETPOLINE_SAFE					\
>>   	"call *%[thunk_target]\n",				\
>>   	"       jmp    904f;\n"					\
>> @@ -194,12 +199,16 @@
>>   	"    	lfence;\n"					\
>>   	"       jmp    902b;\n"					\
>>   	"       .align 16\n"					\
>> -	"903:	addl   $4, %%esp;\n"				\
>> -	"       pushl  %[thunk_target];\n"			\
>> +	"903:	add   $4, %%" _ASM_SP ";\n"			\
>> +	"       push  %[thunk_target];\n"			\
> 
> Yeah, don't do that.
This is the change for above reason.

Thanks
Zhenzhong
