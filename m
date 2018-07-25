Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC437C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891AD20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YjaTy5TB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891AD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbeGYSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:15:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46047 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbeGYSPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:15:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so5701497pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OiGBo+518rwaAJ4oU4DLbpg+/8imsg0Wpv4PxHuMRQI=;
        b=YjaTy5TBbrpHKbRQiCBh3rvX46c1zUlzpvrfYsc6n87kWO0Dr16Rnk8faVq5LoR6mJ
         cTENQr2iID1v/MhXFTweBQSYVn6NVX6Xea7g8yhsTDvyFG5WBG7vNj/Jbw+7b1OtEtU/
         gynEGzsdGBY9yNTzsIbiwndFu1HtF1Os+LTOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OiGBo+518rwaAJ4oU4DLbpg+/8imsg0Wpv4PxHuMRQI=;
        b=ShIfZeHe1tF9flV31+XBJfryZsj1Gt3JTP5226p/XKRTiq3gFr/a82JeNrn7Vfc+75
         keuU250sqYP0ObLeC51qRNiGogjPfrE1GWRg5XbsL0YiH9aLl1OY2u3wuZZUlYUThFbV
         mJet5akI+UF3OJ7om6zsaPbvueamZonlHsl7WLLS3lgBQASOjIALxtx/nBCEw8kSJA7R
         d/NcNgNZHj+28zPEzg6PJSJzNYTKoO8P17uSrMWtP9s2XWjqNiNN+tESaPNXeIB6vVMv
         oa3jR7r697jB1Yy2cAsPkAJDkRVkcxozEgICrYmPSS2efgZCNLKZKpJoIAQx70tbPZrc
         SsxA==
X-Gm-Message-State: AOUpUlH/Qr9v7WSeSqj22Q+z05DovwmJdByB4+4dfdE5dHYhYQQlVgZ1
        dIunzQ+aDv/SVMBz4K5hxUcXTSgO/e8=
X-Google-Smtp-Source: AAOMgpcayYzMx3/ACat583aQoNO8WQ4bt13IyIcZdOvZI3hkX/44J2OIoquMeWGVLqcSJCLnMLIzqw==
X-Received: by 2002:a62:198e:: with SMTP id 136-v6mr22930243pfz.103.1532538155057;
        Wed, 25 Jul 2018 10:02:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id v22-v6sm37076386pfi.60.2018.07.25.10.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:02:34 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:02:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
Message-ID: <20180725170233.GP129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-5-bgodavar@codeaurora.org>
 <20180723175611.GL129942@google.com>
 <12b59e77a4ee99c3de7bbd73ff10ce4b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12b59e77a4ee99c3de7bbd73ff10ce4b@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 12:32:36PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-07-23 23:26, Matthias Kaehlcke wrote:
> > On Fri, Jul 20, 2018 at 07:02:40PM +0530, Balakrishna Godavarthi wrote:
> > > In function qca_setup, we set initial and operating speeds for
> > > Qualcomm
> > > Bluetooth SoC's. This block of code is common across different
> > > Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> > > a wrapper function to set the speeds. So that future coming SoC's
> > > can use these wrapper functions to set speeds.
> > > 
> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 93
> > > ++++++++++++++++++++++++++++---------
> > >  1 file changed, 70 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index 5f1c0a8fd5cd..5f8a74d65bec 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -119,6 +119,11 @@ struct qca_data {
> > >  	u64 votes_off;
> > >  };
> > > 
> > > +enum qca_speed_type {
> > > +	QCA_INIT_SPEED = 1,
> > > +	QCA_OPER_SPEED
> > > +};
> > > +
> > >  struct qca_serdev {
> > >  	struct hci_uart	 serdev_hu;
> > >  	struct gpio_desc *bt_en;
> > > @@ -923,6 +928,61 @@ static inline void host_set_baudrate(struct
> > > hci_uart *hu, unsigned int speed)
> > >  		hci_uart_set_baudrate(hu, speed);
> > >  }
> > > 
> > > +static unsigned int qca_get_speed(struct hci_uart *hu,
> > > +				  enum qca_speed_type speed_type)
> > > +{
> > > +	unsigned int speed = 0;
> > > +
> > > +	if (speed_type == QCA_INIT_SPEED) {
> > > +		if (hu->init_speed)
> > > +			speed = hu->init_speed;
> > > +		else if (hu->proto->init_speed)
> > > +			speed = hu->proto->init_speed;
> > > +	} else {
> > > +		if (hu->oper_speed)
> > > +			speed = hu->oper_speed;
> > > +		else if (hu->proto->oper_speed)
> > > +			speed = hu->proto->oper_speed;
> > > +	}
> > > +
> > > +	return speed;
> > > +}
> > > +
> > > +static int qca_check_speeds(struct hci_uart *hu)
> > > +{
> > > +	if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
> > > +	    !qca_get_speed(hu, QCA_OPER_SPEED))
> > > +		return -EINVAL;
> > 
> > You changed this from:
> > 
> > 	/* One or the other speeds should be non zero. */
> > 	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
> > 	    !qca_get_speed(hu, QCA_OPER_SPEED))
> > 		return -EINVAL;
> > 
> > There is no entry in the change log. What is the reason for this
> > change?
> 
> [Bala] : My bad i missed to add the log,as the above  if for ROME chip,
> having INIT or OPER speed is fine.

Ok, thanks for the clarification, I recall this was discussed earlier.
