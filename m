Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE6FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6AC20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="itOJqoaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6AC20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbeG3SWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:22:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39312 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbeG3SWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:22:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UGdF7g145792;
        Mon, 30 Jul 2018 16:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=OkrCXnbpaIi1rKJZdguUUEr3hhXSXL5RC8bIN8rVK/8=;
 b=itOJqoaKp7fgMWtiCqzwmWi2npCo9DBV9IvsBbFSlZV3E2Gh8ETP+aCsIitPQz+vxrMm
 95BYBbdOwZ5TBwzuXe+mE2kPfJHn/65YiZ46Qe++2YoyBdWE6WA6jc2vulpql2k1x2EY
 cc8Ktjy4mYjCfRGsiniLiOUFRyqbFe9iKHZK+NfegqtOw4bGf6SJDv44jK03zG6LBm4Q
 EwplIMZnTlHDWuBBk9v94FQ1kz8G2Ah+jIaN4xl9NquAWTl4tZ5ZU9TtkJU53pS7urPD
 l/t6NfXaB0clYj6kZy7X2VIQ7NKXSuyBBAqrZVgns1Thc7/yWUohzvSBnuTXRDw5uZt8 AA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2kggenwcrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 16:46:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6UGkQMw027058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 16:46:26 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6UGkQtj018363;
        Mon, 30 Jul 2018 16:46:26 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 09:46:25 -0700
Subject: Re: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
 <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
 <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
 <20180730162235.GC4276@arm.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <2651847f-79ea-fe2a-c1d7-efe4d11702b4@oracle.com>
Date:   Mon, 30 Jul 2018 11:46:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730162235.GC4276@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 11:22 AM, Will Deacon wrote:
> On Mon, Jul 30, 2018 at 05:16:42PM +0100, Catalin Marinas wrote:
>> On Mon, Jul 30, 2018 at 10:29:21AM -0500, Dave Kleikamp wrote:
>>> machine_kexec flushes the reboot_code_buffer from the icache
>>> after stopping the other cpus.
>>>
>>> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
>>> for kernel mappings") added an IPI call to flush_icache_range, which
>>> causes a hang here, so replace the call with __flush_icache_range
>>
>> While machine_kexec() may be called with interrupts disabled (IIUC) and
>> we shouldn't IPI other CPUs, I don't understand why it hangs here. Are
>> there any other CPUs online at this point?
> 
> The BUG_ON and WARN_ON at the start of machine_kexec() suggest to me that
> this should only happen if we're kexec'ing a crash kernel and
> smp_crash_stop_failed(). Is that something we need to care about?

I observed the hang trying to kexec a crash kernel and I did not see the
warning that smp_crash_stop_failed(). I'm not exactly sure why
flush_icache_range() hung (but it did), but I think that
__flush_icache_range() makes more sense here anyway.

> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
