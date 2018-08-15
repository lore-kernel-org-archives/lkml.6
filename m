Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E9C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A72215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A72215B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeHOO5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:57:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728668AbeHOO5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:57:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3686C2BCA9;
        Wed, 15 Aug 2018 12:05:11 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94B242156712;
        Wed, 15 Aug 2018 12:05:07 +0000 (UTC)
Date:   Wed, 15 Aug 2018 14:05:05 +0200
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
Subject: Re: [PATCH v9 11/22] s390: vfio-ap: sysfs interfaces to configure
 domains
Message-ID: <20180815140505.36d3138e.cohuck@redhat.com>
In-Reply-To: <1534196899-16987-12-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 15 Aug 2018 12:05:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 15 Aug 2018 12:05:11 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 17:48:08 -0400
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
>  drivers/s390/crypto/vfio_ap_ops.c |   88 ++++++++++++++++++++++++++++++++++++-
>  1 files changed, 87 insertions(+), 1 deletions(-)

Looks sane to me.
