Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C530ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C194320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C194320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbeGXDBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388258AbeGXDBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:01:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D137430820CB;
        Tue, 24 Jul 2018 01:57:11 +0000 (UTC)
Received: from t450s.home (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EB755C1B2;
        Tue, 24 Jul 2018 01:57:11 +0000 (UTC)
Date:   Mon, 23 Jul 2018 19:57:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
Message-ID: <20180723195711.0a3c9301@t450s.home>
In-Reply-To: <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org>
References: <20180724000944.7671.64284.stgit@gimli.home>
        <20180724001310.7671.41243.stgit@gimli.home>
        <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 24 Jul 2018 01:57:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 17:40:02 -0700
Sinan Kaya <okaya@kernel.org> wrote:

> On 7/23/2018 5:13 PM, Alex Williamson wrote:
> > + * The NVMe specification requires that controllers support PCIe FLR, but
> > + * but some Samsung SM961/PM961 controllers fail to recover after FLR (-1
> > + * config space) unless the device is quiesced prior to FLR.  
> 
> Does disabling the memory bit in PCI config space as part of the FLR 
> reset function help? (like the very first thing)

No, it does not.  I modified this to only clear PCI_COMMAND_MEMORY and
call pcie_flr(), the Samsung controller dies just as it did previously.
 
> Can we do that in the pcie_flr() function to cover other endpoint types
> that might be pushing traffic while code is trying to do a reset?

Do you mean PCI_COMMAND_MASTER rather than PCI_COMMAND_MEMORY?  I tried
that too, it doesn't work either.  I'm not really sure the theory
behind clearing memory, clearing busmaster to stop DMA seems like a
sane thing to do, but doesn't help here.  Thanks,

Alex
