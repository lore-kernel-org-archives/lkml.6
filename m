Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0225AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6BD208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZfrQG286"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6BD208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbeGaCJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:09:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48102 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6V0TL0o051046;
        Tue, 31 Jul 2018 00:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Vza+M7HZa0POrLWJ9es7E64+cpDMtjGGL4/kKVG6OVI=;
 b=ZfrQG286GJLMevzhFThs98eW00x5TDlHWbhuFwCsFvY5fOOXfG/DbWcOffe3Ox7+TWNj
 o1kefZiZEAnAN/vP7gDLLrqTF++fRa937L9RR1pdBMPucdC1lSqFAaMgD5HRqiyHnAwS
 J9lNhZvLPyItYK7QLD0hOTnrkc5Ui5IRbbvgFGX1tWBVw/94uslzv8Er/5YXhMzw1Vpf
 TD5jgXnLBF3rWBw/25o7o7H2tXzouuN2bPgZr6uyd3Zyh/yzyCTSDGmSEKJD5FaYFalP
 ClaLifrq4I4RRr0rwg2SxjE58ligi3HLjU6QFCJESmHwIeGnsi4QUWJcR1dqFUteyluq 5A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kgh4pxp0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 00:31:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6V0VHAt025033
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 00:31:17 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6V0VGBe003403;
        Tue, 31 Jul 2018 00:31:17 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 17:31:16 -0700
Subject: Re: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
 <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
 <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
 <20180730162235.GC4276@arm.com>
 <2651847f-79ea-fe2a-c1d7-efe4d11702b4@oracle.com>
 <20180730165757.GF4276@arm.com>
 <d9bac115-794c-4225-bcaa-91b6847604a2@oracle.com>
 <20180731002830.GJ11258@linaro.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <86e4ea58-a9d7-c4ab-97e4-b8be256fc954@oracle.com>
Date:   Mon, 30 Jul 2018 19:31:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731002830.GJ11258@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 07:28 PM, AKASHI Takahiro wrote:
> On Mon, Jul 30, 2018 at 04:36:28PM -0500, Dave Kleikamp wrote:
>> On 07/30/2018 11:57 AM, Will Deacon wrote:
>>> On Mon, Jul 30, 2018 at 11:46:24AM -0500, Dave Kleikamp wrote:
>>>> On 07/30/2018 11:22 AM, Will Deacon wrote:
>>>>> On Mon, Jul 30, 2018 at 05:16:42PM +0100, Catalin Marinas wrote:
>>>>>> On Mon, Jul 30, 2018 at 10:29:21AM -0500, Dave Kleikamp wrote:
>>>>>>> machine_kexec flushes the reboot_code_buffer from the icache
>>>>>>> after stopping the other cpus.
>>>>>>>
>>>>>>> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
>>>>>>> for kernel mappings") added an IPI call to flush_icache_range, which
>>>>>>> causes a hang here, so replace the call with __flush_icache_range
>>>>>>
>>>>>> While machine_kexec() may be called with interrupts disabled (IIUC) and
>>>>>> we shouldn't IPI other CPUs, I don't understand why it hangs here. Are
>>>>>> there any other CPUs online at this point?
>>>>>
>>>>> The BUG_ON and WARN_ON at the start of machine_kexec() suggest to me that
>>>>> this should only happen if we're kexec'ing a crash kernel and
>>>>> smp_crash_stop_failed(). Is that something we need to care about?
>>>>
>>>> I observed the hang trying to kexec a crash kernel and I did not see the
>>>> warning that smp_crash_stop_failed(). I'm not exactly sure why
>>>> flush_icache_range() hung (but it did), but I think that
>>>> __flush_icache_range() makes more sense here anyway.
>>>
>>> Yeah, I'll pick the patch up, but it would be nice to understand the
>>> failure case you observed.
>>
>> I see why it failed. ipi_cpu_crash_stop() does not call
>> set_cpu_online(cpu, false) the way ipi_cpu_stop() does. So
>> cpu_online_mask is still populated with the stopped cpus.
>>
>> Any reason why it isn't called there?
> 
> Because I wanted that saved cpu-related state be as close to as it was
> at panic.
> If cpus go offline, the core dump would show that all the cores but
> a panicked one be offline whether or not they actually were.

That makes sense.

Thanks,
Dave

> 
> Thanks,
> -Takahiro AKASHI
> 
>> Thanks,
>> Dave
>>
>>>
>>> Will
>>>
