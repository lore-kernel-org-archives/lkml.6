Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5254C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBAE214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBAE214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbeHPK0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:26:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727285AbeHPK0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:26:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93F91818A6B0;
        Thu, 16 Aug 2018 07:30:22 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4AB79DE;
        Thu, 16 Aug 2018 07:30:17 +0000 (UTC)
Date:   Thu, 16 Aug 2018 09:30:15 +0200
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
Subject: Re: [PATCH v9 10/22] s390: vfio-ap: sysfs interfaces to configure
 adapters
Message-ID: <20180816093015.19e54936.cohuck@redhat.com>
In-Reply-To: <4bf27c7a-34c6-9160-cdc6-19022b86202b@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-11-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180815115242.35a2a1ce.cohuck@redhat.com>
        <4bf27c7a-34c6-9160-cdc6-19022b86202b@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 16 Aug 2018 07:30:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 16 Aug 2018 07:30:22 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018 12:59:35 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 08/15/2018 05:52 AM, Cornelia Huck wrote:
> > On Mon, 13 Aug 2018 17:48:07 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> >> +/**
> >> + * unassign_adapter_store
> >> + *
> >> + * @dev: the matrix device
> >> + * @attr: a mediated matrix device attribute
> >> + * @buf: a buffer containing the adapter ID (APID) to be assigned
> >> + * @count: the number of bytes in @buf
> >> + *
> >> + * Parses the APID from @buf and unassigns it from the mediated matrix device.
> >> + * The APID must be a valid value  
> > A valid value, but not necessarily assigned, right?  
> 
> You are correct, if the APID is not assigned, then the corresponding bit 
> will be
> cleared regardless. In a previous version, the functions failed if the 
> APID is
> not assigned, but a colleague removed that check. I guess it makes sense 
> given
> it really does not hurt anything to ask to unassign an APID that isn't 
> assigned
> to begin with. Would you prefer I update the comment, or do you feel the 
> user
> should be made aware of an attempt to unassign an APID that is not assigned?

I think the code is fine; updating the comment would be good.
