Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B678C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6A27ED6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RR0qV0kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF6A27ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937480AbeF2VBR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:01:17 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34620 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934806AbeF2VBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:01:10 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so458507ywg.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qeslvj0khRd6owYna/LP+gsXQ5FMUJ2841oDVc3g4cg=;
        b=RR0qV0kxrVucBrq+7+m7hMfZHOAVATPh/BwG99+QVHkbn1E5E4QYU0MlcougFC4U4q
         9gFEhXwrEchTAod8NrXY2afPnQNd4paZbhQBY9Ra9LuKTLDwkONZyKTHWSjLBdxaM10G
         BE+KYi2iG+XtEJ+ZSZKGMaS4KH1NmYbGmEBkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qeslvj0khRd6owYna/LP+gsXQ5FMUJ2841oDVc3g4cg=;
        b=EGX5O28t8PkUdepJstIzNDLrjy4TNi0Mf0eokrozN/o1B+xnVuF3nhARZYg2Jd8MgW
         f+z1+/T/LHo472XabSDktVPEJMwxWWOMNomosdaaqXR2z4PFQj6z1LnJeWW7l/EuWNIA
         kqDdi1RU4kZLtycXxzG/CvmKJCc0YKvfMEubcmDKuvc8Zz6+xumYkHB3GEJ3+lQ7nXON
         1fDob2ueTpYG/Z1Dw45xFPoLhdS/WdLnz1r28pswTLksAQNdJ1lrmwLmD/x6GzTmMvwn
         wZCBj3eIpz/6s0HZgPVlLdI45YfPlINl7R02lEgBQ6RkrCcZzC8icQ7RG6lvcCQfe4dV
         mScw==
X-Gm-Message-State: APt69E1dOCoEt4r24dlRHf7ntOIMXmQk225+P7QgyReYEDWcSDtjymhw
        z4Lq4ZBUNFsyzzfk8fo+k0SDhQ==
X-Google-Smtp-Source: ADUXVKKGJKJe8YE5l8/VH6DG3KGsCK+0sJm9n/HAgj9brmN7v+Bk64iDlAADdmqLYPFWntALnPCd+g==
X-Received: by 2002:a25:38f:: with SMTP id 137-v6mr8251031ybd.314.1530306070033;
        Fri, 29 Jun 2018 14:01:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 21-v6sm3705965ywf.28.2018.06.29.14.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 14:01:09 -0700 (PDT)
Date:   Fri, 29 Jun 2018 14:01:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
Message-ID: <20180629210108.GW129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-5-bgodavar@codeaurora.org>
 <20180625234354.GI129942@google.com>
 <89b1e4ce98a26d79935bf2ba9a4bc278@codeaurora.org>
 <20180626190207.GN129942@google.com>
 <4368cc0e04c26560f2adeb5ab796b827@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4368cc0e04c26560f2adeb5ab796b827@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 08:59:38PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-06-27 00:32, Matthias Kaehlcke wrote:
