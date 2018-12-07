Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1ACC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC1B2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544203472;
	bh=3I2kTOYzunets9OVVQmt8UnqmR4KUDFuJesLjixBJVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t2vtnYiMTGWTgTADqLfJpvq6EwbiSk3WGyBZQCprD0tDdNf/8UFwnPG0LIOuhCGhl
	 TIkIL2AdtVy2s8q8CXQL4BcaRInbru8AVighQq7zwQ1227x5Zo5LfzfJXUy2qYlhet
	 gYBqa4aSeoIW3UbXKFplbJ0rDBoFDcbZG59GSZ7M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC1B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLGRYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:24:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44346 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeLGRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:24:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so4456767otl.11;
        Fri, 07 Dec 2018 09:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ARtyEqBV6uEmUnXceIdhSKNFQAUgYVxl/0LXA5z+K8=;
        b=JjF9NZHZ2SSi+jisBf00cJPyQ2mOUYro147FbDzZ0AUjMhAtlYDKk54oA5mYJD6aaw
         PmM6BgDyVGFfe7cT/3kQus9s4akraBIILp3C8BpL6r/IehxQkty9igD6SxkzowjUmx8i
         qCiaN+XcFwCiVGt08ZWcZ5KQIbKkudGUwSCx24sNqCaiureSK29TYzEAYsyEdxeazCbh
         czokQ75nP2hjWzVINzEeP7V8ridYjtTnmd3RUaINmpEojprutLZnxC+jMwQQkuwzOGpU
         YDYZGhqK9tyFLunzMU6LOX0oizW+NvmpRu59+hoDo78BPp5+XKboV7Z6UrwjvufeAfTX
         Scow==
X-Gm-Message-State: AA+aEWYzLWii1UnpZ/m7MCF4Tsedy2Qk0e8O7IBpR8SZZ873PwiVHpFG
        BzmdqDA3ggWFcPh3a1R1CqX7rCE=
X-Google-Smtp-Source: AFSGD/UNNmMVRGvOrwjk7f2Fyx1tTtFlO80/sDHOCW6z53e579g6CgG1LNctQ3SsdLCIo8+3i7FFbg==
X-Received: by 2002:a9d:23c2:: with SMTP id t60mr2113139otb.48.1544203469258;
        Fri, 07 Dec 2018 09:24:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b63sm2378517oih.6.2018.12.07.09.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:24:28 -0800 (PST)
Date:   Fri, 7 Dec 2018 11:24:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] device property: Introduce fwnode_get_name()
Message-ID: <20181207172427.GA6642@bogus>
References: <20181128115952.80890-1-heikki.krogerus@linux.intel.com>
 <20181128115952.80890-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128115952.80890-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 02:59:50PM +0300, Heikki Krogerus wrote:
> This helper returns the name of the node. The name is
> primarily expected to be returned from a new fwnode
> operation meant for this purpose, but when no name is
> returned, the helper will also attempt to read a device
> property "name".
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/fwnode.h   |  3 +++
>  include/linux/property.h |  2 ++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 240ab5230ff6..8bd35b44d9ec 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1156,6 +1156,42 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_handle_put);
>  
> +/**
> + * fwnode_get_name - Copy the name of an fwnode to a buffer
> + * @fwnode: Pointer to the node
> + * @buf: Buffer where the name is copied to
> + * @len: Size of the buffer
> + *
> + * Copies the node name of @fwnode to @buf. The routine attempts to first use
> + * the get_name fwnode op of @fwnode, and if it fails, the routine attempts to
> + * read a property "name".
> + *
> + * NOTE: @buf must be large enough to accommodate the name and trailing '\0'.
> + *
> + * Returns 0 on success or errno in case of an error.
> + */
> +int fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
> +{
> +	const char *name;
> +	int ret;
> +
> +	ret = fwnode_call_int_op(fwnode, get_name, buf, len);
> +	if (ret == 0 || ret == -EOVERFLOW)
> +		return ret;
> +
> +	ret = fwnode_call_int_op(fwnode, property_read_string_array,
> +				 "name", &name, 1);

Do you expect this to work on DT? It does today, but I plan to change 
that. 'name' is a fake property on FDT.

Again, I think this is all working at too low of a level. Name is used 
either for matching or an informational string. For matching, this 
should remain firmware specific. For imformational strings, 
device_node.full_name works.

Rob
