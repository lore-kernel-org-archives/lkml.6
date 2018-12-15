Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8448DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF062084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbeLOTnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:43:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54146 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLOTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:43:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3468914E8B31D;
        Sat, 15 Dec 2018 11:43:09 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:43:08 -0800 (PST)
Message-Id: <20181215.114308.647436101869587689.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <836932fc-9266-b73d-2ee5-645f399e1a54@redhat.com>
References: <20181213101022.12475-1-jasowang@redhat.com>
        <20181213144116-mutt-send-email-mst@kernel.org>
        <836932fc-9266-b73d-2ee5-645f399e1a54@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 11:43:09 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Dec 2018 12:29:54 +0800

> 
> On 2018/12/14 上午4:12, Michael S. Tsirkin wrote:
>> On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
>>> Hi:
>>>
>>> This series tries to access virtqueue metadata through kernel virtual
>>> address instead of copy_user() friends since they had too much
>>> overheads like checks, spec barriers or even hardware feature
>>> toggling.
>>>
>>> Test shows about 24% improvement on TX PPS. It should benefit other
>>> cases as well.
>>>
>>> Please review
>> I think the idea of speeding up userspace access is a good one.
>> However I think that moving all checks to start is way too aggressive.
> 
> 
> So did packet and AF_XDP. Anyway, sharing address space and access
> them directly is the fastest way. Performance is the major
> consideration for people to choose backend. Compare to userspace
> implementation, vhost does not have security advantages at any
> level. If vhost is still slow, people will start to develop backends
> based on e.g AF_XDP.

Exactly, this is precisely how this kind of problem should be solved.

Michael, I strongly support the approach Jason is taking here, and I
would like to ask you to seriously reconsider your objections.

Thank you.
