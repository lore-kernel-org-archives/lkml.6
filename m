Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C53CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95402081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C8vlNCrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95402081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeK1VDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:03:15 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:46138 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK1VDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:03:15 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EEC3610C11A4;
        Wed, 28 Nov 2018 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543399329; bh=2eEYBroUcxoZKIvO1Pwga1iilzoXVCMNhPoUiqSwc+w=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=C8vlNCrlQK68Vvv0xR4XY8kw8gcy5uIeIgonuxbKeWy88GUj463WaXNOCv4fDjA3i
         kRaZ6MGGa2/xEzcYNvqAsFzM+p8fyKsBWwdeElWvPxDYUjGxZk+SsVViZcgf9xwaFT
         4QWWa5oHp/qMeotxFLlJ0uexhPcmt1Rp0WyiiSElji6avbNja8ZL+V8nC+X9joAtj3
         CeGQtaRqiriE5vYbLKj7f9Fxx2Skysbf6DLYdRCOusvVtlfWVYMDiSUN26mIrSbvRK
         SIGG4Lp5c8wNVIZN09fx13Lhsu1N4pPRmDhCC7ez5axvXtIY5qxAsEHGZBoXAqbtM2
         HwUUgBpRrvyhA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id DD8E33E81;
        Wed, 28 Nov 2018 02:02:08 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 28 Nov 2018 02:02:08 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 28 Nov 2018 11:02:07 +0100
Received: from [10.0.2.15] (10.107.19.26) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 28 Nov
 2018 11:02:07 +0100
Subject: Re: [PATCH] net: dwc-xlgmac: set skb to NULL after freeing it
To:     Pan Bian <bianpan2016@163.com>
References: <1543396853-35188-1-git-send-email-bianpan2016@163.com>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <71f99f51-6bdc-0a25-d81c-12dc13f61271@synopsys.com>
Date:   Wed, 28 Nov 2018 10:02:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1543396853-35188-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.26]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-11-2018 09:20, Pan Bian wrote:
> The buffer skb is freed via dev_kfree_skb in a loop. After freeing skb,
> the value of packet_count is updated via packet_count++. If packet_count
> happens to equal the upper bound (i.e., budget), the loop will be broken
> and skb may be assigned to desc_data->state.skb. Resulting that
> desc_data->state.skb may point to a freed memory chunk. To fix this, the
> patch sets skb to NULL after dev_kfree_skb(skb).
>
> Signed-off-by: Pan Bian <bianpan2016@163.com>

This is missing the Fixes tag and your patch prefix should be
[PATCH net].

Thanks and Best Regards,
Jose Miguel Abreu
