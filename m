Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1F1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D5720869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D5720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbeKLJQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:16:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731346AbeKLJQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 04:16:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A5043082E4D;
        Sun, 11 Nov 2018 23:26:30 +0000 (UTC)
Received: from krava (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5CCE75C1B4;
        Sun, 11 Nov 2018 23:26:28 +0000 (UTC)
Date:   Mon, 12 Nov 2018 00:26:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181111232627.GC30042@krava>
References: <20181108071303.GB29732@krava>
 <20181108.170721.825832647693654935.davem@davemloft.net>
 <20181111194132.GA3769@krava>
 <20181111.150801.1421291572221954626.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111.150801.1421291572221954626.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 11 Nov 2018 23:26:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 03:08:01PM -0800, David Miller wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Sun, 11 Nov 2018 20:41:32 +0100
> 
> > On Thu, Nov 08, 2018 at 05:07:21PM -0800, David Miller wrote:
> >> From: Jiri Olsa <jolsa@redhat.com>
> >> Date: Thu, 8 Nov 2018 08:13:03 +0100
> >> 
> >> > we could separated fork/mmaps to separate dummy event map, or just
> >> > parse them out in the read thread and create special queue for them
> >> > and drop just samples in case we are behind
> >> 
> >> What you say at the end here is basically what I am proposing.
> >> 
> >> Perf dequeues events from mmap ring as fast as possible.
> >> 
> >> Perf has two internal queues, high priority and low priority.
> >> 
> >> High priority events are never dropped.
> >> 
> >> Low priority events are dropped on overload, oldest first.
> > 
> > I added the dropping logic, it's simple so far..
> 
> So for me perf top gets into a state where the samples counter stops
> incrementing, but the event counter does keep moving (which is the
> histogram code decaying histogram entries from the display thread).
> 
> Which means the event processing has basically stopped.
> 
> The event threads are not stuck in a loop, because they respond to
> the "q" keypress and we can exit.

is the drop count showing something?

jirka
