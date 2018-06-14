Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A5C65C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0C9208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NUcQVkW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0C9208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755509AbeFNUpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:45:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45756 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755272AbeFNUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q3puFswNuKO6yoOLdzhuH1D3gmQYXmQIzCavO9MS8Hc=; b=NUcQVkW6HLHdOBXEhe025JyP1F
        v0SCkbg8MTvLRvhppTctL9gfj1oMGQ6botSMw641tQkEbBvoXNbid+6igLmcMyt0YuouGVh7DVwui
        0lzj2ut5M4PgyhRB96WIP6meRTzeCLRU/ia6cj1oerYajDrGJo8b1CyhYruTg/N9PdLz/GL+OXy2M
        cp+cxIm/dclaMaRXUqOgqPLDBJlT3UNRDwdiz7/NAv0JQWj951WYohpiPykFelil+AwfDeZOm/5Y/
        5HvVxceKKsftM/pn6dYUmJhTRcsr6x6BcFWkPw6r5kK97Pc6dARjqKDvN622pkI408O5Q8eZDz2QW
        DMrlCsWQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTZ7V-0007q4-78; Thu, 14 Jun 2018 20:45:25 +0000
Subject: Re: [PATCH v8 03/10] firmware: xilinx: Add zynqmp IOCTL API for
 device control
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, michal.simek@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jolly Shah <jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
 <1529000862-11510-4-git-send-email-jollys@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3044c2b9-2268-dfcb-2d45-0117c6f91a8d@infradead.org>
Date:   Thu, 14 Jun 2018 13:45:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529000862-11510-4-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 11:27 AM, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add ZynqMP firmware IOCTL API to control and configure
> devices like PLLs, SD, Gem, etc.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  2 ++
>  2 files changed, 22 insertions(+)

Hi,

Does this driver claim (implement) some specific ioctl code or ID?

If so, its ioctl numbers should be documented in Documentation/ioctl/ioctl-number.txt.

thanks,
-- 
~Randy
