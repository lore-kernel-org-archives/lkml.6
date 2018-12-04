Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3868C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76262082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZtn4M7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76262082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeLDTPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:15:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43690 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDTPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:15:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so8690098pfk.10;
        Tue, 04 Dec 2018 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Ax7XMPI4Tn1GvyMmhvsW9/E0TIX7TD/rRQB9Rzk7sRA=;
        b=XZtn4M7X7bIqVmgkZb81E1a1JlYD/Pk6djiP+15cl1tKcmq1ZyK2XVwPRhpbQIDxgO
         yk4+5jVr/kPsDBWn6Wxbqp6LJlr4zcMdSHY1HTLyhdcfImfN4954n1YkMSQdk/cJk/NW
         szSQnLFN3yjpc9bt5Z40yjuQc7Qt+A34vzEoE26Rskbdg5Gn1cNxWgMAVUS0pZaGv9tl
         mOogksRvUzqnQfaBwh5e9sAnBqyjLOEm3jSIfF4z+/+Yw38aKznWCtjiY2L9hZTS+ksz
         pipJs/2vzAAXP4y5AvMICzlZ4yoBFrtEtCTa3j18QOk6VIoCRX+vFy7tfIocZA8W5xXj
         PZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Ax7XMPI4Tn1GvyMmhvsW9/E0TIX7TD/rRQB9Rzk7sRA=;
        b=AUOp3VvBNgwHFfTWlcigXs3lySn+3Km2EBe6fwEaqowkJJvZpYWwbeKqVa51lRl21z
         XWQEW0HMrNJGLRDp3gf9P7Bmw67v/fkGQb/gCMwGgHPCMPkvUcGctMoE/EIK8Uh9rrx1
         clE5Y2id/GRMkXomh5uLHqsPbSlNLeFf9uuxFi9OvhzdG2dxrKnqwwaIcFMioRuk0Epj
         wL1V52FNhgxTqMnvYHnVtjtXaZIROOnrE22KvV8B1zNmAvRPh7QasxxuTjMlkCvOEgJR
         hCHK2deTBurThjMPEYrII7n0pCNr97P4i5Sk55KanoB4EXMIe7bUPNoj0+ofkvxzeXGJ
         PdMg==
X-Gm-Message-State: AA+aEWY4YUKbGJysjATjkpLRn77Y15QxrvgCM9OpjL3mYcRtT0vac2ky
        oLg18ZW80tsrJti4ySo9Pvo=
X-Google-Smtp-Source: AFSGD/WDRzJNfEap3bDxZKdMHpnETlKAoX1IOJlWAsO3pVovLr/CVdbfegrEyjYSzwvoY86pkEYH1Q==
X-Received: by 2002:a65:560e:: with SMTP id l14mr17844786pgs.168.1543950911267;
        Tue, 04 Dec 2018 11:15:11 -0800 (PST)
Received: from ?IPv6:2620:0:1000:fd28:6d19:9d6f:7404:e580? ([2620:0:1000:fd28:6d19:9d6f:7404:e580])
        by smtp.gmail.com with ESMTPSA id i4sm34314709pfj.82.2018.12.04.11.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:15:10 -0800 (PST)
Date:   Tue, 04 Dec 2018 11:15:06 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20181204190932.GD6707@atomide.com>
References: <20181203012933.6647-1-tony@atomide.com> <20181203012933.6647-2-tony@atomide.com> <20181203192351.GB257010@dtor-ws> <20181203231251.GB39861@atomide.com> <20181204040001.GA239923@dtor-ws> <20181204190932.GD6707@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] Input: omap-keypad: Fix idle configration to not block SoC idle states
To:     Tony Lindgren <tony@atomide.com>
CC:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>,
        Illia Smyrnov <illia.smyrnov@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <887EB3E7-D753-441D-9D84-1FCBB4C5E033@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 4, 2018 11:09:32 AM PST, Tony Lindgren <tony@atomide=2Ecom> wro=
te:
>Hi,
>
>* Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom> [181204 04:00]:
>> Hi Tony,
>>=20
>> On Mon, Dec 03, 2018 at 03:12:51PM -0800, Tony Lindgren wrote:
>> >=20
>> > With PM enabled, I noticed that pressing a key on the droid4
>keyboard will
>> > block deeper idle states for the SoC=2E Looks like we can fix this by
>> > managing the idle register to gether with the interrupt similar to
>what
>> > we already do for the GPIO controller=2E
>>=20
>> Can you show me where exactly we are doing this? I can't seem to find
>> the matching code=2E
>
>With your change it now becomes the fix, and we're just missing the
>clearing of the OMAP4_KBD_WAKEUPENABLE register in omap4_keypad_close=2E
>
>Does the following minimal version with updated comments make
>more sense now?

