Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBEEC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B31020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BvMAHvr1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T4eYNzAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B31020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJKOjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:39:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57994 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:39:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 445EE6063F; Thu, 11 Oct 2018 07:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539242037;
        bh=Nq6kym1pl8Kgr6ofuLIGbmm0n3GNiqcfAK0u40QadkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BvMAHvr1FdpWwuITK3uzaDUsmpYHOndnd1mX1hCplYCDS3roLzIZwRhjdRQ0HbxIm
         SCZ9GdHz7H+VnVNSbPg8angR/muz13nWn7fIYGxLkiu1GaeYDXJIEGSMbPp3M3+Dix
         xgYYzGKSTh6kIRpBNG1/O4qj5judQMuUX+Uqh9es=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9CA1B60B0D;
        Thu, 11 Oct 2018 07:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539242036;
        bh=Nq6kym1pl8Kgr6ofuLIGbmm0n3GNiqcfAK0u40QadkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T4eYNzAJTMwIylukMMqMqbMFxbtqkYobWIegteZDkyFFtaEL5pzkgOK9t+Y4p3buD
         PhqQwZ6nZZIY6+RL2Lg0N1aQ1rWEDUjJIKY98OKSa1YzTkRaJATiXkjjqAP0lFLkZ9
         xi8dbQPqI2wquCqx+Y8kF0jyYgKzUy1oyoiRawps=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Oct 2018 12:43:56 +0530
From:   alokc@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     broonie@kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
In-Reply-To: <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
 <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
Message-ID: <0cffce97ad9c25e397a450c43e31c397@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static irqreturn_t geni_spi_isr(int irq, void *data)
>> +{
>> +       struct spi_master *spi = data;
>> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +       struct geni_se *se = &mas->se;
>> +       u32 m_irq;
>> +       unsigned long flags;
>> +       irqreturn_t ret = IRQ_HANDLED;
>> +
>> +       if (mas->cur_mcmd == CMD_NONE)
>> +               return IRQ_NONE;
>> +
>> +       spin_lock_irqsave(&mas->lock, flags);
>> +       m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
>> +
>> +       if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & 
>> M_RX_FIFO_LAST_EN))
>> +               geni_spi_handle_rx(mas);
>> +
>> +       if (m_irq & M_TX_FIFO_WATERMARK_EN)
>> +               geni_spi_handle_tx(mas);
>> +
>> +       if (m_irq & M_CMD_DONE_EN) {
>> +               if (mas->cur_mcmd == CMD_XFER)
>> +                       spi_finalize_current_transfer(spi);
>> +               else if (mas->cur_mcmd == CMD_CS)
>> +                       complete(&mas->xfer_done);
>> +               mas->cur_mcmd = CMD_NONE;
>> +               /*
>> +                * If this happens, then a CMD_DONE came before all 
>> the Tx
>> +                * buffer bytes were sent out. This is unusual, log 
>> this
>> +                * condition and disable the WM interrupt to prevent 
>> the
>> +                * system from stalling due an interrupt storm.
>> +                * If this happens when all Rx bytes haven't been 
>> received, log
>> +                * the condition.
>> +                * The only known time this can happen is if 
>> bits_per_word != 8
>> +                * and some registers that expect xfer lengths in num 
>> spi_words
>> +                * weren't written correctly.
>> +                */
>> +               if (mas->tx_rem_bytes) {
>> +                       writel(0, se->base + 
>> SE_GENI_TX_WATERMARK_REG);
>> +                       dev_err(mas->dev, "Premature done. tx_rem = %d 
>> bpw%d\n",
>> +                               mas->tx_rem_bytes, 
>> mas->cur_bits_per_word);
>> +               }
>> +               if (mas->rx_rem_bytes)
>> +                       dev_err(mas->dev, "Premature done. rx_rem = %d 
>> bpw%d\n",
>> +                               mas->rx_rem_bytes, 
>> mas->cur_bits_per_word);
>> +       }
>> +
>> +       if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN)) {
>> +               mas->cur_mcmd = CMD_NONE;
>> +               complete(&mas->xfer_done);
>> +       }
>> +
>> +       writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
>> +       spin_unlock_irqrestore(&mas->lock, flags);
>> +       return ret;
> 
> Nitpick: Now this always returns IRQ_HANDLED, and we assign ret just to
> do that. Perhaps only return IRQ_HANDLED if one of the above if
> conditions is taken?

Not always. If ISR get triggered without setting proper cur_mcmd then it 
will return IRQ_NONE.
