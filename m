Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00020C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29D220645
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551260426;
	bh=x+VQTUTmXUy4/oJWenGc/yHoSkt8Q8ZwRPwstsmi5JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pwZu67N9L4V5YYoPcvXpxL926yYkd28BfTilmbPThnjaNbUI7+X3qTiqtht6d3V4N
	 RMn4SgpChfZlr4UR1fnbIcIKiH34wkWzaDvQ6jH9jLqMhKRYXpXWzdgfPtEdgdTfLf
	 arI+iDQCGSf7qUHy7sjHBz5z5EVaFlp1uqmlhgOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfB0JkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:40:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43658 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0JkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:40:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id j1so11950562lfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8DgYr2f7szhb5YbePJzSZfe5UqD4tssgV37MUUi4cQ=;
        b=gCXKAdW3gkQnQ21D5CoKwdgYbTSxdjkz2+syYve89X/Qwe8DbDEhNw+/5ANI2Quwni
         CaQ/fWMifcv5LDqbegwPK8zJRB3D4iPZbCKUTCb2I5njjoMz9yT9+nrSnR9R0/cvKt8J
         ThkRoknybEfyyjb2qExuSHgXbryT3IcBZGhSjug8caLmUxBKKU5iVWNh+jCq7r+h7S2h
         JEHrkwZiSEGX7MZLjjyCyibqMJUx9ghDR+uMrShyKRCl/53Lg72we513/OU9M5smUngH
         tvm30E9LrkT8Fcx6bWK1Rtwf85p0QTy98+4nWwbFCpw6arSfy42t5r+PLi/0ABxOTjIs
         UL1Q==
X-Gm-Message-State: AHQUAuapuJAuCzUFQ3kYQg9fefFMFn8tu/Asj9VmBbfdjkhIH+UtOqyb
        8WVEolTKxdl3cfeaTT22E90=
X-Google-Smtp-Source: AHgI3IZ60eoDWkqz4LbLTJ2LX3LoqqjLgG8M2KJhVP10ma1/mkJ8k5S82SSFWfQkjfOxR4B2w1FyiA==
X-Received: by 2002:ac2:4109:: with SMTP id b9mr256058lfi.109.1551260422857;
        Wed, 27 Feb 2019 01:40:22 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u9sm3923158lfe.58.2019.02.27.01.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 01:40:22 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gyvhN-0007GW-GA; Wed, 27 Feb 2019 10:40:21 +0100
Date:   Wed, 27 Feb 2019 10:40:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
Message-ID: <20190227094021.GL4747@localhost>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
 <20190227092318.GK4747@localhost>
 <20190227093104.GA5354@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227093104.GA5354@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:31:04AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 27, 2019 at 10:23:18AM +0100, Johan Hovold wrote:
> > On Tue, Feb 26, 2019 at 03:41:07PM +0100, Greg Kroah-Hartman wrote:
> > > The dev_links_info structure has 4 bytes of padding at the end of it
> > > when embedded in struct device (which is the only place it lives).  To
> > > help reduce the size of struct device pack this structure so we can take
> > > advantage of the hole with later structure reorganizations.
> > > 
> > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  include/linux/device.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 6cb4640b6160..b63165276a09 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -884,7 +884,7 @@ struct dev_links_info {
> > >  	struct list_head suppliers;
> > >  	struct list_head consumers;
> > >  	enum dl_dev_state status;
> > > -};
> > > +} __packed;
> > 
> > This seems like a bad idea. You're changing the alignment of these
> > fields to one byte, something which may cause the compiler to generate
> > less efficient code to deal with unaligned accesses (even if they happen
> > to currently be naturally aligned in struct device).
> 
> No, all this changes is the trailing "space" is gone.  The alignment of
> the fields did not change at all as they are all naturally aligned
> (list_head is just 2 pointers).

Yes, currently and in struct device, but given a pointer to a struct
dev_links_info the compiler must assume it is unaligned and act
accordingly for example.

> So this allows us to save 4 bytes in struct device by putting something in that
> trailing "hole" that can be aligned with it better (i.e. an integer or
> something else).

I understand that, but I don't think it is worth to start using packed
liked this for internal structures as it may have subtle and unintended
consequences.

Johan
