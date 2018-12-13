Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765B0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3302820851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3302820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeLMOcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:32:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeLMOcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:32:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D9B1C0495B5;
        Thu, 13 Dec 2018 14:32:42 +0000 (UTC)
Received: from redhat.com (ovpn-120-178.rdu2.redhat.com [10.10.120.178])
        by smtp.corp.redhat.com (Postfix) with SMTP id B4237607DC;
        Thu, 13 Dec 2018 14:32:30 +0000 (UTC)
Date:   Thu, 13 Dec 2018 09:32:30 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net V3 0/3] Fix various issue of vhost
Message-ID: <20181213093207-mutt-send-email-mst@kernel.org>
References: <20181213025339.14023-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213025339.14023-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Dec 2018 14:32:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:53:36AM +0800, Jason Wang wrote:
> Hi:
> 
> This series tries to fix various issues of vhost:
> 
> - Patch 1 adds a missing write barrier between used idx updating and
>   logging.
> - Patch 2-3 brings back the protection of device IOTLB through vq
>   mutex, this fixes possible use after free in device IOTLB entries.
> 
> Please consider them for -stable.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Thanks
> 
> Changes from V2:
> - drop dirty page fix and make it for net-next
> Changes from V1:
> - silent compiler warning for 32bit.
> - use mutex_trylock() on slowpath instead of mutex_lock() even on fast
>   path.
> 
> Jason Wang (3):
>   vhost: make sure used idx is seen before log in vhost_add_used_n()
>   vhost_net: switch to use mutex_trylock() in vhost_net_busy_poll()
>   Revert "net: vhost: lock the vqs one by one"
> 
>  drivers/vhost/net.c   |  8 +++++++-
>  drivers/vhost/vhost.c | 23 +++++++++++++++++++----
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
