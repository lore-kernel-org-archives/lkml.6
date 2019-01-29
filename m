Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE6C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7557521738
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfA2Cez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:34:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfA2Cez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 21:34:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CABC5F797;
        Tue, 29 Jan 2019 02:34:55 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA9E760BE8;
        Tue, 29 Jan 2019 02:34:48 +0000 (UTC)
Subject: Re: [PATCH net-next V4 0/5] vhost: accelerate metadata access through
 vmap()
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Miller <davem@davemloft.net>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20190123095557.30168-1-jasowang@redhat.com>
 <20190126.143708.1203048880266877709.davem@davemloft.net>
 <20190126193126-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e6f97f48-0fcb-9bea-1603-c6d93f83b3a8@redhat.com>
Date:   Tue, 29 Jan 2019 10:34:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126193126-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 29 Jan 2019 02:34:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/27 上午8:31, Michael S. Tsirkin wrote:
> On Sat, Jan 26, 2019 at 02:37:08PM -0800, David Miller wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Wed, 23 Jan 2019 17:55:52 +0800
>>
>>> This series tries to access virtqueue metadata through kernel virtual
>>> address instead of copy_user() friends since they had too much
>>> overheads like checks, spec barriers or even hardware feature
>>> toggling.
>>>
>>> Test shows about 24% improvement on TX PPS. It should benefit other
>>> cases as well.
>> I've read over the discussion of patch #5 a few times.
>>
>> And it seems to me that, at a minimum, a few things still need to
>> be resolved:
>>
>> 1) More perf data added to commit message.


Ok.


>>
>> 2) Whether invalidate_range_start() and invalidate_range_end() must
>>     be paired.


The reason that vhost doesn't need an invalidate_range_end() is because 
we have a fallback to copy_to_user() friends. So there's no requirement 
to setup the mapping in range_end() or lock the vq between range_start() 
and range_end(). We try to delay the setup of vmap until it will be 
really used in vhost_meta_prefetch() and we hold mmap_sem when trying to 
setup vmap, this will guarantee there's no intermediate state at this time.


>
> Add dirty tracking.


I think this could be solved by introducing e.g 
vhost_meta_prefetch_done() at the end of handle_tx()/handle_rx() and 
call set_page_dirty() for used pages instead of the tricks of 
classifying VMA. (As I saw hugetlbfs has its own set dirty method).

Thanks


>
>> Etc.  So I am marking this series "Changes Requested".
