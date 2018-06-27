Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0258C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955F426844
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ntp0Bf6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955F426844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeF0KCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:02:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32908 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbeF0KCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:02:36 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RA1J48077206;
        Wed, 27 Jun 2018 05:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530093679;
        bh=gV1SZ22bp+fpdDNA2rReOekZXw4XEsKsJA2VUfxkndE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ntp0Bf6oj1nSKbZzxDBvdGXqbw616ZAzYE6LHBBdi2DqbuoY40PLROo28mdwaT54Q
         Ua1zaLsAPR/3C3PPJY965s+QinZudXdk6yTgq6WG+dj2fYA19Q7+99BxHBc/rJ1cQz
         1evL2N3zRgXyFuIMq2og5sNmT1QFHXkICHioefxA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RA1JAT004934;
        Wed, 27 Jun 2018 05:01:19 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 05:01:18 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 05:01:19 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RA1FQH026673;
        Wed, 27 Jun 2018 05:01:16 -0500
Subject: Re: [PATCH v2 04/13] clk: davinci: psc-dm646x: use two lookup entries
 for the aemif clock
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-5-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <1da88059-2d5b-f035-1d4c-9e21ae141017@ti.com>
Date:   Wed, 27 Jun 2018 15:31:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626092537.6737-5-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 June 2018 02:55 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to be able to get the clock both from the board file by its
> con_id and from the aemif driver by dev_id.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I see the DM365 and DM644x EVM board files getting reference to aemif
clock using just the con_id, but don't see that for DM646x. Am I
overlooking something?

Thanks,
Sekhar
