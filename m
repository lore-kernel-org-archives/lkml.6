Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3769FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6331D208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MvgrPmTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6331D208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbeFNLt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:49:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41798 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755120AbeFNLtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:49:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so6077634wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQqfTUrqV3Zn5Gu1LzoamN+Q/eO3VJd7G0F97ntNyAg=;
        b=MvgrPmTWxDluIffS4YoEYmWxtqgUh3QYR7qmiFa1x8+oD9anfq7CXF3Ja4g6zDHDom
         WuUs6qBBjPjRfJxjwHCNTWBTvKcbPpYAvB9w/aGHfdz/JIMrJDCgV9g/DXvmx8l+MIix
         PZSoi/BYhwYZqjaZ2epmGVLEtR+gFSbM6Z4Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQqfTUrqV3Zn5Gu1LzoamN+Q/eO3VJd7G0F97ntNyAg=;
        b=ICHjJbfvEort8UcRXppV0JItnVQkK57cZNvOVm5TYo5AVhi8E2G/bDbTxpMmes7mDC
         umJAnsoRo7WkZPJEVZVCuKuD+nJwkmqbnEtkDbtnuTxyvkfD5mOgWTeoPxLjZ8OJiVgP
         KPwxHAj74gDTWDvTh4/LB+viFCxpKlKK0HiYZX7BGGOgzvAdpAIJCvq7vT3375OTu4Qd
         LO+Tp4O/8BdXGhGdVWkRPzaeUTQIkWpQ/mVI+V5TIUgKNa1N3CacafxlNVx57vA4Iom2
         6PYvU2sqZb0972zTMNHloXT5lLVwEFlvXsA84iO0Yvf8jNRECLBuNm/aa0ILhvAvp79i
         7T3A==
X-Gm-Message-State: APt69E0rDd43N0YK40Jw2pWMeXljSaVifBHdkhTxE3Q2d1Q+gLetb7Fk
        7RAKuvJZAD4bu2wObD5DEMHhJi4u
X-Google-Smtp-Source: ADUXVKJ3YViDvNrRYPaYmDbwhdSDnuJhRMKTbKVHXqvmhwyVPdxZcV4MV2aB+PO1P438le1y2JcZwQ==
X-Received: by 2002:adf:b94e:: with SMTP id b14-v6mr2063066wrg.265.1528976991268;
        Thu, 14 Jun 2018 04:49:51 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id i193-v6sm5559213wmf.13.2018.06.14.04.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 04:49:50 -0700 (PDT)
Date:   Thu, 14 Jun 2018 13:49:44 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
Message-ID: <20180614114944.GA18651@andrea>
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com>
 <20180614103852.GA18216@andrea>
 <b84a5ef9-6cd1-7dc9-a51d-cb195cdea83c@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b84a5ef9-6cd1-7dc9-a51d-cb195cdea83c@vmware.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >>+		/*
> >>+		 * wake_up_process() paired with set_current_state() inserts
> >>+		 * sufficient barriers to make sure @owner either sees it's
> >>+		 * wounded or has a wakeup pending to re-read the wounded
> >>+		 * state.
> >IIUC, "sufficient barriers" = full memory barriers (here).  (You may
> >want to be more specific.)
> 
> Thanks for reviewing!
> OK. What about if someone relaxes that in the future?

This is actually one of my main concerns ;-)  as, IIUC, those barriers are
not only sufficient but also necessary: anything "less than a full barrier"
(in either wake_up_process() or set_current_state()) would _not_ guarantee
the "condition" above unless I'm misunderstanding it.

But am I misunderstanding it?  Which barriers/guarantee do you _need_ from
the above mentioned pairing? (hence my comment...)

  Andrea
