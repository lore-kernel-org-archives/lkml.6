Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC61C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827062064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T7zx0mIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827062064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeKALCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:02:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48814 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeKALCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:02:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA11wcd5103641;
        Thu, 1 Nov 2018 02:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=t5YudyavaJOSk5jEIYSVgrwZNOMwk8i6m5MUfQKJVmE=;
 b=T7zx0mIXnm3ZI64pJtkdiKdZyypaO7VcWt0I8989HbT1yVTEo1AQVeewCeY40bSOMrkH
 fygrSnE9ub3tT8otpcXcwua3ovwtSG4eGwUpE6J/9ogVt7eYe7Facph932JKf41DQZrV
 fearlEhCFmZW1G4s9d/uoX07rTf9t5CRLhlTMMxMyEDRhzZsv4HlL2cSWOcZqygRnQUa
 LWo5WFaBDePWP4tE91JLnro9AGcG1MGFvRaXUuSRJHKTrkgLf8IwwhWrZ/Wae/W0EMaU
 aBLOei5bVNZajsMmk+eSWUXjAPiPMZuRJARadkF1Ft/HtC7RpV13OKventpLEkGTSkE8 Cw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ncfyq6bk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Nov 2018 02:01:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA121Vvx020750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Nov 2018 02:01:31 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA121UMR002656;
        Thu, 1 Nov 2018 02:01:30 GMT
Received: from [10.191.18.205] (/10.191.18.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Oct 2018 19:01:30 -0700
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
 <849ae148-85cd-5f46-d98b-b827cc9c605c@oracle.com>
 <20181031135320.GC13237@hirez.programming.kicks-ass.net>
 <20181031140032.GB13257@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <04040fa2-02c6-9aa6-15fe-609ad21b3426@oracle.com>
Date:   Thu, 1 Nov 2018 10:02:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031140032.GB13257@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9063 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811010016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/31 22:00, Peter Zijlstra wrote:
> On Wed, Oct 31, 2018 at 02:53:20PM +0100, Peter Zijlstra wrote:
>> On Wed, Oct 31, 2018 at 02:01:20PM +0800, Zhenzhong Duan wrote:
>>> On 2018/10/30 16:36, Peter Zijlstra wrote:
>>>> On Mon, Oct 29, 2018 at 11:55:06PM -0700, Zhenzhong Duan wrote:
>>>>> Since CONFIG_RETPOLINE hard depends on compiler support now, so
>>>>> replacing indirect-jump check with the range check is safe in that case.
>>>>
>>>> Can we put kprobes on module init text before we run alternatives on it?
>>>
>>> Forgive me I doesn't understand your question. Do you mean this patch impact
>>> kprobes on module init text?
>>
>> In that case we would still see the indirect paravirt calls for example,
>> and we'd still need that cascade you took out.

Understood.
In another case when loading a non-retpoline module, we suffer the same.
>>
>> Now, I'm not at all sure we're able to use kprobes at those times, so it
>> might be a non-issue.

Not sure, but if it's possible then alternative patching may cover the 
kprobes, it looks like a bug.
> 
> Hmm, what about the case where we have RETPOLINE runtime disabled? Then
> the CALL_NOSPEC alternative patches in an indirect call again, and the
> retpolines are gone.

Is RETPOLINE runtime toggle supported in upstream? I don't see such code.
> 
> Does that not need the __insn_is_indirect_jump() thing?

Yes it's needed if RETPOLINE runtime disabled.

Based on all above reasons, I'd like to drop this patch.

Thanks
Zhenzhong
