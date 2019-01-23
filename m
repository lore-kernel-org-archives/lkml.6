Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA12C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7570221726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RhKK5awk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gz1h7F9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfAWGpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:45:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfAWGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:45:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF4166044E; Wed, 23 Jan 2019 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548225911;
        bh=reB+sFH9gB/CGoVID6Zz79pLcZ3lKJFvt+jTIZLSX6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RhKK5awkx35OpEKQfsDlgpsB8fSz398MTuSzpf7RTu3Ix3L9tMrQWOiGF2ioxcgV2
         Qcf5kN1sTbgaiMzfCH4EDY5fKecilp3aAMWP+v03xkQCUj4ovHrLZZ5+ObXPZA+2pK
         IBpLwjiecznQhxrvHtJsMuhMHB1GZJzgddigNT/E=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5E7C660112;
        Wed, 23 Jan 2019 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548225910;
        bh=reB+sFH9gB/CGoVID6Zz79pLcZ3lKJFvt+jTIZLSX6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gz1h7F9aZIx9vCTR/DH+KMPWO5wCIbpTh/C6epWjghcttJMZMQzeC1DpSJHaCNXDR
         pqXyMYH/llShpLC/Ff7BPWL5d194X23uz6NUQcIEz8Gv68UD2U52SwIhy60JPMCcB4
         UlD+r/uZG4nUwg4WP1Syz6SMryxlnCH7Hw2Tuvuo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 12:15:10 +0530
From:   alokc@codeaurora.org
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 0/6] Add interconnect support for GENI QUPs
In-Reply-To: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Message-ID: <74b768d6573665fe2a4533a23ad23a9e@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mark Brown

On 2019-01-22 12:03, Alok Chauhan wrote:
> This patch series contains following:
> * Add wrapper framework to support interconnect path from GENI QUPs.
>   This wrapper enabled and help individual SEs to put their BW request.
>   Adding this wrapper make sense because we don't want individual SEs
>   to request to interconnect driver separately and put individual bw
>   votes from QUP.
> 
>   This wrapper framework does the following:
>   - Request for interconnect path handle
>   - Maintain record of individual SEs' avg/peak bw.
>   - Aggregated avg/peak bw based on how many SE's are active and put
>     single bw request from QUP
> 
> * Interconnect wrapper API calling from I2C, SPI & Uart driver
> * dt binding in sdm845 soc for Interconnect path for GENI QUPs
> * dt binding documentation
> 
> 
> Alok Chauhan (6):
>   dt-bindings: soc: qcom: Add interconnect binding for GENI QUP
>   soc: qcom: Add wrapper to support for Interconnect path
>   i2c: i2c-qcom-geni: Add interconnect support
>   spi: spi-geni-qcom: Add interconnect support
>   tty: serial: qcom_geni_serial: Add interconnect support
>   arm64: dts: sdm845: Add interconnect for GENI QUP
> 
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  10 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |  14 +++
>  drivers/i2c/busses/i2c-qcom-geni.c                 |  13 +++
>  drivers/soc/qcom/qcom-geni-se.c                    | 129 
> +++++++++++++++++++++
>  drivers/spi/spi-geni-qcom.c                        |  20 +++-
>  drivers/tty/serial/qcom_geni_serial.c              |  27 ++++-
>  include/linux/qcom-geni-se.h                       |  11 ++
>  7 files changed, 222 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
