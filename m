Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3DBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D872214D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xjf9RfM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D872214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeHBNtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:49:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54773 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeHBNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:49:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so2193103wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 04:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ifTTOSifsV/xtKwW6uj4Ori4LwlbvqnwtNtpPMVhj9c=;
        b=Xjf9RfM9Oj+qA9U6jzfkxUDKqJKX9mZ27yQrbw2uyNPMpaJqi9MyENVT3ahoFmnpNS
         zM8zECqQgZy9DEh7z3JmTXZAFOPu72wcUP0l5uoMFlHKQqtBLZlWSo/rcv84EM5u2B+B
         jisGmcyLwdHXpuuathrsBCqZnlyiJmmGdr39g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ifTTOSifsV/xtKwW6uj4Ori4LwlbvqnwtNtpPMVhj9c=;
        b=PBg4UFAM9Fec89y+hpty42ga1kst82fFn7VYwXKBBs0ZVeuFjgW6o9nhjHoK7okS7F
         hKetZDaEhAtEDiXwc7mj6L6+Xnjxx1F/whArMrYPEw3rW5mzTnOlyaVlcENVL7jK4U6c
         vFx5hIiPoet0d93XnMDPs/5MPKatVQfnuNexZeV3C/awVEzqNPCgUAD7fYMgbr13dP6c
         JQC8pZAbk3bJrXzllHQNj0CsNLZKtR8B+e8PfwlgQeuOsKyJgR3eay/lPTgB7qxncKcZ
         I/c9YdXSYd0QRH7Oq60UzYVEdQjMtbUeDlJOaAe2ydQYLSgIHVhvxGSQxcfT5Q1k+OJm
         kAoQ==
X-Gm-Message-State: AOUpUlG4NotqPOdp8txY1fAUG5Sn9PrmRam+BuNUG34uQaH4NCzQAGpP
        s6xRw/f/DCmcDHw7CZOHhJqD5A==
X-Google-Smtp-Source: AAOMgpf7Z/otlj01xPIfORcHETskLpgBQiQSL/IHubMzEl9XtZKjO+zPBTl9FE+1c2o+boTYnWjKIw==
X-Received: by 2002:a1c:864c:: with SMTP id i73-v6mr1861652wmd.40.1533211138477;
        Thu, 02 Aug 2018 04:58:58 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id n17-v6sm1753745wmc.13.2018.08.02.04.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 04:58:57 -0700 (PDT)
Subject: Re: [PATCH v7 1/8] interconnect: Add generic on-chip interconnect API
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-2-georgi.djakov@linaro.org>
 <fc7fd938-0e87-b88e-b2f2-ca8fd4134746@infradead.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <56986119-5365-e53a-6106-31f7d87d63dc@linaro.org>
Date:   Thu, 2 Aug 2018 14:58:55 +0300
MIME-Version: 1.0
In-Reply-To: <fc7fd938-0e87-b88e-b2f2-ca8fd4134746@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 08/02/2018 03:05 AM, Randy Dunlap wrote:
> On 07/31/2018 09:13 AM, Georgi Djakov wrote:
>> This patch introduces a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) between endpoints and
>> set the desired constraints on this data flow path. The providers receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  Documentation/interconnect/interconnect.rst |  96 ++++
>>  drivers/Kconfig                             |   2 +
>>  drivers/Makefile                            |   1 +
>>  drivers/interconnect/Kconfig                |  10 +
>>  drivers/interconnect/Makefile               |   2 +
>>  drivers/interconnect/core.c                 | 569 ++++++++++++++++++++
>>  include/linux/interconnect-provider.h       | 125 +++++
>>  include/linux/interconnect.h                |  42 ++
>>  8 files changed, 847 insertions(+)
>>  create mode 100644 Documentation/interconnect/interconnect.rst
>>  create mode 100644 drivers/interconnect/Kconfig
>>  create mode 100644 drivers/interconnect/Makefile
>>  create mode 100644 drivers/interconnect/core.c
>>  create mode 100644 include/linux/interconnect-provider.h
>>  create mode 100644 include/linux/interconnect.h
>>
>> diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
>> new file mode 100644
>> index 000000000000..e628881ee218
>> --- /dev/null
>> +++ b/Documentation/interconnect/interconnect.rst
>> @@ -0,0 +1,96 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=====================================
>> +GENERIC SYSTEM INTERCONNECT SUBSYSTEM
>> +=====================================
>> +
>> +Introduction
>> +------------
>> +
>> +This framework is designed to provide a standard kernel interface to control
>> +the settings of the interconnects on a SoC. These settings can be throughput,
> 
> I would say:                         on an SoC.
> 
> Do you pronounce that as "sock" or the letters S.O.C.?

