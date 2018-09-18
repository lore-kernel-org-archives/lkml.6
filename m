Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CA920880
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CA920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeISEu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:50:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39275 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeISEu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:50:27 -0400
Received: by mail-it0-f65.google.com with SMTP id h1-v6so5323747itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:organization:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qyCijqEYPntGwh9BMjACFQvIyIv3pf+v7mxoqG0uJis=;
        b=buS6hD3QsjLXT1hHEw7lcbRw/txXkka5tkD7WW28ac5JBR5D97b4p48lnn8+i3i190
         e+MEgEWEMF3npVwh0eIp/hIJrjWpyZtRQNiS7M8Kfi4z1mCJfat9ALgTuz+wCujGJ7YW
         Vp7vWAac/5XCvRt9UyYvH2uSMvOM2PqX23sajFla4UqJlwp4TTsx8HkEmwoZdIez+wmW
         V1TO6WJ4NYi9MOhePWLwOA3N7DZU31Cg5cveb9LdzcvrosE11J4P9w4PfRWCgPEWcyNS
         kleXkx2MgrjXcJT/Yo/fZIJxduNMxRaJVt0DPYgwCO0wBjbPzAMCG1jfKdWY+kT5eB2+
         fuCg==
X-Gm-Message-State: APzg51Ax/tInMj6JtT2xMb6VgRD+LtJmNn4QZlOKJUC3MVgaVhwJxi1f
        K+v47D3QF5BkxB+uIRGgEtIaNw==
X-Google-Smtp-Source: ANB0VdZtrovg7qqSYaHzTKcto7rLI5ZsIiUq9S8rrSaP7o1rvMQhfPMQDqhg45hJ4fVFF9aSNHshjQ==
X-Received: by 2002:a02:41d8:: with SMTP id n85-v6mr29609304jad.108.1537312533898;
        Tue, 18 Sep 2018 16:15:33 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7352502ita.2.2018.09.18.16.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 16:15:32 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isubramanian@apm.com" <isubramanian@apm.com>,
        "kchudgar@apm.com" <kchudgar@apm.com>,
        "qnguyen@apm.com" <qnguyen@apm.com>
References: <20180917233533.28626-1-ahs3@redhat.com>
 <20180917.193531.1424852853827678152.davem@davemloft.net>
 <a5adee73-dde7-d00f-e7ef-1f81dc7c813a@amd.com>
From:   Al Stone <ahs3@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ahs3@redhat.com; keydata=
 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
 AeZZwq9vgjZvBA==
Organization: Red Hat, Inc.
Message-ID: <4929e93d-508a-4670-9450-66e4fc85be7e@redhat.com>
Date:   Tue, 18 Sep 2018 17:15:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a5adee73-dde7-d00f-e7ef-1f81dc7c813a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 05:09 PM, Lendacky, Thomas wrote:
> 
> 
> On 09/17/2018 09:35 PM, David Miller wrote:
>> From: Al Stone <ahs3@redhat.com>
>> Date: Mon, 17 Sep 2018 17:35:33 -0600
>>
>>> @@ -866,8 +866,11 @@ static int xgene_enet_napi(struct napi_struct *napi, const int budget)
>>>  	processed = xgene_enet_process_ring(ring, budget);
>>>  
>>>  	if (processed != budget) {
>>> +		struct irq_desc *desc = irq_to_desc(ring->irq);
>>> +
>>>  		napi_complete_done(napi, processed);
> 
> The problem could be that the driver isn't checking the
> napi_complete_done() return code.  It was changed to return a bool and
> the check should be more like:
> 
>   if ((processed != budget) && napi_complete_done(napi, processed)) {
> 
> If it returns false, then the driver will get called for polling again
> after having issued enable_irq() and it well then issue the enable_irq()
> a second (or more) time without having the matching diable_irq().
> 
> Thanks,
> Tom

Aha, that might be.  My apologies -- I play in ACPI but seldom in the network
drivers, so was not fully aware of that change.  I can give that a try.

Thanks for the pointer.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