Awesome, thank you Tony=2E

>
>Regards,
>
>Tony
>
>8< --------------
>From tony Mon Sep 17 00:00:00 2001
>From: Tony Lindgren <tony@atomide=2Ecom>
>Date: Tue, 4 Dec 2018 11:07:56 -0800
>Subject: [PATCH] Input: omap-keypad: Fix idle configration to not block
> SoC idle states
>
>With PM enabled, I noticed that pressing a key on the droid4 keyboard
>will
>block deeper idle states for the SoC=2E Let's fix this by using
>IRQF_ONESHOT
>and stop constantly toggling the device OMAP4_KBD_IRQENABLE register as
>suggested by Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>=2E
>
>From the hardware point of view, looks like we need to manage the
>registers
>for OMAP4_KBD_IRQENABLE and OMAP4_KBD_WAKEUPENABLE together to avoid
>blocking deeper SoC idle states=2E And with toggling of
>OMAP4_KBD_IRQENABLE
>register now gone with IRQF_ONESHOT, also the SoC idle state problem is
>gone during runtime=2E We still also need to clear OMAP4_KBD_WAKEUPENABLE
>in
>omap4_keypad_close() though to pair it with omap4_keypad_open() to
>prevent
>blocking deeper SoC idle states after rmmod omap4-keypad=2E
>
>Cc: Axel Haslam <axelhaslam@ti=2Ecom>
>Cc: Illia Smyrnov <illia=2Esmyrnov@ti=2Ecom>
>Cc: Marcel Partap <mpartap@gmx=2Enet>
>Cc: Merlijn Wajer <merlijn@wizzup=2Eorg>
>Cc: Michael Scott <hashcode0f@gmail=2Ecom>
>Cc: NeKit <nekit1000@gmail=2Ecom>
>Cc: Pavel Machek <pavel@ucw=2Ecz>
>Cc: Sebastian Reichel <sre@kernel=2Eorg>
>Reported-by: Pavel Machek <pavel@ucw=2Ecz>
>Signed-off-by: Tony Lindgren <tony@atomide=2Ecom>
>---
> drivers/input/keyboard/omap4-keypad=2Ec | 16 ++++------------
> 1 file changed, 4 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/input/keyboard/omap4-keypad=2Ec
>b/drivers/input/keyboard/omap4-keypad=2Ec
>--- a/drivers/input/keyboard/omap4-keypad=2Ec
>+++ b/drivers/input/keyboard/omap4-keypad=2Ec
>@@ -126,12 +126,8 @@ static irqreturn_t omap4_keypad_irq_handler(int
>irq, void *dev_id)
> {
> 	struct omap4_keypad *keypad_data =3D dev_id;
>=20
>-	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS)) {
>-		/* Disable interrupts */
>-		kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>-				 OMAP4_VAL_IRQDISABLE);
>+	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS))
> 		return IRQ_WAKE_THREAD;
>-	}
>=20
> 	return IRQ_NONE;
> }
>@@ -173,11 +169,6 @@ static irqreturn_t omap4_keypad_irq_thread_fn(int
>irq, void *dev_id)
> 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
> 			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
>=20
>-	/* enable interrupts */
>-	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>-		OMAP4_DEF_IRQENABLE_EVENTEN |
>-				OMAP4_DEF_IRQENABLE_LONGKEY);
>-
> 	return IRQ_HANDLED;
> }
>=20
>@@ -214,9 +205,10 @@ static void omap4_keypad_close(struct input_dev
>*input)
>=20
> 	disable_irq(keypad_data->irq);
>=20
>-	/* Disable interrupts */
>+	/* Disable interrupts and wake-up events */
> 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> 			 OMAP4_VAL_IRQDISABLE);
>+	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, 0);
>=20
> 	/* clear pending interrupts */
> 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>@@ -365,7 +357,7 @@ static int omap4_keypad_probe(struct
>platform_device *pdev)
> 	}
>=20
>	error =3D request_threaded_irq(keypad_data->irq,
>omap4_keypad_irq_handler,
>-				     omap4_keypad_irq_thread_fn, 0,
>+				     omap4_keypad_irq_thread_fn, IRQF_ONESHOT,
> 				     "omap4-keypad", keypad_data);
> 	if (error) {
> 		dev_err(&pdev->dev, "failed to register interrupt\n");



--=20
Dmitry
