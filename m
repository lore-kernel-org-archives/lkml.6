Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9849BECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A2920666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A2920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389624AbeIUP2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:28:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbeIUP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:28:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 136573002C77;
        Fri, 21 Sep 2018 09:40:18 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72B58106A78C;
        Fri, 21 Sep 2018 09:40:11 +0000 (UTC)
Date:   Fri, 21 Sep 2018 11:40:09 +0200
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
Subject: Re: [PATCH v10 06/26] s390: vfio-ap: sysfs interfaces to configure
 adapters
Message-ID: <20180921114009.24e928d9.cohuck@redhat.com>
In-Reply-To: <1536781396-13601-7-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-7-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 21 Sep 2018 09:40:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 15:42:56 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces two new sysfs attributes for the VFIO mediated
> matrix device for assigning AP adapters to and unassigning
> AP adapters from a mediated matrix device. The IDs of the
> AP adapters assigned to the mediated matrix device will be
> stored in an AP mask (APM).
> 
> The bits in the APM, from most significant to least significant
> bit, correspond to AP adapter IDs (APID) 0 to 255. On
> some systems, the maximum allowable adapter number may be less
> than 255 - depending upon the host's AP configuration - and
> assignment may be rejected if the input adapter ID exceeds the
> limit.
> 
> When an adapter is assigned, the bit corresponding to the APID
> will be set in the APM. Likewise, when an adapter is
> unassigned, the bit corresponding to the APID will be cleared
> from the APM.
> 
> In order to successfully assign an adapter, the APQNs derived from
> the adapter ID being assigned and the queue indexes of all domains
> previously assigned:
> 
> 1. Must be bound to the vfio_ap device driver.
> 
> 2. Must not be assigned to any other mediated matrix device
> 
> If there are no domains assigned to the mdev, then there must
> be an AP queue bound to the vfio_ap device driver with an
> APQN containing the APID, otherwise all domains
> subsequently assigned will fail because there will be no
> AP queues bound with an APQN containing the adapter ID.
> 
> Assigning or un-assigning an AP adapter will be rejected if
> a guest using the mediated matrix device is running.
> 
> The relevant sysfs structures are:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. assign_adapter
> .................. unassign_adapter
> 
> To assign an adapter to the $uuid mediated matrix device's APM,
> write the APID to the assign_adapter file. To unassign an adapter,
> write the APID to the unassign_adapter file. The APID is specified
> using conventional semantics: If it begins with 0x the number will
> be parsed as a hexadecimal number; if it begins with a 0 the number
> will be parsed as an octal number; otherwise, it will be parsed as a
> decimal number.
> 
> For example, to assign adapter 173 (0xad) to the mediated matrix
> device $uuid:
> 
> 	echo 173 > assign_adapter
> 
> 	or
> 
> 	echo 0xad > assign_adapter
> 
> 	or
> 
> 	echo 0255 > assign_adapter
> 
> To unassign adapter 173 (0xad):
> 
> 	echo 173 > unassign_adapter
> 
> 	or
> 
> 	echo 0xad > unassign_adapter
> 
> 	or
> 
> 	echo 0255 > unassign_adapter
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |  295 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 295 insertions(+), 0 deletions(-)

(...)

> +/**
> + * vfio_ap_mdev_verify_no_sharing
> + *
> + * Verifies that the APQNs derived from the cross product of the AP adapter IDs
> + * and AP queue indexes comprising the AP matrix are not configured for another
> + * mediated device. AP queue sharing is not allowed.
> + *
> + * @kvm: the KVM guest
> + * @matrix: the AP matrix
> + *
> + * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
> + */
> +static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	int nbits;
> +	struct ap_matrix_mdev *lstdev;
> +	unsigned long apm[BITS_TO_LONGS(matrix_mdev->matrix.apm_max + 1)];
> +	unsigned long aqm[BITS_TO_LONGS(matrix_mdev->matrix.aqm_max + 1)];

Can you please convert this to use a fixed-size array? I think
{apm,aqm}_max has an upper bound of 255?

(Also, this can use DECLARE_BITMAP.)

> +
> +	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
> +		if (matrix_mdev == lstdev)
> +			continue;
> +
> +		memset(apm, 0, sizeof(apm));
> +		memset(aqm, 0, sizeof(aqm));
> +
> +		/*
> +		 * We work on full longs, as we can only exclude the leftover
> +		 * bits in non-inverse order. The leftover is all zeros.
> +		 */
> +		nbits = sizeof(apm) * BITS_PER_BYTE;
> +		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
> +				lstdev->matrix.apm, nbits))
> +			continue;
> +
> +		nbits = sizeof(aqm) * BITS_PER_BYTE;
> +		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
> +				lstdev->matrix.aqm, nbits))
> +			continue;
> +
> +		return -EADDRINUSE;
> +	}
> +
> +	return 0;
> +}
