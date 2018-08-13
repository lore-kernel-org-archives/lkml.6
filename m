Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A25AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1F2189A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA1F2189A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeHMSG4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:06:56 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45731 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMSG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:06:56 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so17710794qti.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9oU7rsfmvDzntttF/8buaYPRNWR0tPx1MDnnVlZyXI=;
        b=MrNPcQRMBKo1giUIha26ycd4BfVTIBfigPRnyKSUozg7Gu9uxsGw83xQSr+apmjib6
         /gc7PQu44Oh/PW2vTAaphHmTNs9BWa2nlXt9pRCLTRqXKTusDiuU4P5Vc7kR1WA8dzdl
         U8eKJ1OmxozMOncq3FANa3bVWODRro7rnnIO+SOyRrjrL6vCWO2XczmC/EVjVrCbNEP0
         isn9zJvTGBwjZ5nn5MvgsM0dDZridVehIxDwEufRjinuhkTJVpKGMLRYi1iHepPep0zA
         ra8US+TcNrZaTJummVqbiJlM7BMYI1jX7cuNMb2PqTBGJjC9wGDmIQAbteJ9paOpE2fl
         VYog==
X-Gm-Message-State: AOUpUlGvVNNUGjIC06XgGiuq5sOFIKm4x5DBpkH3cousxZdZcw2BLtjN
        5jsqqzdD2Wy8qODckQZJRtjcC6ehuMj7iYZDI5Q=
X-Google-Smtp-Source: AA+uWPyhPD7go37f6QkM/tycWwUOYeYp0r/szMxwf6wj2JTTijpqhcQyXllArpn+t/vveEtS+4RHli9fSD16K/OTrlE=
X-Received: by 2002:ac8:274a:: with SMTP id h10-v6mr10048008qth.187.1534173854119;
 Mon, 13 Aug 2018 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180811155554.3382650-1-arnd@arndb.de> <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
 <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
In-Reply-To: <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Aug 2018 17:23:57 +0200
Message-ID: <CAK8P3a1AGC4fFYSSDQn2snkvf5htZVffCwRLV1NBm5YeZgw+CA@mail.gmail.com>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
To:     alexdeucher@gmail.com
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        David Airlie <airlied@linux.ie>, michel.daenzer@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>,
        Jerry.Zuo@amd.com, dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 4:49 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Sun, Aug 12, 2018 at 3:55 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
> > Adding Harry as well.
> > Am 11.08.2018 um 17:54 schrieb Arnd Bergmann:
> > >
> > > Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
> > > Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86")
>
> Maybe it would be better to revert 4841203102a3 so we can limit the
> scope of this to DCN support.

That would help, but we would still require the patch at
https://patchwork.kernel.org/patch/10090227/ or something else to avoid
broken randconfig builds.

     Arnd
