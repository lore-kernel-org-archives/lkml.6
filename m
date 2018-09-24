Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C3ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8730220833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8730220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeIXQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:47:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbeIXQrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:47:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 846393082E54;
        Mon, 24 Sep 2018 10:45:39 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61839104C529;
        Mon, 24 Sep 2018 10:45:32 +0000 (UTC)
Date:   Mon, 24 Sep 2018 12:45:30 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 07/26] s390: vfio-ap: sysfs interfaces to configure
 domains
Message-ID: <20180924124530.0efe5f37.cohuck@redhat.com>
In-Reply-To: <1536781396-13601-8-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 24 Sep 2018 10:45:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 15:42:57 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces two new sysfs attributes for the VFIO mediated
> matrix device for assigning AP domains to and unassigning
> AP domains from a mediated matrix device. The IDs of the
> AP domains assigned to the mediated matrix device will be
> stored in an AP queue mask (AQM).
> 
> The bits in the AQM, from most significant to least
> significant bit, correspond to AP queue index (APQI) 0 to
> 255 (note that an APQI is synonymous with with a domain ID).
> On some systems, the maximum allowable domain number may be
> less than 255 - depending upon the host's AP configuration -
> and assignment may be rejected if the input domain ID exceeds
> the limit.
> 
> When a domain is assigned, the bit corresponding to the APQI
> will be set in the AQM. Likewise, when a domain is unassigned,
> the bit corresponding to the APQI will be cleared from the AQM.
> 
> In order to successfully assign a domain, the APQNs derived from
> the domain ID being assigned and the adapter numbers of all
> adapters previously assigned:
> 
> 1. Must be bound to the vfio_ap device driver.
> 
> 2. Must not be assigned to any other mediated matrix device.
> 
> If there are no adapters assigned to the mdev, then there must
> be an AP queue bound to the vfio_ap device driver with an
> APQN containing the domain ID (i.e., APQI), otherwise all
> adapters subsequently assigned will fail because there will be no
> AP queues bound with an APQN containing the APQI.
> 
> Assigning or un-assigning an AP domain will also be rejected if
> a guest using the mediated matrix device is running.
> 
> The relevant sysfs structures are:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. assign_domain
> .................. unassign_domain
> 
> To assign a domain to the $uuid mediated matrix device,
> write the domain's ID to the assign_domain file. To
> unassign a domain, write the domain's ID to the
> unassign_domain file. The ID is specified using
> conventional semantics: If it begins with 0x, the number
> will be parsed as a hexadecimal (case insensitive) number;
> if it begins with 0, it will be parsed as an octal number;
> otherwise, it will be parsed as a decimal number.
> 
> For example, to assign domain 173 (0xad) to the mediated matrix
> device $uuid:
> 
> 	echo 173 > assign_domain
> 
> 	or
> 
> 	echo 0255 > assign_domain
> 
> 	or
> 
> 	echo 0xad > assign_domain
> 
> To unassign domain 173 (0xad):
> 
> 	echo 173 > unassign_domain
> 
> 	or
> 
> 	echo 0255 > unassign_domain
> 
> 	or
> 
> 	echo 0xad > unassign_domain
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |  138 ++++++++++++++++++++++++++++++++++++-
>  1 files changed, 137 insertions(+), 1 deletions(-)

Might have been good to add some documentation for the new attributes
in the sysfs API directory, but as that one seems to be rather
hit-and-miss anyway (and you provide a documentation file for the whole
thing),

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
