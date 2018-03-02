Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427158AbeCBPKr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:10:47 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:36070 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427101AbeCBPKl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 2 Mar 2018 10:10:41 -0500
Date: Fri, 2 Mar 2018 23:10:22 +0800
From: joeyli <jlee@suse.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI / scan: Send the change uevent with offine
 environmental data
Message-ID: <20180302151022.GB6140@linux-l9pv.suse>
References: <20180302063508.15818-1-jlee@suse.com>
 <20180302140059.GA12772@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302140059.GA12772@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 03:00:59PM +0100, Michal Hocko wrote:
> On Fri 02-03-18 14:35:08, Lee, Chun-Yi wrote:
> > In current design of ACPI container offline, Kernel emits
> > KOBJ_CHANGE uevent to user space to indidate that the ejection of
> > the container was triggered by platform. (caa73ea15 patch)
> > 
> > A pure KOBJ_CHANGE uevent is not enough for user space to identify
> > the purpose. For example, a "udevadm trigger" command can also
> > be used to emit change event to all udev rules. A udev rule can not
> > identify that the event is from kernel for offline or from udevadm
> > for other purpose. Then the offline action in udev rule may also be
> > triggered by udevadm tool.
> > 
> > So, similar to the change uevent of dock, kernel sends the
> > KOBJ_CHANGE uevent with a offline environmental data to indicate
> > purpose. It's useful by udev rule for using ENV{EVENT} filter.
> 
> Looks reasonable to me. I have also tested this on Huawei Kunlun server
> which hits the offline & online storm as a result of udevadm triggered
> and a container udev rule which hooks into change event and offlines
> all devices attached to the container. This patch allowed the udev rule
> to be more targeted at the offline event.
> 
> > Cc: Michal Hocko <mhocko@kernel.org> 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> 
> > Cc: Len Brown <lenb@kernel.org> 
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Tested-by: Michal Hocko <mhocko@suse.com>
>

Thank you for review and testing.

Joey Lee
 
> > ---
> >  drivers/acpi/scan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 8e63d93..f6dca9b 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -116,6 +116,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
> >  {
> >  	struct acpi_device_physical_node *pn;
> >  	bool offline = true;
> > +	static const char *envp[] = { "EVENT=offline", NULL };
> >  
> >  	/*
> >  	 * acpi_container_offline() calls this for all of the container's
> > @@ -126,7 +127,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
> >  	list_for_each_entry(pn, &adev->physical_node_list, node)
> >  		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
> >  			if (uevent)
> > -				kobject_uevent(&pn->dev->kobj, KOBJ_CHANGE);
> > +				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
> >  
> >  			offline = false;
> >  			break;
> > -- 
> > 2.10.2
> 
> -- 
> Michal Hocko
> SUSE Labs
