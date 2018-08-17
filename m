Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A772C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C202188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C202188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeHQMhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:37:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbeHQMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:37:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A96468182D3A;
        Fri, 17 Aug 2018 09:34:59 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C3EC2166BA5;
        Fri, 17 Aug 2018 09:34:55 +0000 (UTC)
Date:   Fri, 17 Aug 2018 11:34:52 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
Subject: Re: [PATCH v9 17/22] s390: vfio-ap: zeroize the AP queues.
Message-ID: <20180817113452.5cee98e2.cohuck@redhat.com>
In-Reply-To: <59fddbc0-49f5-c83b-144f-7390b80dfc9f@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-18-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180815182401.4cfa0a78.cohuck@redhat.com>
        <59fddbc0-49f5-c83b-144f-7390b80dfc9f@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 17 Aug 2018 09:34:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 17 Aug 2018 09:34:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 16:36:32 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 08/15/2018 12:24 PM, Cornelia Huck wrote:
> > On Mon, 13 Aug 2018 17:48:14 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >
> > Nit: please drop the leading period in the subject.  
> 
> I assume you mean the ending period?

Err, of course.

> 
> >  
> >> From: Tony Krowiak <akrowiak@linux.ibm.com>
> >>
> >> Let's call PAPQ(ZAPQ) to zeroize a queue:
> >>
> >> * For each queue configured for a mediated matrix device
> >>    when it is released.
> >>
> >> Zeroizing a queue resets the queue, clears all pending
> >> messages for the queue entries and disables adapter interruptions
> >> associated with the queue.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> >> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> >> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_ops.c     |   25 +++++++++++++++++++++++++
> >>   drivers/s390/crypto/vfio_ap_private.h |   25 +++++++++++++++++++++++++
> >>   2 files changed, 50 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> >> index 3e8534b..34f982a 100644
> >> --- a/drivers/s390/crypto/vfio_ap_private.h
> >> +++ b/drivers/s390/crypto/vfio_ap_private.h
> >> @@ -74,4 +74,29 @@ struct ap_matrix_mdev {
> >>   extern int vfio_ap_mdev_register(void);
> >>   extern void vfio_ap_mdev_unregister(void);
> >>   
> >> +static inline int vfio_ap_reset_queue(unsigned int apid, unsigned int apqi,
> >> +				      unsigned int retry)
> >> +{
> >> +	struct ap_queue_status status;
> >> +
> >> +	do {
> >> +		status = ap_zapq(AP_MKQID(apid, apqi));
> >> +		switch (status.response_code) {
> >> +		case AP_RESPONSE_NORMAL:
> >> +			return 0;
> >> +		case AP_RESPONSE_RESET_IN_PROGRESS:
> >> +		case AP_RESPONSE_BUSY:
> >> +			msleep(20);
> >> +			break;
> >> +		default:
> >> +			pr_warn("%s: error zeroizing %02x.%04x: response code %d\n",
> >> +				VFIO_AP_MODULE_NAME, apid, apqi,
> >> +				status.response_code);  
> > How can we end up here? Does this mean that we just don't know what to
> > do with this response, or is this something that should never happen?
> > (How much sense does it make to print an error?)  
> 
> There are additional response codes that could be returned; for example,
> in the case of a catastrophic failure such as: The function can not be
> performed because the AP was somehow deconfigured or the functiona
> cannot be performed due to a machine check failure that caused the AP
> path to be removed. It shouldn't happen, but all are possibilities.
> I can get rid of the message and just return -EIO if you prefer.

These sound like "ugh, we're broken anyway". Not sure if an additional
message would help here much; I'd expect other code to just handle the
failure (especially things like machine checks). I would not oppose
removing the message :)

Maybe add a comment /* things are really broken, give up */ instead?

> 
> >  
> >> +			return -EIO;
> >> +		}
> >> +	} while (retry--);
> >> +
> >> +	return -EBUSY;
> >> +}
> >> +
> >>   #endif /* _VFIO_AP_PRIVATE_H_ */  
> 
> 

