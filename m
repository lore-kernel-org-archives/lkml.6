Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F9DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DE2218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EZQrmNGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfBKWBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:01:13 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11285 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfBKWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:01:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c61f0850002>; Mon, 11 Feb 2019 14:00:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 14:01:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 14:01:12 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 22:01:11 +0000
Subject: Re: [PATCH 2/3] mm/gup: Introduce get_user_pages_fast_longterm()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>, <netdev@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211201643.7599-3-ira.weiny@intel.com> <20190211203916.GA2771@ziepe.ca>
 <bcc03ee1-4c42-48c3-bc67-942c0f04875e@nvidia.com>
 <20190211212652.GA7790@iweiny-DESK2.sc.intel.com>
 <fc9c880b-24f8-7063-6094-00175bc27f7d@nvidia.com>
 <20190211215238.GA23825@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f392756e-f885-e32e-77a9-d3a51689bee0@nvidia.com>
Date:   Mon, 11 Feb 2019 14:01:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211215238.GA23825@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549922438; bh=vWs2aKXh4VkvG7WO8haiJ5PzQmL2tFLJDsIxpuuhupo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EZQrmNGEqpt0sljknlDD5qDlmVF+KBcIX1F9PjPhl1qC3uyH76fvnqkaxSFw8QeFl
         tNUm1VP4uk1PJDLX9jOZ49OA00wchP3s8+oAfLb+KGzX20/vXDU7FEpbLmMdwF0umt
         uXq1LTcC5dbPzJBXMHz7UN1qZrTsDZQhV6n6hq+Xtozit/Y+gfpqTlgGuqWmJxoape
         2RbUjashm8TFMTMfSmdQZ/D5QzO3aaX9CB1SzVlUWoWsWOcysXLS/+8mwvJsrnKBLM
         sP9qgYuiorn9eS3zZkbff50xGSijAGyoiPxkSROf9nIPMLSb5T1O/uL854sjh/f9p+
         oD9g8x5lI235Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 1:52 PM, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 01:39:12PM -0800, John Hubbard wrote:
>> On 2/11/19 1:26 PM, Ira Weiny wrote:
>>> On Mon, Feb 11, 2019 at 01:13:56PM -0800, John Hubbard wrote:
>>>> On 2/11/19 12:39 PM, Jason Gunthorpe wrote:
>>>>> On Mon, Feb 11, 2019 at 12:16:42PM -0800, ira.weiny@intel.com wrote:
>>>>>> From: Ira Weiny <ira.weiny@intel.com>
>>>> [...]
> Fair enough.   But to do that correctly I think we will need to convert
> get_user_pages_fast() to use flags as well.  I have a version of this series
> which includes a patch does this, but the patch touched a lot of subsystems and
> a couple of different architectures...[1]
> 
> I can't test them all.  If we want to go that way I'm up for submitting the

I have a similar problem, and a similar list of call sites, for the
put_user_pages() conversion, so that file list looks familiar. And the
arch-specific gup implementations are about to complicate my life too. :)

> patch...  But if we remove longterm in the future we may be left with a
> get_user_pages_fast() which really only needs 1 flag.  But perhaps overall we
> would be better off?
> 
> Ira

I certainly think so, yes.


thanks,
-- 
John Hubbard
NVIDIA
> 
> 
> [1] mm/gup.c: Change GUP fast to use flags rather than write bool
> 
> To facilitate additional options to get_user_pages_fast change the
> singular write parameter to be the more generic gup_flags.
> 
> This patch currently does not change any functionality.  New
> functionality will follow in subsequent patches.
> 
> Many of the get_user_pages_fast call sites were unchanged because they
> already used FOLL_WRITE or 0 as appropriate.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  arch/mips/mm/gup.c                         | 11 ++++++-----
>  arch/powerpc/kvm/book3s_64_mmu_hv.c        |  4 ++--
>  arch/powerpc/kvm/e500_mmu.c                |  2 +-
>  arch/powerpc/mm/mmu_context_iommu.c        |  4 ++--
>  arch/s390/kvm/interrupt.c                  |  2 +-
>  arch/s390/mm/gup.c                         | 12 ++++++------
>  arch/sh/mm/gup.c                           | 11 ++++++-----
>  arch/sparc/mm/gup.c                        |  9 +++++----
>  arch/x86/kvm/paging_tmpl.h                 |  2 +-
>  arch/x86/kvm/svm.c                         |  2 +-
>  drivers/fpga/dfl-afu-dma-region.c          |  2 +-
>  drivers/gpu/drm/via/via_dmablit.c          |  3 ++-
>  drivers/infiniband/hw/hfi1/user_pages.c    |  3 ++-
>  drivers/misc/genwqe/card_utils.c           |  2 +-
>  drivers/misc/vmw_vmci/vmci_host.c          |  2 +-
>  drivers/misc/vmw_vmci/vmci_queue_pair.c    |  6 ++++--
>  drivers/platform/goldfish/goldfish_pipe.c  |  3 ++-
>  drivers/rapidio/devices/rio_mport_cdev.c   |  4 +++-
>  drivers/sbus/char/oradax.c                 |  2 +-
>  drivers/scsi/st.c                          |  3 ++-
>  drivers/staging/gasket/gasket_page_table.c |  4 ++--
>  drivers/tee/tee_shm.c                      |  2 +-
>  drivers/vfio/vfio_iommu_spapr_tce.c        |  3 ++-
>  drivers/vhost/vhost.c                      |  2 +-
>  drivers/video/fbdev/pvr2fb.c               |  2 +-
>  drivers/virt/fsl_hypervisor.c              |  2 +-
>  drivers/xen/gntdev.c                       |  2 +-
>  fs/orangefs/orangefs-bufmap.c              |  2 +-
>  include/linux/mm.h                         |  4 ++--
>  kernel/futex.c                             |  2 +-
>  lib/iov_iter.c                             |  7 +++++--
>  mm/gup.c                                   | 10 +++++-----
>  mm/util.c                                  |  8 ++++----
>  net/ceph/pagevec.c                         |  2 +-
>  net/rds/info.c                             |  2 +-
>  net/rds/rdma.c                             |  3 ++-
>  36 files changed, 81 insertions(+), 65 deletions(-)
> 
> 
