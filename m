Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB397C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF33222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502209AbfBNPkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:40:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21885 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502131AbfBNPkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:40:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36370C070473;
        Thu, 14 Feb 2019 15:40:49 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29AD1A912;
        Thu, 14 Feb 2019 15:40:46 +0000 (UTC)
Date:   Thu, 14 Feb 2019 16:40:44 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Message-ID: <20190214164044.5e67660a.cohuck@redhat.com>
In-Reply-To: <6147f1ce-fd8b-1ec2-30ce-7ac68f3d8e27@de.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
        <20190214155441.087d2a68.cohuck@redhat.com>
        <6147f1ce-fd8b-1ec2-30ce-7ac68f3d8e27@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 14 Feb 2019 15:40:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 16:05:35 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 14.02.2019 15:54, Cornelia Huck wrote:
> > On Thu, 14 Feb 2019 14:51:01 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:  
> 
> Pierre,
> this is independent from this series and should have been sent separately.
> In the end (when we have the final solution) this will require cc stable.
> >   
> >> Libudev relies on having a subsystem link for non-root devices. To
> >> avoid libudev (and potentially other userspace tools) choking on the
> >> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
> >> bus subsytem, and make the matrix device reside within it.  
> > 
> > How does libudev choke on this? It feels wrong to introduce a bus that
> > basically does nothing...  
> 
> I have seen libvirt looping when a matrix device was available before the
> libvirt start.
> Marc Hartmayer debugged this and circumvented this in libvirt:
> https://www.redhat.com/archives/libvir-list/2019-February/msg00837.html
> 
> Still libudev expects a subsystem link in the matrix folder when doing the 
> udev_enumerate_scan_devices call.
> 
> Having a bus is one way of adding a subsystem link.

Ugh, that feels really broken. Adding a bus is probably the easiest way
to get this working, though :/
