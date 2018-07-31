Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D49C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B92208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B92208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGaRQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:16:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:4743 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732013AbeGaRQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:16:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 08:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="249915686"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.255.77.135]) ([10.255.77.135])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2018 08:35:59 -0700
Subject: Re: [PATCH v3 0/6] kaddr and pfn can be NULL to ->direct_access()
To:     Huaisheng Ye <yehs2007@zoho.com>, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk,
        martin.petersen@oracle.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.cz,
        agk@redhat.com, snitzer@redhat.com, keescook@chromium.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        colyli@suse.de, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
References: <20180730071548.9172-1-yehs2007@zoho.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <d39a623d-5071-731b-87ae-9f9bd11024c6@intel.com>
Date:   Tue, 31 Jul 2018 08:35:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180730071548.9172-1-yehs2007@zoho.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/2018 12:15 AM, Huaisheng Ye wrote:

Applied
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> Changes since v2 [2]:
> * Collect Martin and Mike's acks for dcssblk and dm-writecache;
> * Rebase the series of patch to v4.18-rc7.
>
> Changes since v1 [1]:
> * Involve the previous patches for pfn can be NULL.
> * Reword the patch descriptions according to Christian's comment.
> * According to Ross's suggestion, replace local pointer dummy_addr
>    with NULL within md/dm-writecache for direct_access.
>
> [1]: https://lkml.org/lkml/2018/7/24/199
> [2]: https://lkml.org/lkml/2018/7/25/581
>
> Some functions within fs/dax, dax/super and md/dm-writecache don't
> need to get local pointer kaddr or variable pfn from direct_access.
> Assigning NULL to kaddr or pfn with ->direct_access() is more
> straightforward and simple than offering a useless local pointer or
> variable.
>
> So all ->direct_access() need to check the validity of pointer kaddr
> and pfn for NULL assignment. If either of them is equal to NULL, that
> is to say callers may have no need for kaddr or pfn, so this series of
> patch are prepared for allowing them to pass in NULL instead of having
> to pass in a local pointer or variable that they then just throw away.
>
> Huaisheng Ye (6):
>    libnvdimm, pmem: kaddr and pfn can be NULL to ->direct_access()
>    s390, dcssblk: kaddr and pfn can be NULL to ->direct_access()
>    tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()
>    dax/super: Do not request a pointer kaddr when not required
>    md/dm-writecache: Don't request pointer dummy_addr when not required
>    filesystem-dax: Do not request kaddr and pfn when not required
>
>   drivers/dax/super.c             |  3 +--
>   drivers/md/dm-writecache.c      |  3 +--
>   drivers/nvdimm/pmem.c           |  7 +++++--
>   drivers/s390/block/dcssblk.c    |  8 +++++---
>   fs/dax.c                        | 13 ++++---------
>   tools/testing/nvdimm/pmem-dax.c | 12 ++++++++----
>   6 files changed, 24 insertions(+), 22 deletions(-)
>
