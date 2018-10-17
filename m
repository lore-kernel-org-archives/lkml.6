Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C0EECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200C021476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MtlJUmRF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EDFPzE+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200C021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJRGj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:39:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47934 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJRGj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:39:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2EBD360B1E; Wed, 17 Oct 2018 22:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539816098;
        bh=K4d8FL3r1i/nYhhDMke68WpV1Fz2Mp2E61do0bSWBBs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MtlJUmRFdFX+7KH7EpqUdy7U1ear691sy/sUGkSkQz5SPRzyPBcWeyJH5DlNdeTds
         iXKuQ8zWCw29DS6hNtI8Hkr89/32qj510Pnpv13Da10hh/wbfcnfaAHh+bD3+c6Of9
         QwQHPpMLTZbDTYvCGE9Wrzb9Q/qJnu9KHeitZlbA=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FB2060316;
        Wed, 17 Oct 2018 22:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539816097;
        bh=K4d8FL3r1i/nYhhDMke68WpV1Fz2Mp2E61do0bSWBBs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EDFPzE+g94vkCswyus8rBGvoywbFC1XojJFGp6i3ANxdlFRd77zsjcqbgXAetBQpO
         htwMNdRVEJ1q8EU/x7wYeEp58PjXI2YTEyzR6z4stLn1+Qln+Zg8XAkQ/GtnzIKeVg
         fbXnjZPoCQ/gmkboOP08Yw6BARhl2yZLfq7axO8g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FB2060316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 1/2] serial: set suppress_bind_attrs flag only if builtin
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-serial@vger.kernel.org, tj@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20181017140311.28679-1-anders.roxell@linaro.org>
 <20181017150546.0d451252950214bec74a6fc8@linux-foundation.org>
 <e0763032-3ae6-b352-e586-ad131ce689ca@codeaurora.org>
 <20181017153223.6c4e5156895dad7973f7d059@linux-foundation.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <0bc08889-4801-33b6-8273-5cf2123baba5@codeaurora.org>
Date:   Wed, 17 Oct 2018 16:41:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017153223.6c4e5156895dad7973f7d059@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 4:32 PM, Andrew Morton wrote:
> On Wed, 17 Oct 2018 16:21:08 -0600 Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> 
>> On 10/17/2018 4:05 PM, Andrew Morton wrote:
>>> On Wed, 17 Oct 2018 16:03:10 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:
>>>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>
>>> This should have Arnd's Signed-off-by: as well.
>>
>> I'm just interested to know, why?
> 
> So that Arnd certifies that
> 
>          (a) The contribution was created in whole or in part by me and I
>              have the right to submit it under the open source license
>              indicated in the file; or
> 
> and all the other stuff in Documentation/process/submitting-patches.rst
> section 11!
> 
> Also, because section 12 says so :)  And that final sentence is, I
> believe, appropriate.

Ah, interesting.  I see that the documentation was updated since I was 
told last year in the same situation by a different maintainer that 
co-authors should not have SOB lines on the patch.

Good to know.  Thanks for illuminating me.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
