Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E405C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DE82172B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DE82172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeHFMBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:01:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:26735 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeHFMBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:01:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 02:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="78850469"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2018 02:51:53 -0700
Message-ID: <5B681B41.6070205@intel.com>
Date:   Mon, 06 Aug 2018 17:56:17 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com> <1533285146-25212-3-git-send-email-wei.w.wang@intel.com> <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
In-Reply-To: <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 08:11 PM, Tetsuo Handa wrote:
> On 2018/08/03 17:32, Wei Wang wrote:
>> +static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>> +{
>> +	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
>> +	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
>> +	vb->shrinker.batch = 0;
>> +	vb->shrinker.seeks = DEFAULT_SEEKS;
> Why flags field is not set? If vb is allocated by kmalloc(GFP_KERNEL)
> and is nowhere zero-cleared, KASAN would complain it.

Could you point where in the code that would complain it?
I only see two shrinker flags (NUMA_AWARE and MEMCG_AWARE), and they 
seem not related to that.


Best,
Wei