> > On Tue, Jun 26, 2018 at 07:01:18AM +0530, Balakrishna Godavarthi wrote:
> > > Hi Matthias,
> > > 
> > > On 2018-06-26 05:13, Matthias Kaehlcke wrote:
> > > > This is a nice improvement, a few remaining questions inline.
> > > >
> > > > On Mon, Jun 25, 2018 at 07:10:10PM +0530, Balakrishna Godavarthi wrote:
> > > > > In function qca_setup, we set initial and operating speeds for
> > > > > Qualcomm
> > > > > Bluetooth SoC's. This block of code is common across different
> > > > > Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> > > > > a wrapper function to set the speeds. So that future coming SoC's
> > > > > can use these wrapper functions to set speeds.
> > > > >
> > > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > > > ---
> > > > > Changes in v8:
> > > > >     * common function to set INIT and operating speeds.
> > > > >     * moved hardware flow control to qca_set_speed().
> > > > >
> > > > > Changes in v7:
> > > > >     * initial patch
> > > > >     * created wrapper functions for init and operating speeds.
> > > > > ---
> > > > >  drivers/bluetooth/hci_qca.c | 89
> > > > > +++++++++++++++++++++++++++----------
> > > > >  1 file changed, 65 insertions(+), 24 deletions(-)
> > > > >
> > > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > > > index fe62420ef838..38b7dbe6c897 100644
> > > > > --- a/drivers/bluetooth/hci_qca.c
> > > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > > @@ -119,6 +119,11 @@ struct qca_data {
> > > > >  	u64 votes_off;
> > > > >  };
> > > > >
> > > > > +enum qca_speed_type {
> > > > > +	QCA_INIT_SPEED = 1,
> > > > > +	QCA_OPER_SPEED
> > > > > +};
> > > > > +
> > > > >  struct qca_serdev {
> > > > >  	struct hci_uart	 serdev_hu;
> > > > >  	struct gpio_desc *bt_en;
> > > > > @@ -923,6 +928,60 @@ static inline void host_set_baudrate(struct
> > > > > hci_uart *hu, unsigned int speed)
> > > > >  		hci_uart_set_baudrate(hu, speed);
> > > > >  }
> > > > >
> > > > > +static unsigned int qca_get_speed(struct hci_uart *hu,
> > > > > +				  enum qca_speed_type speed_type)
> > > > > +{
> > > > > +	unsigned int speed = 0;
> > > > > +
> > > > > +	if (speed_type == QCA_INIT_SPEED) {
> > > > > +		if (hu->init_speed)
> > > > > +			speed = hu->init_speed;
> > > > > +		else if (hu->proto->init_speed)
> > > > > +			speed = hu->proto->init_speed;
> > > > > +	} else {
> > > > > +		if (hu->oper_speed)
> > > > > +			speed = hu->oper_speed;
> > > > > +		else if (hu->proto->oper_speed)
> > > > > +			speed = hu->proto->oper_speed;
> > > > > +	}
> > > > > +
> > > > > +	return speed;
> > > > > +}
> > > > > +
> > > > > +static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type
> > > > > speed_type)
> > > > > +{
> > > > > +	unsigned int speed, qca_baudrate;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (speed_type == QCA_INIT_SPEED) {
> > > > > +		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> > > > > +		if (speed)
> > > > > +			host_set_baudrate(hu, speed);
> > > > > +		else
> > > > > +			bt_dev_err(hu->hdev, "Init speed should be non zero");
> > > >
> > > > The check for 'speed == 0' is done in multiple places. From this
> > > > code I deduce that it is expected that both INIT and OPER speed are
> > > > set to non-zero values. What happens if either of them is zero? Is the
> > > > driver still operational?
> > > >
> > > [Bala]: yes in hci_uart_setup()(hci_serdev.c) function before calling
> > > qca_setup().
> > >         we actually set baudrate, but int  above code missed to
> > > restrict the
> > > further call to qca_setup()
> > >        if speed =0. so we are checking the same in the qca_setup()..
> > > i.e.
> > > qca_get_speed().
> > 
> > Sorry, didn't quite get you here. Yes, the driver is still operational?
> > 
> > Breaking it down in multiple questions:
> > 
> > 1. Is it an error if one of the speeds isn't specified?
> > 
> 
> [Bala]:  i want to break this issue for two chips.
>         for rome:  No, it is not a error if one of speeds are missing.
>                    but it is mandate to have at least one of the speeds.
>                    to current implementation we are strictly not checking
> this case.
>                    i.e. terminate qca_setup() if both speeds missing.
>                    will do this change in this patch.
>         for wnc3990: yes it an error if any of the speeds are missing.
>                      it is mandate to have both the speeds.
>                      to current implementation we are strictly not checking
> this case.
>                      i.e. terminate qca_setup() if any speeds missing.
>                      will integrate this in patch add support for wcn3990.
> 
>        "The check for 'speed == 0' is done in multiple places. From this
>        code I deduce that it is expected that both INIT and OPER speed are
>        set to non-zero values. What happens if either of them is zero? Is
> the
>        driver still operational"
> 
>       still we will have speed ==0 check for BT chip ROME. pls find code
> snippet below
> 
>          thanks for catching this corner case.

Thanks for the clarification

> > If yes we should probably check this early once and return an error
> > early, instead of doing the check repeatedly
> > 
> > 2. If it is not an error, what is the driver supposed to do?
> > 
> > > > In the discussion on "[v7,8/8] Bluetooth: hci_qca: Add support for
> > > > Qualcomm Bluetooth chip wcn3990" you mentioned the possbility to move
> > > > the hci_uart_set_flow_control() calls into _set_speed(). This seemed
> > > > interesting but finally it isn't done in this series. Did you
> > > > encounter that it is not feasible/desirable for some reason?
> > > >
> > > 
> > > [Bala]: this patch is for rome where flow control is not used.
> > >         after we integrate wcn3990, flow control is hidden in the
> > > qca_set_speed()
> > >         Pls check [v8 7/7] patch.
> > 
> > Sorry, my confusion
> > 
> > > > >  static int qca_setup(struct hci_uart *hu)
> > > > >  {
> > > > >  	struct hci_dev *hdev = hu->hdev;
> > > > > @@ -937,35 +996,17 @@ static int qca_setup(struct hci_uart *hu)
> > > > >  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> > > > >
> > > > >  	/* Setup initial baudrate */
> > > > > -	speed = 0;
> > > > > -	if (hu->init_speed)
> > > > > -		speed = hu->init_speed;
> > > > > -	else if (hu->proto->init_speed)
> > > > > -		speed = hu->proto->init_speed;
> > > > > -
> > > > > -	if (speed)
> > > > > -		host_set_baudrate(hu, speed);
> > > > > +	qca_set_speed(hu, QCA_INIT_SPEED);
> > > > >
> > > > >  	/* Setup user speed if needed */
> > > > > -	speed = 0;
> > > > > -	if (hu->oper_speed)
> > > > > -		speed = hu->oper_speed;
> > > > > -	else if (hu->proto->oper_speed)
> > > > > -		speed = hu->proto->oper_speed;
> > > > > +	ret = qca_set_speed(hu, QCA_OPER_SPEED);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > >
> > > > > -	if (speed) {
> > > > > +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> > > > > +	if (speed)
> > > > >  		qca_baudrate = qca_get_baudrate_value(speed);
> > > >
> > > > Is the check here necessary? qca_get_baudrate_value() returns
> > > > QCA_BAUDRATE_115200 for a zero speed.
> > > 
> > > this if for no zero operating speed,
> > 
> > My point is:
> > 
> > static int qca_setup(struct hci_uart *hu)
> > {
> > 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
> > 
> > 	...
> > 
> > 	if (speed)
> > 		qca_baudrate = qca_get_baudrate_value(speed);
> > }
> > 
> > static uint8_t qca_get_baudrate_value(int speed)
> > {
> >         switch (speed) {
> > 
> > 	...
> > 
> >         default:
> >                 return QCA_BAUDRATE_115200;
> >         }
> > }
> > 
> > If qca_get_baudrate_value() is called with 'speed == 0' it returns
> > QCA_BAUDRATE_115200, which is the same value with which
> > QCA_BAUDRATE_115200 is initialized.
> > 
> > It seems the initialization and the check for 'speed == 0' could be
> > removed.
> 
> [Bala]: the above speed == 0 is highly recommended, let us assume ROME chip
> init speed moved from 115200 to 2000000 and operating speed is defined as
> zero.
>        then this check will help us. else if we remove speed ==0 then in
> qca_baudrate we will end up having a different value.
>         Pls find the code snippet for better understanding.

Hm, still not clear to me, I'm no Bluetooth expert, maybe I'm missing
something that seems obvious to others.

What exactly do you mean with "init speed moved from 115200 to
2000000"?

Is it that the first qca_set_speed(hu, QCA_INIT_SPEED) call in
qca_setup() uses hu->proto->init_speed and the second one
hu->init_speed after it was initialized in qca_open()?

I saw you added a new assignment of qca_baudrate below, which probably
is related, though you don't mention it here:

        /* Setup initial baudrate */
        qca_set_speed(hu, QCA_INIT_SPEED);
        speed = qca_get_speed(hu, QCA_INIT_SPEED);
        if (speed)
                qca_baudrate = qca_get_baudrate_value(speed);


I find it really hard to discuss in code snippets, it's probably best
to send a new version of the patch and discuss it with the full
context.

Regarding the new qca_get_speed() and assignment of qca_baudrate: if
this needs to be done it should probably be moved just before this block
to keep things together:

        speed = qca_get_speed(hu, QCA_OPER_SPEED);
        if (speed)
                qca_baudrate = qca_get_baudrate_value(speed);

If I didn't lose myself jumping back and forth between the snippets
and v8 qca_baudrate isn't used before. And if that is correct then it
probably shouldn't be moved before the block, but rewritten to:

        speed = qca_get_speed(hu, QCA_OPER_SPEED);
        if (!speed)
	        // Note mka@: no need to check 'speed', we know at
		// least one of them is set
	        speed = qca_get_speed(hu, QCA_INIT_SPEED);

        qca_baudrate = qca_get_baudrate_value(speed);

Not sure if that's correct, but it seems reasonable in the sense that
you said that at least one of the speeds needs to be set and it
certainly looks cleaner than the spread out _get_speed() and
qca_get_baudrate_value(). But maybe I just got it wrong and reality is
more ugly, best sent a new patch and have the full context.

> after your suggestion. code snippet along with wcn3990 integration.
> 
> 
> [Bala]: for rome any one of the speeds are required.
>         for wcn3990 requires both speeds.
> 
> static int qca_check_speeds(struct hci_uart *hu)
> {
>         struct qca_serdev *qcadev;
> 
>         qcadev = serdev_device_get_drvdata(hu->serdev);
>         if (qcadev->btsoc_type == QCA_WCN3990) {
>                 /* QCA WCN3990 requires both the speed values. */
>                 if (qca_get_speed(hu, QCA_INIT_SPEED) &&
>                     qca_get_speed(hu, QCA_OPER_SPEED))
> 
>                         return 0;
> 
>                 bt_dev_err(hu->hdev, "Both the speeds should be non zero");
>                 return 1;
>         }

It would probably be clearer to invert the logic, and check for the
error condition and return 0 in the main branch (or even better, at
the end of the function).


>         if (qca_get_speed(hu, QCA_INIT_SPEED) ||
>              qca_get_speed(hu, QCA_OPER_SPEED))
>                 return 0;
> 
>         bt_dev_err(hu->hdev, "either of the speeds should be non zero");
>         return 1;

ditto

>         [Bala]: pls suggest, what could be error no if above criteria is not
> met.

I think you could use -EINVAL as it would be a configuration error.

> static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type
> speed_type)
> {
>         struct qca_serdev *qcadev;
>         unsigned int speed, qca_baudrate;
>         int ret;
> 
>         if (speed_type == QCA_INIT_SPEED) {
>                 speed = qca_get_speed(hu, QCA_INIT_SPEED);
>                 if (speed)
>                         host_set_baudrate(hu, speed);
>                 [Bala]: this speed check is required for ROME, that if ROME
> init speed is zero.
>                 return 0;
>         }

Just noticed, I think this would be clearer with an else branch. The
current structure might be based on a comment from me on an earlier
version of the _set/get_speed() rework, where I suggested to return to
save a level of indentation. Here we set either INIT or OPER speed,
not having the else branch can give the impression that both might be
set.

>         speed = qca_get_speed(hu, QCA_OPER_SPEED);
>         if (!speed)
>                 return 0;
>         [Bala]: this speed check is required for ROME, that if ROME
> operating speed is zero.
> 
> [Bala]: this is speeds in both OPER and init speeds are required.. as we
> move forward if any one of the speed is set.
> 
>         qcadev = serdev_device_get_drvdata(hu->serdev);
>         /* Disabling hardware flow control is preferred while
>          * sending change baud rate command to SoC.
> if (qcadev->btsoc_type == QCA_WCN3990)
>                 hci_uart_set_flow_control(hu, true);
> 
>         qca_baudrate = qca_get_baudrate_value(speed);
>         bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
>         ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>         if (ret) {
>                 bt_dev_err(hu->hdev, "Failed to change the baudrate (%d)",
> ret);
>                 return ret;
>         }
> 
>         host_set_baudrate(hu, speed);
>         if (qcadev->btsoc_type == QCA_WCN3990)
>                 hci_uart_set_flow_control(hu, false);
> 
>         return 0;
> }
> 
> static int qca_setup(struct hci_uart *hu)
> {
>         struct hci_dev *hdev = hu->hdev;
>         struct qca_data *qca = hu->priv;
>         unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>         struct qca_serdev *qcadev;
>         int ret;
>         int soc_ver = 0;
> 
>         qcadev = serdev_device_get_drvdata(hu->serdev);
> 
>         /* Patch downloading has to be done without IBS mode */
>         clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> 
>         ret = qca_check_speeds(hu);
>         if (ret)
>                 return ret;
> 
>         /* Setup initial baudrate */
>         qca_set_speed(hu, QCA_INIT_SPEED);
>         speed = qca_get_speed(hu, QCA_INIT_SPEED);
>         if (speed)
>                 qca_baudrate = qca_get_baudrate_value(speed);
> 
> [Bala]: i have newly add above statement. initial speed of both ROME and
> wcn3990 when the chip boot up is 115200.
>         in future, if we have new chip where initial  speed of chip during
> boot up is 200000. then this will help us to get the actual initial speed
> i.e. based upon the init speed.

As mentioned above, this should probably move further down.

>         if (qcadev->btsoc_type == QCA_WCN3990) {
> bt_dev_dbg(hdev, "setting up wcn3990");
>                 hci_uart_set_flow_control(hu, true);
>                 ret = qca_send_vendor_cmd(hdev, QCA_WCN3990_POWERON_PULSE);
>                 if (ret)
>                         return ret;
> 
>                 hci_uart_set_flow_control(hu, false);
>                 serdev_device_close(hu->serdev);
>                 ret = serdev_device_open(hu->serdev);
>                 if (ret) {
>                         bt_dev_err(hdev, "failed to open port");
>                         return ret;
>                 }
> 
>                 msleep(100);
>                 /* Setup initial baudrate */
>                 qca_set_speed(hu, QCA_INIT_SPEED);
>                 hci_uart_set_flow_control(hu, false);
>                 ret = qca_read_soc_version(hdev, &soc_ver);
>                 if (ret < 0 || soc_ver == 0) {
>                         bt_dev_err(hdev, "Failed to get version %d", ret);
>                         return ret;
>                 }
>                 bt_dev_info(hdev, "wcn3990 controller version 0x%08x",
> soc_ver);
>         } else {
>                 bt_dev_info(hdev, "ROME setup");
>         }
> 
>         /* Setup user speed if needed */
>         ret = qca_set_speed(hu, QCA_OPER_SPEED);
>         if (ret)
>                 return ret;
> 
>         speed = qca_get_speed(hu, QCA_OPER_SPEED);
>         if (speed)
>                 qca_baudrate = qca_get_baudrate_value(speed);
> 
>       [Bala]: the above speed == 0 is highly recommended, let us assume ROME
> chip init speed moved from 115200 to 2000000 and operating speed is defined
> as zero.
>        then this check will help us. else if we remove speed ==0 then in
> qca_baudrate we will end up having a different value.
>        ….
>         }
> 
>  Pls let me know, whether i have clarified your queries.

Partially, let's continue the discussion on v9 unless you have
questions/comments on my comments before you post.

Thanks

Matthias
