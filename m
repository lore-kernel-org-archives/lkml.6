Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeFCPkM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 11:40:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751132AbeFCPkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 11:40:11 -0400
Date: Sun, 3 Jun 2018 23:40:04 +0800
From: Wei Xu <wexu@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfreimann@redhat.com,
        tiwei.bie@intel.com
Subject: Re: [RFC V5 PATCH 8/8] vhost: event suppression for packed ring
Message-ID: <20180603154004.GA24012@wei-ubt>
References: <1527559830-8133-1-git-send-email-jasowang@redhat.com>
 <1527559830-8133-9-git-send-email-jasowang@redhat.com>
 <20180530114200.GA23792@wei-ubt>
 <12f2c455-5868-3b07-0eba-d49dcafd10f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12f2c455-5868-3b07-0eba-d49dcafd10f2@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:09:07AM +0800, Jason Wang wrote:
> 
> 
> On 2018年05月30日 19:42, Wei Xu wrote:
> >>  /* This actually signals the guest, using eventfd. */
> >>  void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> >>  {
> >>@@ -2802,10 +2930,34 @@ static bool vhost_enable_notify_packed(struct vhost_dev *dev,
> >>  				       struct vhost_virtqueue *vq)
> >>  {
> >>  	struct vring_desc_packed *d = vq->desc_packed + vq->avail_idx;
> >>-	__virtio16 flags;
> >>+	__virtio16 flags = RING_EVENT_FLAGS_ENABLE;
> >>  	int ret;
> >>-	/* FIXME: disable notification through device area */
> >>+	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
> >>+		return false;
> >>+	vq->used_flags &= ~VRING_USED_F_NO_NOTIFY;
> >'used_flags' was originally designed for 1.0, why should we pay attetion to it here?
> >
> >Wei
> 
> It was used to recored whether or not we've disabled notification. Then we
> can avoid unnecessary userspace writes or memory barriers.

OK, thanks.

> 
> Thanks
