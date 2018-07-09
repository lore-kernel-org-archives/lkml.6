Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E968C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF23A208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Yb6hs5T1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF23A208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932738AbeGIHj3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:39:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44706 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbeGIHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:39:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id d17-v6so1071688eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FXKRWFspG0VbG5SDSAlkeui09UV6gyzuR7XW3qh8rY8=;
        b=Yb6hs5T15h80Ac8hntcChYG3qmvZi/ErsD00FxwFfJhazDvCoLy7sy4KHZaJaBloiB
         DwpZqE6hARb52vN2xPe9lLlvyPsDGKL7QgvEwAwjN6ScwUHRfoMmXNrtBS5alx8ay0bg
         eYD5Bn4jkDA/Nnyp/nDMX+jey6DjcL8IeqIk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FXKRWFspG0VbG5SDSAlkeui09UV6gyzuR7XW3qh8rY8=;
        b=Z4VJqSPxOMBf4h8z/k9UtgDE66+rulH2jbHN/4jSKIp1GnKSC+UN9tYgNpfcrbe+16
         6g4Jxeqale+ltcq7zF4eWnCRVbDbcOHBiA8HzCxRpdixj/16nV9fUbBICM1LrXWoIFNX
         CAwiu9zt4Hr2zkmqNYr6AKTyMU2fjBWv8pgG34XmG/qH1y9bYzi4Mcg998hpTvVv5PRo
         6dkxXTG4buWEfvL74WbvruLCL+yJYA3FTJzu1VJPbpSXWGfn9m12FfJBibhTTJpqZqLB
         weVN6H/i6WyMMDjgMbE8zGMClJAQ1Tkz1d3qy6k5PbtQsn3TBkTZ1ZujW9KZwynAMhdr
         orLQ==
X-Gm-Message-State: APt69E1DkAIxl/mV4HPBLdrQQKHb9wu294rBXwjL8pe/qPGRFhLPi41C
        lAoVKZfstKbAKVRjZlAtng+76A==
X-Google-Smtp-Source: AAOMgpd7x30aSDA6O4DfR57IOgM9fbGwtd1PZvXLHhduPkGHS8eWjze23gz4TojmB3oNHZtjdTGFQg==
X-Received: by 2002:a50:aba3:: with SMTP id u32-v6mr21205752edc.69.1531121966971;
        Mon, 09 Jul 2018 00:39:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id d18-v6sm5938165eds.40.2018.07.09.00.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 00:39:26 -0700 (PDT)
Date:   Mon, 9 Jul 2018 09:39:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Adam Jackson <ajax@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/cirrus: flip default to 32bpp
Message-ID: <20180709073924.GB3008@phenom.ffwll.local>
Mail-Followup-To: Adam Jackson <ajax@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
References: <20180706091249.25086-1-kraxel@redhat.com>
 <e127596f255261d78fdfe6f534a1000f60c3c605.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e127596f255261d78fdfe6f534a1000f60c3c605.camel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:35:07PM -0400, Adam Jackson wrote:
> On Fri, 2018-07-06 at 11:12 +0200, Gerd Hoffmann wrote:
> > cirrus can handle 1024x768 (and slightly higher) with 24bpp depth.
> > cirrus can handle up to 800x600 with 32bpp.
> 
> 16bpp is maybe a better choice? Nobody's using cirrus because they care
> about color fidelity and it'll use less CPU to update. There's
> precedent here, mgag200 defaults to 16bpp on sufficiently memory-
> impaired devices.

Yeah nouveau does the same fallback to 16bpp if there's not enough vram.
So do a bunch of other drivers.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
