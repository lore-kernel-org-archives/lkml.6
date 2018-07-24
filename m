Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AABECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80F420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80F420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbeGXCtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:49:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:43787 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388267AbeGXCtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:49:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 18:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="57321336"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2018 18:45:03 -0700
Message-ID: <5B5685A0.9040005@intel.com>
Date:   Tue, 24 Jul 2018 09:49:20 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [PATCH v36 2/5] virtio_balloon: replace oom notifier with shrinker
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com> <1532075585-39067-3-git-send-email-wei.w.wang@intel.com> <20180722174125-mutt-send-email-mst@kernel.org> <5B55AE56.5030404@intel.com> <20180723170826-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180723170826-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 10:13 PM, Michael S. Tsirkin wrote:
>>>    	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>>>    #endif
>>> +	err = virtio_balloon_register_shrinker(vb);
>>> +	if (err)
>>> +		goto out_del_vqs;
>>> So we can get scans before device is ready. Leak will fail
>>> then. Why not register later after device is ready?
>> Probably no.
>>
>> - it would be better not to set device ready when register_shrinker failed.
> That's very rare so I won't be too worried.

Just a little confused with the point here. "very rare" means it still 
could happen (even it's a corner case), and if that happens, we got 
something wrong functionally. So it will be a bug if we change like 
that, right?

Still couldn't understand the reason of changing shrinker_register after 
device_ready (the original oom notifier was registered before setting 
device ready too)?
(I think the driver won't get shrinker_scan called if device isn't ready 
because of the reasons below)

>> - When the device isn't ready, ballooning won't happen, that is,
>> vb->num_pages will be 0, which results in shrinker_count=0 and shrinker_scan
>> won't be called.

Best,
Wei
