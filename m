Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ED1C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F2020833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F2020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeILUns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:43:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33944 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeILUnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:43:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48DDB7A9;
        Wed, 12 Sep 2018 08:38:44 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED4A53F5C0;
        Wed, 12 Sep 2018 08:38:42 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <c34452c2-d1e8-19d8-45c1-b48ecf14bbd7@arm.com>
 <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
 <af280111-5dec-a4e1-7dfd-20f38a9fd8ab@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <2873c62f-1bf9-5aa0-b3a2-07980ef61d35@arm.com>
Date:   Wed, 12 Sep 2018 16:38:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <af280111-5dec-a4e1-7dfd-20f38a9fd8ab@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 16:27, Sudeep Holla wrote:
> 
> 
> On 12/09/18 15:41, Jeffrey Hugo wrote:

[...]

>>
>> Correct.  However, what if you have a NOCACHE (not architecturally
>> specified), that is fully described in PPTT, as a non-unified cache
>> (data only)?  Unlikely?  Maybe.  Still seem possible though, therefore I
>> feel this assumption is suspect.
>>
> 
> Yes, we have other issues if the architecturally not specified cache is
> not unified irrespective of what PPTT says. So we may need to review and
> see if that assumption is removed everywhere.
> 
> Until then why can't a simple change fix the issue you have:
> 
> -->8
> 
> diff --git i/drivers/acpi/pptt.c w/drivers/acpi/pptt.c
> index d1e26cb599bf..f74131201f5e 100644
> --- i/drivers/acpi/pptt.c
> +++ w/drivers/acpi/pptt.c
> @@ -406,7 +406,8 @@ static void update_cache_properties(struct cacheinfo
> *this_leaf,
>          * update the cache type as well.
>          */
>         if (this_leaf->type == CACHE_TYPE_NOCACHE &&
> -           valid_flags == PPTT_CHECKED_ATTRIBUTES)
> +           (valid_flags == PPTT_CHECKED_ATTRIBUTES ||
> +            found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID))

Looking at this again, if we are supporting just presence of cache type
and size(may be), then we can drop the whole valid_flags thing here.

>                 this_leaf->type = CACHE_TYPE_UNIFIED;
>  }
> 
-- 
Regards,
Sudeep
