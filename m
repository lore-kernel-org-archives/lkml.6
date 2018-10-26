Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC9C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2864E2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kCUjccC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2864E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJZXj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:39:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33741 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJZXj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:39:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id 125so988302vsi.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8CvBljw6820dVFr8yaguQxlc5f49EgVlDeqDK+bi+A=;
        b=kCUjccC7+2hjeQENI+cjOeaGeTS9OQXZiFiy5t52/EsmHcVQMC5nOZP/Aol3Qz/paO
         UUmCZyJFYctJ5FQ3TqwqinQfCHHJZrx1SVUNzACS11pOVBP+kCc9tYL/3N6KqoGFsryP
         bySYfuSDSrvoqz/bLbM2sYHY3NfFmGAFvmB0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8CvBljw6820dVFr8yaguQxlc5f49EgVlDeqDK+bi+A=;
        b=m9PUsKQ98jkQo15eP/FRYYS/oj4s8lnB03o7r8790qvsOCacKVJNAtoEewwJO8aOvB
         CPZelq5DwMbtc3oM43+XnKkqlnLda045ExhezRLlYQL1kpf4YBNLYm48Me+VooBZKuP9
         oeFe48iEtDVY+IvXyxmlI3y6uZ4VPyzuJCpNyXW+Ph0J1rXc9ocbrNOyawznbza5uiy/
         JoFlNK2AIljuzehQTEvDThguCG4R8V+0YeoMLYwtJBwn/JbP7LlCV4bubD1CeZXMIG8S
         XX8Tn5Wy3SI8+/KTSV9b5f88x1nt3Bjlwv84fs2p9WKcvakcExaxmsmDcO6K5SAUmFd0
         Az4Q==
X-Gm-Message-State: AGRZ1gJL/w2GRnrLl5POwfO8kg5NZDd1ZPE6+lycqHSVVThRVBbmE9XF
        jdbpeENEaTknJ4NrNBiBLgUYIDARal4=
X-Google-Smtp-Source: AJdET5dGy3DC8ZsEqjYR/HEKxCZN7dqdf7kiqAwzlNSpkPg8phNirMRTTDw1QD9f9MqHjEckQpo8ew==
X-Received: by 2002:a67:37c8:: with SMTP id j69mr1666048vsi.8.1540566120272;
        Fri, 26 Oct 2018 08:02:00 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id t14sm1657461uao.6.2018.10.26.08.01.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 08:01:59 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id 124so962310vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 08:01:59 -0700 (PDT)
X-Received: by 2002:a67:b20e:: with SMTP id b14mr1652552vsf.121.1540566117513;
 Fri, 26 Oct 2018 08:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181025222134.174583-1-dianders@chromium.org>
 <20181025222134.174583-5-dianders@chromium.org> <20181026144356.GS154160@art_vandelay>
 <20181026144657.GU154160@art_vandelay>
In-Reply-To: <20181026144657.GU154160@art_vandelay>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Oct 2018 08:01:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WpQGff7HsDfyPVz7y2S12xbL0F7awNh5q5CF2WpWS_Ew@mail.gmail.com>
Message-ID: <CAD=FV=WpQGff7HsDfyPVz7y2S12xbL0F7awNh5q5CF2WpWS_Ew@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] dt-bindings: drm/panel: simple: Innolux TV123WAM
 is actually P120ZDG-BF1
To:     sean@poorly.run
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        ryandcase@chromium.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean,

On Fri, Oct 26, 2018 at 7:47 AM Sean Paul <sean@poorly.run> wrote:
> > I didn't see your v2 when I replied to the v1 patch, so for the record,
> >
> > Reviewed-by: Sean Paul <sean@poorly.run>
> >
> > Also note to whoever applies this to -misc, v1 also had
> >
> > Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
>
> And I just realized that patches 5 & 6 were swapped in v2. So nevermind this,
> Doug's v2 tags are correct.
>
> Dear coffee, please kick in soon.

Sorry about that--I should have mentioned it in the notes.  I realized
that the bindings were supposed to land before the code so I swapped
them.  Thanks for your review!

-Doug
