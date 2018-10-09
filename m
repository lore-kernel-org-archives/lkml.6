Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0834CC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0A3213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cy7vCog9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0A3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJJEbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:31:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39296 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJEbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:31:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w99LCGlR127447;
        Tue, 9 Oct 2018 16:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539119536;
        bh=G+9Y6w6VAIV5UkHpkOJQLceo1BED23riuHyn/t0oA00=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Cy7vCog9U3vHsYzSZimpdgbvurFcKWfWbhUNDqT3uCKhhds/hEgeH/Tdm4YPylgDg
         ll0dwt4wc84ODHDM1S2Mtu5wJBz6CN13qTm15Dks/wTMxS+/sinf83smn+lgCwopau
         nOyxsp04jGPxx74u1kVkLiuGPdoGYSqR/zhKbiwM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99LCGrY021268;
        Tue, 9 Oct 2018 16:12:16 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 16:12:16 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 16:12:16 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99LCGx8016441;
        Tue, 9 Oct 2018 16:12:16 -0500
Subject: Re: [RFC PATCH 00/11] net: ethernet: ti: cpsw: replace cpsw-phy-sel
 with phy driver
To:     Tony Lindgren <tony@atomide.com>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181009143631.GK5662@atomide.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <6f77b8a2-a973-4a13-8b9e-014648dea2c5@ti.com>
Date:   Tue, 9 Oct 2018 16:12:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009143631.GK5662@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 09:36 AM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
>> 2) introduce new PHY API for network interface mode selection which will use
>> already defined set of modes from phy_interface_t.
>>
>> Option 2 was selected for this series.
> 
> Looks good to me :) The dts files will cause merge conflicts with
> what I have pending for the ti-sysc changes so please send the dts
> changes in a separate series when posting without RFC.

expected. I did on top of mauster, but will rebase and resend if approved.

-- 
regards,
-grygorii
