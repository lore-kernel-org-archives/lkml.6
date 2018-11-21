Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09DFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7118021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="G5cHyjwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7118021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeKUUID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:08:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34357 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbeKUUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:08:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so4342624ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cO6gZrBTYfDfny6KeEvGuD4MD/pF6UV95YdWttosCvE=;
        b=G5cHyjwWDY/0L4cs6nHCPj+ffofZ1K+O/xdAlMJw93T6n72rOQ9oNqR86Ho1rWwBfv
         ys+88CEzpvwn20K1+x7ejNUqCBnq9RQwvR8/j11xxiMzSqpLa+xEzZdjwQ30pHxXPmTt
         Qjl6Z6ZJj7JjURWghP8EaAXIqYRH8JU8rIhm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cO6gZrBTYfDfny6KeEvGuD4MD/pF6UV95YdWttosCvE=;
        b=T+9RGAznPAnpoOtftC0gAsplp6gmbhcDg2xZpFXSfneDC4hh/cde0liL2hsREg/C82
         0uXc7N9IjHTGWTGVmz9j5iyC2ZhqAHXrnpLECH9Hr18qNStLL5er//2mKChHQR62JAIw
         9aZ9YkyYcO7TLR8mWGV1vMVHtEUOBGJY92/MiEudNFlb5YCpAB7yhN9p4gjddfDsh4uR
         ITJv5o/yMryUjv1eUGHAdGrETZCkslC5/GcILsCl+GClrsIurw6sKx5zO34hmRapdfY6
         dX6/BoXZAkdJk6w+aU6yVnme/eDpDv85PqwZzFi1YzzwtFMPAy+B0gDEZnEsoyOvfTjk
         2vTA==
X-Gm-Message-State: AGRZ1gIc68GrFaIeF/3KjHj6mJ6XZvp+dvNHzFR0LZSyovZT6XyGTapR
        +bdQ82ULHLtAmeeylIhE/aX/yrt9X4c=
X-Google-Smtp-Source: AJdET5eDwq0W6b5WEJpoGHjN53bxwc+kXYIGBYWPO3KkvXVhbLyPF0l90JMN498la9qc57xdfyR6Aw==
X-Received: by 2002:a17:906:3603:: with SMTP id q3-v6mr4585841ejb.164.1542792857751;
        Wed, 21 Nov 2018 01:34:17 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gy12-v6sm846373ejb.44.2018.11.21.01.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 01:34:16 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:34:14 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v4 2/2] drm/virtio: add edid support
Message-ID: <20181121093414.GK4266@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
References: <20181030063206.19528-1-kraxel@redhat.com>
 <20181030063206.19528-3-kraxel@redhat.com>
 <20181030093804.GQ21967@phenom.ffwll.local>
 <20181121085422.mk4ob6vhwbnufqzl@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121085422.mk4ob6vhwbnufqzl@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:54:22AM +0100, Gerd Hoffmann wrote:
> On Tue, Oct 30, 2018 at 10:38:04AM +0100, Daniel Vetter wrote:
> > On Tue, Oct 30, 2018 at 07:32:06AM +0100, Gerd Hoffmann wrote:
> > > linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > Like with bochs, I think drm_do_get_edid() here is overkill and fairly
> > pointless.
> 
> Like with bochs it makes sense to use drm_do_get_edid(), because it
> handles edid override and other common stuff.  Not that this should
> actually be needed for virtual devices, but I think it still makes sense
> for consistency with other drivers, and it might be handy for testing
> too.

Yeah Jani corrected me here, I forgot that we reworked all this quite a
bit. I checked the kerneldoc, it's up-to-date, so all good. Ack: me fwiw.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
