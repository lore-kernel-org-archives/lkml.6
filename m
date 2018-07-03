Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08382244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz/vszoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08382244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeGCHVQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:21:16 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43321 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeGCHVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:21:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id m12-v6so734563lfc.10;
        Tue, 03 Jul 2018 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Gc7xJ5dE/rSLF8g/aKS5HaMl9JkU1C85YvWz97Mjj0=;
        b=Dz/vszoHVnaaBQzopMEhvOpWRc2bWjHnfR2rNMQDir5Iq0ws2WLhKsakrup6WYzBLc
         Blo04ljAsshxn1xZwa3YbZJ5pY5BuI8wFZsKZVbhOrbQf4oGdZnMtNAi5Ldr1Fuo9s1P
         EDN03/uH8Gk5et39durkJbipJr6hRwXpejz9sA4y+uQF7DBCMOpX0BNsapqwhyD+oRtD
         JwjfyOBHXFTdV78r/oLCUgz/TCnwOY9RKkX4j+LnJrFXO3bkpclHcPNzgQWm6jdyaHok
         yvUMZr1Dd/xoI866K+f9Yh0t9TWbCpOBsvqUh7+AsY9ZOu5iOU4zc4Xevj6F6+bSB5Vq
         t77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Gc7xJ5dE/rSLF8g/aKS5HaMl9JkU1C85YvWz97Mjj0=;
        b=cEWvZaoWISWehFBA7BHQZEpbX85lJvKVjK3K5xl++lkEXMSBeMj2ZTwLDVvxKs0DAq
         81xNR7XBHg4GRv9OuCzNMJW0Hp6TLHWLgba+leiCVs9+hdRk0wqEqWoXy4DcnbQxQP8e
         NfQo2Yq0B4NaLpEkNIRL9zW1/KIAi8WBE6SrNnBLXmgzir3uZ33BPBTX64jbvj74Hdyk
         jsgR4to54kYTV6WmrR2DQ3RU208qZDenyCaZzpFMofPKtgnztAT+FtrRBK1Ne0ysoHuw
         48WKMUl7F2FAMX+Ud39xxNJFaQ69ED0cu/1gNXnnnENsefIejb3AvSGJIvNlftZg6DgP
         NhZg==
X-Gm-Message-State: APt69E22GjemGaf9p+rrg7oB+PATvX4FgGd3FSrAPVpQLzKhZxJb8b73
        WvPguHHZaGgSJcwgAF88k5PPPDDD
X-Google-Smtp-Source: AAOMgpfw9mURmGJUjvbAd8nvT4jjA1DfSB4U70KUNzYJpEKVNz/ZTKohm5m//C9Ru6KAa4In1nVzvg==
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr1075515lfe.60.1530602466917;
        Tue, 03 Jul 2018 00:21:06 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id s2-v6sm111968lfs.26.2018.07.03.00.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 00:21:05 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1faFcQ-00032R-7H; Tue, 03 Jul 2018 09:20:58 +0200
Date:   Tue, 3 Jul 2018 09:20:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        alan@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180703072058.GN9802@localhost>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180628120103.GA28131@kroah.com>
 <20180629094607.GC31718@amd>
 <20180629114646.GU629@localhost>
 <20180629120554.GA2477@amd>
 <20180629120914.GA9802@localhost>
 <20180702193226.GB30798@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702193226.GB30798@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 09:32:26PM +0200, Pavel Machek wrote:
> On Fri 2018-06-29 14:09:14, Johan Hovold wrote:
> > On Fri, Jun 29, 2018 at 02:05:54PM +0200, Pavel Machek wrote:
> > > On Fri 2018-06-29 13:46:46, Johan Hovold wrote:
> > > > On Fri, Jun 29, 2018 at 11:46:07AM +0200, Pavel Machek wrote:
> > > > > 
> > > > > > > Finally, note that documentation (including kerneldoc) remains to be
> > > > > > > written, but hopefully this will not hinder review given that the
> > > > > > > current interfaces are fairly self-describing.
> > > > > > 
> > > > > > This all looks great.  Thanks for doing this work and adding a new
> > > > > > subsystem for something that has been asked for for many years.
> > > > > > 
> > > > > > All now merged in my tree, nice job!
> > > > > 
> > > > > I don't think discussion was finished on this one.
> > > > > 
> > > > > In particular, we agreed that /dev/gnssrawX would be better device
> > > > > name, so that we still have place where to put proper abstraction
> > > > > layer in future.
> > > > 
> > > > I did not agree with you on that. I said we could consider that name if
> > > > this was to be changed at all, which I do not think is necessary for
> > > > the reasons spelled out in this thread.
> > > 
> > > So, again: there's nothing gnss specific in those patches. It does not
> > > know about the format of the data passed around. (Best you can claim
> > > that somehow data flow characteristics are unique to gnss.) And this
> > > takes namespace needed for real gnss subsystem. Please don't do it.
> > 
> > This is the real gnss subsystem. Get over it.
> 
> Congratulations. You have created gnss subsystem that has 0 lines of
> code that are gnss-specific.

We have been through this already.

> This is not real gnss subsystem. This is pipe that passes data,
> similar to /dev/psaux or mouse on /dev/ttyS0. Sooner or later, real
> gnss subsystem (with unified interface) will be needed, as it was for
> input, and this "pipe and gpio" thing should not hog required
> namespace.

It is still the gnss subsystem with a raw interface to the underlying
protocols. As I've said repeatedly, *if* someone ever comes up with a
way of abstracting these protocols, and can make the case this is really
something we want to handle in the kernel, we would still be using the
same drivers for managing power and I/O. Get it? It's the same
subsystem, you'd just be adding a second higher-level interface (cf.
hiddev and hidraw).

So again, all that this comes down to is bike shedding about the device
node name.

Johan
