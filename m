Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431CECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7ED213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Kc3w/VZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7ED213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbeGLVZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:25:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34608 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732816AbeGLVZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:25:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so23013413wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MLBrXH8l8BEh3BfNKPVXEtzagAfU9Q66aZ7Q5xL6in0=;
        b=Kc3w/VZDqhMxfuqVdcFNwynV5/U/FW4xMiRNwBPNzrK6ohp2ydHp46KFUpzQRL8+uz
         1HzsNjp1gXqqzF9fpJToLfpFL/gF1cJPfqQdWerACZOsorLEuMYnh+Ua8l+wzPRhSjcB
         LM7LznRz8aS3DbbH68CCWJhKE5jhqZh2znUXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLBrXH8l8BEh3BfNKPVXEtzagAfU9Q66aZ7Q5xL6in0=;
        b=QZ3x5PoO7arpcQa638/XCtfHFpjQK+BtY+kPmkrrn0wGoruvvPdu3Uc9zc4poyuJvU
         XpncxJCYal398qDgbiI1fLci8rg66VWjVS915AY3YmZ+RdV2VCvE8Pa2GtXgYtVkKwT4
         af5s27Mi9kmuBMlWYKJuyPk7Tga/jKvTFjAs/sMvgRtETPyE6blNLrc/VBUPVyFJGOIh
         d2Wr+DZl6EkOibgLBV9nDDtekbI1xRgbgqZcm5Nty7zvUarfsZJLbMpS6o7MQ1Yu7U2n
         XJwAGSbPeUF4kL+dCAbT1jHPVWexyXZXgfs59DS9tvDURORlcWQ4buYNAdS4lbkqu7qi
         CaRA==
X-Gm-Message-State: AOUpUlHmDtNXjFDGpud7xZ9BcYInnZ4V8rNjNoLmwEfFvZS2i8CMNUaL
        iPrr/seLiyF3IwzTFmbiNFAXwA==
X-Google-Smtp-Source: AAOMgpcwD5KRrd9IUg78jeVl8F399JPxIxA9gCSdTwWIpKR1c9qQ/aRD4lrsqjGY6UYAOupuQTr0sA==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr2851325wrc.119.1531430035160;
        Thu, 12 Jul 2018 14:13:55 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id n23-v6sm4103291wmh.6.2018.07.12.14.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 14:13:54 -0700 (PDT)
Date:   Thu, 12 Jul 2018 23:13:48 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712211348.GA5308@andrea>
References: <20180712175228.GB3533@andrea>
 <Pine.LNX.4.44L0.1807121637050.1306-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807121637050.1306-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:43:46PM -0400, Alan Stern wrote:
> On Thu, 12 Jul 2018, Andrea Parri wrote:
> 
> > > It seems reasonable to ask people to learn that locks have stronger
> > > ordering guarantees than RMW atomics do.  Maybe not the greatest
> > > situation in the world, but one I think we could live with.
> > 
> > Yeah, this was one of my main objections.
> 
> Does this mean you don't think you could live with it?

Well, I *could* leave with it and with RCtso locks, ;-) but I'd rather not.

Assuming that I will not be able to resist this RCtso trend, ;-) would the
below (completely untested) work?

  let rmw = rmw | lk-rmw   (* from lock.cat *)
  let po-unlock-rf-lock-po = po ; [Release] ; rf ; [domain(rmw)] ; po
  [the rest of your patch + the updates to the doc. I suggested in v2 ;-)]

   Andrea
