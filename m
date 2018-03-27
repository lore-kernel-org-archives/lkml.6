Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeC0LRP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:17:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750898AbeC0LRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:17:13 -0400
Date: Tue, 27 Mar 2018 13:17:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v3 05/14] s390: vfio-ap: base implementation of VFIO AP
 device driver
Message-ID: <20180327131705.46fded40.cohuck@redhat.com>
In-Reply-To: <e4d7621c-a09c-bdfd-ffe2-35c5ea3acdc7@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1521051954-25715-6-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1d5a5e18-1886-dd73-a17e-9bec617507ba@linux.vnet.ibm.com>
        <e4d7621c-a09c-bdfd-ffe2-35c5ea3acdc7@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 13:25:25 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 03/15/2018 09:25 AM, Pierre Morel wrote:
> > On 14/03/2018 19:25, Tony Krowiak wrote:  

> >> +config VFIO_AP
> >> +    def_tristate m  
> > not sure it must be module by default.
> > I would not set it by default.  
> Connie also asked about this in the last review, so I will go ahead
> and change it.
> >  
> >> +    prompt "VFIO support for AP devices"
> >> +    depends on ZCRYPT && VFIO_MDEV_DEVICE  
> >
> > VFIO_MDEV_DEVICE is a general feature *needed* by VFIO_AP
> > and has no use case by its own. If it is set it is obviously because some
> > mediated device drivers needs it.
> > while ZCRYPT is a Z feature which may be set without VFIO_AP.
> >
> > So you need:
> >
> > config VFIO_AP
> >     def_tristate n
> >     prompt "VFIO support for AP devices"
> >     depends on ZCRYPT
> >     select VFIO_MDEV
> >     select VFIO_MDEV_DEVICE
> > ...  
> I was thinking the same just yesterday and I agree, this makes sense.

OTOH, nobody else seems to do a select on these symbols so far.

If you decide to go that route, you'll also need to depend on VFIO
(otherwise you could end up selecting symbols with unmet dependencies).
All in all, I prefer the 'depends' approach.
