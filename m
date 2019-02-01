Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137A6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D974A218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfBAOfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:35:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfBAOf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:35:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E2F8142BFE;
        Fri,  1 Feb 2019 14:35:29 +0000 (UTC)
Received: from gondolin (ovpn-117-104.ams2.redhat.com [10.36.117.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D6A84C488;
        Fri,  1 Feb 2019 14:35:26 +0000 (UTC)
Date:   Fri, 1 Feb 2019 15:35:22 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
Message-ID: <20190201153522.4f72cf00.cohuck@redhat.com>
In-Reply-To: <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
        <20190131105555.4af6d8ea.cohuck@redhat.com>
        <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 01 Feb 2019 14:35:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 18:50:57 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 1/31/19 4:55 AM, Cornelia Huck wrote:
> > On Wed, 30 Jan 2019 12:48:46 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> > Two questions:
> > - Does the event cover _any_ change to the AP configuration, or can the
> >    periodic scan detect changes that are not signaled?  
> 
> It can detect any change, such as a change to the CRYCB masks.

Nice. I suppose we can not rely on those messages being generated,
though, and therefore need to keep the periodic scan...

> 
> > - Do we want to generate such an event in QEMU on plugging/unplugging
> >    the vfio-ap device?  
> 
> We've discussed this quite a bit internally and decided not to implement
> that at this time. We will address it as a future enhancement.

Ok, but I think it would be nice to have.

> >> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
> >> index a0baee25134c..dccccc337078 100644
> >> --- a/drivers/s390/cio/chsc.c
> >> +++ b/drivers/s390/cio/chsc.c
> >> @@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
> >>   			      " failed (rc=%d).\n", ret);
> >>   }
> >>   
> >> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
> >> +{
> >> +	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
> >> +	if (sei_area->rs != 5)
> >> +		return;  
> > 
> > I'm guessing that a reporting source of 5 means ap, right? (The code is
> > silent on all those magic rs values :/)  
> 
> The 5 indicates the accessibility of one or more adjunct processors has
> changed. The reason this gets called is because the CC sent with the
> instruction indicates the AP configuration has changed, so the reporting
> belongs where it is. There is only one RS associated with it.

So if we'd ever get there anything but rs == 5, it would be a hardware
or hypervisor bug? Then the code makes sense, I guess.

> 
> > 
> > If so, should the debug logging be moved after the check?  
> 
> covered in the response above.
> 
> >   
> >> +
> >> +	ap_bus_cfg_chg();
> >> +}
> >> +
