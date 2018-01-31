Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeAaPA3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:00:29 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46599 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeAaPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:00:27 -0500
X-Google-Smtp-Source: AH8x224wGtmWndkSPWDv8N11NKOTiZoB/oo8waX1g3XnzbNtoxSgyPHokL2ZiUWUeH+RuHDWT53S6w==
Subject: Re: [Xen-devel] [PATCHv2] xen-netfront: remove warning when unloading
 module
To: Eduardo Otubo <otubo@redhat.com>, xen-devel@lists.xenproject.org
Cc: jgross@suse.com, wei.liu2@citrix.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.durrant@citrix.com,
        cheshi@redhat.com, vkuznets@redhat.com, mgamal@redhat.com,
        cavery@redhat.com, boris.ostrovsky@oracle.com
References: <20171123141835.5820-1-otubo@redhat.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <fcbb9d8a-85b4-5543-6ebc-cd34a66729ff@gmail.com>
Date: Wed, 31 Jan 2018 17:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171123141835.5820-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eduardo!

I am working on a frontend driver (PV DRM) and also seeing some strange

things on driver unloading:

xt# rmmod -f drm_xen_front.ko
[ 3236.462497] [drm] Unregistering XEN PV vdispl
[ 3236.485745] [drm:xen_drv_remove [drm_xen_front]] *ERROR* Backend 
state is InitWait while removing driver
[ 3236.486950] vdispl vdispl-0: 22 freeing event channel 11
[ 3236.496123] vdispl vdispl-0: failed to write error node for 
device/vdispl/0 (22 freeing event channel 11)
[ 3236.496271] vdispl vdispl-0: 22 freeing event channel 12
[ 3236.501633] vdispl vdispl-0: failed to write error node for 
device/vdispl/0 (22 freeing event channel 12)

These are somewhat different from your use-case with grant references, 
but I have a question:

do you really see that XenbusStateClosed and XenbusStateClosing are

called? In my driver I can't see those and once I tried to dig deeper 
into the problem

I saw that on driver removal it is disconnected from XenBus, so no 
backend state

change events come in via .otherend_changed callback.

The only difference I see here is that the backend is a user-space 
application

Thank you,
Oleksandr

On 11/23/2017 04:18 PM, Eduardo Otubo wrote:
> v2:
>   * Replace busy wait with wait_event()/wake_up_all()
>   * Cannot garantee that at the time xennet_remove is called, the
>     xen_netback state will not be XenbusStateClosed, so added a
>     condition for that
>   * There's a small chance for the xen_netback state is
>     XenbusStateUnknown by the time the xen_netfront switches to Closed,
>     so added a condition for that.
>
> When unloading module xen_netfront from guest, dmesg would output
> warning messages like below:
>
>    [  105.236836] xen:grant_table: WARNING: g.e. 0x903 still in use!
>    [  105.236839] deferring g.e. 0x903 (pfn 0x35805)
>
> This problem relies on netfront and netback being out of sync. By the time
> netfront revokes the g.e.'s netback didn't have enough time to free all of
> them, hence displaying the warnings on dmesg.
>
> The trick here is to make netfront to wait until netback frees all the g.e.'s
> and only then continue to cleanup for the module removal, and this is done by
> manipulating both device states.
>
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>   drivers/net/xen-netfront.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index 8b8689c6d887..391432e2725d 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -87,6 +87,8 @@ struct netfront_cb {
>   /* IRQ name is queue name with "-tx" or "-rx" appended */
>   #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
>   
> +static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
> +
>   struct netfront_stats {
>   	u64			packets;
>   	u64			bytes;
> @@ -2021,10 +2023,12 @@ static void netback_changed(struct xenbus_device *dev,
>   		break;
>   
>   	case XenbusStateClosed:
> +		wake_up_all(&module_unload_q);
>   		if (dev->state == XenbusStateClosed)
>   			break;
>   		/* Missed the backend's CLOSING state -- fallthrough */
>   	case XenbusStateClosing:
> +		wake_up_all(&module_unload_q);
>   		xenbus_frontend_closed(dev);
>   		break;
>   	}
> @@ -2130,6 +2134,20 @@ static int xennet_remove(struct xenbus_device *dev)
>   
>   	dev_dbg(&dev->dev, "%s\n", dev->nodename);
>   
> +	if (xenbus_read_driver_state(dev->otherend) != XenbusStateClosed) {
> +		xenbus_switch_state(dev, XenbusStateClosing);
> +		wait_event(module_unload_q,
> +			   xenbus_read_driver_state(dev->otherend) ==
> +			   XenbusStateClosing);
> +
> +		xenbus_switch_state(dev, XenbusStateClosed);
> +		wait_event(module_unload_q,
> +			   xenbus_read_driver_state(dev->otherend) ==
> +			   XenbusStateClosed ||
> +			   xenbus_read_driver_state(dev->otherend) ==
> +			   XenbusStateUnknown);
> +	}
> +
>   	xennet_disconnect_backend(info);
>   
>   	unregister_netdev(info->netdev);
