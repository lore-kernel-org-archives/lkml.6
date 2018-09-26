Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0163A2152A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqqpRrj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0163A2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeI0DSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:18:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36368 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeI0DSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:18:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so241489pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qbJIzsd4Q/+x+E4ubrNYqmJxLbyIfI9qzr+o+90Fmkw=;
        b=RqqpRrj8wzHHuhWckXCf2Cruo/v5XpHb1IusrzKg6D12xEva+wNWpgUTsZnF8Rzf1f
         NTujcF+bszIypQ9di74i+NyX9CtSVH2sZ8M8bGT4/IcIEtC8Otr+HeN/37/tVA6S+qfn
         aGfeAuDm68dvCvDIXDqR2IwDF1JuWUnWzirc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qbJIzsd4Q/+x+E4ubrNYqmJxLbyIfI9qzr+o+90Fmkw=;
        b=FA8GcN5R03KhDQJQgA8RIw0S7HdnXSG7WtsDkEZ8Lt2L7q3aC4nB9AxZDSil7c7lql
         Q9ykdbSnBMVqhHn8iQoT36Tp/cGhCkKzexaEKsaX/KKHEk5blyZLuMIAAhX4wPXFVEbJ
         K3sLCoCcHw7/GfNg2T30PEtJiF1kPjGNFdQsbDvXjuSh5hFonFYDHGN3sqc1Sl7QvYts
         6bDfry/8hABRNFhalk2HtVfu8kNGiDablroEQxi94ZWXYOstdT17BaTT87t/H3SCbCL+
         MPYDFszcWEjcZYxCprVIECu6fXyaGadm11gkDkB6eZUNh9TC3e1Jfq4629dnOLgliS7D
         JycA==
X-Gm-Message-State: ABuFfohR2OXJq3XLFfTfPuY2PjAbPA7SP+8HylZTOaF4W37knTbDFH1a
        T3JvgExrt/6WMhUi8hVI0v68ow==
X-Google-Smtp-Source: ACcGV60HR6FYPpzV7chjRgKsS16Su2G2gdmD5eFw0PC4mJ5bhHSEZvRgPGSYL6tfS71gLXhY3Khy4g==
X-Received: by 2002:a62:280a:: with SMTP id o10-v6mr7921178pfo.129.1537995821030;
        Wed, 26 Sep 2018 14:03:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g3-v6sm68284pfi.9.2018.09.26.14.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:03:40 -0700 (PDT)
Date:   Wed, 26 Sep 2018 14:03:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3.1 1/2] device property: Add device_get_bd_address()
 and fwnode_get_bd_address()
Message-ID: <20180926210339.GE22824@google.com>
References: <20180925191014.85573-1-mka@chromium.org>
 <20180925191014.85573-2-mka@chromium.org>
 <20180926113625.GM11965@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926113625.GM11965@kuha.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 02:36:25PM +0300, Heikki Krogerus wrote:
> On Tue, Sep 25, 2018 at 12:10:13PM -0700, Matthias Kaehlcke wrote:
> > +/**
> > + * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
> > + *                         firmware node
> > + * @fwnode:	Pointer to the firmware node
> > + * @bd_addr:	Pointer to struct to store the BD address in
> > + *
> > + * Search the firmware node for 'local-bd-address'.
> > + *
> > + * All-zero BD addresses are rejected, because those could be properties
> > + * that exist in the firmware tables, but were not updated by the firmware. For
> > + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> > + */
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr)
> > +{
> > +	bdaddr_t ba;
> > +	int ret;
> > +
> > +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> > +					    (u8 *)&ba, sizeof(bdaddr_t));
> > +	if (ret < 0)
> > +		return ret;
> > +	if (is_zero_ether_addr((u8 *)&ba))
> > +		return -ENODATA;
> > +
> > +	memcpy(bd_addr, &ba, sizeof(bdaddr_t));
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(fwnode_get_bd_address);
> > +
> > +/**
> > + * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
> > + *                         given device
> > + * @dev:	Pointer to the device
> > + * @bd_addr:	Pointer to struct to store the BD address in
> > + */
> > +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr)
> > +{
> > +	return fwnode_get_bd_address(dev_fwnode(dev), bd_addr);
> > +}
> > +EXPORT_SYMBOL_GPL(device_get_bd_address);
> 
> Let's not fill property.c with framework specific helper functions any
> more!
> 
> Those functions are completely bluetooth specific, so they do not
> belong here. The fact that some other framework already managed to
> slip their helpers in does not justify others to do the same.

You have a point, I'll see if I can find a better place.

Thanks

Matthias
