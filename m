Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB600C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C80D215F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C80D215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeI1UKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:10:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeI1UKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:10:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93DFB8666D;
        Fri, 28 Sep 2018 13:46:55 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E914D600C1;
        Fri, 28 Sep 2018 13:46:49 +0000 (UTC)
Date:   Fri, 28 Sep 2018 15:46:47 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com,
        buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [FIXUP v11] fixup! s390: vfio-ap: implement mediated device
 open callback
Message-ID: <20180928154647.5092c8e9.cohuck@redhat.com>
In-Reply-To: <feaecda1-0da7-a23e-671b-a98799481aaf@de.ibm.com>
References: <20180928121429.7323d78b.cohuck@redhat.com>
        <20180928133321.31884-1-akrowiak@linux.vnet.ibm.com>
        <20180928153506.3521bc33.cohuck@redhat.com>
        <9da2f32b-2d58-fcd1-a830-1fba0ed8bc0c@linux.ibm.com>
        <feaecda1-0da7-a23e-671b-a98799481aaf@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 28 Sep 2018 13:46:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 15:42:35 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/28/2018 03:41 PM, Halil Pasic wrote:
> > 
> > 
> > On 09/28/2018 03:35 PM, Cornelia Huck wrote:  
> >> On Fri, 28 Sep 2018 09:33:21 -0400
> >> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >>  
> >>> From: Tony Krowiak <akrowiak@linux.ibm.com>
> >>>
> >>> Fixes case statement in vfio_ap_mdev_copy_masks() function in
> >>> vfio-ap-ops.c.
> >>> ---
> >>>  drivers/s390/crypto/vfio_ap_ops.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> >>> index e1e1beaaeba5..86b42487a51c 100644
> >>> --- a/drivers/s390/crypto/vfio_ap_ops.c
> >>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> >>> @@ -741,11 +741,12 @@ static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
> >>>  		break;
> >>>  	case CRYCB_FORMAT1:
> >>>  	case CRYCB_FORMAT0:
> >>> -	default:
> >>>  		apm = (unsigned long *)crycb->apcb0.apm;
> >>>  		aqm = (unsigned long *)crycb->apcb0.aqm;
> >>>  		adm = (unsigned long *)crycb->apcb0.adm;
> >>>  		break;
> >>> +	default:
> >>> +		return;  
> >>
> >> /* cannot happen */
> >>
> >> ?  
> > 
> > Or use something like BUG(). Without conveying that default is illegal we
> > don't gain anything over the previous version IMHO.  
> 
> Only WARN_ON, if at all.

Agreed.

This is only a marker for some future developer who might need to deal
with a new format.
