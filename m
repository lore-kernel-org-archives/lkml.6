Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87279C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B28221711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9yXFPfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B28221711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeHCGH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:07:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34447 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeHCGH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:07:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so2527949pfi.1;
        Thu, 02 Aug 2018 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R+dpqvFWGuFnRNONwAaaTAeeevTZLnkPYfjgbpBeDs8=;
        b=h9yXFPfOgmaYvoI+IB/opJkdsRB05plALQrUeDtKE2XtgeAZLhj4ivnA7OsXlDWWSC
         Il4vhrZw5gHtkeTFleTa7lYOUDGLvMIamg9Oec9YuwyFuAab8TZGmZU5nbeSXryyrsqI
         KWx9W45zHJC46WBcrODSu9GWHthoPxD23jqadUxHKextqUxHOBv1dR/42JH+hwvAtUYz
         hxqURKc9hX1+Es7CyOhr9AfFwDTGnZ9f3v+FGjS7Y61bXcuUkJWiBJqB4PLcpGZ/XXDO
         3zyCy9T0wV4Z+zLdXgJ7E7kz9gf9Hfg5XEWqt4P+kUS+2wsryh0K0DoOLCwp+Amg3aqC
         eKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R+dpqvFWGuFnRNONwAaaTAeeevTZLnkPYfjgbpBeDs8=;
        b=Vou/rCqz76rxhDqChI293Pkc4Z5gpuOj0TYRrpuMGZ4yToEB2wn15FXbySrBoEHL3f
         LyNDncjCeYRsiFw013IkEWtaEW+DiA9vBPtahVN8jl8aISHq6D/DeqmsRlNaRh2FLuCs
         gJ7aF0499WKUSJRw9uT4T9kc1IAtXPDN7rGN75XXSegkzIOvsTbV/aNDCcqsn0UcSdzB
         2d8qhkiyr/9h0irlgu6g6hptMHazxEsjBlmsyf6Lri5WYVyO18TgYWktmJkkwaVTwrE9
         nWQYbHISJ3mE3kIn4A8RBtVl2NBHVqWtavKHpSaG9keyTXG1k6IRQwBEY+nX8yj7A00E
         DnIw==
X-Gm-Message-State: AOUpUlGc2h6S7aSwqB3PK1ftAggSeDjS730j4ovinyA0gAPHYwdpAMtA
        AWK4QFOmmbqs+kZZeWIulas=
X-Google-Smtp-Source: AAOMgpeb/RuB1TwtBG95zNYZiBZyRji9wj5TzCPCOHNOufWMaMLynCsv+6kRiSESA5XYiM9EwxAiTg==
X-Received: by 2002:a62:4808:: with SMTP id v8-v6mr2514074pfa.89.1533269587735;
        Thu, 02 Aug 2018 21:13:07 -0700 (PDT)
Received: from localhost ([175.223.10.158])
        by smtp.gmail.com with ESMTPSA id p64-v6sm6260893pfa.47.2018.08.02.21.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 21:13:06 -0700 (PDT)
Date:   Fri, 3 Aug 2018 13:13:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180803041302.GB502@jagdpanzerIV>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
 <20180803023929.GA7500@jagdpanzerIV>
 <20180803030019.GB86818@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803030019.GB86818@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

On (08/03/18 12:00), Minchan Kim wrote:
> > 	"Device is so fast that asynchronous IO would be inefficient."
> > 
> > Which is not the reason why BDI_CAP_SYNCHRONOUS_IO is used by ZRAM.
> > Probably, the comment needs to be updated as well.
> 
> I couldn't catch your point. Could you clarify a little bit more?
> What do you want to correct for the comment?
>
> > Both SWP_SYNCHRONOUS_IO and BDI_CAP_SYNCHRONOUS_IO tend to pivot
> > "efficiency" [looking at the comments], but in ZRAM's case the whole
> > reason to use SYNC IO is a race condition and user-after-free that
> > follows.
> 
> Actually, it's not whole reason. As I wrote down, without it, swap_readpage
> waits the IO completion for a long time by blk_poll so it causes system
> sluggish problem when device is slow(e.g., zram with backing device).

Sure, this is problem #1. But slow swap device probably doesn't do any
irreversible harm to the system. Unlike use-after-free, which does. Thus
use-after-free is a problem #0. BDI_CAP_SYNCHRONOUS_IO comment doesn't
mention problem #0; it talks about problem #1 only. So, nothing serious,
just wanted to point that out.

So we probably can make ZRAM always ASYNC when WB is enabled.


Or... maybe we can make swap out to be SYNC and perform WB in background.
In __zram_bvec_write() we can always write compressed object to zmalloc,
even the huge ones.
Things to note:
a) even when WB is enabled we still allocate huge classes
b) even when WB is enabled we still may use those huge classes (consider
   a case when backing devices is full)

So huge classes are still there and we still use them. So let's use
them?

For a huge object, after we stored it into zsmalloc, we can schedule a WB
work, which would:
a) write that particular object (page) to the backing device
b) mark entry as WB entry
c) remove object from zsmalloc, unlock necessary locks

So swap in should either see object in zsmalloc or on backing device.
How does this sound?

And reading from a backing device can always be SYNC. Can it?
Am I missing something?

	-ss
