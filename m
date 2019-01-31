Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A88C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5613C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfAaJ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfAaJ4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:56:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC1C9C00293F;
        Thu, 31 Jan 2019 09:56:00 +0000 (UTC)
Received: from gondolin (ovpn-116-34.ams2.redhat.com [10.36.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 512ED17B03;
        Thu, 31 Jan 2019 09:55:58 +0000 (UTC)
Date:   Thu, 31 Jan 2019 10:55:55 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
Message-ID: <20190131105555.4af6d8ea.cohuck@redhat.com>
In-Reply-To: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 31 Jan 2019 09:56:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 12:48:46 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The current AP bus implementation periodically polls the AP configuration
> to detect changes. When the AP configuration is dynamically changed via the
> SE or an SCLP instruction, the changes will not be reflected to sysfs until
> the next time the AP configuration is polled. The CHSC architecture
> provides a Store Event Information (SEI)command to make notification of an

missing blank ---------------------------^

> AP configuration change. This patch introduces a handler to process
> notification from the CHSC SEI command BY immediately kickING off an AP bus

s/BY/by/

s/kickING/kicking/

> scan.

Scan-after-event sounds useful, yeah.

Two questions:
- Does the event cover _any_ change to the AP configuration, or can the
  periodic scan detect changes that are not signaled?
- Do we want to generate such an event in QEMU on plugging/unplugging
  the vfio-ap device?

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/include/asm/ap.h   | 12 ++++++++++++
>  drivers/s390/cio/chsc.c      | 12 ++++++++++++
>  drivers/s390/cio/chsc.h      |  1 +
>  drivers/s390/crypto/ap_bus.c | 12 ++++++++++++
>  4 files changed, 37 insertions(+)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index 1a6a7092d942..c778593d509f 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -360,4 +360,16 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
>  	return reg1;
>  }
>  
> +/*
> + * Interface to tell the AP bus code that a configuration
> + * change has happened. The bus code should at least do
> + * an ap bus resource rescan.
> + */
> +#if IS_ENABLED(CONFIG_ZCRYPT)
> +void ap_bus_cfg_chg(void);
> +#else
> +#error "no CONFIG_ZCRYPT"

That #error looks like a development debugging leftover.

> +static void ap_bus_cfg_chg(void){};
> +#endif
> +
>  #endif /* _ASM_S390_AP_H_ */
> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
> index a0baee25134c..dccccc337078 100644
> --- a/drivers/s390/cio/chsc.c
> +++ b/drivers/s390/cio/chsc.c
> @@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
>  			      " failed (rc=%d).\n", ret);
>  }
>  
> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
> +{
> +	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
> +	if (sei_area->rs != 5)
> +		return;

I'm guessing that a reporting source of 5 means ap, right? (The code is
silent on all those magic rs values :/)

If so, should the debug logging be moved after the check?

> +
> +	ap_bus_cfg_chg();
> +}
> +
>  static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
>  {
>  	switch (sei_area->cc) {
> @@ -612,6 +621,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
>  	case 2: /* i/o resource accessibility */
>  		chsc_process_sei_res_acc(sei_area);
>  		break;
> +	case 3: /* ap config changed */
> +		chsc_process_sei_ap_cfg_chg(sei_area);
> +		break;
>  	case 7: /* channel-path-availability information */
>  		chsc_process_sei_chp_avail(sei_area);
>  		break;
> diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
> index 78aba8d94eec..5651066c46e3 100644
> --- a/drivers/s390/cio/chsc.h
> +++ b/drivers/s390/cio/chsc.h
> @@ -9,6 +9,7 @@
>  #include <asm/chsc.h>
>  #include <asm/schid.h>
>  #include <asm/qdio.h>
> +#include <asm/ap.h>

I would probably include this in chsc.c instead.

>  
>  #define CHSC_SDA_OC_MSS   0x2
>  
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index 48ea0004a56d..94f621783d6b 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -35,6 +35,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/debugfs.h>
>  #include <linux/ctype.h>
> +#include <asm/crw.h>

Why are you adding this #include?

>  
>  #include "ap_bus.h"
>  #include "ap_debug.h"
> @@ -860,6 +861,17 @@ void ap_bus_force_rescan(void)
>  EXPORT_SYMBOL(ap_bus_force_rescan);
>  
>  /*
> +* A config change has happened, Force an ap bus rescan.

s/Force/force/

> +*/
> +void ap_bus_cfg_chg(void)
> +{
> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> +
> +	ap_bus_force_rescan();
> +}
> +EXPORT_SYMBOL(ap_bus_cfg_chg);
> +
> +/*
>   * hex2bitmap() - parse hex mask string and set bitmap.
>   * Valid strings are "0x012345678" with at least one valid hex number.
>   * Rest of the bitmap to the right is padded with 0. No spaces allowed

