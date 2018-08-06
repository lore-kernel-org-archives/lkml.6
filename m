Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97CAC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C34D21A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C34D21A03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbeHFTv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:51:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55122 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732363AbeHFTv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:51:57 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 91BAB133E98F1;
        Mon,  6 Aug 2018 10:41:49 -0700 (PDT)
Date:   Mon, 06 Aug 2018 10:41:48 -0700 (PDT)
Message-Id: <20180806.104148.1576759632957723909.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2] vhost: switch to use new message format
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533525467-17787-1-git-send-email-jasowang@redhat.com>
References: <1533525467-17787-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Aug 2018 10:41:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Aug 2018 11:17:47 +0800

> We use to have message like:
> 
> struct vhost_msg {
> 	int type;
> 	union {
> 		struct vhost_iotlb_msg iotlb;
> 		__u8 padding[64];
> 	};
> };
> 
> Unfortunately, there will be a hole of 32bit in 64bit machine because
> of the alignment. This leads a different formats between 32bit API and
> 64bit API. What's more it will break 32bit program running on 64bit
> machine.
> 
> So fixing this by introducing a new message type with an explicit
> 32bit reserved field after type like:
> 
> struct vhost_msg_v2 {
> 	__u32 type;
> 	__u32 reserved;
> 	union {
> 		struct vhost_iotlb_msg iotlb;
> 		__u8 padding[64];
> 	};
> };
> 
> We will have a consistent ABI after switching to use this. To enable
> this capability, introduce a new ioctl (VHOST_SET_BAKCEND_FEATURE) for
> userspace to enable this feature (VHOST_BACKEND_F_IOTLB_V2).
> 
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - use __u32 instead of int for type

Applied, thanks Jason.
