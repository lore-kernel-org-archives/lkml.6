Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C378C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0DA2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZEIOcer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0DA2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeGIS7M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:59:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39107 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbeGIS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:59:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so37854667oib.6;
        Mon, 09 Jul 2018 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l3wllvD/ENolaKhqYhm+8wWPjdE6hnIAAPopA3sbHWg=;
        b=VZEIOcer7ldzlSsw7vSIoPtLa0O5+DRoAak4jPjYtwJZ1J995xVwHujrtEgSRy8CO4
         5MlxP6A0ylA98MBrnTjZpTpbLCkALER1Yc1eGBjXbR5X4JTWHfpqUWbHsMM7CnZeKWYv
         kshn5qHxsI/bD3gSLbe9ua2vaus5UmlxTvojBQfGfwrJpK9mCgbcmDXtTH0Y4mjdxjeX
         4E6Izw24vlgjA+dRfAtBGAmVyMtEPyU6pbOvgaITP7pFisrW4e9z5QYU48gK9Aw86Pqw
         H0MZBzlRXGtd2U0GHTSPj05q3OW/ay7IS1+5vhSgm/ZGZxVVpxlr1B4IU8jiBxMkxA8/
         hvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l3wllvD/ENolaKhqYhm+8wWPjdE6hnIAAPopA3sbHWg=;
        b=J5sQxV033JTZbVNBrcp4o+C/BhJMcNOHYRtPmVK6z+ltFo4qzqyrnfa42JpMsuM5f9
         //M/kUjXagpiaxyKTmnStt1x0VNRQPXHsYQ6FJ1XbaC9zwks3Ax6Q0m1BplCBlPu/fGN
         QK4MvpL9R802sGlCk0TT26gynZTgcGycBbVVC0c3Kgebuq9c2/1SZYd7Y0a2lUMHfthD
         fl58C/yraiJNZmz0umwEGFkO8Inb2phP5aAM6mRKPLtwyihqW7fDszWexPxjMZbTb28J
         /6I5xxW9nY5+q0a7oCHYgCvDNHByJkHHbE8iyMenZFgnuqPb3FYLNCh+uIR5DHzx8aB5
         JIAA==
X-Gm-Message-State: APt69E3vpPABrKS0sH0Uk2QB3xvf5RG+O0mXFcOXdNHW01Y9JbxWdhVb
        5qmF2sr7RSIvPGgCBKzQ790=
X-Google-Smtp-Source: AAOMgpdAXHT97Le0CX/9GlixXsCen4s5AQgtHpc3HrEUA2feuSp9BghtkbBviXSzKG9ixBLSP5y3Jg==
X-Received: by 2002:aca:1719:: with SMTP id j25-v6mr22869672oii.138.1531162749864;
        Mon, 09 Jul 2018 11:59:09 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c2-v6sm10333073oia.53.2018.07.09.11.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 11:59:09 -0700 (PDT)
Date:   Mon, 9 Jul 2018 11:59:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] usb: typec: function for checking cable plug
 orientation
Message-ID: <20180709185908.GB1896@roeck-us.net>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
 <20180627151953.30942-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627151953.30942-3-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:19:47PM +0300, Heikki Krogerus wrote:
> This adds function typec_get_orientation() that can be used
> for checking the current cable plug orientation.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/class.c | 12 ++++++++++++
>  include/linux/usb/typec.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 53df10df2f9d..2b3eaa969f3b 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1279,6 +1279,18 @@ int typec_set_orientation(struct typec_port *port,
>  }
>  EXPORT_SYMBOL_GPL(typec_set_orientation);
>  
> +/**
> + * typec_get_orientation - Get USB Type-C cable plug orientation
> + * @port: USB Type-C Port
> + *
> + * Get current cable plug orientation for @port.
> + */
> +enum typec_orientation typec_get_orientation(struct typec_port *port)
> +{
> +	return port->orientation;
> +}
> +EXPORT_SYMBOL_GPL(typec_get_orientation);
> +
>  /**
>   * typec_set_mode - Set mode of operation for USB Type-C connector
>   * @port: USB Type-C port for the connector
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 672b39bb0adc..a5f6433e218b 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -265,6 +265,7 @@ void typec_set_pwr_opmode(struct typec_port *port, enum typec_pwr_opmode mode);
>  
>  int typec_set_orientation(struct typec_port *port,
>  			  enum typec_orientation orientation);
> +enum typec_orientation typec_get_orientation(struct typec_port *port);
>  int typec_set_mode(struct typec_port *port, int mode);
>  
>  #endif /* __LINUX_USB_TYPEC_H */
> -- 
> 2.18.0
> 
