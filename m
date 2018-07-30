Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF0C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA2820892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G9aTh4b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA2820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeG3Wbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:31:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41873 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbeG3Wbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:31:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so6085690ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+s3s7vmClttRoqUAxQqrCOU+mU4w3UtWb/jgeBziMU=;
        b=G9aTh4b4NVeEVa1rB+1rLfn8UzJzRvPIx6HZAGsAYPTTzKtegyOZqbEfFlN1FbQ8xH
         9sVfP2ZgPCy2dbV5M5jQxeNX5kDyhzStg2xyCQZoaz0+DGFLbTkHrC4E2dUv+7FbdEoO
         KjzvwjN124UjxkQY501BJGg4YMUBdsfX/lp7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+s3s7vmClttRoqUAxQqrCOU+mU4w3UtWb/jgeBziMU=;
        b=NGbT9VWR8iy9Zlq6Itc0/xXH0phLoe/K3/5TdaQKT7A6e0hzkAszYzzaR8CUsnISCX
         FB8i569yrWR5ahfnoUFg2gBvWxLr2FDqv4jyYBeXd7UZA85GhTU8qb8RVW35HBVNXRk2
         qzIyY1F72AtnuCA+npat7tkD8knY03GmiRyW5gdO7VmO9YpY3TBEbThZnNV/upVMFmNf
         h8z0SQMooP/QNLIPiW1mNhWj23a91NOXJWJBkr+Iqdscakxuk4aIiOXAfy/NhpEs5h2d
         upxy20E560WgIWbRL6Dgn3UuISXJ5fgo6RZ2ekm6cNYYDnBiT50XjsCuVsQmqZlUy0Uo
         zf5g==
X-Gm-Message-State: AOUpUlF6zPDs0P2ZjB14BrMm/x1FPIZy+Xa19dZDsuiP11+21JFY55Qv
        o114E4Bp1qprRm7ujP6V8gQyyw==
X-Google-Smtp-Source: AAOMgpfpTrVCG5duzshd43r8aDgGFIkbrT4qnlGMBkT+SB/CNqTqwakeL+12CbmefaUKZmqCeFh9jg==
X-Received: by 2002:a17:902:7009:: with SMTP id y9-v6mr18181101plk.249.1532984103769;
        Mon, 30 Jul 2018 13:55:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id u42-v6sm21916018pgn.1.2018.07.30.13.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:55:02 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:55:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH v11 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180730205502.GC68975@google.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
 <20180727141320.25218-8-bgodavar@bgodavar-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727141320.25218-8-bgodavar@bgodavar-linux.qualcomm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 07:43:20PM +0530, Balakrishna Godavarthi wrote:
> From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> 
> Add support to set voltage/current of various regulators
> to power up/down Bluetooth chip wcn3990.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v11:
>     * removed support to read regulator currents from dts.	
>     * updated review comments.

Updated regulator voltage ranges?

> +static int qca_wcn3990_init(struct hci_uart *hu, u32 *soc_ver)
> +{
> +	struct hci_dev *hdev = hu->hdev;
> +	int i, ret;
> +
> +	/* wcn3990 is a discrete Bluetooth chip connected to SoC.
> +	 * sometimes we will face communication synchronization issues,
> +	 * like reading version command timeouts. In which HCI_SETUP fails,
> +	 * to overcome these issues, we try to communicate by performing an
> +	 * cold power off and on.
> +	 */
> +	for (i = 0; i <= 3; i++) {
> +		ret = qca_power_setup(hu, true);
> +		if (ret)
> +			goto regs_off;
> +
> +		/* Forcefully enable wcn3990 to enter in to boot mode. */
> +		host_set_baudrate(hu, 2400);
> +		ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
> +		if (ret)
> +			goto regs_off;
> +
> +		qca_set_speed(hu, QCA_INIT_SPEED);
> +		ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
> +		if (ret)
> +			goto regs_off;
> +
> +		/* Wait for 100 ms for SoC to boot */
> +		msleep(100);
> +
> +		/* Now the device is in ready state to communicate with host.
> +		 * To sync host with device we need to reopen port.
> +		 * Without this, we will have RTS and CTS synchronization
> +		 * issues.
> +		 */
> +		serdev_device_close(hu->serdev);
> +		ret = serdev_device_open(hu->serdev);
> +		if (ret) {
> +			bt_dev_err(hu->hdev, "failed to open port");
> +			break;
> +		}
> +
> +		hci_uart_set_flow_control(hu, false);
> +		ret = qca_read_soc_version(hdev, soc_ver);
> +
> +		if (!ret)
> +			break;
> +
> +regs_off:
> +		bt_dev_err(hdev, "retrying to establish communication: %d",
> +			   i + 1);
> +		qca_power_shutdown(hdev);
> +	}
> +
> +	return ret;
> +}

I'm still not convinced that the retry loop is needed/desirable, I
commented on the discussion on v10.

> +static const struct qca_vreg_data qca_soc_data = {
> +	.soc_type = QCA_WCN3990,
> +	.vregs = (struct qca_vreg []) {
> +		{ "vddio",   1800000, 1900000,  15000  },
> +		{ "vddxo",   1800000, 1900000,  80000  },
> +		{ "vddrf",   1300000, 1350000,  300000 },
> +		{ "vddch0",  3300000, 3400000,  450000 },
> +	},

In v10 this was:

		{ "vddio",   1800000, 1800000,  15000  },
		{ "vddxo",   1800000, 1800000,  80000  },
		{ "vddrf",   1304000, 1304000,  300000 },
		{ "vddch0",  3000000, 3312000,  450000 },

I don't have concerns about the new voltage ranges, but you should
mention such changes in the changelog, ideally with a brief
description why the change was made.
