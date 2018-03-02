Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428445AbeCBOBE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:01:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:55475 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424382AbeCBOBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:01:02 -0500
Date: Fri, 2 Mar 2018 15:00:59 +0100
From: Michal Hocko <mhocko@kernel.org>
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI / scan: Send the change uevent with offine
 environmental data
Message-ID: <20180302140059.GA12772@dhcp22.suse.cz>
References: <20180302063508.15818-1-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302063508.15818-1-jlee@suse.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-03-18 14:35:08, Lee, Chun-Yi wrote:
> In current design of ACPI container offline, Kernel emits
> KOBJ_CHANGE uevent to user space to indidate that the ejection of
> the container was triggered by platform. (caa73ea15 patch)
> 
> A pure KOBJ_CHANGE uevent is not enough for user space to identify
> the purpose. For example, a "udevadm trigger" command can also
> be used to emit change event to all udev rules. A udev rule can not
> identify that the event is from kernel for offline or from udevadm
> for other purpose. Then the offline action in udev rule may also be
> triggered by udevadm tool.
> 
> So, similar to the change uevent of dock, kernel sends the
> KOBJ_CHANGE uevent with a offline environmental data to indicate
> purpose. It's useful by udev rule for using ENV{EVENT} filter.

Looks reasonable to me. I have also tested this on Huawei Kunlun server
which hits the offline & online storm as a result of udevadm triggered
and a container udev rule which hooks into change event and offlines
all devices attached to the container. This patch allowed the udev rule
to be more targeted at the offline event.

> Cc: Michal Hocko <mhocko@kernel.org> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> 
> Cc: Len Brown <lenb@kernel.org> 
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Tested-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/acpi/scan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 8e63d93..f6dca9b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -116,6 +116,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
>  {
>  	struct acpi_device_physical_node *pn;
>  	bool offline = true;
> +	static const char *envp[] = { "EVENT=offline", NULL };
>  
>  	/*
>  	 * acpi_container_offline() calls this for all of the container's
> @@ -126,7 +127,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
>  	list_for_each_entry(pn, &adev->physical_node_list, node)
>  		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
>  			if (uevent)
> -				kobject_uevent(&pn->dev->kobj, KOBJ_CHANGE);
> +				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
>  
>  			offline = false;
>  			break;
> -- 
> 2.10.2

-- 
Michal Hocko
SUSE Labs
