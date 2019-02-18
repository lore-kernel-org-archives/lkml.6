Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0652147C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfBRMBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:01:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfBRMBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:01:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CCB3C03DFE1;
        Mon, 18 Feb 2019 12:01:53 +0000 (UTC)
Received: from gondolin (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80D7010027DE;
        Mon, 18 Feb 2019 12:01:50 +0000 (UTC)
Date:   Mon, 18 Feb 2019 13:01:47 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     pmorel@linux.ibm.com, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Message-ID: <20190218130147.5ed3edbe.cohuck@redhat.com>
In-Reply-To: <f38c99e6-bb25-9179-e4cd-20ba8482111f@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
        <20190214155441.087d2a68.cohuck@redhat.com>
        <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
        <20190214175730.4ab609ae.cohuck@redhat.com>
        <9200b1f8-874f-ffa7-bef0-19ca570d7ac1@linux.ibm.com>
        <eac03540-a499-fa0f-1a4a-b5cc99030775@linux.ibm.com>
        <20190215101118.5417d725.cohuck@redhat.com>
        <f38c99e6-bb25-9179-e4cd-20ba8482111f@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 18 Feb 2019 12:01:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 16:59:33 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 2/15/19 4:11 AM, Cornelia Huck wrote:
> > On Thu, 14 Feb 2019 13:30:59 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >   
> >> On 2/14/19 12:36 PM, Pierre Morel wrote:  
> >>> On 14/02/2019 17:57, Cornelia Huck wrote:  

> >>>> (And reading further in the current code, it seems we clear that
> >>>> structure _after_ the matrix device had been setup, so how can that
> >>>> even work? Where am I confused?)  
> >>>
> >>> On device_register there were no bus, so the core just do not look for a
> >>> driver and this field was nor tested nor overwritten.  
> > 
> > Hm... so has the callback in driver_for_each_device() in
> > vfio_ap_verify_queue_reserved() ever been invoked at all? It seems this
> > patch fixes more than just libudev issues...  
> 
> It is this patch that rendered the driver_for_each_device() in
> vfio_ap_verify_queue_reserved() erroneous. That function gets called
> every time an adapter or domain is assigned to the mdev. This patch
> introduced the problem with driver_for_each_device().

So, does this function need to be removed or called from another place,
then? (It looks like it was dead code before.)
