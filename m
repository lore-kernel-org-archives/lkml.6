Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C507C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FA0224F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="IIQiQsD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FA0224F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeGBP2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:28:00 -0400
Received: from vern.gendns.com ([206.190.152.46]:37566 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeGBP16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R+zbhw4j2bow9K8nbLIV14wMYZf26fHCcUqexe8eSFU=; b=IIQiQsD4nJ3HrTj26nEA3kFn20
        pZX0C2MzBn+hnynzBVQpXCA7717wrw614v8hsBQgs2/cmTvN2/HOKk4uhojumraD8ysdUSSiUfIdf
        pWj5YFbjrLeb2m/SbC3++C1tqj5nBJk4r9nDMRbyMD6rlzipPAcMRtScspvJSJKNOwbXsSY9GGZLm
        T64QCj0zAQi//nxHfCtokBZWUkXQXA+eBBPosH2TLtdV5ic8vXFKluNFXJba5+mYPPnzANA+ZL8iQ
        XwbJBtDE0qA9XR+IRPFOogTrmzWLCRoUTXUwHXmOwtLMbHf+Cg6Ph49N77cJ1VtnMUCxt5pFf9BE9
        sWzsaYtQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59290 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fa0k7-00DDDN-3M; Mon, 02 Jul 2018 11:27:55 -0400
Subject: Re: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the
 reset framework
To:     Sekhar Nori <nsekhar@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
 <CAMRc=Me1JTuw40tMWaai2oKMxmc_ktN2OKBhF8tmGt0cQ6magg@mail.gmail.com>
 <e4bd9f57-617a-a59e-5d05-be1a6b3e6b3d@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <345aed22-629a-abf6-df22-adee88a43df6@lechnology.com>
Date:   Mon, 2 Jul 2018 10:27:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e4bd9f57-617a-a59e-5d05-be1a6b3e6b3d@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 07:08 AM, Sekhar Nori wrote:
> Hi Bjorn,
> 
> On Thursday 21 June 2018 05:11 PM, Bartosz Golaszewski wrote:
>> 2018-06-21 12:52 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>>> Hi Bartosz,
>>>
>>> On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> These are the remaining patches that still need to be merged in order
>>>> to complete the conversion of the davinci dsp driver to using the reset
>>>> framework.
>>>>
>>>> They apply on top of v4.18-rc1 with David Lechner's remaining patches
>>>> merged.
>>>
>>> Series looks good to me.
>>>
>>> To preserve bisect, shouldn't the order of applying be patch #3, #4, #1
>>> and #2 ?
>>>
>>> Given the dependencies and to preserve bisect its easiest if I take the
>>> series with acks from remoteproc and clock maintainers.
>>>
>>> Open to other suggestions as well.
>>>
>>> Thanks,
>>> Sekhar
>>
>> Oops you're right about the order. Do you want me to resend?
> 
> With your ack, I can queue 1/4 for v4.19 and provide an immutable commit
> to you (on top of v4.18-rc1) for you to merge any further changes you
> want to queue from your tree.
> 
> Bartosz, given the number of moving pieces, I think its better to keep
> 2/4 for v4.20 release - once all other other dependencies have been merged.

I was thinking the same thing as well. I will pick it up in a
clk-davinci-4.20 branch if that sounds OK.

