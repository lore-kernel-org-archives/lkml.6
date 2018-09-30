Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8652C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC77206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kMMlSFna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC77206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeI3JGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:06:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43650 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeI3JGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:06:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so6787207pfi.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 19:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/0UqHBa5+jDKt8VnkN+WgpN5Ef+XkqOchBs6T7CyrK0=;
        b=kMMlSFnaHrlxv4JqQxbGpEqK1qvzPAivduLOX3sr/hfscCLFq47beNfLEDaWhQYBa9
         HPP75B7wW1f58sgtYWBI4mZny+TYeOpgPCAGUDGMBTTHHWXMydRNba5qRUU1XxbqEG8K
         TBDewD+hgz31ywOH1p4Wtxh9Y1uREklBv2YCW3PwEl2qQrcUl0tDwq8nykZpFVjat+mH
         QnmxLbTgs6r7U4f61wuC/wq1jHc9PJud7cWDiJzjNLDrXY6EKDsPxq/5sFIGjJEqYLTb
         w+qNuvL3tRh6321AE1IzNJti5MmSbPu2vWQANLP6wIV//x9HL8p7gp4Ua4HKHTFBbLr3
         pnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/0UqHBa5+jDKt8VnkN+WgpN5Ef+XkqOchBs6T7CyrK0=;
        b=UxRO1Y1ku9/kAs9ugBEW1QeeUCDRq5qbBOscqeDBstmK8T2zfO5KKjKdwyNKPNFWEz
         L5myMdWkyh6IFc2pDDIwx0TOC1UKzJG7aGQc47fbe6caKZ7iXpwWIxH7Kw3MVtqeV38W
         3xSclakeO+2pbTgUitWJTN+RdeiaasN2SRhjw98UdHegJhixgMxZB9gNm7lYxhesUfdx
         t1NQw643vW5t1rYskaIuzFZaAcoLjcju2K0lv6YE1Iim2z2gSmrNx3gxq5bFA7OJWVRm
         VHbvvyxdBtIqeftXTZRoDUvaQRBpTSU+EK7z1S75ZE/JeIHOK1YQheCiZ17Ozxam2inu
         W1SQ==
X-Gm-Message-State: ABuFfogSSot9kZcAiSVJvGbJZTZo9PUCS7IknsGIvAby0gLxEyZXK1ic
        4YKJ2wCQItPF+EHZViqF1z7l7/tFe9w=
X-Google-Smtp-Source: ACcGV62p/HfhNuvZB7ETJ3Zfit40MBedAhUvArB9SjgHPZabmFmQ9s9+wirSjw9Sx8cB6NJ5DKwUPA==
X-Received: by 2002:a63:d70c:: with SMTP id d12-v6mr4913196pgg.110.1538274917560;
        Sat, 29 Sep 2018 19:35:17 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id l127-v6sm14376812pfc.55.2018.09.29.19.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 19:35:16 -0700 (PDT)
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
To:     Tejun Heo <tj@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20180920191646.18198-1-f.fainelli@gmail.com>
 <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
 <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com>
 <3d4b406b-4fa4-9248-a0ab-d4eeea808034@gmail.com>
 <58d4992a-a06e-60e7-1856-5cd87741a771@gmail.com>
 <20180929085622.GD270328@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <31fa33d5-afc2-b388-95f7-103451e9df3e@kernel.dk>
Date:   Sat, 29 Sep 2018 20:35:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180929085622.GD270328@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/18 2:56 AM, Tejun Heo wrote:
> On Fri, Sep 28, 2018 at 03:41:23PM -0700, Florian Fainelli wrote:
>> On 09/25/2018 09:12 AM, Florian Fainelli wrote:
>>> On 09/24/2018 11:19 PM, Kishon Vijay Abraham I wrote:
>>>> On Friday 21 September 2018 12:49 AM, Florian Fainelli wrote:
>>>>> On 09/20/2018 12:16 PM, Florian Fainelli wrote:
>>>>>> Hi Kishon, Tejun,
>>>>>>
>>>>>> This patch series adds support for the SATA AHCI and PHY found on the
>>>>>> ARM-basd BCM63138 DSL SoCs.
>>>>>>
>>>>>> It would probably make sense for patches 1-3 to go through Kishon's
>>>>>> tree, patches 4-7 through Tejun's tree, and I would be merging the last
>>>>>> two patches through the Broadcom ARM-SoC tree.
>>>>>>
>>>>>> Let me know if this is not a workable plan, thank you very much!
>>>>>
>>>>> Looks like I had left patches with the incorrect subject, please
>>>>> disregard the following patches:
>>>>>
>>>>> [PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built for
>>>>> DSL SoCs
>>>>> [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
>>>>> [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
>>>>>
>>>>> since they have incorrect/inconsistent titles, the other patches are
>>>>> fine though. Sorry about that.
>>>>
>>>> merged the first 3 patches to linux-phy tree.
>>>
>>> Thanks a lot Kishon!
>>
>> Tejun, are you good with picking up patches 4-7 and I take the last two?
>> Can you make sure you pick up the ones that contain "ahci_brcm" in their
>> subject, I had incorrectly formatted them initially, sorry again about that.
> 
> Jens is running the libata tree now.  Jens?

I looked over them, but the series seems somewhat messed up. Can you
resend 4-7?

-- 
Jens Axboe

