Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC6EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F5F2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F5F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbeHAMxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:53:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:16904 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387592AbeHAMxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:53:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 04:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,431,1526367600"; 
   d="scan'208";a="71677732"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2018 04:08:04 -0700
Message-ID: <5B619599.1000307@intel.com>
Date:   Wed, 01 Aug 2018 19:12:25 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Michal Hocko <mhocko@kernel.org>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com> <1532683495-31974-3-git-send-email-wei.w.wang@intel.com> <20180730090041.GC24267@dhcp22.suse.cz>
In-Reply-To: <20180730090041.GC24267@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 05:00 PM, Michal Hocko wrote:
> On Fri 27-07-18 17:24:55, Wei Wang wrote:
>> The OOM notifier is getting deprecated to use for the reasons mentioned
>> here by Michal Hocko: https://lkml.org/lkml/2018/7/12/314
>>
>> This patch replaces the virtio-balloon oom notifier with a shrinker
>> to release balloon pages on memory pressure.
> It would be great to document the replacement. This is not a small
> change...

OK. I plan to document the following to the commit log:

   The OOM notifier is getting deprecated to use for the reasons:
     - As a callout from the oom context, it is too subtle and easy to
       generate bugs and corner cases which are hard to track;
     - It is called too late (after the reclaiming has been performed).
       Drivers with large amuont of reclaimable memory is expected to be
       released them at an early age of memory pressure;
     - The notifier callback isn't aware of the oom contrains;
     Link: https://lkml.org/lkml/2018/7/12/314

     This patch replaces the virtio-balloon oom notifier with a shrinker
     to release balloon pages on memory pressure. Users can set the 
amount of
     memory pages to release each time a shrinker_scan is called via the
     module parameter balloon_pages_to_shrink, and the default amount is 256
     pages. Historically, the feature VIRTIO_BALLOON_F_DEFLATE_ON_OOM has
     been used to release balloon pages on OOM. We continue to use this
     feature bit for the shrinker, so the shrinker is only registered when
     this feature bit has been negotiated with host.

     In addition, the bug in the replaced virtballoon_oom_notify that only
     VIRTIO_BALLOON_ARRAY_PFNS_MAX (i.e 256) balloon pages can be freed
     though the user has specified more than that number is fixed in the
     shrinker_scan function.


Best,
Wei
