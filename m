Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B860DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729E12075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729E12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIEKjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:39:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeIEKjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:39:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EA5787A72;
        Wed,  5 Sep 2018 06:10:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D17E5B27AE;
        Wed,  5 Sep 2018 06:10:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2090C16E08; Wed,  5 Sep 2018 08:10:41 +0200 (CEST)
Date:   Wed, 5 Sep 2018 08:10:41 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] drm: fix drm_mode_addfb() on big endian machines.
Message-ID: <20180905061041.7yfmvnpbnbugboc4@sirius.home.kraxel.org>
References: <20180903105756.24912-1-kraxel@redhat.com>
 <20180903105756.24912-4-kraxel@redhat.com>
 <20180903164558.GL21634@phenom.ffwll.local>
 <CAKb7Uvh-UB6pR1r-D5sX0HwWwTExVzjxcdeAKNAmRWdqh=hKGw@mail.gmail.com>
 <8e8f8cf3-c4d4-6bfd-4e53-536d4d0c79ff@daenzer.net>
 <CAKb7UvicP594ASs4QutRH4oW1XZ2gTA5Fa=w8FPQzzKaSzDQuw@mail.gmail.com>
 <4262e9d1-75c9-1be3-08bd-1ef842a13f2f@daenzer.net>
 <CAKb7UvhwQ3h8d2t+-Cqd675oJSffyQrBG4SB1UqMSX82SDXs1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7UvhwQ3h8d2t+-Cqd675oJSffyQrBG4SB1UqMSX82SDXs1g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 05 Sep 2018 06:10:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 05 Sep 2018 06:10:42 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> >>> As explained before, that would break radeon userspace on big endian hosts.
> >>
> >> We last discussed this about a year ago, so I hope you'll forgive my
> >> lapse in memory...
> >>
> >> There's userspace that uses ADDFB2 with DRM_FORMAT_XRGB8888 but
> >> expects it to be host-endian?
> >
> > ADDFB, not ADDFB2. The latter probably didn't even exist yet when this
> > was made to work. :)
> 
> Right, but ADDFB doesn't know or care about DRM_FORMAT_*. That's what
> I'm saying -- keep ADDFB working, and fix up the DRM_FORMAT_*
> underneath it both in the conversion and in the driver. Gerd's patch
> allows us to do this incrementally, eventually truing up the
> DRM_FORMAT_* in the driver, enabling ADDFB2 to work as expected.

If it is that simple then yes, we should be able to fix the radeon kms
driver, then drop the quirk once all kms drivers are fixed.

But IIRC there are some radeon-sepcific calls used by the radeon xorg
driver affected too (thats why the commit message says "... both xorg and
kernel drivers ..."), so fixing it for radeon isn't that easy ...

cheers,
  Gerd

