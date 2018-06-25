Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D70BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0D426273
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="UmMj7EOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0D426273
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755543AbeFYXCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:02:31 -0400
Received: from vern.gendns.com ([206.190.152.46]:35083 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753205AbeFYXC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h3c1wC0NN7g5gFRbtOFLAPEI2WuLdyNuvC94qg932uY=; b=UmMj7EOq48lSjTteL9cQBJ5x44
        vMZ6C6fbK+sSBtcvejNJn24CGzvOWXfQTV8FhnU5HvjFSBDXByOFoIe7v58hvldExQpoLRqjJDFhA
        IRjpsTRG342YHwluhDvX1Y0CsoHU10PnY8O1MyXghdhVnmz+B9SeLUDqycBmt3rhZoZa8nNwrB4F3
        rkhYMC8MmPL3diWcSWjczMFFE6amHprqp+Cpt1TF/j2ukCY0UcIHlK92r23hK5Pby8/CjXHLhnSVE
        Ro3O2ttE1y3crCD9QRFxILeZD/Jo62C1pRfuSP3msdgoshF0L5aBq4nc+pMe+SCnBDLcnDZBrMu9S
        MqIM5Wow==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60372 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXaV7-002LVF-B6; Mon, 25 Jun 2018 19:02:25 -0400
Subject: Re: [RESEND (again) PATCH] clkdev: don't call __of_clk_get_by_name()
 unnecessarily from clk_get()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20180625160440.10537-1-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <5824a382-00fc-0af3-097f-519a36c2d555@lechnology.com>
Date:   Mon, 25 Jun 2018 18:02:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625160440.10537-1-brgl@bgdev.pl>
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

On 06/25/2018 11:04 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The way this function is implemented caused some confusion when
> converting the TI DaVinci platform to using the common clock framework.
> 
> Current kernel supports booting DaVinci boards both in device tree as
> well as legacy, board-file mode. In the latter, we always end up
> calling clk_get_sys() as of_node is NULL and __of_clk_get_by_name()
> returns -ENOENT.
> 
> It was not obvious at first glance how clk_get(dev, NULL) will work in
> board-file mode since we always call __of_clk_get_by_name(). Let's make
> it clearer by checking if of_node is NULL and skipping right to
> clk_get_sys().
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

