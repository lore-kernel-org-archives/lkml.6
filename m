Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F91C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC051213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h4si3o/d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fLyo44Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC051213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeJDOUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:20:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeJDOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:20:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 43D946079B; Thu,  4 Oct 2018 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538638131;
        bh=HjrXyEOQR0dCIHda/ch3XFMzUZ9v01Lx6GEhabta3js=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h4si3o/d1/ak7+En6JPc7qBlfrujGh6dYV2xh3XJAaGmuY5qLiY/h+eL8NG4LbQ8o
         5T1eO/EpIntqyb9k8Fa4sRVGI/xnQCOic6MDiQOEyRNy1wLmvPbeicbYnzHmTwMfmJ
         gKoPdE0y/0Y2zblt1fVzhaeK7rOjTNGmKz/0vLCE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 498F36021C;
        Thu,  4 Oct 2018 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538638130;
        bh=HjrXyEOQR0dCIHda/ch3XFMzUZ9v01Lx6GEhabta3js=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fLyo44EbkndiILetHUfJKz6er17fRq2mOb4ckUsiDTbEKI/eUpiF5ZwSwUr9Rn69d
         i1h5MLmxqqBZCsD+OGR1zdZ/tf61WSrcmToDavz/HRmDmewsbyp4Tih5NufWyseOoD
         hkPjx/9sRq1osmleKh8aWN0LeTiBuEIQS34jH1mY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Oct 2018 12:58:50 +0530
From:   alokc@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-i2c-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/3] i2c: i2c-qcom-geni: Simplify tx/rx functions
In-Reply-To: <20180924235235.182649-2-swboyd@chromium.org>
References: <20180924235235.182649-1-swboyd@chromium.org>
 <20180924235235.182649-2-swboyd@chromium.org>
Message-ID: <71abf26e927bce446cfd47ca9879444a@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-25 05:22, Stephen Boyd wrote:
> We never really look at the 'ret' local variable in these functions, so
> let's remove it to make way for shorter and simpler code. Furthermore,
> we can shorten some lines by adding two local variables for the SE and
> the message length so that everything fits in 80 columns and testing 
> the
> 'dma_buf' local variable in lieu of the 'mode' local variable.  And
> kernel style is to leave the return statement by itself, detached from
> the rest of the function.
> 
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

changes looks more clean now.

Reviewed-by: Alok Chauhan <alokc@codeaurora.org>

