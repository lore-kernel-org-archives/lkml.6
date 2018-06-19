Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAB5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8934D20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I4pcu0Co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8934D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967204AbeFSSiu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:38:50 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37057 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967138AbeFSSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:38:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id r21-v6so263743pgv.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JE4DOrM3WvnMkyt8EoPxln/91xrwEnWnvgsv6ctlhbg=;
        b=I4pcu0Co1voWBWy8C8y1cXg0u49bRBjx7CBCK7SQOyl6kvgVGRs0PCavHB/jEQP7mi
         9PJXVYQOw/SdvEhAO/GZc6TqXAaP08ShK58LmUr5AP7bCW/cqQAvQ9bmOm1d0V0O/VNH
         2vprB8tewBQ3PiVTHAD+vyW4wi/O6br18bvHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JE4DOrM3WvnMkyt8EoPxln/91xrwEnWnvgsv6ctlhbg=;
        b=StvqWpR8xMuESa+5BxgJPqYYDLJFzu2X/YDdNqXG9uUj/4A/2CnEl4eLuPXl8n+Xo1
         S2vROL/KdIgOawSK8w0Fv6PMt9VE/FEYTh+V0/GNvfFXs+KZh3tcA/SPu8+QNT8Ju0gF
         DLJTWPNzRWtq02CBRr4mA/id6FzJcDiwIuH7LJkCYjMpTAuAeOo3tkSxS24sH5D4zPVz
         lSMDCQQOLT4xH1f26pW5a6yGK9NprtPQ5k0nxuwsxhYVcCwXIU9I7liu5AoQ0mFj6pIx
         OHa4y608zcr98gckdrJfZbS8ZDh3Ph+M7BGQK1mA+RnEQ/mz+Ha02tRpfIb5z5Wd4heg
         3fuA==
X-Gm-Message-State: APt69E2pmzd5N4r93oRd8aF7PfHhNU5hJsUMokJADBwD2RpuNrNBCPgF
        nxsTZQ8iX4v0I2qbBG3fj/CTtA==
X-Google-Smtp-Source: ADUXVKL2u4aLeyviRc0DVg+dvivaNLKYgc8xwFNbFZUh+bZNqfhrug9IVwKYCsQqPRZSuWHIGmHxgA==
X-Received: by 2002:a63:6106:: with SMTP id v6-v6mr15815519pgb.441.1529433528311;
        Tue, 19 Jun 2018 11:38:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id x72-v6sm430073pff.176.2018.06.19.11.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:38:47 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:38:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Message-ID: <20180619183847.GC169030@google.com>
References: <20180615174731.47588-1-mka@chromium.org>
 <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
 <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
 <20180615182945.GN88063@google.com>
 <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
 <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
 <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
 <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
 <a1c2d331-ea79-b2de-af32-1f914bea2fda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1c2d331-ea79-b2de-af32-1f914bea2fda@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 07:13:41PM +0200, Paolo Bonzini wrote:
> On 19/06/2018 19:08, Nick Desaulniers wrote:
> >> This one really makes the code uglier though, so I'm not really inclined
> >> to applying the patch.
> > Note that of the three variables (w, u, x), only u is used later on.
> > What about declaring them as negated with the cast, that way there's
> > no cast in a ternary?
> 
> I still find it inferior, but I guess it's at least acceptable.  I
> prefer not_{x,w,u} though. :)

Thanks Nick and Paolo for the suggestions, I'll sent an updated
version soon.
