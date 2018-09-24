Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66718C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6512086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6512086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeIXQ7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbeIXQ7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:59:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFA873082E24;
        Mon, 24 Sep 2018 10:58:05 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBC105C1B4;
        Mon, 24 Sep 2018 10:57:58 +0000 (UTC)
Date:   Mon, 24 Sep 2018 12:57:56 +0200
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
Subject: Re: [PATCH v10 08/26] s390: vfio-ap: sysfs interfaces to configure
 control domains
Message-ID: <20180924125756.1ea6c31a.cohuck@redhat.com>
In-Reply-To: <1536781396-13601-9-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 24 Sep 2018 10:58:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 15:42:58 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Provides the sysfs interfaces for:
> 
> 1. Assigning AP control domains to the mediated matrix device
> 
> 2. Unassigning AP control domains from a mediated matrix device
> 
> 3. Displaying the control domains assigned to a mediated matrix
>    device
> 
> The IDs of the AP control domains assigned to the mediated matrix
> device are stored in an AP domain mask (ADM). The bits in the ADM,
> from most significant to least significant bit, correspond to
> AP domain numbers 0 to 255. On some systems, the maximum allowable
> domain number may be less than 255 - depending upon the host's
> AP configuration - and assignment may be rejected if the input
> domain ID exceeds the limit.
> 
> When a control domain is assigned, the bit corresponding its domain
> ID will be set in the ADM. Likewise, when a domain is unassigned,
> the bit corresponding to its domain ID will be cleared in the ADM.
> 
> The relevant sysfs structures are:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. assign_control_domain
> .................. unassign_control_domain
> 
> To assign a control domain to the $uuid mediated matrix device's
> ADM, write its domain number to the assign_control_domain file.
> To unassign a domain, write its domain number to the
> unassign_control_domain file. The domain number is specified
> using conventional semantics: If it begins with 0x the number
> will be parsed as a hexadecimal (case insensitive) number;
> if it begins with 0, it is parsed as an octal number;
> otherwise, it will be parsed as a decimal number.
> 
> For example, to assign control domain 173 (0xad) to the mediated
> matrix device $uuid:
> 
> 	echo 173 > assign_control_domain
> 
> 	or
> 
> 	echo 0255 > assign_control_domain
> 
> 	or
> 
> 	echo 0xad > assign_control_domain
> 
> To unassign control domain 173 (0xad):
> 
> 	echo 173 > unassign_control_domain
> 
> 	or
> 
> 	echo 0255 > unassign_control_domain
> 
> 	or
> 
> 	echo 0xad > unassign_control_domain
> 
> The assignment will be rejected if the APQI exceeds the maximum
> value for an AP domain:
>   * If the AP Extended Addressing (APXA) facility is installed,
>     the max value is 255
>   * Else the max value is 15
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |  112 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 112 insertions(+), 0 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