Ah right indeed, this should be based on the phonetics and not the writing.

>> +latency and priority between multiple interconnected devices or functional
>> +blocks. This can be controlled dynamically in order to save power or provide
>> +maximum performance.
>> +
>> +The interconnect bus is a hardware with configurable parameters, which can be
> 
>                     bus is hardware

Ok.

>> +set on a data path according to the requests received from various drivers.
>> +An example of interconnect buses are the interconnects between various
>> +components or functional blocks in chipsets. There can be multiple interconnects
>> +on a SoC that can be multi-tiered.
> 
>       an SoC
> 
>> +
>> +Below is a simplified diagram of a real-world SoC interconnect bus topology.
>> +
>> +::
>> +
>> + +----------------+    +----------------+
>> + | HW Accelerator |--->|      M NoC     |<---------------+
>> + +----------------+    +----------------+                |
>> +                         |      |                    +------------+
>> +  +-----+  +-------------+      V       +------+     |            |
>> +  | DDR |  |                +--------+  | PCIe |     |            |
>> +  +-----+  |                | Slaves |  +------+     |            |
>> +    ^ ^    |                +--------+     |         |   C NoC    |
>> +    | |    V                               V         |            |
>> + +------------------+   +------------------------+   |            |   +-----+
>> + |                  |-->|                        |-->|            |-->| CPU |
>> + |                  |-->|                        |<--|            |   +-----+
>> + |     Mem NoC      |   |         S NoC          |   +------------+
>> + |                  |<--|                        |---------+    |
>> + |                  |<--|                        |<------+ |    |   +--------+
>> + +------------------+   +------------------------+       | |    +-->| Slaves |
>> +   ^  ^    ^    ^          ^                             | |        +--------+
>> +   |  |    |    |          |                             | V
>> + +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
>> + | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
>> + +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
>> +           |
>> +       +-------+
>> +       | Modem |
>> +       +-------+
>> +
>> +Terminology
>> +-----------
>> +
>> +Interconnect provider is the software definition of the interconnect hardware.
>> +The interconnect providers on the above diagram are M NoC, S NoC, C NoC, P NoC
>> +and Mem NoC.
>> +
>> +Interconnect node is the software definition of the interconnect hardware
>> +port. Each interconnect provider consists of multiple interconnect nodes,
>> +which are connected to other SoC components including other interconnect
>> +providers. The point on the diagram where the CPUs connect to the memory is
>> +called an interconnect node, which belongs to the Mem NoC interconnect provider.
>> +
>> +Interconnect endpoints are the first or the last element of the path. Every
>> +endpoint is a node, but not every node is an endpoint.
>> +
>> +Interconnect path is everything between two endpoints including all the nodes
>> +that have to be traversed to reach from a source to destination node. It may
>> +include multiple master-slave pairs across several interconnect providers.
>> +
>> +Interconnect consumers are the entities which make use of the data paths exposed
>> +by the providers. The consumers send requests to providers requesting various
>> +throughput, latency and priority. Usually the consumers are device drivers, that
>> +send request based on their needs. An example for a consumer is a video decoder
>> +that supports various formats and image sizes.
>> +
>> +Interconnect providers
>> +----------------------
>> +
>> +Interconnect provider is an entity that implements methods to initialize and
>> +configure a interconnect bus hardware. The interconnect provider drivers should
> 
>    configure interconnect bus hardware.
> (i.e., drop the "a")

Ok.

>> +be registered with the interconnect provider core.
>> +
>> +The interconnect framework provider API functions are documented in
>> +.. kernel-doc:: include/linux/interconnect-provider.h
> 
> What do you want that to do?  and does that happen?
> 
> The .. kernel-doc:: line won't be printed.  It will just be expanded to the
> contents of that header file, so the preceding sentence fragment will look/sound
> odd.

Thanks for catching this, I understood it incorrectly. Will improve it.

BR,
Georgi

>> +
>> +Interconnect consumers
>> +----------------------
>> +
>> +Interconnect consumers are the clients which use the interconnect APIs to
>> +get paths between endpoints and set their bandwidth/latency/QoS requirements
>> +for these interconnect paths.
>> +
>> +The interconnect framework consumer API functions are documented in
>> +.. kernel-doc:: include/linux/interconnect.h
> 
> same as above.
> 
> 
