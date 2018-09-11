Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49449C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5D02086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CYcPjw1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5D02086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIKMkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:40:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36483 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeIKMke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:40:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so18461882edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qo6wYAZoCPbUQOBFKhs51vyBwRmhyOdfwj7oPQ6MePY=;
        b=CYcPjw1zpQ/110Zo6LviC7giAyAZmVaqwnjYicQNA5pKXJ2OVqVXp4CboO7WiU1HVp
         8+hGVRQVTvJFjh/I7O5qVBtrwaARa6YAEU+H7DlIgTieyu8zqURcTxZa5fZwHTrL9JHu
         ybuQN4Z6fxl84bh/HXaaT2wvThs2leBI1mkng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qo6wYAZoCPbUQOBFKhs51vyBwRmhyOdfwj7oPQ6MePY=;
        b=JD3p2WcP4ptZqYJhIgIykiCwQG/1Ke9fTAQUstMAPUCeq9iLOwe/Bek5bAnQeVE1Jz
         vlR41hEhsKygfmAVfM/Nhru9Jie0jy/3RLx3cgdswA9TYh+KgY8gZXE4A0ZB9yoS7pek
         h8lvM6Bf2O5GS7RAkoUHYbkZxjoIQ0OHNDV7jO35Uf6WyA6GGjBVwJ6XmgZi7dwjD/UA
         ME4RGMP+aDmP4jVDkUB8cCTeR5iqi7xHtI81jvzYhk1oAdKYz0hUJGuog/9t+fFEEiw/
         HQY5hZQ3rV0kjxYuc5x9hP4XAND0y6TWqgxeORMiX79HlFw37uaJrNXWwgcIhIHvezoZ
         TmTw==
X-Gm-Message-State: APzg51DonKfR60ji40kHlNrJRH/qRTBmWSGBbf6xnI/Tglicj6u4bAmq
        dvLVYJW/2jCUy6InLfZN92rEIA==
X-Google-Smtp-Source: ANB0Vdb/filSJVRnxGASspQo+0/BrR8pWyiHWVcgMm/juAapENWCp5Ck5zrrpsDsCLmDnFNOmWyjLg==
X-Received: by 2002:a05:6402:397:: with SMTP id o23mr26797580edv.117.1536651751153;
        Tue, 11 Sep 2018 00:42:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g38-v6sm9984215edc.40.2018.09.11.00.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 00:42:30 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:42:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/4] fbdev: Drop FBINFO_CAN_FORCE_OUTPUT flag
Message-ID: <20180911074228.GI19774@phenom.ffwll.local>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, nouveau@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <CGME20180822085418epcas5p30ab8aa4b49ba204f4891760af002bce1@epcas5p3.samsung.com>
 <20180822085405.10787-1-daniel.vetter@ffwll.ch>
 <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910124845eucas1p1b51674cd657757aadf5138e277e57ebe~TCsHYsLqt1779917799eucas1p18@eucas1p1.samsung.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 02:48:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 08/22/2018 10:54 AM, Daniel Vetter wrote:
> > This was only added for the drm's fbdev emulation support, so that it
> > would try harder to show the Oops.
> > 
> > Unfortunately this never really worked reliably, and in practice ended
> > up pushing the real Oops off the screen due to plentyfull locking,
> > sleep-while-atomic and other issues. So we removed all that support
> > from the fbdev emulation a while back. Aside: We've also removed the
> > kgdb support, for similar reasons.
> > 
> > Since it's such a small patch I figured I don't split this up into the
> > usual 3-phase removal.
> > 
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: David Lechner <david@lechnology.com>
> > Cc: nouveau@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Ack for merging the entire series through drm-misc-next?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
