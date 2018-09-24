Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0CAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5042145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="T6uDC/e5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5042145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeIXRy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:54:28 -0400
Received: from erza.pados.hu ([176.9.136.194]:35616 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbeIXRy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zqce1NMi+8hhKt4c2Gk/M6jsu/ScNdS3uP8LWP+Clws=; b=T6uDC/e5FGZmsKRorJxHyEg0Pa
        0sw09TcqQCBg4e+7khdgS474i6EHU4a6Lv6tYd5L3LdfWieCRd85OJdl/8LtCgkxfWVoE+SeRI74m
        zjEiiMAXGXYalb+EL+pu+fOrDbsTmmkmV+V+gAVobx6tMwZjrNhj1i680v/XsX7illybDr3w7AKfp
        Lqds+zno+MuWgDkZAFgDbel+QUB5UDVRGf+tEnZ8Lra3/XwJIqhFNWaZezJ7gr5MN9UlNHyzFXM5b
        nKEdiIh9F47oUGlcQjO7K6Bv5EH17aMSoFsMqAtrcebOW1oK6Z7cYUpws6ER+XLBjeU/CfJaT7SLG
        YFyo5NTQ==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g4PPs-0002hT-Hz; Mon, 24 Sep 2018 13:52:40 +0200
MIME-Version: 1.0
Date:   Mon, 24 Sep 2018 11:52:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <48c673281bec5fbb4b8b84ed884c000a@pados.hu>
Subject: Re: [PATCH v5] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
In-Reply-To: <20180924084756.GD5101@localhost>
References: <20180924084756.GD5101@localhost>
 <20180923160330.2184-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Oops, I sent v4 again, so it had no changes at all. Can't
   I just resend v5 instead of calling it v6? September 24, 2018 10:48 AM, "Johan
    Hovold" <johan@kernel.org> wrote: > On Sun, Sep 23, 2018 at 06:03:30PM +0200,
    Karoly Pados wrote: > >> This patch allows using the CBUS pins of FT-X devices
    as GPIO in CBUS >> bitbanging mode. There is no conflict between the GPIO
    and VCP >> functionality in this mode. Tested on FT230X and FT231X. >> >>
    As there is no way to request the current CBUS register configuration >>
   from the device, all CBUS pins are set to a known state when the first >>
   GPIO is requested. This allows using libftdi to set the GPIO pins >> before
    loading this module for UART functionality, a behavior that >> existing applications
    might be relying upon (though no specific case >> is known to the authors
    of this patch). >> >> Signed-off-by: Karoly Pados <pados@pados.hu> >> ---
    >> Changelog: >> - v2: Fix compile error when CONFIG_GPIOLIB is not defined.
    >> - v3: Incorporate review feedback. >> - v4: Include linux/gpio/driver.h
    unconditionally. >> Replace and invert gpio_input with gpio_output. >> Make
    ftdi_gpio_direction_get return 0/1. >> Change dev_err msg in ftdi_set_bitmode_req.
    >> Change formatting of error checking in ftdi_gpio_get. >> Drop dev_err
   in ftdi_gpio_set. >> Remove some line breaks and empty lines. >> Change error
    handling in ftdi_read_eeprom (and adjust caller). >> Replace SIO->FTX in
   FTDI_SIO_CBUS_MUX_GPIO macro name. >> - v5: Read only 4 bytes from eeprom
   in ftx_gpioconf_init. >> Compare ftdi_read_eeprom result with 0 instead of
    eq. cehck. >> Reserve 4 GPIOs even for FT234X. >> Release CBUS after gpiochip
    deregister to avoid possible race. >> Adjust comment on FTDI_SIO_SET_BITMODE
    macro. >> Protect GPIO value/dir setting with mutex. > > This patch doesn't
    add any locking so I'm assuming you posted the wrong > version of the patch.
    > >> Add support for gpiochip.get_multiple and set_multiple. >> Add names
    to GPIO lines. > > I'll wait for v6. > > Thanks, > Johan [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: pados.hu]
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I sent v4 again, so it had no changes at all. Can't I just resend v=
5 instead of calling it v6? =0A=0ASeptember 24, 2018 10:48 AM, "Johan Hov=
old" <johan@kernel.org> wrote:=0A=0A> On Sun, Sep 23, 2018 at 06:03:30PM =
+0200, Karoly Pados wrote:=0A> =0A>> This patch allows using the CBUS pin=
s of FT-X devices as GPIO in CBUS=0A>> bitbanging mode. There is no confl=
ict between the GPIO and VCP=0A>> functionality in this mode. Tested on F=
T230X and FT231X.=0A>> =0A>> As there is no way to request the current CB=
US register configuration=0A>> from the device, all CBUS pins are set to =
a known state when the first=0A>> GPIO is requested. This allows using li=
bftdi to set the GPIO pins=0A>> before loading this module for UART funct=
ionality, a behavior that=0A>> existing applications might be relying upo=
n (though no specific case=0A>> is known to the authors of this patch).=
=0A>> =0A>> Signed-off-by: Karoly Pados <pados@pados.hu>=0A>> ---=0A>> Ch=
angelog:=0A>> - v2: Fix compile error when CONFIG_GPIOLIB is not defined.=
=0A>> - v3: Incorporate review feedback.=0A>> - v4: Include linux/gpio/dr=
iver.h unconditionally.=0A>> Replace and invert gpio_input with gpio_outp=
ut.=0A>> Make ftdi_gpio_direction_get return 0/1.=0A>> Change dev_err msg=
 in ftdi_set_bitmode_req.=0A>> Change formatting of error checking in ftd=
i_gpio_get.=0A>> Drop dev_err in ftdi_gpio_set.=0A>> Remove some line bre=
aks and empty lines.=0A>> Change error handling in ftdi_read_eeprom (and =
adjust caller).=0A>> Replace SIO->FTX in FTDI_SIO_CBUS_MUX_GPIO macro nam=
e.=0A>> - v5: Read only 4 bytes from eeprom in ftx_gpioconf_init.=0A>> Co=
mpare ftdi_read_eeprom result with 0 instead of eq. cehck.=0A>> Reserve 4=
 GPIOs even for FT234X.=0A>> Release CBUS after gpiochip deregister to av=
oid possible race.=0A>> Adjust comment on FTDI_SIO_SET_BITMODE macro.=0A>=
> Protect GPIO value/dir setting with mutex.=0A> =0A> This patch doesn't =
add any locking so I'm assuming you posted the wrong=0A> version of the p=
atch.=0A> =0A>> Add support for gpiochip.get_multiple and set_multiple.=
=0A>> Add names to GPIO lines.=0A> =0A> I'll wait for v6.=0A> =0A> Thanks=
,=0A> Johan
