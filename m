Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0C0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51302172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51302172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeI1QjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbeI1QjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:39:15 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B914D6662;
        Fri, 28 Sep 2018 10:16:12 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 093363091390;
        Fri, 28 Sep 2018 10:16:06 +0000 (UTC)
Date:   Fri, 28 Sep 2018 12:16:04 +0200
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
Subject: Re: [PATCH v11 00/26] guest dedicated crypto adapters
Message-ID: <20180928121604.65874dc1.cohuck@redhat.com>
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 28 Sep 2018 10:16:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 19:16:15 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Abstract:
> ========
> 
> On s390, we have cryptographic coprocessor cards, which are modeled on
> Linux as devices on the AP bus. Each card can be partitioned into domains
> which can be thought of as a set of hardware registers for processing 
> crypto commands. Crypto commands are sent to a specific domain within a
> card is via a queue which is identified as a (card,domain) tuple. We model 
> this something like the following (assuming we have access to cards 3 and 
> 4 and domains 1 and 2):
> 
> AP -> card3 -> queue (3,1)
>             -> queue (3,2)
>    -> card4 -> queue (4,1)
>             -> queue (4,2)  
> 
> If we want to virtualize this, we can use a feature provided by the
> hardware. We basically attach a satellite control block to our main
> hardware virtualization control block and the hardware takes care of
> most of the rest.
> 
> For this control block, we don't specify explicit tuples, but a list of
> cards and a list of domains. The guest will get access to the cross
> product.
> 
> Because of this, we need to take care that the lists provided to
> different guests don't overlap; i.e., we need to enforce sane
> configurations. Otherwise, one guest may get access to things like
> secret keys for another guest.
> 
> The idea of this patch set is to introduce a new device, the matrix
> device. This matrix device hangs off a different root and acts as the
> parent node for mdev devices.
> 
> If you now want to give the tuples (4,1) and (4,2), you need to do the
> following:
> 
> - Make sure the queues (4,1) and (4,2) belong to vfio_ap (see patches
>   #5 and #6)
> - Create the mediated device.
> - Assign card 4 and domains 1 and 2 to the mediated device
> - Optionally activate the mediated device.
> 
> QEMU will now simply consume the mediated device and things should work.
> 
> For a complete description of the architecture and concepts underlying
> the design, see the Documentation/s390/vfio-ap.txt file included with this
> patch set.
> 
> v10 => v11 Change log:
> =====================
> * Fixed race condition when setting KVM in the notifier
> * Removed KVM_S390_VM_CPU_FEAT_AP, no longer necessary
> * Fail vfio_ap module inti if AP instructions not available on host
> * Remove KVM_S390_VM_CPU_FEAT_AP
> * Expose VM enable/disable APIE attributes only if AP instructions
>   available on host.

I think this version is good to go with the touchups mentioned.
