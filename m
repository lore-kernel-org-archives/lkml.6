Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD9C485D0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDECE2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Mi6O/Uy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDECE2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbeGLRb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:31:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35898 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeGLRbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:31:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id t3-v6so22472701eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXdj/4GDDjY63k8RkvkpHsWdt8vcMXS+ar9cvWgI1nQ=;
        b=Mi6O/Uy2VOQBPlgF52Dq9BOU8MRHe1qog/abhXN6FjbKZV6U9alOqWBD1fA/o4mW1R
         zJPtd7OJf1v5m4jdWu7CzSl8vqE9X+oRjajAqDqD6N0EGcrS5foOx8Mx2CgZaE9c9eBi
         GssRQIIoLboxhMmfEFg1CBSiGwkRQVaLZ9zHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TXdj/4GDDjY63k8RkvkpHsWdt8vcMXS+ar9cvWgI1nQ=;
        b=gaIPQt0LBEeYrXmhkKfhyCWTcJ5YOvel2vYJgrw70W0nKVPSzcskGJM2T0d9PHfVIG
         dZ+/EN4R58kMZy5T9wujg5rGB0kQnPF6RhItBVxQzJDBD6N/fu1bTMla0KUO/Lha4wkF
         6LOiTNLIbikBXljrXz57ZJhWvEg9zYNxklctRc2R3mm4uYCYl3cKDG8EQfvd8HgEny0/
         wLqhqvo7RBWyO/ht6QwbbxFhCJi7u2EEh/z9JCytNeK16037op2jKCmULW0UCINeYldH
         86BfunNZbdUNVRuVZ/RRx63H3EIzqbGLUP6DWwSDrhbhfGKtrEmPC8n1FGUtFQXv7Bnw
         Pv9w==
X-Gm-Message-State: AOUpUlHXyEecyxcNrEtVRVYr9SElAnO4M8oD2jiF0r9Mnc8J3IMN9FNF
        4i5RInCuL+6OJ+GYfsyZ4Fr2Tw==
X-Google-Smtp-Source: AAOMgpfIuLIXItoA2MRyJ8J3GMLSEE5jiAjkgH5L91oz8LqEu8RvEbYC9PLt/qb4KW9lZoECaOb1+w==
X-Received: by 2002:aa7:c592:: with SMTP id g18-v6mr3502248edq.214.1531416084557;
        Thu, 12 Jul 2018 10:21:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id p18-v6sm5159443edc.5.2018.07.12.10.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 10:21:23 -0700 (PDT)
Date:   Thu, 12 Jul 2018 19:21:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH 0/2] drm/nouveau: Add support for dp_mst_info in debugfs
Message-ID: <20180712172121.GS3008@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Archit Taneja <architt@codeaurora.org>
References: <20180712171056.26359-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712171056.26359-1-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:10:45PM -0400, Lyude Paul wrote:
> This hooks up the DRM helpers for dumping information on the current
> status of each MST topology from nouveau's perspective to debugfs files,
> similar to what i915 does (albeit, i915 labels their debugfs node for
> this as i915_dp_mst_info).
> 
> Lyude Paul (2):
>   drm/nouveau: Expose nv50 MST structures in disp.h
>   drm/nouveau: Hook up dp_mst_info in debugfs

We already register the i2c-over-aux and dp_aux devnodes in
drm_dp_aux_register(). Could we do the same with a per-devnode debugfs
file for mst? The topology manager sits on top of the dp aux abstraction,
so this could work, with s/encoder->name/dp_aux->name/.

Would give us mst info on every driver for free (plus we could nuke the
ad-hoc version in i915).
-Daniel

> 
>  drivers/gpu/drm/nouveau/dispnv50/disp.c   | 34 ----------------
>  drivers/gpu/drm/nouveau/dispnv50/disp.h   | 35 +++++++++++++++++
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 47 ++++++++++++++++++++++-
>  3 files changed, 80 insertions(+), 36 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
