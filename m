Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeCNTFh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:05:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751447AbeCNTFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:05:35 -0400
Date: Wed, 14 Mar 2018 21:05:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sonny Rao <sonnyrao@chromium.org>
Cc: kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: add vsock compat ioctl
Message-ID: <20180314210417-mutt-send-email-mst@kernel.org>
References: <20180314172605.130483-1-sonnyrao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314172605.130483-1-sonnyrao@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 10:26:05AM -0700, Sonny Rao wrote:
> This will allow usage of vsock from 32-bit binaries on a 64-bit
> kernel.
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

I think you need to convert the pointer argument though.
Something along the lines of:

#ifdef CONFIG_COMPAT
static long vhost_vsock_dev_compat_ioctl(struct file *f, unsigned int ioctl,
					 unsigned long arg)
{
        return vhost_vsock_dev_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
} 
#endif  



> ---
>  drivers/vhost/vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 0d14e2ff19f16..d0e65e92110e5 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -705,6 +705,7 @@ static const struct file_operations vhost_vsock_fops = {
>  	.release        = vhost_vsock_dev_release,
>  	.llseek		= noop_llseek,
>  	.unlocked_ioctl = vhost_vsock_dev_ioctl,
> +	.compat_ioctl   = vhost_vsock_dev_ioctl,
>  };
>  
>  static struct miscdevice vhost_vsock_misc = {
> -- 
> 2.13.5
