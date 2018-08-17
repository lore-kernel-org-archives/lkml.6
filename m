Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9480821893
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9480821893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeHQLqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:46:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQLqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:46:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39608401EF1B;
        Fri, 17 Aug 2018 08:43:40 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEB432026D6C;
        Fri, 17 Aug 2018 08:43:33 +0000 (UTC)
Date:   Fri, 17 Aug 2018 10:43:31 +0200
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
Subject: Re: [PATCH v9 09/22] s390: vfio-ap: register matrix device with
 VFIO mdev framework
Message-ID: <20180817104331.378fa130.cohuck@redhat.com>
In-Reply-To: <5b77a5e9-6d91-c7a3-5ada-d888735f0488@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180814131929.37d4b530.cohuck@redhat.com>
        <5b77a5e9-6d91-c7a3-5ada-d888735f0488@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 17 Aug 2018 08:43:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 17 Aug 2018 08:43:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 12:24:16 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 08/14/2018 07:19 AM, Cornelia Huck wrote:
> > On Mon, 13 Aug 2018 17:48:06 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> >> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
> >> +{
> >> +	struct ap_matrix_mdev *matrix_mdev;
> >> +
> >> +	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
> >> +	if (!matrix_mdev)
> >> +		return -ENOMEM;
> >> +
> >> +	matrix_mdev->name = dev_name(mdev_dev(mdev));
> >> +	vfio_ap_matrix_init(&matrix_dev.info, &matrix_mdev->matrix);
> >> +	mdev_set_drvdata(mdev, matrix_mdev);
> >> +
> >> +	if (atomic_dec_if_positive(&matrix_dev.available_instances) < 0) {
> >> +		kfree(matrix_mdev);
> >> +		return -EPERM;
> >> +	}  
> > Maybe move this check to the top of the function?  
> 
> Please ignore my previous response to your comment. I can't move the call to
> atomic_dec_if_positive() to the top of the function because it 
> decrements the
> available_instances and if the kzalloc() of matrix_mdev fails, then the 
> value
> would have to then be incremented to remain valid. What I can do is this:
> 
> 1. Check the value of available_instances using atomic_read() at the top of
>     the function and if it is zero, return an error.
> 
> 2. Replace the call to atomic_dec_if_positive() with a call to atomic_dec()
>     to decrement the available_instances.
> 
> I agree that it makes sense to return before attempting to allocate the
> matrix_mdev if available_instances is zero.

Wouldn't that be racy, though?

I don't think re-incrementing the counter is too bad, and it's
certainly better than going through allocation/freeing of structures.

> 
> >  
> >> +
> >> +	mutex_lock(&matrix_dev.lock);
> >> +	list_add(&matrix_mdev->list, &matrix_dev.mdev_list);
> >> +	mutex_unlock(&matrix_dev.lock);
> >> +
> >> +	return 0;
> >> +}  
> 
> 

