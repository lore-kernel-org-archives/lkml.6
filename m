Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595C1C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1101220857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PFEROfTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1101220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbeGZUSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:18:54 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37278 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbeGZUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:18:53 -0400
Received: by mail-qk0-f193.google.com with SMTP id t79-v6so1714980qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zRUXTyqO68bW2EUOiVs9RoOG2P/UfwWbiy3okiawp20=;
        b=PFEROfTS1+Sy2EkqqlI1uJIoI3UvHGUTWYJ9MGTz7VVw+tFUH8jaR/Yz4gJMFVPE/c
         W2/e8BQBfmn49Uh6+8cLRge2Q0IxTTEsg0NKdB9mjqstrnrma1n4fT13CSpV79HV9b6J
         jNeyIE1ITf+3il92l5S8EX3wiLcejBMt/BStI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zRUXTyqO68bW2EUOiVs9RoOG2P/UfwWbiy3okiawp20=;
        b=hI/ombcq2+4THFkb2UvaApLzeHJE5lWsV5PVK10OerdbFaVuN8TmiG2FtwZkMRS8zc
         X3V/yo0r0Ryi7OguFEe54c8RTtkX9b6UJelsCVcx7zMLlneiqwiSV8rR6y3YDre0Mi0G
         NveGEHd6hf0AHAapqEWibMmg3B2oQc2LegdvAISwvjL2dk8ADElF1iyNx9wWh8OeF+tY
         7BbOtvoSG6oqzqXcEVbgxxCZSMLgzWevDVle7SLhqzT+joUxjFp+4vwjuZhjGcLBaQyf
         mOvlceRNHbDL5W/dvlfVVDKCZ4vjXOKdMcMN9vfwQ4U3RyO+xXC9hqse7dOcrUDQ1zhH
         MMjA==
X-Gm-Message-State: AOUpUlEipju1NdDyMQnyxfUW2nHAKhvaUGYg/VI1jzE22LkY676y6kpW
        D0FpE87RTpLKG5hgyUWiKZ3mnA==
X-Google-Smtp-Source: AAOMgpcuj8pLyRvPeODPIIPzg03EPn32IOOOYu743pss+Dd1jTnj5m4IaEdza90zk/y2mE2zTaCOYg==
X-Received: by 2002:a37:12d2:: with SMTP id 79-v6mr2945012qks.299.1532631645134;
        Thu, 26 Jul 2018 12:00:45 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v192-v6sm1566969qkb.0.2018.07.26.12.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:00:44 -0700 (PDT)
Subject: Re: [PATCH 0/7] Add clock config and pm support to bcm iProc mdio mux
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <20180726185246.GE10686@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <c9262069-54ba-6e8b-68f3-0d2b62d1d3ac@broadcom.com>
Date:   Thu, 26 Jul 2018 12:00:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180726185246.GE10686@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-07-26 11:52 AM, Andrew Lunn wrote:
> On Thu, Jul 26, 2018 at 11:36:17AM -0700, Arun Parameswaran wrote:
>> Hi,
>> The patchset is based on David Miller's "net" repo.
> 
> Hi Arun
> 
> "net" is intended for bug fixes. This looks like new features, so
> should be against net-next". Please read the netdev FAQ.
> 
>        Andrew
> 
Hi Andrew
The first three patches are 'fixes', and the subsequent patches
(which are new features) depend on the first 3 patches.

Since I had the 'fixes', and the dependency, I used the 'net'
repo.

Please advise if I should still use 'net-next' for all of them.

Thanks
Arun


