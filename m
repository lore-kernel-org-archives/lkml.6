Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9260EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E2F20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E2F20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935454AbeFMMM3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:12:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935261AbeFMMM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:12:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F8F54000D0B;
        Wed, 13 Jun 2018 12:12:27 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1964202322E;
        Wed, 13 Jun 2018 12:12:23 +0000 (UTC)
Date:   Wed, 13 Jun 2018 14:12:21 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v5 04/13] s390: vfio-ap: base implementation of VFIO AP
 device driver
Message-ID: <20180613141221.5b924348.cohuck@redhat.com>
In-Reply-To: <7237751c-66b5-d14c-5b71-cc1cfc79db87@linux.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1525705912-12815-5-git-send-email-akrowiak@linux.vnet.ibm.com>
        <889b8d41-e08c-0eb5-2de0-a1d6669a03b3@linux.ibm.com>
        <20180613094812.1fd1846d.cohuck@redhat.com>
        <41e7ccbd-f6f5-ba20-f236-7824c682994d@linux.ibm.com>
        <20180613131402.0305d092.cohuck@redhat.com>
        <7237751c-66b5-d14c-5b71-cc1cfc79db87@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 13 Jun 2018 12:12:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 13 Jun 2018 12:12:27 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 14:01:54 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 13/06/2018 13:14, Cornelia Huck wrote:
> > On Wed, 13 Jun 2018 12:54:40 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 13/06/2018 09:48, Cornelia Huck wrote:  
> >>> On Wed, 13 Jun 2018 09:41:16 +0200
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>     
> >>>> On 07/05/2018 17:11, Tony Krowiak wrote:  
> >>>>> Introduces a new AP device driver. This device driver
> >>>>> is built on the VFIO mediated device framework. The framework
> >>>>> provides sysfs interfaces that facilitate passthrough
> >>>>> access by guests to devices installed on the linux host.  
> >>>> ...snip...
> >>>>     
> >>>>> +static int vfio_ap_matrix_dev_create(void)
> >>>>> +{
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
> >>>>> +
> >>>>> +	if (IS_ERR(vfio_ap_root_device)) {
> >>>>> +		ret = PTR_ERR(vfio_ap_root_device);
> >>>>> +		goto done;
> >>>>> +	}
> >>>>> +
> >>>>> +	ap_matrix = kzalloc(sizeof(*ap_matrix), GFP_KERNEL);
> >>>>> +	if (!ap_matrix) {
> >>>>> +		ret = -ENOMEM;
> >>>>> +		goto matrix_alloc_err;
> >>>>> +	}
> >>>>> +
> >>>>> +	ap_matrix->device.type = &vfio_ap_dev_type;
> >>>>> +	dev_set_name(&ap_matrix->device, "%s", VFIO_AP_DEV_NAME);
> >>>>> +	ap_matrix->device.parent = vfio_ap_root_device;
> >>>>> +	ap_matrix->device.release = vfio_ap_matrix_dev_release;
> >>>>> +	ap_matrix->device.driver = &vfio_ap_drv.driver;
> >>>>> +
> >>>>> +	ret = device_register(&ap_matrix->device);
> >>>>> +	if (ret)
> >>>>> +		goto matrix_reg_err;
> >>>>> +
> >>>>> +	goto done;
> >>>>> +
> >>>>> +matrix_reg_err:
> >>>>> +	put_device(&ap_matrix->device);  
> >>>> Did not see this before but here you certainly want to
> >>>> do a kfree and not a put_device.  
> >>> No, this must not be a kfree. Once you've tried to register something
> >>> embedding a struct device with the driver core, you need to use
> >>> put_device, as another path may have acquired a reference, even if
> >>> registering ultimately failed. See the comment for device_register().
> >>> IOW, the code is correct.  
> >> learned something again :) ,
> >> but still, a kfree is needed for the kzalloc.
> >> Does'nt it?  
> > No, the put callback for the embedding structure needs to take care of
> > freeing things. Otherwise it is buggy.  
> 
> Seems buggy to me.
> How does the put_device knows if it is embedded and then in what it is 
> embedded ?

It does not need to know; the code registering the structure needs to
set up device->release correctly.

> 
> >  
> >>>     
> >>>>     
> >>>>> +
> >>>>> +matrix_alloc_err:
> >>>>> +	root_device_unregister(vfio_ap_root_device);
> >>>>> +
> >>>>> +done:
> >>>>> +	return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static void vfio_ap_matrix_dev_destroy(struct ap_matrix *ap_matrix)
> >>>>> +{
> >>>>> +	device_unregister(&ap_matrix->device);
> >>>>> +	root_device_unregister(vfio_ap_root_device);  
> >>>> Also here you need a kfree(ap_matrix) too .  
> >>> Same here.
> >>>     
> 
> 

