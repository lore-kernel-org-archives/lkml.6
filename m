Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC3FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FAB20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FAB20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeINR6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:58:31 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:46988 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbeINR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:58:31 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 4C160B40061;
        Fri, 14 Sep 2018 12:44:10 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Sep 2018 05:44:07 -0700
Subject: Re: [PATCH v2,net-next 1/2] ip_gre: fix parsing gre header in
 ipgre_err
To:     David Miller <davem@davemloft.net>,
        <yanhaishuang@cmss.chinamobile.com>
CC:     <kuznet@ms2.inr.ac.ru>, <jbenc@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1536744082-3568-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <20180913.105840.140151724801067072.davem@davemloft.net>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <4bd44714-8190-feca-27dc-6f6b254341f8@solarflare.com>
Date:   Fri, 14 Sep 2018 13:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180913.105840.140151724801067072.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24094.003
X-TM-AS-Result: No-1.265400-4.000000-10
X-TMASE-MatchedRID: 5+1rHnqhWUQOwH4pD14DsPHkpkyUphL9f6/Md8Lb2l8S+jFO7d+PWxFh
        ASIm32ESIHvHLq6y9SYlGDdg0lZZyQXIgwc8UuR+84dsinZ5e1jljSRvSGpq3AagDhBTr1Yko8W
        MkQWv6iUD0yuKrQIMCBBWOoA5nlyNC24oEZ6SpSmb4wHqRpnaDur/VFDZgUnZ9dvopdtgvRyAgP
        AF3UgrsdqRClEwTKdsF/FpD8YEv2sEOgskqdAdar0IdXsJVoXCzXb/lfI3yCfSsUr1Ig/KbYfMZ
        MegLDIeGU0pKnas+RbnCJftFZkZizYJYNFU00e7N+XOQZygrvY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.265400-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24094.003
X-MDID: 1536929052-ERAb9xKpOvdN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/18 18:58, David Miller wrote:
> From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> Date: Wed, 12 Sep 2018 17:21:21 +0800
>
>> @@ -86,7 +86,7 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>>  
>>  	options = (__be32 *)(greh + 1);
>>  	if (greh->flags & GRE_CSUM) {
>> -		if (skb_checksum_simple_validate(skb)) {
>> +		if (csum_err && skb_checksum_simple_validate(skb)) {
>>  			*csum_err = true;
>>  			return -EINVAL;
>>  		}
> You want to ignore csum errors, but you do not want to elide the side
> effects of the skb_checksum_simple_validate() call which are to set
> skb->csum_valid and skb->csum.
>
> Therefore, the skb_checksum_simple_validate() call still needs to be
> performed. We just wont return -EINVAL in the NULL csum_err case.

How about just reversing the order of the AND?

	if (skb_checksum_simple_validate(skb) && csum_err) {
		*csum_err = true;
		return -EINVAL;
	}

