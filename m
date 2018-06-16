Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F72AC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8885208E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqJQG8x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8885208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756818AbeFPArI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:47:08 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46564 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753539AbeFPArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:47:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so6145960pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 17:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFpvAd/fU0CyhQ0zKxnwWj17TUo6i2ZCvI/MgWndbrY=;
        b=KqJQG8x84/hcN+F34upZBVEQVU2xX+TYvlP9hJ70ylkRmLZO/7kzkYUYsnNmIUeILW
         zzHjqw5kWOSl1/+EvmdYOb1Xj7vOEYlb1bt2MIlxp5P3e55Mr7QFRQ9kBGItychYC5sv
         nDyc2B45V2zbblm9n1yzCb+D4NWsW9wbBOHng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFpvAd/fU0CyhQ0zKxnwWj17TUo6i2ZCvI/MgWndbrY=;
        b=psM4M4f2dmEgLLYcXSusa6S34Nz7PR2i1a/1Z6nOnxY3albdIaYIupCJOYWwJp4Isc
         4Y9O+iUk/wFkml+4ic5HjqG+0ClGZF7l5tCzrDiGrz1V7+Vd1/xJHP8Qr9FeCQUFq1Vx
         u+JtD9Ykqw+xZMi2WlFnv9NIvJOLXHhN4YhS/mZ3f3DmDMcdMkhwEWgRWhSvi9K1Feyr
         fevaSnEEPfj0VjUzFsTRtNgrKDd/9Bk7lytBXqkc9UTNmChBX4tYWt62GTJvHJmJI2NL
         XTXSjjFcXNrhlQKJeFrX0iRp1zk9DbgdEYQh/PITonSnPVglm2I0PRn09YCjsq3EeSR+
         Mshw==
X-Gm-Message-State: APt69E2yeIN6/+ckPPCFaC5vCP1R5bNbWViC0GqU8gJBvMVHd3JzYG5J
        4UoRyjHsmOlDqRv8izYN8QzIqw==
X-Google-Smtp-Source: ADUXVKLYSAi4EoCXvLmAQv4QscV+EGdOI7qUhW3ZV2ATqecnNlG1MvH5s7WfbJy4pjykGy/pPaY+Uw==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr4529772plb.26.1529110026810;
        Fri, 15 Jun 2018 17:47:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z19-v6sm10524864pgv.12.2018.06.15.17.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 17:47:05 -0700 (PDT)
Date:   Fri, 15 Jun 2018 17:47:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bskeggs@redhat.com, airlied@linux.ie, jeyu@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/nouveau/nvif: remove const attribute from
 nvif_mclass
Message-ID: <20180616004705.GQ88063@google.com>
References: <CAKwvOd=ntzV5x+rDSH6VEoS2ONZacnqeemewNgv3Aotm3Hd-hA@mail.gmail.com>
 <20180615230044.189899-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615230044.189899-1-ndesaulniers@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 04:00:42PM -0700, Nick Desaulniers wrote:
> Similar to commit 0bf8bf50eddc ("module: Remove
> const attribute from alias for MODULE_DEVICE_TABLE")
> 
> Fixes many -Wduplicate-decl-specifier warnings due to the combination of
> const typeof() of already const variables.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
