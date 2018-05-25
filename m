Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeEYCKW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:10:22 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:54278 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEYCKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:10:19 -0400
Date: Thu, 24 May 2018 22:10:18 -0400 (EDT)
Message-Id: <20180524.221018.776118684279850747.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: synchronize IOTLB message with dev cleanup
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526990337-24892-1-git-send-email-jasowang@redhat.com>
References: <1526990337-24892-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 May 2018 19:58:57 +0800

> DaeRyong Jeong reports a race between vhost_dev_cleanup() and
> vhost_process_iotlb_msg():
> 
> Thread interleaving:
> CPU0 (vhost_process_iotlb_msg)			CPU1 (vhost_dev_cleanup)
> (In the case of both VHOST_IOTLB_UPDATE and
> VHOST_IOTLB_INVALIDATE)
> =====						=====
> 						vhost_umem_clean(dev->iotlb);
> if (!dev->iotlb) {
> 	        ret = -EFAULT;
> 		        break;
> }
> 						dev->iotlb = NULL;
> 
> The reason is we don't synchronize between them, fixing by protecting
> vhost_process_iotlb_msg() with dev mutex.
> 
> Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
