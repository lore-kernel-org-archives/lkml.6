Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EE8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF9420851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF9420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeLMUMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:12:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbeLMUMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:12:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34C663082138;
        Thu, 13 Dec 2018 20:12:31 +0000 (UTC)
Received: from redhat.com (ovpn-120-21.rdu2.redhat.com [10.10.120.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 14BB560BE7;
        Thu, 13 Dec 2018 20:12:29 +0000 (UTC)
Date:   Thu, 13 Dec 2018 15:12:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
Message-ID: <20181213144116-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213101022.12475-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Dec 2018 20:12:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
> Hi:
> 
> This series tries to access virtqueue metadata through kernel virtual
> address instead of copy_user() friends since they had too much
> overheads like checks, spec barriers or even hardware feature
> toggling.
> 
> Test shows about 24% improvement on TX PPS. It should benefit other
> cases as well.
> 
> Please review

I think the idea of speeding up userspace access is a good one.
However I think that moving all checks to start is way too aggressive.
Instead, let's batch things up but let's not keep them
around forever.
Here are some ideas:


1. Disable preemption, process a small number of small packets
   directly in an atomic context. This should cut latency
   down significantly, the tricky part is to only do it
   on a light load and disable this
   for the streaming case otherwise it's unfair.
   This might fail, if it does just bounce things out to
   a thread.

2. Switch to unsafe_put_user/unsafe_get_user,
   and batch up multiple accesses.

3. Allow adding a fixup point manually,
   such that multiple independent get_user accesses
   can get a single fixup (will allow better compiler
   optimizations).





> Jason Wang (3):
>   vhost: generalize adding used elem
>   vhost: fine grain userspace memory accessors
>   vhost: access vq metadata through kernel virtual address
> 
>  drivers/vhost/vhost.c | 281 ++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |  11 ++
>  2 files changed, 266 insertions(+), 26 deletions(-)
> 
> -- 
> 2.17.1
