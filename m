Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8626C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3103218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3103218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbeHNL3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:29:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbeHNL3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F255401EF09;
        Tue, 14 Aug 2018 08:43:44 +0000 (UTC)
Received: from gondolin (ovpn-117-136.ams2.redhat.com [10.36.117.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3EC27C41;
        Tue, 14 Aug 2018 08:43:38 +0000 (UTC)
Date:   Tue, 14 Aug 2018 10:43:35 +0200
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
Subject: Re: [PATCH v9 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
Message-ID: <20180814104335.4bc3630a.cohuck@redhat.com>
In-Reply-To: <1534196899-16987-5-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 08:43:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 08:43:44 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 17:48:01 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Harald Freudenberger <freude@de.ibm.com>
> 
> Move all the inline functions from the ap bus header
> file ap_asm.h into the in-kernel api header file
> arch/s390/include/asm/ap.h so that KVM can make use
> of all the low level AP functions.
> 
> Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>  drivers/s390/crypto/ap_bus.c   |   23 +---
>  drivers/s390/crypto/ap_bus.h   |    1 +
>  drivers/s390/crypto/ap_card.c  |    1 -
>  drivers/s390/crypto/ap_queue.c |    1 -
>  5 files changed, 260 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index c1bedb4..887494a 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -47,6 +47,50 @@ struct ap_queue_status {
>  };
>  
>  /**
> + * ap_intructions_available() - Test if AP instructions are available.
> + *
> + * Returns 1 if the AP instructions are installed, otherwise 0.
> + */
> +static inline int ap_instructions_available(void)
> +{
> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
> +	register unsigned long reg1 asm ("1") = 0;
> +	register unsigned long reg2 asm ("2") = 0;
> +
> +	asm volatile(
> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
> +		"0: la    %0,1\n"
> +		"1:\n"
> +		EX_TABLE(0b, 1b)
> +		: "+d" (reg1), "+d" (reg2)
> +		: "d" (reg0)
> +		: "cc");
> +	return reg1;
> +}

I think upstream this change (have this function return !0 when the
instructions are installed) will be an addon patch to the one which has
already made its way into master. Not really relevant for the remainder
of this patch series, though.
