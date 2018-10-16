Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031FDC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4B42098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hpXWofUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4B42098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJQDam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:30:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48420 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJQDam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:30:42 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9GJcYkK108076;
        Tue, 16 Oct 2018 14:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539718714;
        bh=ry1DCDtpEG+friX9KDb9/mPFkLzrvBkzIZa2+pueuLk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hpXWofUYZ9PuKT/0kYsOyXr6IaJ/Qq9bAHLRSP1qjsqhJ3HTBg2vu5n6Jw0QO26nT
         z7mSe6HYHbncTdDSLDlaM0IpFuSFTcXQIiHCPye6NOTDkyAFXVmnE1QCKao0E3gtt8
         5TovMjgEgGz1vHyBtmlH9hdUaoJ1M4Sx7xEqSE4Y=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9GJcXVC005681;
        Tue, 16 Oct 2018 14:38:33 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 16
 Oct 2018 14:38:33 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 16 Oct 2018 14:38:33 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9GJcXP9031728;
        Tue, 16 Oct 2018 14:38:33 -0500
Subject: Re: [RFC PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC:     <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alexander.h.duyck@intel.com>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <92ab4728-109f-01cc-09db-3da4d8c8e92e@ti.com>
Date:   Tue, 16 Oct 2018 14:38:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2018 01:20 PM, Ivan Khoronzhuk wrote:
> The cpsw holds separate mcast entires for vlan entries. At this moment
> driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
> As result mcast for vlans doesn't work. It can be fixed by adding same
> mcast entries for every created vlan, but this patchseries uses more
> sophisticated way and allows to create mcast entries only for vlans
> that really require it. Generic functions from this series can be
> reused for fixing vlan and macvlan unicast.

I assume this is first of all for dual_mac mode.

> 
> Simple example of ALE table before and after this series, having same
> mcast entries as for vlan 100 as for real device (reserved vlan 2),
> and one mcast address only for vlan 100 - 01:1b:19:00:00:00.
> 
[...]

> vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x5, mem_list = 0x5
> ucast, vid = 100, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
> mcast, vid = 100, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
> mcast, vid = 100, addr = 33:33:00:00:00:01, port_mask = 0x1
> mcast, vid = 100, addr = 01:00:5e:00:00:01, port_mask = 0x1
> mcast, vid = 100, addr = 33:33:ff:47:7d:9d, port_mask = 0x1
> mcast, vid = 100, addr = 01:80:c2:00:00:00, port_mask = 0x1
> mcast, vid = 100, addr = 01:80:c2:00:00:03, port_mask = 0x1
> mcast, vid = 100, addr = 01:80:c2:00:00:0e, port_mask = 0x1
> mcast, vid = 100, addr = 33:33:00:00:00:fb, port_mask = 0x1
> mcast, vid = 100, addr = 33:33:00:01:00:03, port_mask = 0x1
> mcast, vid = 100, addr = 01:1b:19:00:00:00, port_mask = 0x1
> 			 ^^^
>      Here mcast entry (ptpl2), is added only for vlan 100
>      as it should be.
> 
> Based on net-next/master

Thank you.
For patches 2-4
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

For patch 1 - I'm not sure, so it'd good to get more comments.

> 
> Ivan Khoronzhuk (4):
>    net: core: dev_addr_lists: add auxiliary func to handle reference
>      address updates
>    net: 8021q: vlan_core: allow use list of vlans for real device
>    net: ethernet: ti: cpsw: fix vlan mcast
>    net: ethernet: ti: cpsw: fix vlan configuration while down/up
> 
>   drivers/net/ethernet/ti/cpsw.c | 189 +++++++++++++++++++++++++++------
>   include/linux/if_vlan.h        |  10 ++
>   include/linux/netdevice.h      |  10 ++
>   net/8021q/vlan_core.c          |  27 +++++
>   net/core/dev_addr_lists.c      |  97 +++++++++++++++++
>   5 files changed, 303 insertions(+), 30 deletions(-)
> 

-- 
regards,
-grygorii
