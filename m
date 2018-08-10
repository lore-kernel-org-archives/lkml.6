Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF7C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E452422448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YnK63IbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E452422448
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeHJUYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:24:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48126 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbeHJUYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:24:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7AHrI9T121610;
        Fri, 10 Aug 2018 12:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533923598;
        bh=QvHjhosZjfOexwEGHwV+FvA54JrmBcMOzIHsZT+LTf8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YnK63IbZOhLvPu9+9Cp0Mo/kMzeCmzTov/esvJn4EVl30dGzkOeUpBFePmvBp432U
         tI7eCSXAqatxmLZxYZIS4c1CMebxZhQoA+t+U/QGu6IlONXgPXRek0rh/T5eEHfEH7
         DvrGSVmvQdr1Bviaz6zMPaUSg0ORmz6htKUgqe3k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7AHrIIk031995;
        Fri, 10 Aug 2018 12:53:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 10
 Aug 2018 12:53:17 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 10 Aug 2018 12:53:17 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7AHrH8K011103;
        Fri, 10 Aug 2018 12:53:17 -0500
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw: fix runtime pm while add/del
 reserved vid
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC:     <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <877f6057-70e2-c13b-7937-334ebfef6889@ti.com>
Date:   Fri, 10 Aug 2018 12:53:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2018 07:47 AM, Ivan Khoronzhuk wrote:
> Here 2 not critical fixes for:
> - vlan ale table leak while error if deleting vlan (simplifies next fix)
> - runtime pm while try to set reserved vlan
> 
> Based on net/master
> 
> Ivan Khoronzhuk (2):
>    net: ethernet: ti: cpsw: clear all entries when delete vid
>    net: ethernet: ti: cpsw: fix runtime_pm while add/kill vlan
> 
>   drivers/net/ethernet/ti/cpsw.c     | 25 +++++++++++--------------
>   drivers/net/ethernet/ti/cpsw_ale.c |  2 +-
>   2 files changed, 12 insertions(+), 15 deletions(-)
> 

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
