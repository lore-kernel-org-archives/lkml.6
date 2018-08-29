Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07109C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BBE2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BBE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeH2TMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:12:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728442AbeH2TMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:12:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A142B5CB;
        Wed, 29 Aug 2018 15:14:39 +0000 (UTC)
Received: from flask (unknown [10.40.205.185])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9543210EE838;
        Wed, 29 Aug 2018 15:14:34 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 29 Aug 2018 17:14:33 +0200
Date:   Wed, 29 Aug 2018 17:14:33 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wanpeng.li@hotmail.com
Subject: Re: [PATCH V3 1/2] kvm/x86 : add coalesced pio support
Message-ID: <20180829151432.GA19487@flask>
References: <1535109632-59745-1-git-send-email-peng.hao2@zte.com.cn>
 <1535109632-59745-2-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535109632-59745-2-git-send-email-peng.hao2@zte.com.cn>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 15:14:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 15:14:39 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-24 19:20+0800, Peng Hao:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  include/uapi/linux/kvm.h  | 5 +++--
>  virt/kvm/coalesced_mmio.c | 8 +++++---
>  virt/kvm/kvm_main.c       | 2 ++
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index b6270a3..9cc56d3 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -420,13 +420,13 @@ struct kvm_run {
>  struct kvm_coalesced_mmio_zone {
>  	__u64 addr;
>  	__u32 size;
> -	__u32 pad;
> +	__u32 pio;

I would prefer to have this as a slightly more compatible

	union {
		__u32 pad;
		__u32 pio;
	};

>  };
>  
>  struct kvm_coalesced_mmio {
>  	__u64 phys_addr;
>  	__u32 len;
> -	__u32 pad;
> +	__u32 pio;

Also, please add a check that "pio <= 1".

This would catch most cases where userspace passed garbage in that field
and we'd also make the remaining bits available for future features.

Thanks.
