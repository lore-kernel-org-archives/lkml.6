Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA07C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDD82172F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDD82172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeI1F6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:58:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeI1F6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00E7A308429C;
        Thu, 27 Sep 2018 23:37:49 +0000 (UTC)
Received: from [10.72.12.26] (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 616D46531E;
        Thu, 27 Sep 2018 23:37:40 +0000 (UTC)
Subject: Re: [PATCH net V2] vhost-vsock: fix use after free
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     stefanha@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergei.shtylyov@cogentembedded.com
References: <20180927122204.4188-1-jasowang@redhat.com>
 <20180927123539-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <588ed28b-7e4b-9dc8-92ce-d75692836c9e@redhat.com>
Date:   Fri, 28 Sep 2018 07:37:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927123539-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 27 Sep 2018 23:37:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月28日 01:04, Michael S. Tsirkin wrote:
> On Thu, Sep 27, 2018 at 08:22:04PM +0800, Jason Wang wrote:
>> The access of vsock is not protected by vhost_vsock_lock. This may
>> lead to use after free since vhost_vsock_dev_release() may free the
>> pointer at the same time.
>>
>> Fix this by holding the lock during the access.
>>
>> Reported-by:syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
>> Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
>> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> Cc: Stefan Hajnoczi<stefanha@redhat.com>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Wow is that really the best we can do?

For net/stable, probably yes.

>   A global lock on a data path
> operation?

It's already there, and the patch only increase the critical section.

>   Granted use after free is nasty but Stefan said he sees
> a way to fix it using a per socket refcount. He's on vacation
> until Oct 4 though ...
>

Stefan has acked the pacth, so I think it's ok? We can do optimization 
for -next on top.

Thanks
