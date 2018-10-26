Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5953ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8FA20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iI2f9sfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8FA20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeJ0DAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:00:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40567 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeJ0DAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:00:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id g21-v6so940323pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dPkVkEIpK+5pbXWFCO64RlYk5FcCpaa9dN09DMSorR4=;
        b=iI2f9sfv+dB6oBmEdmfCJ5tk8ChIcyXiwBbFlb4+IVao6zmXUXaw0iZ0kYMHjnZnmW
         7p301FDTnC0Nrj4tVci27oLwmRuyXkZHi9u8X7orMyIr8lz/QQs/sv9Tw+w5HCCEqwvW
         di7X3qNTenVYJWbpI0B0uYVjaok6/eU0+GxyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dPkVkEIpK+5pbXWFCO64RlYk5FcCpaa9dN09DMSorR4=;
        b=thg/Oll1hjuJQaaIgGSrjav1Ivp5imPXuRPpnyhjIw3lBhmPWUgEV105AcZoClslkl
         PFLld8DxdPG0A9Q232L23KRVhoyBiF3+voyyvU7KkBAjKE5WdEh5iCFr/yAwJLb/S+kA
         612ZJbVeA7iXhp+eLrnbeC/xLlA/xAsNYHUmM6IWSihFovRXHVow89+CAPEV/EkKifVz
         llZcBMMnS0XeTWRB5EE9fGLLOl75M/6mcqNya9o7ghrCR0+EIWwGR5CYvNFzjaLWwTeD
         H2ZtzV3Xh+K1jYoMAmKtLaTzDxJpScu3h2QSWsoMdWPvgbN2B11tG6vkCWbmMAZaLn4p
         DTnw==
X-Gm-Message-State: AGRZ1gKTUqnFD18ScvZO4b+8kJBjeVA91YfAqHJf3kRX60UuDXDCFXBW
        reiCkmBNwOK22k6czMsGOvr9sg/+hig=
X-Google-Smtp-Source: AJdET5erdRVECfSb/PiwuyA+0DPjWvQj5uEduu5BNX0qnaeQPAtUf6aqjYOvpkGPlVDIn1QmCVb1Ew==
X-Received: by 2002:a63:1444:: with SMTP id 4mr4278247pgu.430.1540578140697;
        Fri, 26 Oct 2018 11:22:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p64-v6sm9899373pfi.22.2018.10.26.11.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 11:22:19 -0700 (PDT)
Date:   Fri, 26 Oct 2018 11:22:18 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC 6/6] Revert "pstore/ram_core: Do not reset restored zone's
 position and size"
Message-ID: <20181026182218.GB187415@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <20181026180042.52199-6-joel@joelfernandes.org>
 <CAGXu5jLoMhBKuxhSqbgitfOYkO0gU34L4asn9iQEdHqJPxfDSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLoMhBKuxhSqbgitfOYkO0gU34L4asn9iQEdHqJPxfDSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 07:16:28PM +0100, Kees Cook wrote:
> On Fri, Oct 26, 2018 at 7:00 PM, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > This reverts commit 25b63da64708212985c06c7f8b089d356efdd9cf.
> >
> > Due to the commit which is being reverted here, it is not possible to
> > know if pstore's messages were from a previous boot, or from very old
> > boots. This creates an awkard situation where its unclear if crash or
> > other logs are from the previous boot or from very old boots. Also
> > typically we dump the pstore buffers after one reboot and are interested
> > in only the previous boot's crash so let us reset the buffer after we
> > save them.
> >
> > Lastly, if we don't zap them, then I think it is possible that part of
> > the buffer will be from this boot and the other parts will be from
> > previous boots. So this revert fixes all of this by calling
> > persistent_ram_zap always.
> 
> I like the other patches (comments coming), but not this one: it's
> very intentional to keep all crashes around until they're explicitly
> unlinked from the pstore filesystem from userspace. Especially true
> for catching chains of kernel crashes, or a failed log collection,
> etc. Surviving multiple reboots is the expected behavior on Chrome OS
> too.

Oh, ok. Hence the RFC tag ;-) We can drop this one then. I forgot that
unlinking was another way to clear the logs.

thanks!

- Joel

