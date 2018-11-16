Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB43C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF602086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEHVnW8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF602086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbeKPT7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:59:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41634 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:59:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so16164124lfj.8;
        Fri, 16 Nov 2018 01:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZRsKcSkngEhVVyFO5g2YoKSrORmYMIFROVS31LbGv8=;
        b=VEHVnW8Aythv6hZt4DHyeasTHOnM66P5I6t9vgmtZVGW/dd9eIKmRq4WVXuZzzhUrN
         IzjzD4JaiFm6A3I2e2lVhri7mXvKXfUGrQEyqpPya6x/qUo0d6649FFX45LPNzNEgGY6
         flVkGLhdEMMyq0tOwLQ14u+1zsGWOT1Qs75UbKyPu+IwWF4nb+/NF+CM6NH8zdj7TxhG
         PQs/4NmyVbdjDBa6G/2SmbtvQAhtJfEivcUcO4oBd2tBf6JjpfvXWf7Re6uXNAU9letF
         2OTPk2XygK2KY9P754EVTVan0IDX9BAr+nJN7Z4sAqQcJbKsMBxGvmACSEAO2jnERFpK
         3h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZRsKcSkngEhVVyFO5g2YoKSrORmYMIFROVS31LbGv8=;
        b=HZQq/8dpl41yQJ5ic1jidNQnNDwDxlFippl0+3C9SD8pwblFHAWQMwYxbEUFs7PK8P
         m361et3pizFlxb7KrtBPRHY8wAj7XZw5gPGK8e4TZuShkngQbsqmvcdXJc7U7mJLqyDQ
         ZC4qUJhRpSDcYY4JgisV/YUHS3hXubhxchHblD8Mpt+jOVvQJtnC2CHbidPtBTONDVIk
         MEirlvAOOrAINPurc7ZQ6rvucIDCpH7McCmQy8XWftdvdlg5U9UjYGlQPKr6S8VqKOrO
         xI4v5E0Emix3Q1+0kilISxgXitXYBDk7UrRa57E/1c3vAx5M39E/q0zIisoQf6UR9bZp
         la+g==
X-Gm-Message-State: AGRZ1gJ9kFFs+I790+gY431Xhnvk5iwnk8sKOW9cAXUQ2FcgAMvWreRs
        e2ew1mo81BZoIQt2HgyLDek=
X-Google-Smtp-Source: AJdET5d8hsFnaB4BqJDaiyqMEzGGrjumczP8mLApNCQWwx2ZGs7VU+ieOsD7PqsFir8lGxQnnaN92w==
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr5492190lfi.57.1542361644189;
        Fri, 16 Nov 2018 01:47:24 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y14-v6sm2432772ljj.55.2018.11.16.01.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 01:47:22 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gNaii-0002XJ-3y; Fri, 16 Nov 2018 10:47:24 +0100
Date:   Fri, 16 Nov 2018 10:47:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v1 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181116094724.GO19900@localhost>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-2-bgodavar@codeaurora.org>
 <20181114152722.GA19900@localhost>
 <e2362ad539463a3a139419b93ccca831@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2362ad539463a3a139419b93ccca831@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 08:04:29PM +0530, Balakrishna Godavarthi wrote:
> Hi Johan,
> 
> On 2018-11-14 20:57, Johan Hovold wrote:
> > On Tue, Nov 06, 2018 at 05:35:25PM +0530, Balakrishna Godavarthi wrote:
> >> wcn3990 requires a power pulse to turn ON/OFF along with
> >> regulators. Sometimes we are observing the power pulses are sent
> >> out with some time delay, due to queuing these commands. This is
> >> causing synchronization issues with chip, which intern delay the
> >> chip setup or may end up with communication issues.
> >> 
> >> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> >> ---
> >>  drivers/bluetooth/hci_qca.c | 22 +++++++++-------------
> >>  1 file changed, 9 insertions(+), 13 deletions(-)
> >> 
> >> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> >> index f72ded4ec9ae..051f081d1835 100644
> >> --- a/drivers/bluetooth/hci_qca.c
> >> +++ b/drivers/bluetooth/hci_qca.c
> >> @@ -1016,8 +1016,7 @@ static inline void host_set_baudrate(struct 
> >> hci_uart *hu, unsigned int speed)
> >>  static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> >>  {
> >>  	struct hci_uart *hu = hci_get_drvdata(hdev);
> >> -	struct qca_data *qca = hu->priv;
> >> -	struct sk_buff *skb;
> >> +	int ret;
> >> 
> >>  	/* These power pulses are single byte command which are sent
> >>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> >> @@ -1030,18 +1029,14 @@ static int qca_send_power_pulse(struct hci_dev 
> >> *hdev, u8 cmd)
> >>  	 * sending power pulses to SoC.
> >>  	 */
> >>  	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> >> -
> >> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> >> -	if (!skb)
> >> -		return -ENOMEM;
> >> -
> >>  	hci_uart_set_flow_control(hu, true);
> >> +	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);
> > 
> > Don't you want a non-zero timeout here? Otherwise you might as well
> > call serdev_device_write() directly.
> 
> [Bala]: we need an in definite timeout for these commands. will use 
> HCI_UART_TX_WAKEUP.
> 
> > Also have you made sure that serdev_device_write_wakeup() is called in
> > the drivers write-wakeup callback as serdev_device_write() requires?
> > 
> > See this series in case what you really wanted was to wait indefinitely
> > (you can use MAX_SCHEDULE_TIMEOUT):
> > 
> > 	https://lkml.kernel.org/r/<20181114150904.19653-1-johan@kernel.org>
> 
> [Bala]: thanks for pointers. from 
> https://lore.kernel.org/patchwork/patch/1012358/
>          it was clear to me that i need call below functions in order to 
> wait until full data is sent.
> 
>          serdev_device_write_wakeup()
>          serdev_device_write()
>          serdev_device_wait_until_sent()
> 
>          correct me whether my understanding is correct.

No, serdev_device_write_wakeup() needs to be called from the serdev
driver's write_wakeup() callback (as defined in struct struct
serdev_device_ops).

Either use serdev_device_write_wakeup() as the callback, or call it from
your driver's custom write_wakeup() callback.

Hmm, I see now that the callbacks are set in hci_uart_register_device()
to hci_serdev_client_ops, which is shared by all serdev BT drivers. You
may be able to just add the call to the callback defined there so that
all Bluetooth drivers can use serdev_device_write().

Johan