>  drivers/i2c/busses/i2c-qcom-geni.c | 79 ++++++++++++++----------------
>  1 file changed, 36 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c
> b/drivers/i2c/busses/i2c-qcom-geni.c
> index 9f2eb02481d3..0b466835cf40 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -365,29 +365,24 @@ static int geni_i2c_rx_one_msg(struct
> geni_i2c_dev *gi2c, struct i2c_msg *msg,
>  				u32 m_param)
>  {
>  	dma_addr_t rx_dma;
> -	enum geni_se_xfer_mode mode;
> -	unsigned long time_left = XFER_TIMEOUT;
> +	unsigned long time_left;
>  	void *dma_buf;
> +	struct geni_se *se = &gi2c->se;
> +	size_t len = msg->len;
> 
> -	gi2c->cur = msg;
> -	mode = GENI_SE_FIFO;
>  	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
>  	if (dma_buf)
> -		mode = GENI_SE_DMA;
> -
> -	geni_se_select_mode(&gi2c->se, mode);
> -	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_RX_TRANS_LEN);
> -	geni_se_setup_m_cmd(&gi2c->se, I2C_READ, m_param);
> -	if (mode == GENI_SE_DMA) {
> -		int ret;
> -
> -		ret = geni_se_rx_dma_prep(&gi2c->se, dma_buf, msg->len,
> -								&rx_dma);
> -		if (ret) {
> -			mode = GENI_SE_FIFO;
> -			geni_se_select_mode(&gi2c->se, mode);
> -			i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
> -		}
> +		geni_se_select_mode(se, GENI_SE_DMA);
> +	else
> +		geni_se_select_mode(se, GENI_SE_FIFO);
> +
> +	writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
> +	geni_se_setup_m_cmd(se, I2C_READ, m_param);
> +
> +	if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
> +		geni_se_select_mode(se, GENI_SE_FIFO);
> +		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
> +		dma_buf = NULL;
>  	}
> 
>  	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> @@ -395,12 +390,13 @@ static int geni_i2c_rx_one_msg(struct
> geni_i2c_dev *gi2c, struct i2c_msg *msg,
>  		geni_i2c_abort_xfer(gi2c);
> 
>  	gi2c->cur_rd = 0;
> -	if (mode == GENI_SE_DMA) {
> +	if (dma_buf) {
>  		if (gi2c->err)
>  			geni_i2c_rx_fsm_rst(gi2c);
> -		geni_se_rx_dma_unprep(&gi2c->se, rx_dma, msg->len);
> +		geni_se_rx_dma_unprep(se, rx_dma, len);
>  		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
>  	}
> +
>  	return gi2c->err;
>  }
> 
> @@ -408,45 +404,41 @@ static int geni_i2c_tx_one_msg(struct
> geni_i2c_dev *gi2c, struct i2c_msg *msg,
>  				u32 m_param)
>  {
>  	dma_addr_t tx_dma;
> -	enum geni_se_xfer_mode mode;
>  	unsigned long time_left;
>  	void *dma_buf;
> +	struct geni_se *se = &gi2c->se;
> +	size_t len = msg->len;
> 
> -	gi2c->cur = msg;
> -	mode = GENI_SE_FIFO;
>  	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
>  	if (dma_buf)
> -		mode = GENI_SE_DMA;
> -
> -	geni_se_select_mode(&gi2c->se, mode);
> -	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_TX_TRANS_LEN);
> -	geni_se_setup_m_cmd(&gi2c->se, I2C_WRITE, m_param);
> -	if (mode == GENI_SE_DMA) {
> -		int ret;
> -
> -		ret = geni_se_tx_dma_prep(&gi2c->se, dma_buf, msg->len,
> -								&tx_dma);
> -		if (ret) {
> -			mode = GENI_SE_FIFO;
> -			geni_se_select_mode(&gi2c->se, mode);
> -			i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
> -		}
> +		geni_se_select_mode(se, GENI_SE_DMA);
> +	else
> +		geni_se_select_mode(se, GENI_SE_FIFO);
> +
> +	writel_relaxed(len, se->base + SE_I2C_TX_TRANS_LEN);
> +	geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
> +
> +	if (dma_buf && geni_se_tx_dma_prep(se, dma_buf, len, &tx_dma)) {
> +		geni_se_select_mode(se, GENI_SE_FIFO);
> +		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
> +		dma_buf = NULL;
>  	}
> 
> -	if (mode == GENI_SE_FIFO) /* Get FIFO IRQ */
> -		writel_relaxed(1, gi2c->se.base + SE_GENI_TX_WATERMARK_REG);
> +	if (!dma_buf) /* Get FIFO IRQ */
> +		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
> 
>  	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>  	if (!time_left)
>  		geni_i2c_abort_xfer(gi2c);
> 
>  	gi2c->cur_wr = 0;
> -	if (mode == GENI_SE_DMA) {
> +	if (dma_buf) {
>  		if (gi2c->err)
>  			geni_i2c_tx_fsm_rst(gi2c);
> -		geni_se_tx_dma_unprep(&gi2c->se, tx_dma, msg->len);
> +		geni_se_tx_dma_unprep(se, tx_dma, len);
>  		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
>  	}
> +
>  	return gi2c->err;
>  }
> 
> @@ -474,6 +466,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
> 
>  		m_param |= ((msgs[i].addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK);
> 
> +		gi2c->cur = &msgs[i];
>  		if (msgs[i].flags & I2C_M_RD)
>  			ret = geni_i2c_rx_one_msg(gi2c, &msgs[i], m_param);
>  		else

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
