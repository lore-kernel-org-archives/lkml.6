Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48B42077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yIkv2wlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48B42077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeGLIZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:25:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44556 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeGLIZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:25:53 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so10366632pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YaXCr5/u7vglMXNeli0r9hPBM6mNfeAqra1cWWxPVWU=;
        b=yIkv2wlg1ucMMTFImfGpBmK2WS7NWY/5mBDFV/76fHqRZsaZSW14LdIqpH9j8Rn45B
         A9uGvvobEkxjUSuUMq0jQIDySyMdpqc8fm7eDU55tM1uApddyFc03NFZ8yQnuKr6shnb
         6URKc5UJtTGOw8mR4veJM4rKj/q1lcSbkZqog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YaXCr5/u7vglMXNeli0r9hPBM6mNfeAqra1cWWxPVWU=;
        b=dj9Ba0gT65E/EWQ4y5TzueQhD8MKCDio5z0383g0JsuLCkQG8acSlC7xikKBHCPZ5P
         cf5IIsHM8xl+oH7AqcXOohR63EP15Of3L0RgeYzntQL8cdONIjAF/Dbvz9+LH8Yqk3XW
         SSS2/JaDe/sJPInDmZCW4Packl4ipCKTOSZErBu0HLUAHswxbLZKujqmJOMQbirh9LiN
         EG3tHMbGHUDsQMlZ2GS5e1tzhfF1ADP1s3jmCx+StO0UMF5ri0sRARc9+trRsWv6p3FQ
         +KbLllsNxtBDehtwsIx93jZjAt93POd145+mpj7GWwbEEgMTKvJjV1FXBXKUSM6wNyNf
         UmTw==
X-Gm-Message-State: AOUpUlF5Y07y7OszF7CMej0a0OqiDdV/lIzrgJi5pldp3/M/PCf/pqVq
        gZ0sEG7k5Z3wxM3RyzJTgyBIqw==
X-Google-Smtp-Source: AAOMgpcHRHeQbR5Ar4U9UJB8nDtHgZtD5gXGbynKXE1tkg9hpVdngDDULYug+jn/I7X88xNgUgP7Vw==
X-Received: by 2002:a17:902:342:: with SMTP id 60-v6mr1200848pld.311.1531383443767;
        Thu, 12 Jul 2018 01:17:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id u8-v6sm37647091pfl.105.2018.07.12.01.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 01:17:23 -0700 (PDT)
Date:   Thu, 12 Jul 2018 01:17:22 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        kernel-team@android.com, Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove setting task's se->runnable_weight
 during PELT update
Message-ID: <20180712081722.GB154647@joelaf.mtv.corp.google.com>
References: <20180709164753.24699-1-dietmar.eggemann@arm.com>
 <20180710230917.GA187293@joelaf.mtv.corp.google.com>
 <0aba9bb6-eec7-130e-373f-5f87f192f2d4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aba9bb6-eec7-130e-373f-5f87f192f2d4@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:43:28AM +0200, Dietmar Eggemann wrote:
> On 07/11/2018 01:09 AM, Joel Fernandes wrote:
> > On Mon, Jul 09, 2018 at 05:47:53PM +0100, Dietmar Eggemann wrote:
> > > A CFS (SCHED_OTHER, SCHED_BATCH or SCHED_IDLE policy) task's
> > > se->runnable_weight must always be in sync with its se->load.weight.
> > > 
> > > se->runnable_weight is set to se->load.weight when the task is
> > > forked (init_entity_runnable_average()) or reniced (reweight_entity()).
> > > 
> > > There are two cases in set_load_weight() which since they currently only
> > > set se->load.weight could lead to a situation in which se->load.weight
> > > is different to se->runnable_weight for a CFS task:
> > > 
> > > (1) A task switches to SCHED_IDLE.
> > > 
> > > (2) A SCHED_FIFO, SCHED_RR or SCHED_DEADLINE task which has been reniced
> > >      (during which only its static priority gets set) switches to
> > >      SCHED_OTHER or SCHED_BATCH.
> > > 
> > > Set se->runnable_weight to se->load.weight in these two cases to prevent
> > > this. This eliminates the need to explicitly set it to se->load.weight
> > > during PELT updates in the CFS scheduler fastpath.
> > 
> > Looks good to me. By the way just asking, is there a chance where
> > se_weight(se) and se_runnable(se) can ever be different?
> 
> Yes they can be different, not for a task though but for se's representing
> task groups. It got introduced to be able to propagate load and runnable
> load independently through the task groups hierarchies.

I know that task-group se has different values. I was saying for task ses,
the extra division can be skipped possibly improving performance (if at all).

thanks,

- Joel

