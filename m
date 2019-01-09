Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4AEC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AC5206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="r5yMSFBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfAIVNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:13:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41233 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfAIVNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:13:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so9960937qtf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hkyNanvyMn3mY9eEgM4StkmRatJp0sh5OtF1SRLHNA=;
        b=r5yMSFBCS9v5caBk0H1gThnPzPjV8xhOMA9s2tuZpIWliZa5XW8Qhn/J8iE2MTlNSE
         LWoM3y7+zpbVcNr8s/JzDK/FxO1TUegiWUvIAIQJPCtYiQ3nX+E/Qky18OfDFwMIaCYQ
         cKdBUUTVFenWcEeGPhkNWyTrDZQSMRT13os3YtpAobgwLArMN2MBWa0JEjEBeBVV6w2C
         ikPX9Gn7XiOVRl4bwytWVU7rqx7E7CLUgcnSBGDK9aK79FOrIMtmbjWudKdkuENX5LoE
         Z9/IGV3m34nQcg25QsnZgGCYC9ftaDkPbTHkf15o1dz/FIFXbe+/GbIj+fpfoaO97VnH
         fyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hkyNanvyMn3mY9eEgM4StkmRatJp0sh5OtF1SRLHNA=;
        b=RF4Eigagzu7AiCVLbakSiy0c2BxOn5tS4udRveMXTDNJVbMFdbKkmLRNgYtVVYtxtE
         KQcGXwFm35I3QfQh9macaqwy/zjmm9WmirU7hsACqAhaBEoG/knli/vuSrGb2yLJN4CE
         L31J5XWQwiryaOythScMR1hdFiQX1yWw5ezFxYzMYy3YAgkmFta31j/5QdKDqxKV2+IM
         3TTtNy/SgTH7GtOXTiTKvHob6lP0mKbIBF/roF9rXccUYAGmuiDBTuLR3HtxHm38aJ2c
         s2TmyteXUh5rIY1wEToRPK9SJodBdNydUYq9lp1pdL1IxBW2SnoFclaRkajQNyn9tWgZ
         v/Mg==
X-Gm-Message-State: AJcUukf/I6PzbHVujE0HCndeo+mtkiVGThO6IVDkx3lXwQxCrhQCTxsv
        I75htTQ2DR4cXW7wSO+ViDrbGQ==
X-Google-Smtp-Source: ALg8bN6M77z9U1M3+ALqpver56KTGWYXWJbGW1Ls/scd0P00RxYTzfY2G9ev2HknDNAa9hy9RHLu4g==
X-Received: by 2002:ac8:4a8e:: with SMTP id l14mr7079930qtq.135.1547068395159;
        Wed, 09 Jan 2019 13:13:15 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e17sm40365771qte.12.2019.01.09.13.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 13:13:14 -0800 (PST)
Message-ID: <1547068393.6911.3.camel@lca.pw>
Subject: Re: [PATCH] xfs: silence lockdep false positives when freezing
From:   Qian Cai <cai@lca.pw>
To:     Dave Chinner <david@fromorbit.com>
Cc:     darrick.wong@oracle.com, dchinner@redhat.com, peterz@infradead.org,
        bfoster@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 16:13:13 -0500
In-Reply-To: <20190109210111.GZ4205@dastard>
References: <20190106225639.GU4205@dastard>
         <20190109205329.2486-1-cai@lca.pw> <20190109210111.GZ4205@dastard>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 08:01 +1100, Dave Chinner wrote:
> On Wed, Jan 09, 2019 at 03:53:29PM -0500, Qian Cai wrote:
> > Easy to reproduce:
> > 
> > 1. run LTP oom02 workload to let kswapd acquire this locking order:
> >    fs_reclaim -> sb_internal.
> > 
> >  # grep -i fs_reclaim -C 3 /proc/lockdep_chains | grep -C 5 sb_internal
> > [00000000826b9172] &type->s_umount_key#27
> > [000000005fa8b2ac] sb_pagefaults
> > [0000000033f1247e] sb_internal
> > [000000009e9a9664] fs_reclaim
> > 
> > 2. freeze XFS.
> >   # fsfreeze -f /home
> > 
> > Dave mentioned that this is due to a lockdep limitation - "IOWs, this is
> > a false positive, caused by the fact that xfs_trans_alloc() is called
> > from both above and below memory reclaim as well as within /every level/
> > of freeze processing. Lockdep is unable to describe the staged flush
> > logic in the freeze process that prevents deadlocks from occurring, and
> > hence we will pretty much always see false positives in the freeze
> > path....". Hence, just temporarily disable lockdep in that path.
> 
> NACK. Turning off lockdep is not a solution, it just prevents
> lockdep from finding and reporting real issues.
> 

Well, it is a trade-off. It is turned on right after that path. All those false
positives leave unfixed are also going to render lockdep less useful.
