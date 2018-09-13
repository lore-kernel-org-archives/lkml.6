Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36718C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C620866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0C620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeIMO42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41379 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbeIMO41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:56:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B516811B7;
        Thu, 13 Sep 2018 09:47:44 +0000 (UTC)
Received: from [10.72.12.62] (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3771608EC;
        Thu, 13 Sep 2018 09:47:31 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
To:     Tiwei Bie <tiwei.bie@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180827170005-mutt-send-email-mst@kernel.org>
 <20180907012225.GA32677@debian>
 <20180907084509-mutt-send-email-mst@kernel.org>
 <20180910030053.GA15645@debian>
 <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
 <20180912121457-mutt-send-email-mst@kernel.org>
 <20180913085919.GA42049@fbsd1.sh.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
Date:   Thu, 13 Sep 2018 17:47:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913085919.GA42049@fbsd1.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Sep 2018 09:47:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月13日 16:59, Tiwei Bie wrote:
>> If what you say is true then we should take a careful look
>> and not supporting these generic things with packed layout.
>> Once we do support them it will be too late and we won't
>> be able to get performance back.
> I think it's a good point that we don't need to support
> everything in packed ring (especially these which would
> hurt the performance), as the packed ring aims at high
> performance. I'm also wondering about the features. Is
> there any possibility that we won't support the out of
> order processing (at least not by default) in packed ring?
> If I didn't miss anything, the need to support out of order
> processing in packed ring will make the data structure
> inside the driver not cache friendly which is similar to
> the case of the descriptor table in the split ring (the
> difference is that, it only happens in driver now).

Out of order is not the only user, DMA is another one. We don't have 
used ring(len), so we need to maintain buffer length somewhere even for 
in order device. But if it's not too late, I second for a OUT_OF_ORDER 
feature. Starting from in order can have much simpler code in driver.

Thanks

