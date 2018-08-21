Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACFCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839B521837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839B521837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeHUUvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:51:32 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35674 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHUUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:51:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fsAU5-0007Sl-FJ; Tue, 21 Aug 2018 19:30:25 +0200
Message-ID: <1534872621.25523.39.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] workqueue: skip lockdep wq dependency in
 cancel_work_sync()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Tue, 21 Aug 2018 19:30:21 +0200
In-Reply-To: <20180821172711.GR3978217@devbig004.ftw2.facebook.com> (sfid-20180821_192716_762024_DE7C68A2)
References: <20180821120317.4115-1-johannes@sipsolutions.net>
         <20180821120317.4115-2-johannes@sipsolutions.net>
         <20180821160814.GP3978217@devbig004.ftw2.facebook.com>
         <1534871894.25523.34.camel@sipsolutions.net>
         <20180821172711.GR3978217@devbig004.ftw2.facebook.com>
         (sfid-20180821_192716_762024_DE7C68A2)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Tue, Aug 21, 2018 at 07:18:14PM +0200, Johannes Berg wrote:
> > > But this can lead to a deadlock.  I'd much rather err on the side of
> > > discouraging complex lock dancing around ordered workqueues, no?
> > 
> > What can lead to a deadlock?
> 
> Oh not this particular case, but I was wondering whether we'd be
> missing legitimate possible deadlock cases by skipping lockdep for all
> cancel_work_sync()'s as they can actually flush.

I don't see how? This is only relevant in ordered/single-threaded WQs,
but even there it doesn't matter doesn't matter as explained?

I'm actually seeing a false positive report from lockdep, because it
*is* flushing, i.e. I'm running into the case of the work actually
running, i.e. the "_sync" part of "cancel_work_sync()" is kicking in,
but in that case a single-threaded WQ can't have anything executing
*before* it, so we don't need to generate a lockdep dependency - and in
fact don't *want* to create one to avoid the false positive.

I'm not really sure what you think we might be missing? Am I missing
some case where cancel_work_sync() can possibly deadlock? Apart from the
issue I addressed in the second patch, obviously.

johannes
