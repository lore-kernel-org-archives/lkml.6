Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1FC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8362088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8362088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeILV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:26:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38801 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeILV0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:26:08 -0400
Received: by mail-qt0-f194.google.com with SMTP id x7-v6so2437650qtk.5;
        Wed, 12 Sep 2018 09:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzSXajEIOEAaegylvrBHpi2RO12+N/sCEe0XRLpt528=;
        b=eWCwNRZ6vrAmpFL51vZU673oD0bRSugwvvdlT5e0/l3Pv2qI7knvDubb+nrhxVQn6u
         82M7OnpLT1l/CZp86DR6UoPst/5vRKfKE5Z4pECgUQ66hgd6jl0pRRTyh1+lmIS1XBip
         DWyKtv+mzLiD9ijfK+ncH3zXZmRyi6SElncTPaJAp3GT9OzuTsT/97fpllrJdTjH/pgh
         8hO+Wn52cWAOCtp8EPJtOx40JOMb9Z0xv0eqqc2GdESPQXqGV5av0OA3ymQHG+zY761A
         b1fCf4z/dpzrGXRIkFYPRR4fslDf/bZkvGyayHBP2Zn6MDG6ztt2xWpG0dDxasB8tVAN
         Jo/g==
X-Gm-Message-State: APzg51C2+FGJ0a0ufaTG7b7E49aY8FotaS6TOgY248B+gP5Qvb+Zl71f
        ZSuVqb6XjizwO/DjjRBMKccj7WyqidFmJwOFHkU=
X-Google-Smtp-Source: ANB0VdayHXt5KVr1v4xZIQXSVvZNkxzM/lkNiLSy16ce7jG/bLRjxMb2RRGes8TjE1wUZG2bwbThZHKkfWuSPrlYH3I=
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr2115395qvm.115.1536769251572;
 Wed, 12 Sep 2018 09:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180912150142.157913-1-arnd@arndb.de> <20180912150142.157913-2-arnd@arndb.de>
 <20180912153300.GE5633@ziepe.ca>
In-Reply-To: <20180912153300.GE5633@ziepe.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Sep 2018 18:20:34 +0200
Message-ID: <CAK8P3a1RoYo0VHrDfxdmJt9ns0ErTeuctH9CPG5_mg7JTwZtEQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] compat_ioctl: move drivers to generic_compat_ioctl_ptrarg
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Miller <davem@davemloft.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        USB list <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Networking <netdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 5:33 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Sep 12, 2018 at 05:01:03PM +0200, Arnd Bergmann wrote:
> > Each of these drivers has a copy of the same trivial helper function to
> > convert the pointer argument and then call the native ioctl handler.
> >
> > We now have a generic implementation of that, so use it.
> >
>
> For vtpm:
>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
>
> Arnd, would you consider including a patch as part of/after this
> series to make compat_ioctl in drivers/infiniband/core/uverbs_main.c
> use this as well?  Looks like a bug too?

That should be included in patch 5 in this series. I may have skipped
some Cc there since it had too many recipients (sent only to the
mailing lists instead).

        Arnd
