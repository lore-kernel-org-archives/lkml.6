Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC4920879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KaIL9IUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC4920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeLEV5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:57:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45515 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:57:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so18305992edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8890iLdmayaGRW0vSsJonAUr35cKs9NCOufTV5868I8=;
        b=KaIL9IUWVCBnExkjClW0Eysvgk2yLIMzUpbqj4Ogj+2r64ONaOWBB3otrv7xq4zDp9
         XlCu1VRsCAb4kqMaMoodCqhwbapGXzLn17OwPS4XNX7cVPsLv7XPkMy+LRy6JHsJ/ZZ5
         mmUQNpM0s1bT4EryimPuOx37tN40hRdIEuva8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8890iLdmayaGRW0vSsJonAUr35cKs9NCOufTV5868I8=;
        b=jw10Qu4+mflRolsW9VAc7XbzLW7KCZKPp7DPWf5svMkG4LabKVOT5+R7weH6o3zWQU
         p+vNjcwEyB5O+T2ONADhLnsceBZ+rcqJ/sWbY91PF9E6HNT3b/lvQnjJmrwQHQ0QLOmj
         ZOaw6sBijcDQVMYdD4mAK4zN6S7Bu8JyM9aTaI394BcW/1WMugkxcfV72lSKN2U6Egll
         DiSSlhcbdlgTdLmlTdVPIkxF9Tb9O6yYJGG6q/NUW/4halzkv+OK0rzArxmIrsuCDKCy
         TQe4TycL2YniHiWO5lEDr3/RqjsWUG9yrWq2Yc19OUVCATqlq+qOcS+gXGf9i3af2hws
         GnJQ==
X-Gm-Message-State: AA+aEWato8zHAlpS4XkvlTS167YONFkLGNJ4skH58T7tHvmrCYHMVdw2
        3G+gBrmJKy1cLn3mEud4YuMgDYIiMkI=
X-Google-Smtp-Source: AFSGD/X06JeQigJEnbVKzk8UxT/4qZN2cks06jG0LYODNVTCWt2KCgDD6J3GPJb/jL/qdA9qfH/c2g==
X-Received: by 2002:a50:8951:: with SMTP id f17mr22189622edf.130.1544047027190;
        Wed, 05 Dec 2018 13:57:07 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id w28sm6391770edd.38.2018.12.05.13.57.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:57:06 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id q26so14400141wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:57:05 -0800 (PST)
X-Received: by 2002:a1c:c483:: with SMTP id u125mr17093822wmf.14.1544047025411;
 Wed, 05 Dec 2018 13:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Wed, 5 Dec 2018 13:56:54 -0800
X-Gmail-Original-Message-ID: <CA+jURcugFhSt9GGRZELQUCnupOf2Ns96Ao5ZruWfVtq=z_7ytw@mail.gmail.com>
Message-ID: <CA+jURcugFhSt9GGRZELQUCnupOf2Ns96Ao5ZruWfVtq=z_7ytw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] HID: MS and Logitech high-resolution scroll wheel support
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 16:42, Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> A full explanation of why and what is in the v1, v2 patch thread here:
> https://lkml.org/lkml/2018/11/22/625
>
> v3 adds a better commit messages, m560 REL_HWHEEL_HI_RES support and a patch
> moved in the ordering. This is a full patch sequence because Benjamin's
> magic scripts struggle with singular updates ;)

I've retested with the same Logitech mice as before, except for the MX
Anywhere 2S, which is currently not available to me. So, for
reference, that's the MX Master 2S, Performance MX, M560, Anywhere MX,
and the M325 (to check low-resolution scrolling).

Verified-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team
