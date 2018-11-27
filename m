Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC84C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241102133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="amznbjpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241102133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeK0LXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:23:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44886 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeK0LXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:23:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so4037026pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/T57492GUH9ZY+82mh7i4CE9AsqTtkI3ZG3pO+ZjY+4=;
        b=amznbjpYNr+SvajVa96b3wIXXjTFt8U4Gj+tTlY99W3HxDSPOJAlJmL5OUd3M3De6N
         7jj9XsbJ1iSVRRpnQQ7H+kk1lK0MXltxllQxufO1n2dSxve8Os11shGA4rd1fbNJoddP
         3/B/vdItFQmY8UQRA1NuPkhMH/iskBwNvpYHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/T57492GUH9ZY+82mh7i4CE9AsqTtkI3ZG3pO+ZjY+4=;
        b=mxwbElyc/RzUTw/5a8088OQpKhZN8sAgT23yLjLrqg7xf3cMVkYwG63ap1qe9xZMGn
         f/04/2MgBgRBVBOKAuQzz8JezdEeL8SoFxBg/9Y/xG7+/t1tnBqIe7Z2ybGDxSKS3FdD
         LC7FFaXWHkS0GwP+G+9eQk8EVdYkKLo9BOTvjTaGv/XUzAnt+Z7HUmGQSQS54qCgYTia
         ht2z9qz0iPiVuVKbie6gJgJB20EQaI0FzLuINvgkzUzv5B8qaX0P2NMKszH/7moXO1tg
         N6+4p61rRTp/y2SDdH4Rkt9Qd/LDxDAnb+X1bsP0oWQZ63owEvZOk4mtGiA7J0RkWzvG
         2o6A==
X-Gm-Message-State: AA+aEWY7XFUAzla78cSlh8KLsAu2e9M7yqdCZ/VMnY5wVgnfPSatWopd
        I444h7M8oJdcHK/QhAvGeTD2eg==
X-Google-Smtp-Source: AFSGD/UeXzvxGdXrqPLKKDBSaGMQGE0SmYNLLOJu1ey8T2IQlCSw6i+JhdqRSXMl8xPeRaTBIUjOFw==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr29602774plb.325.1543278466185;
        Mon, 26 Nov 2018 16:27:46 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id v2sm1861533pgs.0.2018.11.26.16.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 16:27:45 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:27:44 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_qca: Fix frame reassembly errors
 for wcn3990
Message-ID: <20181127002744.GZ22824@google.com>
References: <20181122121512.13136-1-bgodavar@codeaurora.org>
 <20181122121512.13136-4-bgodavar@codeaurora.org>
 <20181127000950.GY22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181127000950.GY22824@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:09:50PM -0800, Matthias Kaehlcke wrote:
> On Thu, Nov 22, 2018 at 05:45:12PM +0530, Balakrishna Godavarthi wrote:
> > During initalization of wcn3990, we observed UART is reading some
> > stray bytes on the Rx line. This is logging Frame reassembly errors
> > on the serial console. This could be because of tristate of Tx line
> > of wcn3990 during boot up.
> > 
> > [  176.929612] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> > [  176.945734] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> > [  176.953298] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> > [  177.010660] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> > [  177.067633] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> > 
> > Now we enable a flag during bootup to stop executing proto receive
> > function and clear it back once the initialization is done.
> > 
> > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > v2:
> >  * Updated commit text & comments.
> > v1: 
> >  * initial patch
> > ---
> >  drivers/bluetooth/hci_qca.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index ed905ea1c58a..2f3d9e16ba5a 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -56,6 +56,7 @@
> >  
> >  /* Controller states */
> >  #define STATE_IN_BAND_SLEEP_ENABLED	1
> > +#define STATE_DISCARD_RX		2
> >  
> >  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
> >  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> > @@ -511,6 +512,7 @@ static int qca_open(struct hci_uart *hu)
> >  		} else {
> >  			hu->init_speed = qcadev->init_speed;
> >  			hu->oper_speed = qcadev->oper_speed;
> > +			set_bit(STATE_DISCARD_RX, &qca->flags);
> >  			ret = qca_power_setup(hu, true);
> >  			if (ret) {
> >  				destroy_workqueue(qca->workqueue);
> > @@ -903,6 +905,13 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
> >  	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> >  		return -EUNATCH;
> >  
> > +	/* We discard Rx data received while device is in booting
> > +	 * stage, This is because of BT chip Tx line is in tristate.
> > +	 * Due to this we read some garbage data on UART Rx.
> > +	 */
> > +	if (test_bit(STATE_DISCARD_RX, &qca->flags))
> > +		return 0;
> > +
> >  	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
> >  				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
> >  	if (IS_ERR(qca->rx_skb)) {
> > @@ -1193,6 +1202,7 @@ static int qca_setup(struct hci_uart *hu)
> >  		if (ret)
> >  			return ret;
> >  
> > +		clear_bit(STATE_DISCARD_RX, &qca->flags);
> >  		ret = qca_read_soc_version(hdev, &soc_ver);
> >  		if (ret)
> >  			return ret;
> > @@ -1269,6 +1279,14 @@ static const struct qca_vreg_data qca_soc_data = {
> >  
> >  static void qca_power_shutdown(struct hci_uart *hu)
> >  {
> > +	struct qca_data *qca = hu->priv;
> > +
> > +	/* From this point we go into power off state,
> > +	 * disable IBS and discard all the queued data.
> > +	 */
> > +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> 
> Is IBS actually related to the frame reassembly errors or is this
> addressing a different issue? In 100 iteratios of 'hciconfig up/down'
> without clearing the flag I didn't observe any frame reassembly
> errors.

Looks like this addresses the "Bluetooth: Received HCI_IBS_SLEEP_IND
in rx state 0" messages that are seen when the interface is brought up
on a system with firmware binaries (with IBS support?). Please spin
this out into a separate patch.

Thanks

Matthias
