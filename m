Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91712C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416BB23C4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nPQGcDS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416BB23C4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934063AbeGFRl3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:41:29 -0400
Received: from vern.gendns.com ([206.190.152.46]:49750 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933708AbeGFRl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6cCnnBmM4IRyf2IJC9C8dVcPN2b296BXlSPikYs4MG8=; b=nPQGcDS0fLFmP5A/m0j48uwFWQ
        rDq1VuUItU6+1L29EcGsQUn0E8z2zwDZQTGqBX7C7nsqmg+K/gR5ppAffcjsfCpoSJ0v+gIrnrbUt
        mKIddzVoXJ1tRzvZad3tFD41q8991TQJJ3/zUuYOjr1W1nU+QF+Bvt6XOuZkAK3sEftZlViHt1KTP
        V/PZC2fyJS2M08mYtolY4PQO/L2ttM1w1TXenkcJseUmI9GPWdJ0BRj8FlF1sZD2yEhutzDBxqOxg
        JNcweSIjsFHoFXIXGVEvfPT37TIN1FJTyPcZkz4OHT0eW7WX24hLQ5pvE96QKKQIC3bmn+dPrfOLa
        LhMEXmAA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36670 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fbUjU-00BNJ4-Oe; Fri, 06 Jul 2018 13:41:24 -0400
Subject: Re: [PATCH v3 04/13] clk: davinci: psc-dm646x: use two lookup entries
 for the aemif clock
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <20180628095748.4462-5-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <f4964264-55b9-0cb7-c36e-f49d71f689d7@lechnology.com>
Date:   Fri, 6 Jul 2018 12:41:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628095748.4462-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/2018 04:57 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to be able to get the clock both from the board file by its
> con_id and from the aemif driver by dev_id.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---


Applied to clk-davinci-4.19.

Thanks.


