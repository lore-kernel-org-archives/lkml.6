Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A609C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3104208FA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="egoYuZ6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3104208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeGBPdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:33:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeGBPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FRG7krd4aYZ0RMZq8C2uv5/w/L0YN0OUPGmrDEs5Wt4=; b=egoYuZ6fM4kyvJFYcj9i01mC8b
        OGPRUFDcNW8TKsckTGQx/0jGBmkZdyd5gbBqeV00Oc1ZPSSVolp1DvfuxwMPaEuL/QsnUATwQ4woz
        tPiEl23lP9nWlHVRFTmLx9ALERv7sPFigwjm4SCKSLba6KVVpXJ7Rmw65fKhP47kpo44XyFM9MvSE
        TXYjJky9QwGKAedAXkspzaWfc94G/BdU7KNdxt5mRqT136JOTt5+vLktbXSxLDxlFKbdNChvp/Qko
        zYjLtT5rgidYifF6h2CNMZVRQaNeaY2yQFEp5GZpvmRxo1gnOh3ST4bvMh36+TjtT76Lkel5x72a9
        J+lv6LZQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa0p2-0000fU-PW; Mon, 02 Jul 2018 15:33:00 +0000
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
To:     Kalle Valo <kvalo@codeaurora.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, kt.liao@emc.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        ulrik.debie-os@e2big.org, phoenix@emc.com.tw,
        aaron.ma@canonical.com, josh.chen@emc.com.tw
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws>
 <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw> <20180622001632.GI79890@dtor-ws>
 <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
 <20180701234419.GA250349@dtor-ws>
 <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
 <A5DA555C-6131-4F7B-82F2-A06C12E23CAF@gmail.com>
 <87sh5196pk.fsf@purkki.adurom.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57436c8d-c188-500d-5764-5df4208d53b0@infradead.org>
Date:   Mon, 2 Jul 2018 08:32:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87sh5196pk.fsf@purkki.adurom.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 05:12 AM, Kalle Valo wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> 
>> On July 1, 2018 5:00:03 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> On Sun, Jul 1, 2018 at 4:44 PM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>>
>>>> The reason it got messed up is I switched to pulling patches from
>>>> patchwork.kernel.org as it collects Acked-by and Reviewed-by tags so
>>> I
>>>> do not have to add them manually, but unfortunately it does not do
>>>> proper UTF-8:
>>>
>>> Ugh.
>>>
>>> I made an 'issue' of it for patchwork:
>>>
>>>  https://github.com/getpatchwork/patchwork/issues/194
>>>
>>> and hopefully that can be fixed. It's sad when we corrupt names like
>>> this.
>>
>> Might not even be an issue with recent patchwork, but unfortunately
>> the version that is running on kernel.org is ancient as far as I know.
> 
> FWIW I use patchwork.kernel.org and I don't have any issues with UTF-8
> characters in the From header. For example, here's one patch which I
> recently applied:
> 
> https://git.kernel.org/linus/88001968245c
> 
> But of course it depends on what tools you use (I have my own patchwork
> script which downloads and applies the patch) or what characters there
> were etc. 
> 
> Also I heard that we should get an upgrade to patchwork.kernel.org in
> the near future, which is great. The current version has some quirks
> which are quite annoying.
> 

I don't know if it's better or different, but there is also
https://lore.kernel.org/patchwork/


-- 
~Randy
