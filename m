Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F31AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB9A20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mDJkdEfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB9A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933111AbeGIMU1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:20:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45172 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932568AbeGIMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:20:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180709122021euoutp01e282760870f44ffe222008d334bc979e~-sqVHXZbQ1571315713euoutp01M
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 12:20:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180709122021euoutp01e282760870f44ffe222008d334bc979e~-sqVHXZbQ1571315713euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531138821;
        bh=whz87mZnu8NLoIWUOG1U6U3lEHR8oObc1H4zc92J0ZQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mDJkdEfktu1mQ0e63K+qZrCoSwmD+RSuo9+f16h3JgZMH57C2isrIS4UOWVU6Q1Ti
         9aXskU3lWpM87iKgjeq8Gk6rjSuVBZbAQ9Yu9hPSEEMCmnuAjt9AYx0ig3RKr+8Nxc
         7+VyNb3fVRAj5UplkLyH/F3DkzNo8Hc36Ep/JNkk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180709122019eucas1p21b61aa98d0d414aa5f01ca98531698b7~-sqTR0Jag2939229392eucas1p2k;
        Mon,  9 Jul 2018 12:20:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A2.58.05700.203534B5; Mon,  9
        Jul 2018 13:20:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180709122018eucas1p277147b1e6385d552b5a8930d0a8ba91c~-sqSan6292733527335eucas1p2-;
        Mon,  9 Jul 2018 12:20:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180709122018eusmtrp2d4971074a724b1c147a693a10b855790~-sqSKxyg20663106631eusmtrp2J;
        Mon,  9 Jul 2018 12:20:18 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-cc-5b435302eedc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.CF.04183.103534B5; Mon,  9
        Jul 2018 13:20:18 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.116.147.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180709122017eusmtip2d9b78627a3393e5bd59cc83a90b1303b~-sqRQHOWq1868718687eusmtip2I;
        Mon,  9 Jul 2018 12:20:17 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 0/2] CMA: remove unsupported gfp mask parameter
Date:   Mon,  9 Jul 2018 14:19:54 +0200
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUhTcRzv997eobR4LbMfGRWLsoIyoeJHhVpJ/Iig648Ou1Y+tHQeW1M7
        sHlkOUXEzMzMC3NOzcpSzAzbOtYhHlNmUavMRamZx9QUS/P5Ov77XN/fhw/8WFI2Ss1lj4ec
        5FUhimA57SypejbauILYvdlvVUzaBpR9q4xGfbHnSdRblAxQUoGeRobSpwQyJMXRKK9uPUq8
        dptBhtoRAg22thOoosNKoZaabBq9L5ugkOnyQ4DGfoxT6OYTG4M+pPigPHM8ha5nj9DI2Gen
        kKMhgUEvbQ4GXYtJAaiz/7nEB2K7MYfAZTllALdYm0ls/GSicfK3eApXDKQxWNfTSuB31loa
        P88ck+C7hefw2/EOEl96rQe4MTMf4AdvtDQu/9lFYIOlmdnhut95gz8ffDyCV3l4HXEOTBp+
        QoRlSKMaOvZpQbGTDrAs5FZDff0iHXBmZVwxgA1t7YRIBgGsv/GWEYkDwK53esnfi4a+XaKu
        B7C97gopkiEAa20PJy+cWJrzhLoeHS0YLlwugB+NsZRASM5Owa8TuqnULM4bDl+1AQFLuMUw
        p7+bEjDkFsDS24+mnoVcPgvTbJ8JwZByEbCj6DsQQ74wrqWZEfEs2GW+9wfPgxP3cwnxOA7A
        C5lZjEiSAazMrqbF1Hr42NxMCYtIbhm8VeMhyhthlcFBiENnwNc9MwWZnIRpVcJOQZbCiwky
        Mb0EZpnL/9UamyykiDFMSL87VSTjDsL4FxYiFczP+t+VB0AJmMNr1MoAXu0ZwkeuVCuUak1I
        wMpjocoKMPkhX42bB6rBkOWoCXAskE+X9oVv8pNRigj1KaUJQJaUu0gV6yYlqb/i1GleFXpY
        pQnm1Sbgxkrkc6SHlkbvl3EBipN8EM+H8aq/LsE6zdWCtUqrNf1Q+Jemgj3XA8YKP25PLXH3
        AR41n0tPR8fH3NFuY8rdB70Ld0V+1ZiV95QjBdMyAuO0804kSiOnbXVbtHON3TLUXXIgSBVs
        Nzf1lkRVtne6tGVF5TqqF0brOOrRzjONXuYtZ1sXz1bV+cZoKNdoQw/fZnBLTt+7vG3mxl9y
        iTpQ4bmcVKkVvwGAkgi2jAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7pMwc7RBp9PMVrMWb+GzeJDUyuz
        xftlPYwW3YuWs1msXH2UyWJldzObxYL91hadszewW6zc84PJ4suVh0wWmx5fY7W4vGsOm8W9
        Nf9ZLQ5N3cto8fv7P1aLtUfuslvc73OwWHC8hdVi7pwfbBYHPzxhtfh8ro3d4tTdz+wWsxv7
        GC1efjzB4iDh8eTgPCaPNfPWMHpcvnaR2ePgo0NsHj1vWlg9Nn2axO7R9fYKk8eda3vYPE7M
        +M3isXlJvcftf4+ZPSbfWM7ocX7GQkaP3Tcb2DzW/XnF5LHy0kX2ALEoPZui/NKSVIWM/OIS
        W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzub0eYCqbxVpx7HNnAuIKz
        i5GDQ0LAROLch6AuRi4OIYGljBI9vbeZuxg5geIyEienNbBC2MISf651sUEUfWaUWN9/DCzB
        JmAo0fUWIiEisJhR4tP/i6wgDrPAN1aJx7NmsIBUCQvYS3ybeZcRxGYRUJWY9/E1WDevgK3E
        sj9tTBAr5CVWbzjAPIGRZwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAyNx27OeWHYxd
        74IPMQpwMCrx8H4odIoWYk0sK67MPcQowcGsJMKbaAUU4k1JrKxKLcqPLyrNSS0+xGgKtHwi
        s5Rocj4waeSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamCc1Cwv
        22Ih9urZVt6J8/dePTbjYJjFpBucbN1eLgwi+fOk06/V6mj+XNibP3NC5F8Z/zSnVbf3iHaE
        HNLVq9iy2+GVTeyqb5+OzV+auu5+zPQWxaNhoQGl/zuZm18J8AV76xy5ZN7O8Oz5nKKSGcqO
        pibcj3/GNdyU3n/SU3/RFkmjHTE7nOuUWIozEg21mIuKEwGpF60V4gIAAA==
