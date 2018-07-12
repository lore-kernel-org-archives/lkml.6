Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8FBC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BE72086B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="StlbcpXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BE72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbeGLGsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:48:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33645 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeGLGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:48:00 -0400
Received: by mail-it0-f65.google.com with SMTP id y124-v6so1075809itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xhxnlk6u4VoTZdohB+qCVE8yJJgqiMYtNMOd1hPEhkc=;
        b=StlbcpXPh7KppvYiqdfSJ/XUITGaP0YxBbEmswW7LP9K6wXre/eY+DOvr3JZNyM0bg
         GtqkdtM7SyBYgI4qn5Asq0OcmnZBfbG0XdbK0xOctVe3ZNdqJ75MQREJH7GF8cpvLcy1
         MH0cNHIP/5C7kn9YikrdPfQMksB7w4lUdjqL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xhxnlk6u4VoTZdohB+qCVE8yJJgqiMYtNMOd1hPEhkc=;
        b=f4prfG+DajlqlTIB4laLUlwYjMMJHOFehAk/8eW1jPdk5hdeIJ2nZ6/lKjTz9xtCqK
         q9L92vKCJM2JA/F6Eb9EK2z7/E+fA6n3bW8Jcm++NwsZajRExwI0LV0+BtGmH4T67gOU
         +TyGwEj4OKFj5xhqrsuNzMVHhfQWpyQ/I+IHqg5u+0dWVuppHYO7NN32d3za6go4KS9y
         ObG6STljYRSPGrOmvriE4/pPgMIewpHY2yN/cIjmoxF0xHgvSocn/TYv4Oqkt7DnMXPw
         IUjOq7E4lxghMwFzRfY4l7xWV/nMRTRg1xsQa3TdjPilLB9Yq8To4wKz6O2RPOUe0TXM
         iv8A==
X-Gm-Message-State: AOUpUlF9sah+MWiIOrMH+D6uMNezd8CP8nreBQcwL2Y1zykMmgneYvFk
        W5Ioe6zFSIkK4yVVRJwAj2eMB8BUwXfE3Dl4locbGw==
X-Google-Smtp-Source: AAOMgpcjSWMw5Wot4o7xbc+3EzwYuiBXkqmZdA3tUQmCBZmsvIzlBBtfiPrfdt3+B0zT/PaIzYrd8/2oCJmRMSOvIPI=
X-Received: by 2002:a24:558a:: with SMTP id e132-v6mr375857itb.2.1531377591022;
 Wed, 11 Jul 2018 23:39:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 23:39:50
 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <20180711160547.59f086a587c7f3c8d3c40f0f@linux-foundation.org>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709162509.29343-1-daniel.vetter@ffwll.ch> <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org>
 <20180710075328.GG3008@phenom.ffwll.local> <871scbwfd4.fsf@notabene.neil.brown.name>
 <CAKMK7uFEYyD2ChWnO_0PS_rkK180dDoQ1g4J0UWRfchnYQxOTA@mail.gmail.com> <20180711160547.59f086a587c7f3c8d3c40f0f@linux-foundation.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 12 Jul 2018 08:39:50 +0200
X-Google-Sender-Auth: CiIaEbLyPIoSsrtsNgjYChvrCpU
Message-ID: <CAKMK7uHak=JTsO0Lb8UDpgXF_xvUOTjocTKi3jFgR1ZDFZX57w@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Wang <wvw@google.com>, Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:05 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 11 Jul 2018 13:51:08 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>> But I still have the situation that a bunch of maintainers acked this
>> and Andrew Morton defacto nacked it, which I guess means I'll keep the
>> macro in drm? The common way to go about this seems to be to just push
>> the patch series with the ack in some pull request to Linus and ignore
>> the people who raised questions, but not really my thing.
>
> Heh.
>
> But, am I wrong?  Code which uses regular kernel style doesn't have
> these issues.  We shouldn't be enabling irregular style - we should be
> making such sites more regular.  The fact that the compiler generates a
> nice warning in some cases simply helps us with that.

Yes liberal sprinkling of {} per coding style fixes it too. But given
that the if (!cond) ; else pattern is fairly common even outside of
drm it seems like not just graphics people think that little bit of
added robustness in iterator macros is worth it. Only reason I
bothered with this is because I've seen another open-coded version of
this pattern fly by.

Anyway I'm going on vacations for a few weeks now. Andy/Yisheng, I
guess if you want this it's up to you to haggle for a consensus around
this. If that doesn't happen I'm happy to keep it in drm headers.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
