Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeEQHpD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:45:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752348AbeEQHpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:45:01 -0400
Date: Thu, 17 May 2018 09:44:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v5 05/13] s390: vfio-ap: register matrix device with
 VFIO mdev framework
Message-ID: <20180517094454.6afae7ba.cohuck@redhat.com>
In-Reply-To: <4688078d-3e13-5201-582f-52576b25defa@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
        <5471b194-d7ca-c9c6-132e-fa9539fe44f0@linux.ibm.com>
        <4688078d-3e13-5201-582f-52576b25defa@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 15:42:18 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 05/11/2018 01:18 PM, Halil Pasic wrote:
> >
> >
> > On 05/07/2018 05:11 PM, Tony Krowiak wrote:  
> >> Registers the matrix device created by the VFIO AP device
> >> driver with the VFIO mediated device framework.
> >> Registering the matrix device will create the sysfs
> >> structures needed to create mediated matrix devices
> >> each of which will be used to configure the AP matrix
> >> for a guest and connect it to the VFIO AP device driver.

> >> +static int vfio_ap_mdev_create(struct kobject *kobj, struct 
> >> mdev_device *mdev)
> >> +{
> >> +    struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
> >> +
> >> +    ap_matrix->available_instances--;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int vfio_ap_mdev_remove(struct mdev_device *mdev)
> >> +{
> >> +    struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
> >> +
> >> +    ap_matrix->available_instances++;
> >> +
> >> +    return 0;
> >> +}
> >> +  
> >
> > The above functions seem to be called with the lock of this 
> > auto-generated
> > mdev parent device held. That's why we don't have to care about 
> > synchronization
> > ourselves, right?  
> 
> I would assume as much. The comments for the 'struct mdev_parent_ops' in
> include/linux/mdev.h do not mention anything about synchronization, nor 
> did I
> see any locking or synchronization in the vfio_ccw implementation after 
> which
> I modeled my code, so frankly it is something I did not consider.
> 
> >
> >
> > A small comment in the code could be helpful for mdev non-experts. 
> > Hell, I would
> > even consider documenting it for all mdev -- took me some time to 
> > figure out.  
> 
> You may want to bring this up with the VFIO mdev maintainers, but I'd be 
> happy to
> include a comment in the functions in question if you think it important.

Important note: There's currently a patch on list that removes the mdev
parent mutex, and it seems there was never intended to be any
serialization in that place by the mdev core. (Look for "vfio/mdev:
Check globally for duplicate devices".)
