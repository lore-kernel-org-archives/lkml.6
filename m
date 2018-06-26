Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9A3C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75172262BB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dgn+sf59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75172262BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755781AbeFZAFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:05:33 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45945 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754980AbeFZAFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:05:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id o18-v6so6906224pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Ezy/Lem0rIEKXNibWSZX7yYpcuQTIvqQqWys6W340k=;
        b=Dgn+sf59t0ximuB0zH8r3Dv/Oj+K2ln8bwohe/7pJaJ0VTkCWXejBZiuAYk0B8wIkR
         pxC0FJAZwxkzkW0Jcnl8TJabGnVEGhuJeKgTvheen/lk7vqaL7qWlzSfrYqByQq/4Gbq
         fgsMaWyR6lkXf3fC1zjZ5vNZQ5hL/z80y/kng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Ezy/Lem0rIEKXNibWSZX7yYpcuQTIvqQqWys6W340k=;
        b=mu+uV8OWG0mM7qba1n9crds6sKugDkY6pRKNyfSFZW5wCDqYUzaQlJQHVD3/x9PScw
         MQViLFBYR3IBnthN7GOhNl69HXEf0wP1djH6FtD7CQcI0YBV6VJxumzUEhjrNQsk4ScG
         JQ5EC49Civ6nIVhe9dTHh5+/YOCaPzcJ69bJp3Kbvm2udm7szdBJuuRQUosrSokrmD3c
         HUWm5c/O6tCTbnKtAkiitZw928EnEcJlxVRdiAUGFUpg3KLj2vCzRcMJOuvEgUyFaHi6
         Y5PX/lhc33DiWxoFGQ8AxQhTw+mzhY0ckl6wOV49+7SGCjUDKLWOZaUUyb9MVRB8hP4g
         JoRw==
X-Gm-Message-State: APt69E0Lbek4hXxzxe4jSHsaUXyWKwkSH/UAylbqozDUt+va39ujlzg2
        bJmi0i8Be3Gm1Rn497B0u3RfFw==
X-Google-Smtp-Source: ADUXVKKtSbCPSHDV9h8u7RoV5iSyayFfwgkGg5Dq/32TDfgDZZK7UsCsZ3tVEeERZCVSfYPCGK52eA==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12-v6mr14382186plb.74.1529971530572;
        Mon, 25 Jun 2018 17:05:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id x2-v6sm176345pgq.33.2018.06.25.17.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 17:05:29 -0700 (PDT)
Date:   Mon, 25 Jun 2018 17:05:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
Message-ID: <20180626000529.GJ129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-5-bgodavar@codeaurora.org>
 <20180625234354.GI129942@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625234354.GI129942@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:43:54PM -0700, Matthias Kaehlcke wrote:
> This is a nice improvement, a few remaining questions inline.
> 
> On Mon, Jun 25, 2018 at 07:10:10PM +0530, Balakrishna Godavarthi wrote:
> > In function qca_setup, we set initial and operating speeds for Qualcomm
> > Bluetooth SoC's. This block of code is common across different
> > Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> > a wrapper function to set the speeds. So that future coming SoC's
> > can use these wrapper functions to set speeds.
> > 
> > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > ---
> > Changes in v8:
> >     * common function to set INIT and operating speeds.
> >     * moved hardware flow control to qca_set_speed().
> > 	
> > Changes in v7:
> >     * initial patch
> >     * created wrapper functions for init and operating speeds.
> > ---
> >  drivers/bluetooth/hci_qca.c | 89 +++++++++++++++++++++++++++----------
> >  1 file changed, 65 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index fe62420ef838..38b7dbe6c897 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -119,6 +119,11 @@ struct qca_data {
> >  	u64 votes_off;
> >  };
> >  
> > +enum qca_speed_type {
> > +	QCA_INIT_SPEED = 1,
> > +	QCA_OPER_SPEED
> > +};
> > +
> >  struct qca_serdev {
> >  	struct hci_uart	 serdev_hu;
> >  	struct gpio_desc *bt_en;
> > @@ -923,6 +928,60 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
> >  		hci_uart_set_baudrate(hu, speed);
> >  }
> >  
> > +static unsigned int qca_get_speed(struct hci_uart *hu,
> > +				  enum qca_speed_type speed_type)
> > +{
> > +	unsigned int speed = 0;
> > +
> > +	if (speed_type == QCA_INIT_SPEED) {
> > +		if (hu->init_speed)
> > +			speed = hu->init_speed;
> > +		else if (hu->proto->init_speed)
> > +			speed = hu->proto->init_speed;
> > +	} else {
> > +		if (hu->oper_speed)
> > +			speed = hu->oper_speed;
> > +		else if (hu->proto->oper_speed)
> > +			speed = hu->proto->oper_speed;
> > +	}
> > +
> > +	return speed;
> > +}
> > +
> > +static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
> > +{
> > +	unsigned int speed, qca_baudrate;
> > +	int ret;
> > +
> > +	if (speed_type == QCA_INIT_SPEED) {
> > +		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> > +		if (speed)
> > +			host_set_baudrate(hu, speed);
> > +		else
> > +			bt_dev_err(hu->hdev, "Init speed should be non zero");
> 
> The check for 'speed == 0' is done in multiple places. From this
> code I deduce that it is expected that both INIT and OPER speed are
> set to non-zero values. What happens if either of them is zero? Is the
> driver still operational?
> 
> > +		return 0;
> > +	}
> > +
> > +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> > +	if (!speed) {
> > +		bt_dev_err(hu->hdev, "operating speed should be non zero");
> > +		return 0;
> > +	}
> > +
> > +	qca_baudrate = qca_get_baudrate_value(speed);
> > +	bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
> > +	ret = qca_set_baudrate(hu->hdev, qca_baudrate);
> > +	if (ret) {
> > +		bt_dev_err(hu->hdev, "Failed to change the baudrate (%d)", ret);
> > +		return ret;
> > +	}
> > +
> > +	host_set_baudrate(hu, speed);
> > +
> > +	return ret;
> > +}
> 
> In the discussion on "[v7,8/8] Bluetooth: hci_qca: Add support for
> Qualcomm Bluetooth chip wcn3990" you mentioned the possbility to move
> the hci_uart_set_flow_control() calls into _set_speed(). This seemed
> interesting but finally it isn't done in this series. Did you
> encounter that it is not feasible/desirable for some reason?

I got that half wrong. "[v8,7/7] Bluetooth: hci_qca: Add support for
Qualcomm Bluetooth chip wcn3990" adds the flow control calls to
_set_speed() however there are still_set_flow_control() calls in
qca_setup(), which confused/s me.

Could you provide a brief summary on the situations (relevant for this
driver) in which flow controls needs to be enabled/disabled?
