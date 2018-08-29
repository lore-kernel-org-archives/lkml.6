Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B202F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B202F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeH2Mm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:42:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeH2MmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF07D9BA9A;
        Wed, 29 Aug 2018 08:46:34 +0000 (UTC)
Received: from ming.t460p (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A14BE1054E75;
        Wed, 29 Aug 2018 08:46:24 +0000 (UTC)
Date:   Wed, 29 Aug 2018 16:46:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     tglx@linutronix.de, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: Affinity managed interrupts vs non-managed interrupts
Message-ID: <20180829084618.GA24765@ming.t460p>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 08:46:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 08:46:34 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sumit,

On Tue, Aug 28, 2018 at 12:04:52PM +0530, Sumit Saxena wrote:
>  Affinity managed interrupts vs non-managed interrupts
> 
> Hi Thomas,
> 
> We are working on next generation MegaRAID product where requirement is- to
> allocate additional 16 MSI-x vectors in addition to number of MSI-x vectors
> megaraid_sas driver usually allocates.  MegaRAID adapter supports 128 MSI-x
> vectors.
> 
> To explain the requirement and solution, consider that we have 2 socket
> system (each socket having 36 logical CPUs). Current driver will allocate
> total 72 MSI-x vectors by calling API- pci_alloc_irq_vectors(with flag-
> PCI_IRQ_AFFINITY).  All 72 MSI-x vectors will have affinity across NUMA node
> s and interrupts are affinity managed.
> 
> If driver calls- pci_alloc_irq_vectors_affinity() with pre_vectors = 16
> and, driver can allocate 16 + 72 MSI-x vectors.

Could you explain a bit what the specific use case the extra 16 vectors
is?

> 
> All pre_vectors (16) will be mapped to all available online CPUs but e
> ffective affinity of each vector is to CPU 0. Our requirement is to have pre
> _vectors 16 reply queues to be mapped to local NUMA node with
> effective CPU should
> be spread within local node cpu mask. Without changing kernel code, we can

If all CPUs in one NUMA node is offline, can this use case work as expected?
Seems we have to understand what the use case is and how it works.


Thanks,
Ming
