Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB4C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255B62186B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mesosphere.io header.i=@mesosphere.io header.b="e4kcwRYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255B62186B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mesosphere.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeHJQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:08:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35170 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbeHJQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:08:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id e6-v6so4799509edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mesosphere.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2J1p65jUosVCtGY+RSe8DI0tEoIfucrBTGkRbsseLC4=;
        b=e4kcwRYt/25sh7vWxFBLxRJujSXLn76UtoVPdNtIdrztUG15AwAmjAR26Nh12vHZt3
         sgAuLECJEPEPIGfvxCZuRyHVN6IfKRvexpnTB3+QEhm8sr6/gHyWcAbhQs4S7eoM/w0e
         8P8kX4GQoIAc5rSZWbZUPbRjjkQXQ4iXgF0OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2J1p65jUosVCtGY+RSe8DI0tEoIfucrBTGkRbsseLC4=;
        b=ry38fHI19UcYHqFiZnL6GDfIwELJiM307Z7sODTDqQ1SY4pTfbzVntOzvd3x5H9183
         qcTsR+WwuyXnBvdhExZ3BeOOgCOqRg084pMk/yu+tSK2siq3OIAZNlhdOVL+U1y7rCbH
         g3IBdtpJ+uYJRE+yhh2JJpbSy4Tv6Dk1dUFj+7LmDh/2TegqP3WunS2quREjn8yho9JA
         fXHv+LLkhmw2QBAOiY1DpkjTD82JCq4IEDodqu75QOVYesfjCiL+g2SW846x3xmsgqAh
         8XIXBrA7ihtLCOUvPHJ1M4fYNMDPrW1Pn/31GRWzvp4/PBlJ1z3s/4ozt/WMugjPzGep
         6dqQ==
X-Gm-Message-State: AOUpUlEGN4iF3yphGhD7HGhzCsKE2askIXskbU8rhPTHGfqUBNWLII96
        bXDObKRuuCU5afR8vLXb9kNFlQ==
X-Google-Smtp-Source: AA+uWPz/mLMmgetrWpUYOIDiyMdseju3jIToJjIT0O61wsakmW/3aXvw4LWPmtmPxgbmzZMp9t6omw==
X-Received: by 2002:a50:b86f:: with SMTP id k44-v6mr8371710ede.310.1533908306976;
        Fri, 10 Aug 2018 06:38:26 -0700 (PDT)
Received: from ?IPv6:2001:920:1961:8000:91a4:c122:87f:cfa0? ([2001:920:1961:8000:91a4:c122:87f:cfa0])
        by smtp.gmail.com with ESMTPSA id i22-v6sm3543087edr.65.2018.08.10.06.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:38:26 -0700 (PDT)
Subject: Re: [PATCH] perf tools: Check for null when copying nsinfo.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Benno Evers <bevers@mesosphere.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
References: <20180809215349.24299-1-bevers@mesosphere.com>
 <20180810045537.GA479@sejong> <20180810131847.GG5395@kernel.org>
From:   Benno Evers <bevers@mesosphere.io>
Message-ID: <d8d9132b-36af-951d-4932-42ec9fa1ae15@mesosphere.io>
Date:   Fri, 10 Aug 2018 15:38:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180810131847.GG5395@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haha, sorry, I was following some "how-to-contribute" guide out there, 
but it seems like I missed a step :D I sent out a new version with the 
missing sign-off.


On 10.08.2018 15:18, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 10, 2018 at 01:55:37PM +0900, Namhyung Kim escreveu:
>> Hello,
>>
>> On Thu, Aug 09, 2018 at 11:53:48PM +0200, Benno Evers wrote:
>>> The argument to nsinfo__copy() was assumed to be valid, but some code paths
>>> exist that will lead to NULL being passed.
>>>
>>> In particular, running 'perf script -D' on a perf.data file containing an
>>> PERF_RECORD_MMAP event associating the '[vdso]' dso with pid 0 earlier in
>>> the event stream will lead to a segfault.
>>>
>>> Since all calling code is already checking for a non-null return value,
>>> just return NULL for this case as well.
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>
>> It seems you missed the Signed-off-by though.
> Yeah, please collect Namhyung's Acked-by and provide yours, i.e. your
> patch should end with the following lines:
>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Benno Evers <bevers@mesosphere.com>
>
> My git-am scripts will collect the Cc from the e-mail message and add
> the Link:  with the Message-id.
>
> Thanks,
>
> - Arnaldo
>   
>> Thanks,
>> Namhyung
>>
>>
>>> ---
>>>   tools/perf/util/namespaces.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
>>> index 5be021701f34..cf8bd123cf73 100644
>>> --- a/tools/perf/util/namespaces.c
>>> +++ b/tools/perf/util/namespaces.c
>>> @@ -139,6 +139,9 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
>>>   {
>>>   	struct nsinfo *nnsi;
>>>   
>>> +	if (nsi == NULL)
>>> +		return NULL;
>>> +
>>>   	nnsi = calloc(1, sizeof(*nnsi));
>>>   	if (nnsi != NULL) {
>>>   		nnsi->pid = nsi->pid;
>>> -- 
>>> 2.17.1
>>>

