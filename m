Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966746AbeCAJKt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:10:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966675AbeCAJKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:10:46 -0500
Date: Thu, 1 Mar 2018 10:10:38 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, brouer@redhat.com
Subject: Re: [PATCH net-next 0/2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
Message-ID: <20180301101038.4253424d@redhat.com>
In-Reply-To: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Mar 2018 11:19:03 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This series tries to re-enable XDP_REDIRECT for mergeable buffer which
> was removed since commit 7324f5399b06 ("virtio_net: disable
> XDP_REDIRECT in receive_mergeable() case"). Main concerns are:
> 
> - not enough tailroom was reserved which breaks cpumap

To address this at a more fundamental level, I would suggest that we/you
instead extend XDP to know it's buffers "frame" size/end.  (The
assumption use to be, xdp_buff->data_hard_start + PAGE_SIZE, but
ixgbe+virtio_net broke that assumption).

It should actually be fairly easy to implement:
 * Simply extend xdp_buff with a "data_hard_end" pointer.

Now cpumap is more safe... instead of crashing, it can now know/see when
it is safe to create an SKB using build_skb (could fallback to
dev_alloc_skb).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
