Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeBVXRm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:17:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751432AbeBVXRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:17:41 -0500
Date: Thu, 22 Feb 2018 15:17:38 -0800
From: Jeremy McNicoll <jmcnicol@redhat.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [07/18] thunderbolt: Handle rejected Thunderbolt devices
Message-ID: <20180222231736.GA628@mini-rhel.redhat.com>
References: <20180213170018.9780-8-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213170018.9780-8-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 08:00:07PM +0300, Mika Westerberg wrote:
> The ICM firmware may reject devices for different reasons, even if we
> have asked it to accept anything. If we notice a device is rejected, we
> just log the event and bail out.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/icm.c     | 6 ++++++
>  drivers/thunderbolt/tb_msgs.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index 611d28e8e5f2..34d7740d1cbd 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -410,6 +410,12 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
>  		ICM_LINK_INFO_DEPTH_SHIFT;
>  	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
>  
> +	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
> +		tb_info(tb, "switch at %u.%u was rejected by ICM firmware\n",
> +			link, depth);

This kind of condition sounds more like an error instead of info.
Please bump this up to tb_WARN/tb_warn ideally tb_err().

BTW - why do we have tb_WARN and tb_warn in drivers/thunderbolt/tb.h ?

-jeremy

> +		return;
> +	}
> +
>  	ret = icm->get_route(tb, link, depth, &route);
>  	if (ret) {
>  		tb_err(tb, "failed to find route string for switch at %u.%u\n",
> diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
> index b0a092baa605..476bc04cac6c 100644
> --- a/drivers/thunderbolt/tb_msgs.h
> +++ b/drivers/thunderbolt/tb_msgs.h
> @@ -176,6 +176,7 @@ struct icm_fr_event_device_connected {
>  #define ICM_LINK_INFO_DEPTH_SHIFT	4
>  #define ICM_LINK_INFO_DEPTH_MASK	GENMASK(7, 4)
>  #define ICM_LINK_INFO_APPROVED		BIT(8)
> +#define ICM_LINK_INFO_REJECTED		BIT(9)
>  
>  struct icm_fr_pkg_approve_device {
>  	struct icm_pkg_header hdr;