Message-Id: <20180709122018eucas1p277147b1e6385d552b5a8930d0a8ba91c~-sqSan6292733527335eucas1p2-@eucas1p2.samsung.com>
X-CMS-MailID: 20180709122018eucas1p277147b1e6385d552b5a8930d0a8ba91c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180709122018eucas1p277147b1e6385d552b5a8930d0a8ba91c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709122018eucas1p277147b1e6385d552b5a8930d0a8ba91c
References: <CGME20180709122018eucas1p277147b1e6385d552b5a8930d0a8ba91c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

The CMA related functions cma_alloc() and dma_alloc_from_contiguous()
have gfp mask parameter, but sadly they only support __GFP_NOWARN flag.
This gave their users a misleading feeling that any standard memory
allocation flags are supported, what resulted in the security issue when
caller have set __GFP_ZERO flag and expected the buffer to be cleared.

This patchset changes gfp_mask parameter to a simple boolean no_warn
argument, which covers all the underlaying code supports.

This patchset is a result of the following discussion:
https://patchwork.kernel.org/patch/10461919/

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (2):
  mm/cma: remove unsupported gfp_mask parameter from cma_alloc()
  dma: remove unsupported gfp_mask parameter from
    dma_alloc_from_contiguous()

 arch/arm/mm/dma-mapping.c                  | 5 +++--
 arch/arm64/mm/dma-mapping.c                | 4 ++--
 arch/powerpc/kvm/book3s_hv_builtin.c       | 2 +-
 arch/xtensa/kernel/pci-dma.c               | 2 +-
 drivers/iommu/amd_iommu.c                  | 2 +-
 drivers/iommu/intel-iommu.c                | 3 ++-
 drivers/s390/char/vmcp.c                   | 2 +-
 drivers/staging/android/ion/ion_cma_heap.c | 2 +-
 include/linux/cma.h                        | 2 +-
 include/linux/dma-contiguous.h             | 4 ++--
 kernel/dma/contiguous.c                    | 6 +++---
 kernel/dma/direct.c                        | 3 ++-
 mm/cma.c                                   | 8 ++++----
 mm/cma_debug.c                             | 2 +-
 14 files changed, 25 insertions(+), 22 deletions(-)

-- 
2.17.1

