Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1565AC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA6820645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmCDhH3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA6820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeJLVix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:38:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeJLVix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:38:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so6268272pfg.3;
        Fri, 12 Oct 2018 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=essRwWdABp2tBcZA5XaEwt6EmtxT53M4tnapx8hIE60=;
        b=UmCDhH3fyD8xvmhyT5PPrsiIs6dXBjdTAN/QO76OwdxIMwWku5La+G0ro319VTfCRf
         N9A0bYKkHF3FJXkkxJhIghj7VG5XTchu5QoGws0YeokMaeZVXAuqYBJ+ddugkO4X5A1p
         +aa6aLEdIolM8XY2CExBu7YoCxYB336+Z6KuMZytYr5UbFEDEOmEVw8DTSEcVWYQSGSA
         BVI9fsHRHx7NGtaCfrO7Pq1fQjyTTT1vjoyVJuidzBqZwJ/hkJ3GGVMJgRaoW5xS6z8n
         5BE+vvW/TK5PGmLQXIvpcjzoAMgK1g3ag/AbFG9nALxT9Qxw7vUAvko9Z+LXEMGdhXCo
         yZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=essRwWdABp2tBcZA5XaEwt6EmtxT53M4tnapx8hIE60=;
        b=ngy1M7sV9jtwrOZTDrbMC8rF6fT62/atGMgrgdCAm7pn0Nuf57kgjswN303ESVKVO4
         aY9slZBcTsEAg9t45ok11zIsnZQmTtbCkSBKkjfOvZGTiOVwT2pbbQfyBrilhQX6MCV8
         VA24CUm3nu47yo7ES+jh0XT61g1loBzc4Q81I7MUbqIBuWfRSBe8hANenZ47285ajCIi
         RTeuOUCkG3CHQQgEjx8dDAwuKHb92/cpCN38ZzNaa8UmKYVJdtCMvBzzBNJTQeZqZ6ec
         sDu6bbgFUMWB94ZttSW17HG91UtUkzn0jnrZSsS08FTXYEXCN2yG5KrFGcnCVN2zXnmm
         joFA==
X-Gm-Message-State: ABuFfoghM0ZERTW6et2BPZF/T+AgqG2d2m40kgViBpUKQvQTQx4VvE2R
        qJPnzGCMHFAnCvhyAu4Wn0NdhHO5
X-Google-Smtp-Source: ACcGV62SyMXmrCHuAN3a3+ImQMB8BckvFpLbgy+1yBo9KaE6ngL+WxpnlxOZNtcUfR4fEuevvakQ+Q==
X-Received: by 2002:a63:2807:: with SMTP id o7-v6mr5630796pgo.155.1539353176457;
        Fri, 12 Oct 2018 07:06:16 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a79-v6sm2545928pfa.124.2018.10.12.07.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:06:15 -0700 (PDT)
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181011152549.500488630@linuxfoundation.org>
 <9b2c52e4-56ce-37a3-b515-a6ff831fe17e@roeck-us.net>
 <20181012133704.GB3706@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <10e12992-7e33-9569-5a4f-2a8124d3aae4@roeck-us.net>
Date:   Fri, 12 Oct 2018 07:06:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012133704.GB3706@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 06:37 AM, Greg Kroah-Hartman wrote:
> On Fri, Oct 12, 2018 at 05:19:16AM -0700, Guenter Roeck wrote:
>> On 10/11/2018 08:33 AM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 3.18.124 release.
>>> There are 120 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> [preliminary]
>>
>> arm:allmodconfig:
>>
>> drivers/mtd/spi-nor/fsl-quadspi.c: In function 'fsl_qspi_init_lut':
>> drivers/mtd/spi-nor/fsl-quadspi.c:170:5: error: 'LUT_0' undeclared
> 
> That is really odd in that there are no patches that touch this file,
> and I do not even see "LUT_0" anywhere in the 3.18.y tree.
> 

Bisect:


# bad: [8c4ca12b60ea371a32db58cf78b6cb4e2ba4515c] Linux 3.18.124-rc1
# good: [921b2fed6a79439ef1609ef4af0ada5cccb3555c] Linux 3.18.123
git bisect start 'HEAD' 'v3.18.123'
# good: [aed5b0190528303a3f4d319f95d7e38c94ca32ab] USB: remove LPM management from usb_driver_claim_interface()
git bisect good aed5b0190528303a3f4d319f95d7e38c94ca32ab
# good: [10441f560c0ad0aeed00402088d71d4d299d6537] r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED
git bisect good 10441f560c0ad0aeed00402088d71d4d299d6537
# bad: [0661a919177560337d962f43daa46dde2fa4d89e] mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys
git bisect bad 0661a919177560337d962f43daa46dde2fa4d89e
# good: [d4b130cc92bbef445de4ffe4ecd068935375d591] ocfs2: fix locking for res->tracking and dlm->tracking_list
git bisect good d4b130cc92bbef445de4ffe4ecd068935375d591
# bad: [1f002a3e6d7250a62966399bd91eeec308c0b756] fbdev/omapfb: fix omapfb_memory_read infoleak
git bisect bad 1f002a3e6d7250a62966399bd91eeec308c0b756
# bad: [5396a79f029d54c1e02409335c7dfde43c55e4a4] Make file credentials available to the seqfile interfaces
git bisect bad 5396a79f029d54c1e02409335c7dfde43c55e4a4
# good: [7da4d144b6922e94aad8c0d405e4cc63a44b8ec5] dm thin metadata: fix __udivdi3 undefined on 32-bit
git bisect good 7da4d144b6922e94aad8c0d405e4cc63a44b8ec5
# first bad commit: [5396a79f029d54c1e02409335c7dfde43c55e4a4] Make file credentials available to the seqfile interfaces

... and reverting that patch fixes the problem. No idea why; maybe because of include
file changes.

Guenter
