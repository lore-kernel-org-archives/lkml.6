Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F67C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF0B21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF0B21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbeHBRKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:10:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387456AbeHBRKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:10:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A0ED406E8C0;
        Thu,  2 Aug 2018 15:18:52 +0000 (UTC)
Received: from redhat.com (ovpn-117-57.ams2.redhat.com [10.36.117.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id ACB742026D69;
        Thu,  2 Aug 2018 15:18:50 +0000 (UTC)
Date:   Thu, 2 Aug 2018 18:18:49 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
Message-ID: <20180802181309-mutt-send-email-mst@kernel.org>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
 <1532683495-31974-3-git-send-email-wei.w.wang@intel.com>
 <20180730090041.GC24267@dhcp22.suse.cz>
 <5B619599.1000307@intel.com>
 <20180801113444.GK16767@dhcp22.suse.cz>
 <5B62DDCC.3030100@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B62DDCC.3030100@intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 15:18:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 15:18:52 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 06:32:44PM +0800, Wei Wang wrote:
> On 08/01/2018 07:34 PM, Michal Hocko wrote:
> > On Wed 01-08-18 19:12:25, Wei Wang wrote:
> > > On 07/30/2018 05:00 PM, Michal Hocko wrote:
> > > > On Fri 27-07-18 17:24:55, Wei Wang wrote:
> > > > > The OOM notifier is getting deprecated to use for the reasons mentioned
> > > > > here by Michal Hocko: https://lkml.org/lkml/2018/7/12/314
> > > > > 
> > > > > This patch replaces the virtio-balloon oom notifier with a shrinker
> > > > > to release balloon pages on memory pressure.
> > > > It would be great to document the replacement. This is not a small
> > > > change...
> > > OK. I plan to document the following to the commit log:
> > > 
> > >    The OOM notifier is getting deprecated to use for the reasons:
> > >      - As a callout from the oom context, it is too subtle and easy to
> > >        generate bugs and corner cases which are hard to track;
> > >      - It is called too late (after the reclaiming has been performed).
> > >        Drivers with large amuont of reclaimable memory is expected to be
> > >        released them at an early age of memory pressure;
> > >      - The notifier callback isn't aware of the oom contrains;
> > >      Link: https://lkml.org/lkml/2018/7/12/314
> > > 
> > >      This patch replaces the virtio-balloon oom notifier with a shrinker
> > >      to release balloon pages on memory pressure. Users can set the amount of
> > >      memory pages to release each time a shrinker_scan is called via the
> > >      module parameter balloon_pages_to_shrink, and the default amount is 256
> > >      pages. Historically, the feature VIRTIO_BALLOON_F_DEFLATE_ON_OOM has
> > >      been used to release balloon pages on OOM. We continue to use this
> > >      feature bit for the shrinker, so the shrinker is only registered when
> > >      this feature bit has been negotiated with host.
> > Do you have any numbers for how does this work in practice?
> 
> It works in this way: for example, we can set the parameter,
> balloon_pages_to_shrink, to shrink 1GB memory once shrink scan is called.
> Now, we have a 8GB guest, and we balloon out 7GB. When shrink scan is
> called, the balloon driver will get back 1GB memory and give them back to
> mm, then the ballooned memory becomes 6GB.
> 
> When the shrinker scan is called the second time, another 1GB will be given
> back to mm. So the ballooned pages are given back to mm gradually.

I think what's being asked here is a description of tests that
were run. Which workloads see improved behaviour?

Our behaviour under memory pressure isn't great, in particular it is not
clear when it's safe to re-inflate the balloon, if host attempts to
re-inflate it too soon then we still get OOM. It would be better
if VIRTIO_BALLOON_F_DEFLATE_ON_OOM would somehow mean
"it's ok to ask for almost all of memory, if guest needs memory from
balloon for apps to function it can take it from the balloon".


-- 
MST
