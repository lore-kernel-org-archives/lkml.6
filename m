Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB50C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD6120666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="IusagCOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD6120666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJBWMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:12:46 -0400
Received: from vern.gendns.com ([206.190.152.46]:42362 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJBWMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ery2w7D+ksXEHdXAvw8WOM/X879V79mzUm4ZPMHAtsA=; b=IusagCOo6DokguKVtd+CJoYr0y
        5sR1to8U/+nbMijYLPrFMsvBLtGaaUIHPA5ewTtHhmc4HJi6ga4yBdFBG6BurUYauKEe9H3LCrA1c
        MFytb12jsjsGXcHOBLYlIlRCwA1f/nGbw345hs3q6hxF7IFbjmnEjRM2y+PlGo6xZvxHqvJieiJNg
        hdENy0hNe9Vlrr2biLR3Z+UHywraFaQIkZh5jNBKHfDr1zLyQrR6SX1cswhF/Pbqedcv+TDQyCjZ6
        w8O0nL87tXmqYtZWhgBej02e1mQef+h4Klf6c2G9jeYFehhVcXi3urQJLjPUTh2cHE64vppfFAtVK
        4BTA6Aww==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:50784 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g7MbN-004G7M-0d; Tue, 02 Oct 2018 11:28:45 -0400
Subject: Re: [PATCH v7 2/4] clk: davinci: kill
 davinci_clk_reset_assert/deassert()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <20180621073706.22812-3-brgl@bgdev.pl>
 <160f4225-236c-af54-9693-120e834af578@lechnology.com>
 <CAMRc=McmwWt5OdCxGntDJ-5cxte+Ad2FJcnmWT8NxnBtzP40DA@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <159d6244-8077-e21f-36d9-ccb1eeb3ed78@lechnology.com>
Date:   Tue, 2 Oct 2018 10:28:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McmwWt5OdCxGntDJ-5cxte+Ad2FJcnmWT8NxnBtzP40DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 10/02/2018 10:08 AM, Bartosz Golaszewski wrote:
> pt., 6 lip 2018 o 19:54 David Lechner <david@lechnology.com> napisał(a):
>>
>> On 06/21/2018 02:37 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> This code is no longer used. Remove it.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> Reviewed-by: David Lechner <david@lechnology.com>
>>> Acked-by: Stephen Boyd <sboyd@kernel.org>
>>> ---
>>
>> I've picked this up in clk-davinci-4.20, so it will just hang out
>> there for a while until the rest of this series gets merged.
>>
> 
> Hi David,
> 
> I don't see this patch in next yet. Is it queued for 4.20?
> 
> Thanks in advance,
> Bartosz
> 

This is currently the only clk-davinici patch I have queued, so it
might be easier to just resend it and let Stephen/Mike pick it up
directly instead of me sending a pull request for one patch.

