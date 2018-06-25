Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9DBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0623725A37
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQumZNy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0623725A37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeFYNR1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:17:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38774 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755568AbeFYNPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:15:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id d10-v6so6802311plo.5;
        Mon, 25 Jun 2018 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XiittI51yFow5yb4t8CRwkgvrw9/9VhGTDFlyddmTwk=;
        b=mQumZNy/z+Bmd/kI8O5Tc9vxuQRU3YMHeaknbQCM+UlwY+6dCTlqe61PKChBBPEzN4
         TCJcZ92+SbBRvLu/01nrNP6/6TsXjBZJgBfTfR+qoFqO+FGut2ZVRnSmUNfui0Oj3ttP
         wJ/y698f8aemR+G2aaBOhEexktHu2kzZHS/hkIAJ4x4BOOwxWbGoVRzRLE4ijZvwsO68
         0pOUOzncAVH+dQWVTU2C6xmUfiv8M2RTo4dMb172zeeM71bqz9+7O+5jEDrkN+S5Kcff
         nHFnI08CpdFuTs1OfOwnK5VkkkTh170b+kDdL/vMdE6jJVtXzhvRCyCvYAAbzWmlznUd
         pFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XiittI51yFow5yb4t8CRwkgvrw9/9VhGTDFlyddmTwk=;
        b=Ei7ZhWRqBSH/L0OfFM3ZDzWz4CcfxeYgdz9oiqy1wO5jUsOc5PQb6wHv0I5AP5VoyL
         kcszkmXopiwNbBhTyNNK3WbXrsgEAE8CSskkLyPuqYrRp7JTmB1LUXwyNoyfgcAUgH5N
         yVjl4VGPf7cNFn8f1dWH/bSwKZSGqGYm/RmeU9dmmquXFUqn03Ks6WO/ygj5J7FJISCr
         E1IiFGDaPW02rifoL/9X7V3DCSR1H2Xe1zhGSwxLu9+4xrk80pJku1QXUTLZJTFsaYB/
         3BZEmj+J5aWMdP17EnElxYSiww1hhGORC4KNlU4iR42G35VfaVmq/33eETDYMI9pMmo+
         d6MQ==
X-Gm-Message-State: APt69E3lSEvH+bjPCGL91qEc1bZ8nCjKq12iZUgEIMgi+r/j08H09fMJ
        bl7oEhkFhP4o+QtWvKtPklaIUg==
X-Google-Smtp-Source: ADUXVKJ9OxdxNP35rHY3MotXtzMiaD45/GL2FOij9exCJNT/kPz7i/b9s+bv/Wyb8YRMDWNDBS+p0g==
X-Received: by 2002:a17:902:722:: with SMTP id 31-v6mr12717484pli.3.1529932538457;
        Mon, 25 Jun 2018 06:15:38 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r65-v6sm3887941pfg.65.2018.06.25.06.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:15:37 -0700 (PDT)
Subject: Re: [PATCH V4 2/4] watchdog: stm32: add pclk feature for stm32mp1
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic BARRE <ludovic.barre@st.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
 <1529571737-3552-3-git-send-email-ludovic.Barre@st.com>
 <20180621165335.GA4563@roeck-us.net>
 <0bfe0082-2134-2d3b-322f-cd6c193a9974@st.com>
 <3f65a889-f625-9521-ea09-bcf7b5b24927@roeck-us.net>
 <b5f62568-ff2f-4a04-212e-a952bf009c88@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d92ec883-09ae-271f-69dd-156df17c3e98@roeck-us.net>
Date:   Mon, 25 Jun 2018 06:15:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b5f62568-ff2f-4a04-212e-a952bf009c88@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 05:52 AM, Alexandre Torgue wrote:
> Hi Guenter,
> 
> 
>>> But you are right I forgot to change stm32f429.dtsi.
>>> If I add a commit for stm32f429.dtsi, it's Ok for you ?
>>>
>>
>> Not really. You are imposing a personal preference on others,
>> and you would make stm32f429.dtsi inconsistent since it doesn't
>> use clock names for anything else.This in turn means that people
>> will have an endless source of irritation since they will need
>> a clock name for this node but not for others.
> 
> Why? This kind of implementation depends on each driver. Isn't ?
> 
> Or do you mean that if iwdg driver uses this implementation (clock name usage) all nodes inside stm32f429.dtsi should follow the same implementation ?
> 
>>
>> You will have to get the arm and DT maintainers to agree on this change.
> 
> As this patch makes easier integration of new platform, I agree with Ludovic proposition.
> 

Please provide a formal Acked-by:.

Guenter
