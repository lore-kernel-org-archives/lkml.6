Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9A7C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48832081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48832081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKBTZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:25:29 -0400
Received: from ozlabs.org ([203.11.71.1]:33231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeKBTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:25:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42mdMX5smPzB4VP;
        Fri,  2 Nov 2018 21:18:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv: remove dead npu-dma code
In-Reply-To: <2c87f9d2-3beb-6c7e-71a4-db8a905f57b1@ozlabs.ru>
References: <20181030133122.GA31102@lst.de> <2c87f9d2-3beb-6c7e-71a4-db8a905f57b1@ozlabs.ru>
Date:   Fri, 02 Nov 2018 21:18:48 +1100
Message-ID: <877ehveq9j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> On 31/10/2018 00:31, Christoph Hellwig wrote:
>> This code has never been unused in the kernel since it was merged, and
>> there has been no attempt that I could find to even submit users for
>> it.  Besides the general policy of not keep 1000+ lines of dead
>> code, it helps cleaning up the DMA code and making powerpc user common
>> infrastructure.
>> 
>> This effectively reverts commit 5d2aa710 ("powerpc/powernv: Add support
>> for Nvlink NPUs").
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
...
>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
>> deleted file mode 100644
>> index 6f60e0931922..000000000000
>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
>> +++ /dev/null
>> @@ -1,989 +0,0 @@
...
>> -int pnv_npu2_init(struct pnv_phb *phb)
>> -{
>> -	unsigned int i;
>> -	u64 mmio_atsd;
>> -	struct device_node *dn;
>> -	struct pci_dev *gpdev;
>> -	static int npu_index;
>> -	uint64_t rc = 0;
>> -
>> -	phb->npu.nmmu_flush =
>> -		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
>> -	for_each_child_of_node(phb->hose->dn, dn) {
>> -		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
>> -		if (gpdev) {
>> -			rc = opal_npu_map_lpar(phb->opal_id,
>> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
>> -				0, 0);
>
> I heavily hacked on these (draft):
> https://patchwork.ozlabs.org/project/kvm-ppc/list/?series=70791
>
> and the result is going to be used for VFIO purposes (draft too):
> https://patchwork.ozlabs.org/project/kvm-ppc/list/?series=70793
>
> Other bits can go away from npu-dma but I still need some to make
> KVM+VFIO work for GPUs, this is without any vendor driver on the host
> side whatsoever.

OK, so to be clear we will need at least some of this code so that a KVM
host can pass through a GPU to a guest, and that requires no binary
driver on the host.

I don't think anyone's arguing that we should prevent passing through
devices that might need a binary driver in a guest?

Christoph I think that establishes that this is not all dead code, and
so I'm nacking this patch in its current form. If you have other
objections to this code please raise them specifically.

I'll merge Alistair's patch to remove the NPU dma_ops, because they're
not really necessary and might legitimately be getting in the way of
dma_ops cleanups.

  https://patchwork.ozlabs.org/patch/990721/


cheers
