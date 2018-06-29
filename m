Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F93C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8668927A78
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lTxjfdPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8668927A78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965381AbeF2SLN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:11:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55346 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965209AbeF2SLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:11:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so3067827wmv.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YxdrrWj1uTuceiSbNweHK2dEKfzCYWZMJgXRtxe+69E=;
        b=lTxjfdPM29Dx0RtkHgxH1yHbDvBwG2ekxbHIPl8SsaQjy+zMznhuyWIU4tHL43hOQJ
         7IG8JQHUbYU+oqnbbACQ7LSXMQTVZDDbV05B2rqwPHhox4ahABZX4MUc0AjFHH4Lbnmt
         C3d4jPNNf7nc8zbbt2Xlz1JBAJmB0ph17xQf+Y2J5+X+n0gAtwzlIZOJ4zXAqJCQVd7s
         3fjK2nmpDUONGEyv7nLHYvgasDrbx+3RmrgftVDfBAc4P9Nd+XTdbrDzwPzald2jujzb
         ZDG+FfWOwujXPb6PiMWEvXjeZzz3AGbpoTOG9uteJ8PlEGs5azE1/7gphhkJKbG85r+C
         OBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YxdrrWj1uTuceiSbNweHK2dEKfzCYWZMJgXRtxe+69E=;
        b=cfhGFJiSEVuSgoel5Mnp0OLEWEYrBDaIBJbVFStFl7dj9N1gsYDBelYDUGS6MiZIA2
         ocAx3EHh8bc0Hj8ZJ4IZRcajTGiqQwu6YbyEQkbTNOoANR5lTdy06z6VA43Ysj2573Sc
         vBk+01GJ1yoAZyucRom315AWM84Tn7f9hiiJeGiLuBOLeAKU36rZoOf3y2a5X31nuk+/
         6MJCxrj0gzuSj0NYeG1XrevkqHuFQmk2vWDooZxKPLvuJ7POKv3v5iCtHq7P+RF5+qoj
         kMwl1CabqF+dlTvBZWg1XAkqfGyTbYqwuQYcS+xGndvmWq2aenFiAYmirpOff1wxJ8ey
         JOrw==
X-Gm-Message-State: APt69E3cz3E0FruUqiYAYlM3m0muTTCxMKUdBSXJahxwzvXpJVCCc5hO
        aL9MWceSLmTdPTvOyDAwlxUrEA==
X-Google-Smtp-Source: AAOMgpehLTx3o1m607BKGfRggAnlCZQc5J5D/EanOgBqqdAcCO3lhjMi410VW3LTTFomnGkm5xrqbw==
X-Received: by 2002:a1c:8590:: with SMTP id h138-v6mr2405913wmd.85.1530295865491;
        Fri, 29 Jun 2018 11:11:05 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q17-v6sm13943979wrs.5.2018.06.29.11.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 11:11:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fYxrI-0001SF-Qv; Fri, 29 Jun 2018 12:11:00 -0600
Date:   Fri, 29 Jun 2018 12:11:00 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629181100.GH379@ziepe.ca>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
 <20180629153141.GE379@ziepe.ca>
 <20180629174328.GA4060@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629174328.GA4060@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 08:43:28PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 29, 2018 at 09:31:41AM -0600, Jason Gunthorpe wrote:
> > On Fri, Jun 29, 2018 at 06:10:02PM +0300, Jarkko Sakkinen wrote:
> > > Do not allow to compile TPM core as a module. TPM defines a root of
> > > trust for integrity and keyring subsystems and should be always
> > > available and not be loaded from the user space. There is no a
> > > reasonable use case for a loadable module existing.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >  drivers/char/tpm/Kconfig | 2 +-
> > >  include/linux/tpm.h      | 3 +--
> > >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > This doesn't really make sense..
> > 
> > The kconfig method is that if IMA requires TPM it should declare so
> > and TPM will become non-modular because IMA is non-modular.
> > 
> > There are lots of legitimate use cases for TPM that don't involve IMA
> > or keyring.
> 
> In what context would it make sense to have TPM core as a module? I
> forgot to add RFC tag this patch. Did not meant to push it to
> mainline but more to rise up the discussion.

The usual reasons for modules, embedded that wants minimize kernel
image size to minimize boot time - load modules after the system has
started.. Developers that wish to use module-reload to test the code
they are working on, etc.

Jason
