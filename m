Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E4AC07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEAF20837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEAF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLHCsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 21:48:14 -0500
Received: from [110.188.70.11] ([110.188.70.11]:61970 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbeLHCsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 21:48:14 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id wB82larc071897;
        Sat, 8 Dec 2018 10:47:36 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id wB82lUhp099967;
        Sat, 8 Dec 2018 10:47:30 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from pw-vbox.hygon.cn (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 8 Dec 2018
 10:47:31 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH] x86/cpu: Avoid endless loop to get the number of cache leaves
Date:   Sat, 8 Dec 2018 10:46:54 +0800
Message-ID: <1544237214-18766-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20181115172155.GB25056@zn.tnic>
References: <1541422425-5855-1-git-send-email-puwen@hygon.cn>,<20181115172155.GB25056@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn wB82larc071897
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply :)

On 2018/11/16 1:22, Borislav Petkov wrote:
>> @@ -640,7 +641,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
>>   		/* Do cpuid(op) loop to find out num_cache_leaves */
>>   		cpuid_count(op, i, &eax, &ebx, &ecx, &edx);
>>   		cache_eax.full = eax;
>> -	} while (cache_eax.split.type != CTYPE_NULL);
>> +	} while (cache_eax.split.type != CTYPE_NULL && i != CTYPE_MAX);
> i is an int and CTYPE_MAX is enum _cache_type. Huh?

How about define CTYPE_MAX like this:
#define CTYPE_MAX  4

> This works by chance because CTYPE_MAX is 4 and the termination CPUID
> leaf is the 4th too.

It will return CTYPE_NULL when accessing the 4th CPUID leaf in most of
the cases, but in certain case it will not. So I think it's better to
restrict the maximum CPUID access times to 4 for kernel robustness.

-- 
Regards,
Pu Wen

