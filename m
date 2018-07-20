Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E220647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4E220647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbeGTRiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:38:11 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:41198 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGTRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:38:11 -0400
X-IronPort-AV: E=Sophos;i="5.51,380,1526342400"; 
   d="scan'208";a="60748126"
Subject: Re: [PATCH net-next] xen-netfront: fix queue name setting
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, <netdev@vger.kernel.org>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
References: <20180720163359.28187-1-vkuznets@redhat.com>
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <566f2c29-a7c0-efee-444c-c51a632bfeee@citrix.com>
Date:   Fri, 20 Jul 2018 17:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180720163359.28187-1-vkuznets@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 05:33 PM, Vitaly Kuznetsov wrote:
> Commit f599c64fdf7d ("xen-netfront: Fix race between device setup and
> open") changed the initialization order: xennet_create_queues() now
> happens before we do register_netdev() so using netdev->name in
> xennet_init_queue() is incorrect, we end up with the following in
> /proc/interrupts:
> 
>   60:        139          0   xen-dyn    -event     eth%d-q0-tx
>   61:        265          0   xen-dyn    -event     eth%d-q0-rx
>   62:        234          0   xen-dyn    -event     eth%d-q1-tx
>   63:          1          0   xen-dyn    -event     eth%d-q1-rx
> 
> and this looks ugly. Actually, using early netdev name (even when it's
> already set) is also not ideal: nowadays we tend to rename eth devices
> and queue name may end up not corresponding to the netdev name.
> 
> Use nodename from xenbus device for queue naming: this can't change in VM's
> lifetime. Now /proc/interrupts looks like
> 
>   62:        202          0   xen-dyn    -event     device/vif/0-q0-tx
>   63:        317          0   xen-dyn    -event     device/vif/0-q0-rx
>   64:        262          0   xen-dyn    -event     device/vif/0-q1-tx
>   65:         17          0   xen-dyn    -event     device/vif/0-q1-rx
> 
> Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Ross Lagerwall <ross.lagerwall@citrix.com>
