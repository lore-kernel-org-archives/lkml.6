Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E49ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7462064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7462064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJJBJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJJBJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 324DA30DF6F9;
        Tue,  9 Oct 2018 17:51:03 +0000 (UTC)
Received: from gondolin (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D86C378576;
        Tue,  9 Oct 2018 17:51:00 +0000 (UTC)
Date:   Tue, 9 Oct 2018 19:50:57 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Filippo Sironi <sironi@amazon.de>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        vasu.srinivasan@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] KVM: Start populating /sys/hypervisor with KVM entries
Message-ID: <20181009195057.2dc8fd7b.cohuck@redhat.com>
In-Reply-To: <61740f41-c7e3-edaf-68ac-2e4c4a99523b@oracle.com>
References: <1539078879-4372-1-git-send-email-sironi@amazon.de>
        <c81b65ba-c562-1869-483b-aee5229501e0@de.ibm.com>
        <61740f41-c7e3-edaf-68ac-2e4c4a99523b@oracle.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 09 Oct 2018 17:51:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 12:21:46 -0400
Boris Ostrovsky <boris.ostrovsky@oracle.com> wrote:

> On 10/9/18 6:41 AM, Christian Borntraeger wrote:
> > 
> > 
> > On 10/09/2018 11:54 AM, Filippo Sironi wrote:  
> >> Start populating /sys/hypervisor with KVM entries when we're running on
> >> KVM. This is to replicate functionality that's available when we're
> >> running on Xen.
> >>
> >> Let's start with /sys/hypervisor/uuid, which users prefer over
> >> /sys/devices/virtual/dmi/id/product_uuid as a way to recognize a virtual
> >> machine, since it's also available when running on Xen HVM and on Xen PV
> >> and, on top of that doesn't require root privileges by default.  
> > 
> > Can you make this an arch hook? On s390 it is possible to get the uuid with
> > the stsi instruction. 
> > See
> > https://git.kernel.org/pub/scm/virt/kvm/kvm.git/tree/arch/s390/kernel/sysinfo.c#n248
> > 
> > 
> > We do use uuid_t, but we can certainly return a char*.  
> 
> 
> I would suggest having a top-level sys-hypervisor.c that will create
> common files that all hypervisors should have (uuid, type, version, etc)
> and then have hypervisor- and/or arch-specific hooks.

I think we really need *both* hypervisor- and arch-specific hooks.
