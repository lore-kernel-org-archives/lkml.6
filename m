Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D21EC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 04:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F57F245BC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 04:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F57F245BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbeF3E1e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 00:27:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:9423 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeF3E1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 00:27:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 21:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,289,1526367600"; 
   d="scan'208";a="68963916"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga001.jf.intel.com with ESMTP; 29 Jun 2018 21:27:15 -0700
Message-ID: <5B370797.1090700@intel.com>
Date:   Sat, 30 Jun 2018 12:31:19 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
CC:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 08:05 PM, Wei Wang wrote:
> This patch series is separated from the previous "Virtio-balloon
> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
> implemented by this series enables the virtio-balloon driver to report
> hints of guest free pages to the host. It can be used to accelerate live
> migration of VMs. Here is an introduction of this usage:
>
> Live migration needs to transfer the VM's memory from the source machine
> to the destination round by round. For the 1st round, all the VM's memory
> is transferred. From the 2nd round, only the pieces of memory that were
> written by the guest (after the 1st round) are transferred. One method
> that is popularly used by the hypervisor to track which part of memory is
> written is to write-protect all the guest memory.
>
> This feature enables the optimization by skipping the transfer of guest
> free pages during VM live migration. It is not concerned that the memory
> pages are used after they are given to the hypervisor as a hint of the
> free pages, because they will be tracked by the hypervisor and transferred
> in the subsequent round if they are used and written.
>
> * Tests
> - Test Environment
>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>      Guest: 8G RAM, 4 vCPU
>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
>
> - Test Results
>      - Idle Guest Live Migration Time (results are averaged over 10 runs):
>          - Optimization v.s. Legacy = 284ms vs 1757ms --> ~84% reduction

According to Michael's comments, add one more set of data here:

Enabling page poison with value=0, and enable KSM.

The legacy live migration time is 1806ms (averaged across 10 runs), 
compared to the case with this optimization feature in use (i.e. 284ms), 
there is still around ~84% reduction.


Best,
Wei
