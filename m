Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 533DAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D7F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="bpIUL1Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D7F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbeFLMLt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:11:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48186 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932543AbeFLMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:11:45 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 74A565C11DF;
        Tue, 12 Jun 2018 14:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1528805504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8AukCerDvBdieQFF4Aby5TkP1atSf5ItPL/oIkkS3Q=;
        b=bpIUL1WhaIUbPjsRgciN0b0vxBHvPgXsSNUSOvacrGghQn0hKzn1cfIqRbPJrqVRXLXTsd
        Xw57XJxn+McJ55xkABPPLgEQHNJDM9MGmvc/R/iukNRjs9kY3Wogggp965sBK2FtVGflm8
        Okwvi8oHpb1vAL5kvPH9BF//ob9CPfk=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Tue, 12 Jun 2018 14:11:44 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, festevam@gmail.com, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: imx: fix cached UCR2 read on software reset
In-Reply-To: <20180607075633.y3tm245jv7nkdrqx@pengutronix.de>
References: <20180420124407.12892-1-stefan@agner.ch>
 <20180607075633.y3tm245jv7nkdrqx@pengutronix.de>
Message-ID: <afda793c86ba7394233e17813589b44c@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.06 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.96)[99.84%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2018 09:56, Uwe Kleine-König wrote:
> On Fri, Apr 20, 2018 at 02:44:07PM +0200, Stefan Agner wrote:
>> To reset the UART the SRST needs be cleared (low active). According
>> to the documentation the bit will remain active for 4 module clocks
>> until it is cleared (set to 1).
>>
>> Hence the real register need to be read in case the cached register
>> indicates that the SRST bit is zero.
>>
>> This bug lead to wrong baudrate because the baud rate register got
>> restored before reset completed in imx_flush_buffer.
>>
>> Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> For the record, there is a customer of mine who reports that this commit
> breaks rs485 communication on i.MX25 because RTS stops to toggle as
> intended.
> 
> (Some details: uart3, fsl,uart-has-rtscts, fsl,dte-mode,
> linux,rs485-enabled-at-boot-time, native RTS.)
> 
> I didn't debug this yet.

I have seen your patch today "serial: imx: fix comment about UCR2_SRST
and its handling for shadowing" so I assume you looked into this issue?

Was it related to that change?

--
Stefan
