Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A638C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343D320862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="omGD6dpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343D320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeHBByX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:54:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52828 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeHBByX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AkVMA+svaeBo3nUa5l93xxIl7a2PdP6SuI6GVSyQ22g=; b=omGD6dpZQc3iFmNdCd6EDuIjEn
        5WtrtpNCYW3JQfQPliHmnswegYMih32O8p+N8K+8jvERh9qD57zb9e1H4pr/w40op+ur6TxpVVYDD
        Mx4rvdqY6kz1n+1S4Hj5DCSmBMVo9t3IovZb1UBpKBAdCBwwOrNqwDGVyuSJLzLSWaSanDddZ37xz
        Y3BGZRbr8B/OISkNTCF0dv6enD1Ia8wJgtpKH+UGtcmstnRiwEBkxjehbNNfUchJ2UAOCcSjSTjv/
        kWq3nSuPl/Q3gd1GD/CYM9H2rBLlbv3gH3mDDeHYt+HcemWqVSQCB0VLMZc+U7l+N5SY9AS5GTfwC
        bFlrWBug==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fl17q-0002Fw-Ob; Thu, 02 Aug 2018 00:05:55 +0000
Subject: Re: [PATCH v7 1/8] interconnect: Add generic on-chip interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-2-georgi.djakov@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc7fd938-0e87-b88e-b2f2-ca8fd4134746@infradead.org>
Date:   Wed, 1 Aug 2018 17:05:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731161340.13000-2-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 09:13 AM, Georgi Djakov wrote:
> This patch introduces a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current
> demand.
> 
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) between endpoints and
> set the desired constraints on this data flow path. The providers receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/interconnect/interconnect.rst |  96 ++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   2 +
>  drivers/interconnect/core.c                 | 569 ++++++++++++++++++++
>  include/linux/interconnect-provider.h       | 125 +++++
>  include/linux/interconnect.h                |  42 ++
>  8 files changed, 847 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/core.c
>  create mode 100644 include/linux/interconnect-provider.h
>  create mode 100644 include/linux/interconnect.h
> 
> diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/interconnect/interconnect.rst
> new file mode 100644
> index 000000000000..e628881ee218
> --- /dev/null
> +++ b/Documentation/interconnect/interconnect.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +GENERIC SYSTEM INTERCONNECT SUBSYSTEM
> +=====================================
> +
> +Introduction
> +------------
> +
> +This framework is designed to provide a standard kernel interface to control
> +the settings of the interconnects on a SoC. These settings can be throughput,

I would say:                         on an SoC.

Do you pronounce that as "sock" or the letters S.O.C.?


> +latency and priority between multiple interconnected devices or functional
> +blocks. This can be controlled dynamically in order to save power or provide
> +maximum performance.
> +
> +The interconnect bus is a hardware with configurable parameters, which can be

                    bus is hardware

> +set on a data path according to the requests received from various drivers.
> +An example of interconnect buses are the interconnects between various
> +components or functional blocks in chipsets. There can be multiple interconnects
> +on a SoC that can be multi-tiered.

      an SoC

> +
> +Below is a simplified diagram of a real-world SoC interconnect bus topology.
> +
> +::
> +
> + +----------------+    +----------------+
> + | HW Accelerator |--->|      M NoC     |<---------------+
> + +----------------+    +----------------+                |
> +                         |      |                    +------------+
> +  +-----+  +-------------+      V       +------+     |            |
> +  | DDR |  |                +--------+  | PCIe |     |            |
> +  +-----+  |                | Slaves |  +------+     |            |
> +    ^ ^    |                +--------+     |         |   C NoC    |
> +    | |    V                               V         |            |
> + +------------------+   +------------------------+   |            |   +-----+
> + |                  |-->|                        |-->|            |-->| CPU |
> + |                  |-->|                        |<--|            |   +-----+
> + |     Mem NoC      |   |         S NoC          |   +------------+
> + |                  |<--|                        |---------+    |
> + |                  |<--|                        |<------+ |    |   +--------+
> + +------------------+   +------------------------+       | |    +-->| Slaves |
> +   ^  ^    ^    ^          ^                             | |        +--------+
> +   |  |    |    |          |                             | V
> + +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> + | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> + +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> +           |
> +       +-------+
> +       | Modem |
> +       +-------+
> +
> +Terminology
> +-----------
> +
> +Interconnect provider is the software definition of the interconnect hardware.
> +The interconnect providers on the above diagram are M NoC, S NoC, C NoC, P NoC
> +and Mem NoC.
> +
> +Interconnect node is the software definition of the interconnect hardware
> +port. Each interconnect provider consists of multiple interconnect nodes,
> +which are connected to other SoC components including other interconnect
> +providers. The point on the diagram where the CPUs connect to the memory is
> +called an interconnect node, which belongs to the Mem NoC interconnect provider.
> +
> +Interconnect endpoints are the first or the last element of the path. Every
> +endpoint is a node, but not every node is an endpoint.
> +
> +Interconnect path is everything between two endpoints including all the nodes
> +that have to be traversed to reach from a source to destination node. It may
> +include multiple master-slave pairs across several interconnect providers.
> +
> +Interconnect consumers are the entities which make use of the data paths exposed
> +by the providers. The consumers send requests to providers requesting various
> +throughput, latency and priority. Usually the consumers are device drivers, that
> +send request based on their needs. An example for a consumer is a video decoder
> +that supports various formats and image sizes.
> +
> +Interconnect providers
> +----------------------
> +
> +Interconnect provider is an entity that implements methods to initialize and
> +configure a interconnect bus hardware. The interconnect provider drivers should

   configure interconnect bus hardware.
(i.e., drop the "a")

> +be registered with the interconnect provider core.
> +
> +The interconnect framework provider API functions are documented in
> +.. kernel-doc:: include/linux/interconnect-provider.h

What do you want that to do?  and does that happen?

The .. kernel-doc:: line won't be printed.  It will just be expanded to the
contents of that header file, so the preceding sentence fragment will look/sound
odd.

> +
> +Interconnect consumers
> +----------------------
> +
> +Interconnect consumers are the clients which use the interconnect APIs to
> +get paths between endpoints and set their bandwidth/latency/QoS requirements
> +for these interconnect paths.
> +
> +The interconnect framework consumer API functions are documented in
> +.. kernel-doc:: include/linux/interconnect.h

same as above.


-- 
~Randy
