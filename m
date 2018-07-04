Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41FCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFE0246CC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A/due6mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFE0246CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGDD5R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:57:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60668 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbeGDD5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:57:15 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w643v0UD008818;
        Tue, 3 Jul 2018 22:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530676620;
        bh=XCfJ1q/s8k0/2r67a1QIskpwO6bgnJqfEowKz/dv6+4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A/due6mo2ZR2yuYlEextDnZutuK0T+5fLqlsmLYZ4bS1CgYMe10OdFtns0d2iX1y4
         h3Q+Ab6GwCFpt/5tcJ2G4NuW4GrkIHsAw2mMYtL6lgOyYwQKJk3qKW8pFUx9zDWaUH
         9PCh+Fac9lvZYZbXJ4Erl8Cj6w0piSM2KRsKeVt8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w643v0uJ019618;
        Tue, 3 Jul 2018 22:57:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 3 Jul
 2018 22:56:59 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 3 Jul 2018 22:56:59 -0500
Received: from [172.22.187.102] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w643uxPk019065;
        Tue, 3 Jul 2018 22:56:59 -0500
Subject: Re: [PATCH v3 net-next 0/6] net: ethernet: ti: cpsw: add MQPRIO and
 CBS Qdisc offload
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC:     <corbet@lwn.net>, <akpm@linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <vinicius.gomes@intel.com>, <henrik@austad.us>,
        <jesus.sanchez-palencia@intel.com>, <ilias.apalodimas@linaro.org>,
        <p-varis@ti.com>, <spatton@ti.com>, <francois.ozog@linaro.org>,
        <yogeshs@ti.com>, <nsekhar@ti.com>, <andrew@lunn.ch>
References: <20180615181310.10437-1-ivan.khoronzhuk@linaro.org>
From:   "Strashko, Grygorii" <grygorii.strashko@ti.com>
Message-ID: <82972d3a-c098-b97d-26cf-a9642b858142@ti.com>
Date:   Tue, 3 Jul 2018 22:56:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615181310.10437-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On 6/15/2018 1:13 PM, Ivan Khoronzhuk wrote:
> This series adds MQPRIO and CBS Qdisc offload for TI cpsw driver.
> It potentially can be used in audio video bridging (AVB) and time
> sensitive networking (TSN).
> 
> Patchset was tested on AM572x EVM and BBB boards. Last patch from this
> series adds detailed description of configuration with examples. For
> consistency reasons, in role of talker and listener, tools from
> patchset "TSN: Add qdisc based config interface for CBS" were used and
> can be seen here: https://www.spinics.net/lists/netdev/msg460869.html
> 
> Based on net-next/master
> 
> v3..v2:
>   - corrected typo of "shaper" word, any functional changes
> 
> v2..v1:
>   - changed name cpsw.txt on ti-cpsw.txt
>   - changed name cpsw_set_tc() on cpsw_set_mqprio()
> 
> Ivan Khoronzhuk (6):
>    net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
>    net: ethernet: ti: cpdma: fit rated channels in backward order
>    net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
>    net: ethernet: ti: cpsw: add CBS Qdisc offload
>    net: ethernet: ti: cpsw: restore shaper configuration while down/up
>    Documentation: networking: cpsw: add MQPRIO & CBS offload examples
> 
>   Documentation/networking/ti-cpsw.txt    | 540 ++++++++++++++++++++++++
>   drivers/net/ethernet/ti/cpsw.c          | 364 +++++++++++++++-
>   drivers/net/ethernet/ti/davinci_cpdma.c |  31 +-
>   3 files changed, 913 insertions(+), 22 deletions(-)
>   create mode 100644 Documentation/networking/ti-cpsw.txt


Sry, for the delay
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
