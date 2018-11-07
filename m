Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96838C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5D2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA5D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbeKGTQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:16:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeKGTQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:16:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AA7315561;
        Wed,  7 Nov 2018 09:46:38 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5F4C104C456;
        Wed,  7 Nov 2018 09:46:26 +0000 (UTC)
Date:   Wed, 7 Nov 2018 10:46:24 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v1 4/7] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
Message-ID: <20181107104624.36707cca.cohuck@redhat.com>
In-Reply-To: <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
        <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 07 Nov 2018 09:46:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 19:12:54 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> This is the implementation of the VFIO ioctl calls to handle
> the AQIC interception and use GISA to handle interrupts.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 95 +++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 272ef427dcc0..f68102163bf4 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -895,12 +895,107 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>  	return copy_to_user((void __user *)arg, &info, minsz);
>  }
>  
> +static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
> +			   struct vfio_ap_aqic *parm)
> +{
> +	struct aqic_gisa aqic_gisa = reg2aqic(0);
> +	struct kvm_s390_gisa *gisa = matrix_mdev->kvm->arch.gisa;
> +	struct ap_status ap_status = reg2status(0);
> +	unsigned long p;
> +	int ret = -1;
> +	int apqn;
> +	uint32_t gd;
> +
> +	apqn = (int)(parm->cmd & 0xffff);

It seems you always use cmd & 0xffff only. What if there is other stuff
in the remaining bits of cmd? Do you plan to ignore it in any case, or
should you actively check that there is nothing in it?
