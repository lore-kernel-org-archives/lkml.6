Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeCOIVC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:21:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeCOIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:20:59 -0400
Date: Thu, 15 Mar 2018 08:20:45 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Sonny Rao <sonnyrao@chromium.org>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: fix vhost ioctl signature to build with clang
Message-ID: <20180315082045.yphfdbz57uih7zzl@dhcp-10-169-107-175.ie.oracle.com>
Mail-Followup-To: Sonny Rao <sonnyrao@chromium.org>, kvm@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180314170506.121791-1-sonnyrao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20180314170506.121791-1-sonnyrao@chromium.org>
User-Agent: NeoMutt/20180223
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150096
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 10:05:06AM -0700, Sonny Rao wrote:
>Clang is particularly anal about signed vs unsigned comparisons and
>doesn't like the fact that some ioctl numbers set the MSB, so we get
>this error when trying to build vhost on aarch64:
>
>drivers/vhost/vhost.c:1400:7: error: overflow converting case value to
> switch condition type (3221794578 to 18446744072636378898)
> [-Werror, -Wswitch]
>        case VHOST_GET_VRING_BASE:
>
>3221794578 is 0xC008AF12 in hex
>18446744072636378898 is 0xFFFFFFFFC008AF12 in hex
>
>Fix this by using unsigned ints in the function signature for
>vhost_vring_ioctl().
>
>Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

All the other callers of this function already appear to assume that
it is an unsigned int.

Thanks,

Darren.

>---
> drivers/vhost/vhost.c | 2 +-
> drivers/vhost/vhost.h | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 1b3e8d2d5c8b4..5316319d84081 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1337,7 +1337,7 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
> 	return -EFAULT;
> }
>
>-long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp)
>+long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> {
> 	struct file *eventfp, *filep = NULL;
> 	bool pollstart = false, pollstop = false;
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index ac4b6056f19ae..d8ee85ae8fdcc 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -45,7 +45,7 @@ void vhost_poll_stop(struct vhost_poll *poll);
> void vhost_poll_flush(struct vhost_poll *poll);
> void vhost_poll_queue(struct vhost_poll *poll);
> void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work);
>-long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
>+long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
>
> struct vhost_log {
> 	u64 addr;
>@@ -177,7 +177,7 @@ void vhost_dev_reset_owner(struct vhost_dev *, struct vhost_umem *);
> void vhost_dev_cleanup(struct vhost_dev *);
> void vhost_dev_stop(struct vhost_dev *);
> long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
>-long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
>+long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
> int vhost_vq_access_ok(struct vhost_virtqueue *vq);
> int vhost_log_access_ok(struct vhost_dev *);
>
>-- 
>2.13.5
>
