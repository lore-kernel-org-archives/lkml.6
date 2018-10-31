Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6187320657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QtMwkrZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6187320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeJaOwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:52:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:52:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9V5dQYu020674;
        Wed, 31 Oct 2018 05:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=G1VVVcYCN4EZbsbTkW8AQheDoypc/vN9x/H1l0xo2PU=;
 b=QtMwkrZHpA35j0PWFPVevMg6ZLyBqV/miQIDY8v4uuv1d2K8+h9I8YJoouB21bSMpH7A
 BRYsUBc1I7hMdhpBPmnoKdGxAqVYFwKRwX76+hZ40SsLsgn3v+efM2bKj1K3FaNaKMxc
 862YVw7tyvcw/kurGMrTjAL9jgoz5X0RnX+PJ7/RtZmwHTSHqcu62B0vZ8F84LOz6t5N
 tG9akOug5PuBg2ve1ckcn+rBVDUvRzpMLWWR6O0IRphfn48WpnpHavH1as4qEFY2M3R/
 y4KQGqx9cIMszR8Bn74/VpfJzy7XAUe2hZeTjbsVycRnY3IcCX/yzdKQhtJ+RB7//nnQ rQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ncgnr0gnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 05:54:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9V5sXq2004793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 05:54:34 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9V5sWuv029642;
        Wed, 31 Oct 2018 05:54:32 GMT
Received: from [10.191.22.95] (/10.191.22.95)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 22:54:32 -0700
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH 1/3] retpolines: Only enable retpoline when compiler
 support it
To:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, konrad.wilk@oracle.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, srinivas.eeda@oracle.com,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michal Marek <michal.lkml@markovi.net>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <e63900bc-d7af-4a57-aa96-f6cc84b89e09@default>
 <CAK7LNAQG62vzFpDC_xoTEh6CuxmRVU7jAtVe7YpVmqou1hEagQ@mail.gmail.com>
 <20181030100954.GF744@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <1e62b1b7-8c37-b9a1-bcda-41aa99155420@oracle.com>
Date:   Wed, 31 Oct 2018 13:55:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030100954.GF744@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=948
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810310049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/30 18:09, Peter Zijlstra wrote:
> On Tue, Oct 30, 2018 at 06:39:24PM +0900, Masahiro Yamada wrote:
>> Hi,
>>
>>
>>
>> On Tue, Oct 30, 2018 at 3:57 PM Zhenzhong Duan
>> <zhenzhong.duan@oracle.com> wrote:
>>>
>>> Since retpoline capable compilers are widely available, make
>>> CONFIG_RETPOLINE hard depend on it.
>>>
>>> Change KBUILD to use CONFIG_RETPOLINE_SUPPORT to avoid conflict with
>>> CONFIG_RETPOLINE which is used by kernel.
>>>
>>> With all that stuff, the check of RETPOLINE is changed to
>>> CONFIG_RETPOLINE.
>>>
>>> This change is based on suggestion in https://lkml.org/lkml/2018/9/18/1016
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Borislav Petkov <bp@suse.de>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>>> Cc: H. Peter Anvin <hpa@zytor.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Cc: Michal Marek <michal.lkml@markovi.net>
>>> ---
>>
>>
>> Instead of adding another CONFIG option,
>> does it make sense to add compiler support checks
>> to 'depends on' syntax ?
>>
>>
>> config RETPOLINE
>>           bool "Avoid speculative indirect branches in kernel"
>>           depends on $(cc-option,-mindirect-branch=thunk-extern
>> -mindirect-branch-register) || \
>>                      $(cc-option,-mretpoline-external-thunk)
>>           default y
>>           select STACK_VALIDATION if HAVE_STACK_VALIDATION

Looks better, thanks for suggestion.

> 
> That seems to be what we did for stackprotector, which is similar in
> that it used to fail the build. So yes, this seems sane.

Should I add a scripts/gcc-x86_64-has-retpoline.sh like what 
stackprotector does as below or there is a simpler way?

config CC_HAS_SANE_STACKPROTECTOR
         bool
         default 
$(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 
64BIT
         default 
$(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
         help
            We have to make sure stack protector is unconditionally 
disabled if
            the compiler produces broken code.

Thanks
Zhenzhong
