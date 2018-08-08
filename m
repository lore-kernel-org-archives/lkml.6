Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74EDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916AC208D4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916AC208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeHHSpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:45:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeHHSpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:45:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E45064021CC4;
        Wed,  8 Aug 2018 16:25:18 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB3FF20290AB;
        Wed,  8 Aug 2018 16:25:15 +0000 (UTC)
Date:   Wed, 8 Aug 2018 18:25:13 +0200
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
Subject: Re: [PATCH v8 00/22] vfio-ap: guest dedicated crypto adapters
Message-ID: <20180808182513.557b09cb.cohuck@redhat.com>
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 16:25:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 16:25:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Aug 2018 10:44:10 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Several major objections were raised to design changes introduced in the v7
> patch series, so in order to avoid an extended discussion around these 
> objections and to expedite acceptance of the series, the following changes
> have been made for v8:
> 
> 1. Removed the AP bus's ability to designate queues as 'used by host' or as 
>    'used by alternate driver(s)'. The bind/unbind sysfs interfaces will be
>    used for managing the connection of AP queue devices to a zcrypt driver
>    or the VFIO AP driver.

I don't think the idea of pools is bad per se; I mainly did not like
the sysfs interface and the dynamic interactions.

We can probably reintroduce something like that later on, if it is
still useful.

> 
> 2. Removed the 'activate' sysfs interfaces which allowed for over 
>    provisioning of the mediated device as well as creation of mdevs with
>    overlapping matrixes. It was pointed out that both of these enhancements
>    break the mdev model. Consistency checking of the mdev matrix has
>    therefore been returned to the mediated matrix device's sysfs interfaces
>    for assigning adapters and domains:
> 
>    * Verify that APQNs assigned to the mediated device are bound to the 
>      VFIO AP device driver
> 
>    * Verify that no APQN assigned to the mediated matrix device is assigned
>      to any other mediated matrix device.

Ok, that makes sense.

Where's point 3? :)

> 
> 4. Reworked the handling of the CRYCB in vSIE based upon patches introduced
>    by David in the mainline.

I had reviewed David's patches and they looked good to me.

> 
> Notes:
> =====
> 
> Patches 1-4 (by Harald) posted with this series are forthcoming via
> Martins tree and are based on changes in the ap driver/bus that we use as a
> foundation. They have been included here because some of the functions
> in this patch series are dependent upon them.

I don't remember anything contentious in these.

> 
> Patches 5-6 (by David) are posted with this series because they are not
> currently in our master branch. Patches 19 and 20 of this series are
> dependent upon them. I believe David's patches are available in the 
> mainline now.

I don't see them queued yet, but as said, they looked fine to me.

> 
> This patch series works with the v6 QEMU patches. There is no new QEMU
> patchset version yet because there have been no review comments worthy of
> creating a new series; only a couple of extremely minor nits.

Once the kernel part is merged, I'd need a respin anyway due to the
kernel headers updates.
