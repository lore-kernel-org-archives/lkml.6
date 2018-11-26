Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6EB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6EB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeKZOpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:45:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeKZOpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:45:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F2C9394D4F;
        Mon, 26 Nov 2018 03:52:16 +0000 (UTC)
Received: from [10.72.12.50] (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB0B1974D;
        Mon, 26 Nov 2018 03:52:10 +0000 (UTC)
Subject: Re: [PATCH net-next 2/3] vhost_net: support in order feature
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181123030016.4924-1-jasowang@redhat.com>
 <20181123030016.4924-3-jasowang@redhat.com>
 <20181123104333-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1c50dc69-49d5-0d19-dea9-4c97a2d99b5f@redhat.com>
Date:   Mon, 26 Nov 2018 11:52:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123104333-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 26 Nov 2018 03:52:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/23 下午11:49, Michael S. Tsirkin wrote:
> On Fri, Nov 23, 2018 at 11:00:15AM +0800, Jason Wang wrote:
>> This makes vhost_net to support in order feature. This is as simple as
>> use datacopy path when it was negotiated. An alternative is not to
>> advertise in order when zerocopy is enabled which tends to be
>> suboptimal consider zerocopy may suffer from e.g HOL issues.
> Well IIRC vhost_zerocopy_signal_used is used to
> actually reorder used ring to match available ring.
> So with a big comment explaining why it is so,
> we could just enable IN_ORDER there too.
>

The problem is we allow switching between zerocopy and datacopy.

And what's more important, if we allow in order for zerocopy, a single 
packet delay may hang all the rest.

Thanks

