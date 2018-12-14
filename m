Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FAAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07F8206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbeLNPQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:16:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbeLNPQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:16:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C7A43001587;
        Fri, 14 Dec 2018 15:16:15 +0000 (UTC)
Received: from redhat.com (ovpn-121-101.rdu2.redhat.com [10.10.121.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id 89016261B3;
        Fri, 14 Dec 2018 15:16:14 +0000 (UTC)
Date:   Fri, 14 Dec 2018 10:16:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
Message-ID: <20181214101356-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213101022.12475-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 14 Dec 2018 15:16:15 +0000 (UTC)
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

BTW if the issue is all the error checking, maybe we should
consider using something like uaccess_catch and check
in a single place.


> Please review
> 
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
