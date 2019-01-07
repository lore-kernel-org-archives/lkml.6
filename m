Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9124C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A820665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAGMLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:11:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:54148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfAGMLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:11:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF719AF5D;
        Mon,  7 Jan 2019 12:11:17 +0000 (UTC)
Message-ID: <1546863075.3037.33.camel@suse.com>
Subject: Re: [PATCH lora-next 3/5] net: lora: sx130x: Add PicoCell serdev
 driver
From:   Oliver Neukum <oneukum@suse.com>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Date:   Mon, 07 Jan 2019 13:11:15 +0100
In-Reply-To: <20190104112131.14451-4-afaerber@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
         <20190104112131.14451-4-afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-01-04 at 12:21 +0100, Andreas Färber  wrote:
> 
> +struct picogw_device {
> +	struct serdev_device *serdev;
> +
> +	u8 rx_buf[1024];

No, you cannot do that. AFAICT this buffer can be used for DMA.
Thus putting it into another data structure violates the rules
of DMA coherency. You must allocate it separately.

> +static int picogw_send_cmd(struct picogw_device *picodev, char cmd,
> +	u8 addr, const void *data, u16 data_len)
> +{
> +	struct serdev_device *sdev = picodev->serdev;
> +	u8 buf[4];
> +	int i, ret;
> +
> +	buf[0] = cmd;
> +	buf[1] = (data_len >> 8) & 0xff;
> +	buf[2] = (data_len >> 0) & 0xff;

We have macros for converting endianness and unaligned access.

> +	buf[3] = addr;
> +
> +	dev_dbg(&sdev->dev, "%s: %c %02x %02x %02x\n", __func__, buf[0],
> +		(unsigned int)buf[1], (unsigned int)buf[2], (unsigned int)buf[3]);
> +	for (i = 0; i < data_len; i++) {
> +		dev_dbg(&sdev->dev, "%s: data %02x\n", __func__, (unsigned int)((const u8*)data)[i]);
> +	}
> +
> +	ret = serdev_device_write_buf(sdev, buf, 4);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 4)
> +		return -EIO;
> +
> +	if (data_len) {
> +		ret = serdev_device_write_buf(sdev, data, data_len);
> +		if (ret < 0)
> +			return ret;
> +		if (ret != data_len)
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int picogw_recv_answer(struct picogw_device *picodev,
> +	char *cmd, bool *ack, void *buf, int buf_len,
> +	unsigned long timeout)
> +{
> +	int len;
> +
> +	timeout = wait_for_completion_timeout(&picodev->answer_comp, timeout);
> +	if (!timeout)
> +		return -ETIMEDOUT;

And? The IO is still scheduled. Simply erroring out is problematic.
If you see a timeout you need to kill the scheduled IO.

> +static int picogw_handle_answer(struct picogw_device *picodev)
> +{
> +	struct device *dev = &picodev->serdev->dev;
> +	unsigned int data_len = ((u16)picodev->rx_buf[1] << 8) | picodev->rx_buf[2];
> +	int cmd_len = 4 + data_len;
> +	int i, ret;
> +
> +	if (picodev->rx_len < 4)
> +		return 0;
> +
> +	if (cmd_len > sizeof(picodev->rx_buf)) {
> +		dev_warn(dev, "answer too long (%u)\n", data_len);
> +		return 0;
> +	}
> +
> +	if (picodev->rx_len < cmd_len) {
> +		dev_dbg(dev, "got %u, need %u bytes\n", picodev->rx_len, cmd_len);
> +		return 0;
> +	}
> +
> +	dev_dbg(dev, "Answer %c =%u %s (%u)\n", picodev->rx_buf[0],
> +		(unsigned int)picodev->rx_buf[3],
> +		(picodev->rx_buf[3] == 1) ? "OK" : "K0",
> +		data_len);
> +	for (i = 0; i < data_len; i++) {
> +		//dev_dbg(dev, "%s: %02x\n", __func__, (unsigned int)picodev->rx_buf[4 + i]);
> +	}
> +
> +	complete(&picodev->answer_comp);
> +	ret = wait_for_completion_interruptible_timeout(&picodev->answer_read_comp, HZ / 2);

Problematic. You have no idea when that complete() will have an effect.
You are operating with an undefined timeout here. Theoretically it
could be negative.

	Regards
		Oliver

