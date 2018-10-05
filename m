Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9316DC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5CF20645
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5CF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJEOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbeJEOsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2364EC0587FF;
        Fri,  5 Oct 2018 07:51:05 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87D56675FA;
        Fri,  5 Oct 2018 07:51:00 +0000 (UTC)
Date:   Fri, 5 Oct 2018 09:50:58 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH] s390: vfio-ap: trace the update of APCB masks
Message-ID: <20181005095058.0af1555f.cohuck@redhat.com>
In-Reply-To: <1538724781-31852-1-git-send-email-pmorel@linux.ibm.com>
References: <1538724781-31852-1-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 05 Oct 2018 07:51:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 09:33:01 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Define a tracing function to trace in the KVM trace buffer
> and trace the changes of the APCB masks.

In general, trace events are good :)

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     | 22 ++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |  4 ++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index a8a9984..00e632a 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -753,6 +753,28 @@ static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
>  	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
>  	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.adm_max + 1, BITS_PER_BYTE);
>  	memcpy(adm, matrix_mdev->matrix.adm, nbytes);
> +
> +	switch (matrix_mdev->kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
> +	case CRYCB_FORMAT2:
> +		VM_AP_EVENT(matrix_mdev->kvm, 3,
> +			    "SET CRYCB: apm %016lx %016lx %016lx %016lx",
> +			    apm[0], apm[1], apm[2], apm[3]);
> +		VM_AP_EVENT(matrix_mdev->kvm, 3,
> +			    "SET CRYCB: aqm %016lx %016lx %016lx %016lx",
> +			    aqm[0], aqm[1], aqm[2], aqm[3]);
> +		VM_AP_EVENT(matrix_mdev->kvm, 3,
> +			    "SET CRYCB: adm %016lx %016lx %016lx %016lx",
> +			    adm[0], adm[1], adm[2], adm[3]);
> +		break;
> +	case CRYCB_FORMAT1:
> +	case CRYCB_FORMAT0: /* Both CRYCB format uses APCB format 0 */
> +	default: /* Can not happen */

If it can't happen, trace "SET CRYCB: invalid format '%x'" instead?

> +		VM_AP_EVENT(matrix_mdev->kvm, 3,
> +			    "SET CRYCB: apm %016lx aqm %04x adm %04x", apm[0],
> +			    *((unsigned short *)aqm), *((unsigned short *)adm));
> +		break;
> +	}
> +
>  }
>  
>  /**
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 5675492..4cd779d 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -19,6 +19,10 @@
>  
>  #include "ap_bus.h"
>  
> +#define VM_AP_EVENT(d_kvm, d_loglevel, d_string, d_args...)\
> +	debug_sprintf_event(d_kvm->arch.dbf, d_loglevel, d_string "\n", \
> +			    d_args)
> +
>  #define VFIO_AP_MODULE_NAME "vfio_ap"
>  #define VFIO_AP_DRV_NAME "vfio_ap"
>  

One thing I don't like about this is that you're using the kvm dbf from
driver code, which looks odd. OTOH, these are kvm-specific masks...

Is there anything else that you may want to trace in the vfio-ap
driver, so that you could add a dbf for it?
