Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCVXZG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:25:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52606 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeCVXZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:25:05 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2] ACPI / scan: Send the change uevent with offine environmental data
Date: Fri, 23 Mar 2018 00:25:29 +0100
Message-ID: <16547461.vlqm9ldVjj@aspire.rjw.lan>
In-Reply-To: <20180320055126.8671-1-jlee@suse.com>
References: <20180320055126.8671-1-jlee@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 20, 2018 6:51:26 AM CET Lee, Chun-Yi wrote:
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
> 
> v2:
> Fix build warning for the environmental string
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Tested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  drivers/acpi/scan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 8e63d93..490498e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -116,6 +116,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
>  {
>  	struct acpi_device_physical_node *pn;
>  	bool offline = true;
> +	char *envp[] = { "EVENT=offline", NULL };
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
> 

Applied, thanks!
