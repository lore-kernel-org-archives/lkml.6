Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEE72147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfB0JcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:32:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfB0JcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:32:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D966F30917AE;
        Wed, 27 Feb 2019 09:32:22 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBFC85DDF6;
        Wed, 27 Feb 2019 09:32:13 +0000 (UTC)
Date:   Wed, 27 Feb 2019 10:32:11 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
Message-ID: <20190227103211.5e4d63b2.cohuck@redhat.com>
In-Reply-To: <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 27 Feb 2019 09:32:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 16:29:56 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We need to associate the ap_vfio_queue, which will hold the
> per queue information for interrupt with a matrix mediated device
> which hold the configuration and the way to the CRYCB.
> 
> Let's do this when assigning a APID or a APQI to the mediated device
> and clear the relation when unassigning.
> 
> Queuing the devices on a list of free devices and testing the
> matrix_mdev pointer to the associated matrix allow us to know
> if the queue is associated to the matrix device and associated
> or not to a mediated device.
> 
> When resetting an AP queue we must wait until there are no more
> messages in the message queue before considering the queue is really
> in a clean state.
> 
> Let's do it and wait until the status response code indicate the
> queue is empty after issuing a PAPQ/ZAPQ instruction.

I'm a bit confused about the context where that list moving etc. is
supposed to take place.

When are we assigning/deassigning? Is there even supposed to be any
activity that we need to zap on the queues?

Do we need any serialization/locking on the lists?

> 
> Being at work on the reset function, let's simplify
> vfio_ap_mdev_reset_queue and vfio_ap_mdev_reset_queues by using the
> vfio_ap_queue structure as parameter.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 385 +++++++++++++++++++-------------------
>  1 file changed, 189 insertions(+), 196 deletions(-)
