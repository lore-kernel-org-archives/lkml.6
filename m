Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C52FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED0F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t8NcY6fF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED0F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeG3Sfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:35:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48958 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeG3Sfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:35:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UGx83X160962;
        Mon, 30 Jul 2018 16:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6d1R9j+NoOlhZJ+wnK7IAFnXVtVY9nTXqiQ03RmmDIY=;
 b=t8NcY6fF7zx8eQIdJ60xnht2MsYBBR2LVEUOKbSv9v8OJZEzC9P6v4psF9n6NGTFahhx
 tO9aHmjZU13gIotlkqwBIRYNYsIOpB9egOguERbZjAZsZir5TlSR/F0PcF3mCcwiWgaF
 +kfc2InzOT5Xjf1hPRVxkj1EqF3Ly4SgophRyGxh6DnOmUTa6ux+vjTH+fZSjXo+GfTP
 1HGsgWpg5RQCjzY3lFQGduAjBRWBxk9bjgn2xVevVOeiqRB31A8lAh2Aff4gOeW5k/1S
 gS8Jg5eQFRlrN4ougyFyNf7Plfmlc7kdtmlf6YPf1TOkTwY57xF4WWjBlX49l3pP5pRZ wA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kggenweaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 16:59:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6UGxMX7015858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 16:59:22 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6UGxLh0026723;
        Mon, 30 Jul 2018 16:59:22 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 09:59:21 -0700
Subject: Re: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
 <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
 <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
 <20180730162235.GC4276@arm.com>
 <2651847f-79ea-fe2a-c1d7-efe4d11702b4@oracle.com>
 <20180730165757.GF4276@arm.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <8ef8f860-3acf-5738-879c-a02e7c873ad2@oracle.com>
Date:   Mon, 30 Jul 2018 11:59:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730165757.GF4276@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 11:57 AM, Will Deacon wrote:
> On Mon, Jul 30, 2018 at 11:46:24AM -0500, Dave Kleikamp wrote:
>> On 07/30/2018 11:22 AM, Will Deacon wrote:
>>> On Mon, Jul 30, 2018 at 05:16:42PM +0100, Catalin Marinas wrote:
>>>> On Mon, Jul 30, 2018 at 10:29:21AM -0500, Dave Kleikamp wrote:
>>>>> machine_kexec flushes the reboot_code_buffer from the icache
>>>>> after stopping the other cpus.
>>>>>
>>>>> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
>>>>> for kernel mappings") added an IPI call to flush_icache_range, which
>>>>> causes a hang here, so replace the call with __flush_icache_range
>>>>
>>>> While machine_kexec() may be called with interrupts disabled (IIUC) and
>>>> we shouldn't IPI other CPUs, I don't understand why it hangs here. Are
>>>> there any other CPUs online at this point?
>>>
>>> The BUG_ON and WARN_ON at the start of machine_kexec() suggest to me that
>>> this should only happen if we're kexec'ing a crash kernel and
>>> smp_crash_stop_failed(). Is that something we need to care about?
>>
>> I observed the hang trying to kexec a crash kernel and I did not see the
>> warning that smp_crash_stop_failed(). I'm not exactly sure why
>> flush_icache_range() hung (but it did), but I think that
>> __flush_icache_range() makes more sense here anyway.
> 
> Yeah, I'll pick the patch up, but it would be nice to understand the
> failure case you observed.

I'll dig a little deeper.

Thanks,
Dave

> 
> Will
> 
