Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7744DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176A72086B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9p8vQ1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176A72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeIEUHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:07:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33127 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEUHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:07:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id b30-v6so1194272pla.0;
        Wed, 05 Sep 2018 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CHM52Hl8L4IY9R3OV+u51pd5YtUJ5Nvw97SNBjRJ8VI=;
        b=Q9p8vQ1pIa7Y6Mg7E5MCi36MODu45Jd6eavAv1duyY+d8ibXt0Q1XDAkH1dU0xkKxs
         SqofBpXXYU1qV2e0ElUFydWf4bEn4Of6MaYLjrgKKCJJuC1m9w3kg/HGqJB1pKKXMdYK
         gG2ZLBnryIObTlb2pzJKuZihEMi84vApUuOU8PT1BJQr/sZTxja8rGvCMB5c3G/lTI54
         2sEfRbybNi54MxeJ9A2OoKXgOa6oHcKTBmtmIuap1iD/DlRTeUtnsUxvjh8YNEmqfoWi
         K9IbcXJtDOOG1US/ucZPGIG89OKIjM8ILACZ9wfNPWUeiXOms4UVqYhN87rcHBKHaSlH
         YMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CHM52Hl8L4IY9R3OV+u51pd5YtUJ5Nvw97SNBjRJ8VI=;
        b=PJwsqJl4q8Qp04YorHajjAKtPXOGCux6xSQrTG9icPMD+Yv6DLY2TRx1TeWcI60MSP
         omM3jHrGdCTVneaGBp6ks4sEDyEIzr7awf5oMT+KWRfMuQscAoeTWpsdFCUGNHMzEA0S
         B1jUEsCi1oR/5VohxSCo15KWT8qvOguLyfl0cnt26Ix5NOLpJo8cK2Kdho6604UhJEVw
         yMKTgVcFDUSwcSyyfVejbGMWDmDkA08K/zdusl97j4oVE4l50TQ2PgWZJxEQXKGJrI79
         S/fAJHOOOiwBMUpS382CFk8F/AlmsdPzopS5M6WhkLrtF4Yj0SqC2pdYJwj6np75o8aJ
         R+Dg==
X-Gm-Message-State: APzg51CCw7fLrHmA9qmRiWEXZopAkrGwgOD/0fh6roEc8ENCU2DS0uSj
        T9xmdIt43nFTchU6FtNT6SKSrRpc
X-Google-Smtp-Source: ANB0Vdat74Tik7eZF504+W7PKl2Mttl1pOspBDcvNCKGfQF6lKPh/PV7pspA+1d3BiYyaTBQABQbaw==
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr8018208pld.312.1536161797256;
        Wed, 05 Sep 2018 08:36:37 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 6-v6sm4050414pfr.115.2018.09.05.08.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 08:36:36 -0700 (PDT)
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
References: <20180903165719.499675257@linuxfoundation.org>
 <20180904193202.GB17786@kroah.com>
 <CA+G9fYun7J_BCZ390oa5tY6jp6faaknczzDBuc7w5v6o8+WWVg@mail.gmail.com>
 <20180905104350.GA11612@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <01b6e073-c5e7-4d18-da3a-33fc598c2d28@roeck-us.net>
Date:   Wed, 5 Sep 2018 08:36:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905104350.GA11612@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 03:43 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 05, 2018 at 04:08:35PM +0530, Naresh Kamboju wrote:
>> On 5 September 2018 at 01:02, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Mon, Sep 03, 2018 at 06:55:44PM +0200, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 4.18.6 release.
>>>> There are 123 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>        https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.6-rc1.gz
>>>> or in the git tree and branch at:
>>>>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
>>>> and the diffstat can be found below.
>>>
>>> I have released -rc2 to fix a reported problem:
>>>          https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.6-rc2.gz
>>
>> I get to see  4.18.6-rc1 not rc2.
> 
> Odd.  Something is up with the kernel.org mirroring right now.  Let's
> wait for people to wake up to look into it...
> 

Same here (rc1 vs. rc2). The necessary added patch was there, so I figured you
did not update the release number and ignored it.

Guenter

>> With the current results on given commit id are looking good.
> 
> Wonderful, thanks for testing and letting me know.
> 
> greg k-h
> 

