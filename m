Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF0FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4F52075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JtOBOixu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4F52075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJYBEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:04:30 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36566 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYBEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:04:30 -0400
Received: by mail-lj1-f182.google.com with SMTP id s15-v6so5399951lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4STPq8a7sQaA/rniZu4bpfN5/ozLG7RicxPMpY2Mw8=;
        b=JtOBOixurXwOdGj6grmFVou2nJdkJ35+/B7WO5Vnt7Ijv3C3W0CcV9qEOA9DHm2W1D
         QvnHoxAHDiCs2jI5Z8hjxw4WBcdLq/XhUK/esJE7CzzWHAkb/tRelqNDOOkOaltTZTjc
         agboShjVkVmwdAu6zCaxmcm5RdgsAyxpKur1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4STPq8a7sQaA/rniZu4bpfN5/ozLG7RicxPMpY2Mw8=;
        b=Riz6uTS9buCJ/fv2ZfAXw68/cK4Vg4gk6Az3wq9P6w2Ux4bCGOBPK4LlGQDQdYNt/R
         DQFTrf98te18SVeMtHoQqegnVmByS+FhNPYBlNpEN2SSDVEiMU3iZEYvgfR1g9DdrJpB
         pHepdx1ZTJlS0Qq5NFGfWA0vv05am4LIVobmWhQXBuhkiVlJgw1QVziNnlo9ze2+hZXO
         eUtTRScu0WPPwqB144vEqyXLNbCJOXPz+kySkUtMM8wjaoBBTohipc3sFzb9leciRSdS
         ZHrcvq4qKCOXgiWkMHYJUfPDPhzh1h+eFtYmvUieh+sFnh66/MncBAUIoQUGcXO4J/Nm
         BC2A==
X-Gm-Message-State: AGRZ1gIkoGspoNWRwg/W7sSFrM53b5xCkwUwO11jB0qB/TtX7LRRj18x
        OB3gBEllN+bLupwAX/t5c0KbNhRu7tN7vuqm
X-Google-Smtp-Source: AJdET5dJDBmNIcAVBQN6erDkLvKLocQoNbk7gie17nBXhFF3iQ6bv4AoTREct09TbtuzCzM4UFKhdA==
X-Received: by 2002:a2e:96cd:: with SMTP id d13-v6mr2392094ljj.35.1540398942523;
        Wed, 24 Oct 2018 09:35:42 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 18-v6sm716636ljo.74.2018.10.24.09.35.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 09:35:41 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v6-v6so5380588ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:35:41 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr2231969ljh.59.1540398941199;
 Wed, 24 Oct 2018 09:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <1929897739.23623737.1540322729596.JavaMail.zimbra@redhat.com> <200314933.23623823.1540322768252.JavaMail.zimbra@redhat.com>
In-Reply-To: <200314933.23623823.1540322768252.JavaMail.zimbra@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 17:35:25 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjMjVx_swPnhRWejvvrMvDqOY0MW2Ov9GNt8vn4UEjchw@mail.gmail.com>
Message-ID: <CAHk-=wjMjVx_swPnhRWejvvrMvDqOY0MW2Ov9GNt8vn4UEjchw@mail.gmail.com>
Subject: Re: GFS2: Pull request (merge window)
To:     rpeterso@redhat.com
Cc:     cluster-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 8:26 PM Bob Peterson <rpeterso@redhat.com> wrote:
>
> Please consider pulling the following changes for the GFS2 file system.

Pulled.

Just FYI - I end up editing your notes to look a bit more like most
other people send them. No need to change anything, I just thought I'd
mention it.

            Linus
