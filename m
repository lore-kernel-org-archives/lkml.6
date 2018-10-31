Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9C4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5360120838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wTLD8ys8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5360120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeJaO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:57:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:57:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9V5xOsP080705;
        Wed, 31 Oct 2018 06:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gns1bkZk+ljdH1f9lOhhVAH9LtH2qjy8RxTDVDfewqQ=;
 b=wTLD8ys8H3edK4ygnGZINepq2cnwhESZ+wrDsuT+Uo4cguo9iKXybQy3RgZGcXvU296S
 spwrfb5qBwFKN1SqfAE0UjFYQw3WEx1wXjLEa6yY8udX3TQq4LJfUCR4Twd0jj2ODQGQ
 kdhZYSevqytX+uiOpYcBiAy45Tj4CBULAYRQn26E3aPm/ampVZDsI46vaiIYAJZDeIDp
 3YzKEzlhHalF23PvnkIp0BbCH7VZf31lzY++wxvjVM1RQ6qq5AsuEAsrKDe25rLVv1vG
 bpnebpuU2zY31NMWjr9vsMoCwRX7leQMOChHlSB4lqjolVqtfGnefiB/KHBXRZ0F37H6 iQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nducm5717-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 06:00:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9V60aUI015223
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 06:00:36 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9V60aPD019657;
        Wed, 31 Oct 2018 06:00:36 GMT
Received: from [10.191.22.95] (/10.191.22.95)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 23:00:35 -0700
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH 3/3] kprobes/x86: Simplify indirect-jump check in
 retpoline
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk, tglx@linutronix.de,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, bp@suse.de,
        hpa@zytor.com
References: <cc8f9981-f327-4238-8378-262579584db4@default>
 <20181030083650.GB1459@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <849ae148-85cd-5f46-d98b-b827cc9c605c@oracle.com>
Date:   Wed, 31 Oct 2018 14:01:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030083650.GB1459@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810310051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/30 16:36, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 11:55:06PM -0700, Zhenzhong Duan wrote:
>> Since CONFIG_RETPOLINE hard depends on compiler support now, so
>> replacing indirect-jump check with the range check is safe in that case.
> 
> Can we put kprobes on module init text before we run alternatives on it?

Forgive me I doesn't understand your question. Do you mean this patch 
impact kprobes on module init text?

> 
>> @@ -240,20 +242,16 @@ static int insn_jump_into_range(struct insn *insn, unsigned long start, int len)
>>   
>>   static int insn_is_indirect_jump(struct insn *insn)
>>   {
>> -	int ret = __insn_is_indirect_jump(insn);
>> +	int ret;
>>   
>>   #ifdef CONFIG_RETPOLINE
>> -	/*
>> -	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
>> -	 * Note that even with CONFIG_RETPOLINE=y, the kernel compiled with
>> -	 * older gcc may use indirect jump. So we add this check instead of
>> -	 * replace indirect-jump check.
>> -	 */
>> -	if (!ret)
>> +	/* Jump to x86_indirect_thunk_* is treated as an indirect jump. */
>>   		ret = insn_jump_into_range(insn,
>>   				(unsigned long)__indirect_thunk_start,
>>   				(unsigned long)__indirect_thunk_end -
>>   				(unsigned long)__indirect_thunk_start);
>> +#else
>> +		ret = __insn_is_indirect_jump(insn);
>>   #endif
>>   	return ret;
>>   }
> 
> The resulting code is indented wrong.
> 

Oh, yes. Thanks for point out.

Zhenzhong
