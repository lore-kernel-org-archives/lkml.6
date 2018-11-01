Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA89C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A8A205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ezpg2826"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A8A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeKASXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:23:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57614 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeKASXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:23:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA19JQZF178912;
        Thu, 1 Nov 2018 09:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BQ5bbWAJUg9OP8QS/G1xDanJnHdf2z7/k5qcfrgmYnk=;
 b=ezpg2826XS+sfnm0c9j3Vg2NBcP+dN7eeTZqRnQrN3CoDBO95OYXwZ8WUj4k14sYuMMy
 EX7InF1Qj8K5UXFy0G3hp+9qWWIKBoBjdhR+XroR4t05vIqqWDO9e2+t38C88K5Lmo/H
 nWNCPDo3XIHIpn5S/J2S4R4e3XPpHF2h7cHi06L85dASTuNJDpwZ895wLIVPRQFZQA5d
 U7kCuRh580/CMlqTLVlFT884534vYaPc/FvOkRiWAP6cbFlAbZ/CsZT6kgobdB/uJkVb
 3AfNxymrgPxCTjVytikqvaOE/LahA9SexLxDDolDCsUKtS6fsiM3I58S1zK4AI/XRQJr mw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ncgnr7rve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Nov 2018 09:21:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA19Ku1g029918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Nov 2018 09:20:56 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA19KtlH015878;
        Thu, 1 Nov 2018 09:20:55 GMT
Received: from [10.191.24.24] (/10.191.24.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Nov 2018 02:20:55 -0700
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
 <04040fa2-02c6-9aa6-15fe-609ad21b3426@oracle.com>
 <20181101085634.GC3159@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <e5de6bcd-a7d1-7d48-868f-1a5168332dfc@oracle.com>
Date:   Thu, 1 Nov 2018 17:21:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101085634.GC3159@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9063 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=655
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811010082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/1 16:56, Peter Zijlstra wrote:
> On Thu, Nov 01, 2018 at 10:02:14AM +0800, Zhenzhong Duan wrote:
>>> Hmm, what about the case where we have RETPOLINE runtime disabled? Then
>>> the CALL_NOSPEC alternative patches in an indirect call again, and the
>>> retpolines are gone.
>>
>> Is RETPOLINE runtime toggle supported in upstream? I don't see such code.
> 
> arch/x86/kernel/cpu/bugs.c look for the "nospectre_v2" and related
> options. That will avoid X86_FEATURE_RETPOLINE from being set, and thus
> the JMP_NOSPEC and CALL_NOSPEC alternatives will not patch out the
> indirect jump / call.
> 
Yes, in this case there are also indirect branches. I'll drop 3rd patch 
in v2.

Thanks
Zhenzhong
