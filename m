Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D1FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2725A206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enpdeNSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2725A206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeINSyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:54:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40087 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeINSyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:54:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so7543480ljc.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1fTlrG6/4Wpb9FJk1NByzJfT8aYDMPk6DE/LX8JGj0c=;
        b=enpdeNSzjLJA5aod65aL2BZ31/5qjo3WSaAZMY7lZ8xbyqrLp5W1qlKIUO+A26Kghn
         dgz9skTg3snkclCNZocvLvfrszqKO/3fGDqeb/VY0EBTdZbPJdsdNO8UyLrOoa3zKp/u
         rcNE+KAXJDPZOyN13YcUYb+arZggOUFIEMlHEvrzQz1uJOvGDLGcC+k3+6QzvJfYZM/n
         G33FZeKUtZw92d/8onYs0DtlsNDubjjA+PtmIuvStlu48qo4ZA0ZOvO8y249NptSX81r
         6AUKr9Te98KrGNKcuegnSKyS1LcG8ctAZadMhOK2L8cgvG7UdVxi+aUGmo0tjRHQqBT+
         Nzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fTlrG6/4Wpb9FJk1NByzJfT8aYDMPk6DE/LX8JGj0c=;
        b=Ohm4nwpeILPXfEgZ4sK66ekydTzF9vqhJ/PRM2AgBBBIP6AsNED33m72qBv7X3kNCX
         Yu8gIzJ4oQeKv4omWQib+OFu1fNJoFPw2KK+aEOLoyuEk6UicqN9NJW9fp8w7F6yWJsY
         8jPNqcKif9jKSEViMK2V+Bd251qpRpIu+Il13tDe98PrlAtwSygst0b+huitTX60co4m
         ZrUg7BkiIRgCRge9onCnv1s8Ez429VVngv/psCizFp2Hdf0zNAo0VymCdAgBF+QsAqj2
         I5HHlmRwAajTHDjmlpeBsXkGmIPbFeqgPTzLToYg+mIfRxoXFFoMGZvLBgiSE71toaXu
         kpyA==
X-Gm-Message-State: APzg51CzXUeKfxIvHU8u5lMkUMV2Ojz3Jdteuiy5mu6jlDev9x6UJ/gp
        mR9dsQaQvyMAVqVZBD96roo=
X-Google-Smtp-Source: ANB0VdZJePyU2naq+1AsY4CZVdMc0ncPs6KU+OATtqLaEiZ5ncBdraxGaYk2ofewCt5538CU4sDEbg==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr7717881ljh.49.1536932368906;
        Fri, 14 Sep 2018 06:39:28 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u191-v6sm1233687lja.13.2018.09.14.06.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:39:28 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oJm-0002fp-Jf; Fri, 14 Sep 2018 15:39:30 +0200
Date:   Fri, 14 Sep 2018 15:39:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/50] usb-serial: begin switching to ->[sg]et_serial()
Message-ID: <20180914133930.GF1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-17-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-17-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:16AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> add such methods for usb_serial_driver, provide tty_operations
> ->[sg]et_serial() calling those.  For now the lack of methods
> in driver means ENOIOCTLCMD from usb-serial ->[sg]et_serial(),
> making tty_ioctl() fall back to calling ->ioctl().  Once all
> drivers are converted, we'll be returning -ENOTTY instead,
> completing the switchover.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/usb/serial/usb-serial.c | 18 ++++++++++++++++++
>  include/linux/usb/serial.h      |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
> index f7aaa7f079e1..8bdc48fa5a67 100644
> --- a/drivers/usb/serial/usb-serial.c
> +++ b/drivers/usb/serial/usb-serial.c
> @@ -396,6 +396,22 @@ static void serial_unthrottle(struct tty_struct *tty)
>  		port->serial->type->unthrottle(tty);
>  }
>  
> +static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
> +{
> +	struct usb_serial_port *port = tty->driver_data;

Pleas add a newline here.

> +	if (port->serial->type->get_serial)
> +		return port->serial->type->get_serial(tty, ss);
> +	return -ENOIOCTLCMD;
> +}
> +
> +static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
> +{
> +	struct usb_serial_port *port = tty->driver_data;

And here.

> +	if (port->serial->type->set_serial)
> +		return port->serial->type->get_serial(tty, ss);
> +	return -ENOIOCTLCMD;
> +}

Reviewed-by: Johan Hovold <johan@kernel.org>
