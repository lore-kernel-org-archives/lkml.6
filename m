Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D79C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7D520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4BtF2ED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfAaSWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:22:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43652 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfAaSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:22:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so1832353plb.10;
        Thu, 31 Jan 2019 10:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjQkOgBYwAUPXck63NpVQVXsoSCG7g1qFwUH7WO8meM=;
        b=l4BtF2ED7pt2g0hp+GnCEsyFvEw0mnayLAUPjLhGQd7KbvjAgTqJooK7OM7TJe/qYD
         r/xGbRrrIHW/yNDq0uPicV3j2n1jObYQT6P+zvM1lmo+zdgiLz64ojCwklER0MHITiH+
         /bkyRut0eKIMePXFsLwVJpg/myn0GC4/Ewdg9/5ip9Efge9+VH/98MlNnJcx9fD6845B
         zZ/KhLyxJSbXFQokUjPgIkczjz0MIKFIc6t6WSP5cyqehggZPV3iCy+HTVJC/UfY3zQT
         +91M32MxJ0T4zv0F47eNogU9S02+wvekCzmSx4NcIfqijCC4h76j/vNvoS7ZUCbYdBqG
         vfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjQkOgBYwAUPXck63NpVQVXsoSCG7g1qFwUH7WO8meM=;
        b=Lu/OSwRavS2l/SsDrxPiEvSj+CEmmsR6TEp0iF/KdJbysqtVdHx0KORrwF8jxcZN6S
         leygLrYiG8kP912wi2pBkCtEqv4wNqpzxca+5IkAF4xjeZwnrZgN8rUM5d/4KVqKLq+z
         d0UYjgXL7NgzdHkFCaRTlMsly452hloitI7clx7AUKISNP0iKxChgt5lTpUG8pfBfXZo
         Va5o8TLR3SkwIozDf8tzFSaQvvEsvgi2mZs4bq05aizGhgXRgCmXu4QkGpV59IIxLRFP
         v0tvImqZz0rUzgWpGApSaCvfNBJcnIK78L1V22+19X/ddWVYDdbvLCm/xENU6dtztK2j
         kIng==
X-Gm-Message-State: AJcUukdp5HJe//ryth44NNwn9OX4CHvoSIdFYTYkuOm+7twfwgbv7NK0
        ycokioNVov7+xCjPqOQF+ATRCtq7
X-Google-Smtp-Source: ALg8bN59uZIBNmB5Goe2Gqk1T31yfBrDRk4oZMi6wpsUCY2Y04cpTMQ2OM0BzQrzBa/CIjHAPZrlTQ==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr24245041ply.261.1548958935554;
        Thu, 31 Jan 2019 10:22:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m198sm6310255pga.10.2019.01.31.10.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:22:15 -0800 (PST)
Date:   Thu, 31 Jan 2019 10:22:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
Message-ID: <20190131182213.GB17285@roeck-us.net>
References: <20190131035411.53576-1-kyletso@google.com>
 <20190131070238.GA4500@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131070238.GA4500@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 08:02:38AM +0100, Greg KH wrote:
> On Thu, Jan 31, 2019 at 11:54:11AM +0800, Kyle Tso wrote:
> > Provide a function to get the partner Source Capabilities.
> > 
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
> >  include/linux/usb/tcpm.h      |  1 +
> >  2 files changed, 24 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index f1d3e54210df..29cd84ba9960 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
> >  }
> >  EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
> >  
> > +/*
> > + * Don't call this function in interrupt context. Caller needs to free the
> > + * memory itself.
> > + */
> > +int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **src_pdo)
> > +{
> > +	unsigned int nr_pdo;
> > +
> > +	if (port->nr_source_caps == 0)
> > +		return -ENODATA;
> > +
> > +	*src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
> > +	if (!src_pdo)
> > +		return -ENOMEM;
> > +
> > +	mutex_lock(&port->lock);
> > +	nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
> > +				port->nr_source_caps);
> > +	mutex_unlock(&port->lock);

The mutex use here suggests that the data can be updated while being
copied. But that suggests that port->nr_source_caps can change as
well and may no longer be current after mutex_lock().

> > +	return nr_pdo;
> > +}
> > +EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
> 
> We don't add new functions that no one uses :(
> 

I am also concerned about the API itself; passing a pointer to be freed
by the caller invites memory leaks.

Guenter
