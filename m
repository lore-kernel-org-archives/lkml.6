Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF2CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7232075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7232075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJYHcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:32:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42387 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeJYHcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:32:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id u20-v6so4521970qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 16:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MXL72rO8W4rqRJphwy92sMoYalg1+2LWLd8TUvA1EOg=;
        b=rXs/qN4Wdrm7rp5zA/g50bwp8lfZOqYl8F4dXzPRkNNHM33175rYyVe5aBtq7QJe2X
         P+i76Au19pdI+nlU1sz9ACPqNEDWMmvf8TKltiiz90VvprNDqdIQGAvnFt1xFjqJoCwV
         0jeNaacvg9v1fjsRcX/j0GsRxfOg8cgyfoIb63BE4hBuaZyckD6p+ogO+eC6tLaw2r+q
         HDibCcAc2Slyupj1gtIMnfk0RIQHxcS7pPlKov4jbDRmp5SQpbfQyuE4Xcw45whKTW6g
         dkGMywVNwtgqgWD9nkoZ+4XRis6Q9eYwuXm7wQ9u/K3cdNc6kHrFcc1DcwRaYrzbMwjx
         7wcw==
X-Gm-Message-State: AGRZ1gKCo1R4SglCuoBgOJ/8oqKnPC40bEwa5RUPkwVAcnP02Sy8ckp4
        sKDDnWuRLR7msNpEO8GspsbZuQ==
X-Google-Smtp-Source: AJdET5dHcMlooyoP6vHGrEUM8knVDSD0vPoj8iLtYI8EGfQVWu8fatejHZtIZO2G8Y/ysjbqaHrwZw==
X-Received: by 2002:ae9:e20b:: with SMTP id c11-v6mr4269762qkc.339.1540422139278;
        Wed, 24 Oct 2018 16:02:19 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id l18-v6sm648245qkl.21.2018.10.24.16.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 16:02:18 -0700 (PDT)
Message-ID: <b99609526b4bc8055caa703bc1d9aaf87ef518f7.camel@redhat.com>
Subject: Re: [RESEND PATCH v2 1/2] drm/dp/mst: Reprobe EDID for MST ports on
 resume
From:   Lyude Paul <lyude@redhat.com>
To:     Juston Li <juston.li@intel.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     clinton.a.taylor@intel.com, nathan.d.ciobanu@intel.com,
        mario.limonciello@dell.com, jared_dominguez@dell.com,
        linux-kernel@vger.kernel.org, Lyude <cpaul@redhat.com>,
        stable@vger.kernel.org
Date:   Wed, 24 Oct 2018 19:02:16 -0400
In-Reply-To: <f9b43dde4868d3c079b652b48babde9b8bebc728.camel@redhat.com>
References: <20181024021925.27026-1-juston.li@intel.com>
         <20181024021925.27026-2-juston.li@intel.com>
         <f9b43dde4868d3c079b652b48babde9b8bebc728.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gah, the more I think about this the more I realize this was never the correct
approach to begin with. I wrote this patch a long time ago when I wasn't
nearly as experienced, so that's not terribly surprising.

So: the thing is this isn't actually a problem that's specific to MST. Pretty
much all of the different connector types have this issue, since any GPU is
going to miss hotplugs if the entire system is in S3. So it doesn't make much
sense to have this be in MST helpers; we should just reprobe all of the
connectors on the system.

Honestly: I think it might just be a better idea to just send a sysfs hotplug
when we wake up from suspend/resume, so that userspace just rechecks all of
the connectors anyway. Nouveau already does this, jfyi.

On Wed, 2018-10-24 at 18:09 -0400, Lyude Paul wrote:
> Thought this was going to be an easy review until I realized that there's
> multiple problems in nouveau this would cause issues with, even if we didn't
> pay attention to the -EINVAL that gets returned. The suspend/resume order in
> nouveau needs some fixing up to prevent this patch from causing timeouts,
> and
> then also there's a hidden surprise
> 
> [  972.294437] ============================================
> [  972.295225] WARNING: possible recursive locking detected
> [  972.296042] 4.19.0-rc8mst-reprobe+ #2 Not tainted
> [  972.296842] --------------------------------------------
> [  972.297614] zsh/6840 is trying to acquire lock:
> [  972.298441] 0000000072e521f7 (&dev->mode_config.mutex){+.+.}, at:
> drm_dp_mst_edids_changed+0xc0/0x180 [drm_kms_helper]
> [  972.299299] 
>                but task is already holding lock:
> [  972.300991] 0000000072e521f7 (&dev->mode_config.mutex){+.+.}, at:
> status_store+0x34/0x180 [drm]
> [  972.301875] 
>                other info that might help us debug this:
> [  972.303563]  Possible unsafe locking scenario:
> 
> [  972.305315]        CPU0
> [  972.306182]        ----
> [  972.307061]   lock(&dev->mode_config.mutex);
> [  972.307943]   lock(&dev->mode_config.mutex);
> [  972.308819] 
>                 *** DEADLOCK ***
> 
> [  972.311446]  May be due to missing lock nesting notation
> 
> [  972.313234] 6 locks held by zsh/6840:
> [  972.314135]  #0: 0000000092b5ba9d (sb_writers#4){.+.+}, at:
> vfs_write+0x13e/0x1a0
> [  972.315049]  #1: 00000000e628e6e9 (&of->mutex){+.+.}, at:
> kernfs_fop_write+0xbd/0x1a0
> [  972.315980]  #2: 000000000fb65e6c (kn->count#240){.+.+}, at:
> kernfs_fop_write+0xc5/0x1a0
> [  972.316928]  #3: 0000000072e521f7 (&dev->mode_config.mutex){+.+.}, at:
> status_store+0x34/0x180 [drm]
> [  972.317892]  #4: 00000000344224c2 (crtc_ww_class_acquire){+.+.}, at:
> drm_helper_probe_single_connector_modes+0x66/0x6c0 [drm_kms_helper]
> [  972.318863]  #5: 00000000d65352e2 (crtc_ww_class_mutex){+.+.}, at:
> drm_modeset_lock+0x44/0x110 [drm]
> [  972.319860] 
>                stack backtrace:
> [  972.321800] CPU: 5 PID: 6840 Comm: zsh Kdump: loaded Not tainted 4.19.0-
> rc8mst-reprobe+ #2
> [  972.322772] Hardware name: LENOVO 20EQZ1J7US/20EQZ1J7US, BIOS N1EET80W
> (1.53 ) 09/14/2018
> [  972.323792] Call Trace:
> [  972.324821]  dump_stack+0x85/0xc0
> [  972.325832]  __lock_acquire.cold.59+0x158/0x227
> [  972.326887]  ? retint_kernel+0x10/0x10
> [  972.327918]  lock_acquire+0x9e/0x170
> [  972.328948]  ? drm_dp_mst_edids_changed+0xc0/0x180 [drm_kms_helper]
> [  972.329986]  ? drm_dp_mst_edids_changed+0xc0/0x180 [drm_kms_helper]
> [  972.331066]  __mutex_lock+0x68/0x900
> [  972.332094]  ? drm_dp_mst_edids_changed+0xc0/0x180 [drm_kms_helper]
> [  972.333146]  ? __mutex_unlock_slowpath+0x4b/0x2b0
> [  972.334221]  ? drm_dp_mst_edids_changed+0xc0/0x180 [drm_kms_helper]
> [  972.335255]  drm_dp_mst_edids_changed+0xc0/0x180 [drm_kms_helper]
> [  972.336318]  drm_dp_mst_topology_mgr_resume+0x104/0x190 [drm_kms_helper]
> [  972.337397]  nv50_display_init+0x73/0xd0 [nouveau]
> [  972.338483]  nouveau_display_init+0x8e/0xe0 [nouveau]
> [  972.339547]  nouveau_display_resume+0x39/0x250 [nouveau]
> [  972.340634]  ? pci_restore_standard_config+0x40/0x40
> [  972.341762]  nouveau_do_resume+0x79/0x150 [nouveau]
> [  972.342850]  nouveau_pmops_runtime_resume+0x88/0x150 [nouveau]
> [  972.343915]  pci_pm_runtime_resume+0x78/0xb0
> [  972.345004]  __rpm_callback+0x75/0x1b0
> [  972.346084]  ? pci_restore_standard_config+0x40/0x40
> [  972.347148]  rpm_callback+0x1f/0x70
> [  972.348256]  ? pci_restore_standard_config+0x40/0x40
> [  972.349351]  rpm_resume+0x5d4/0x810
> [  972.350446]  ? drm_modeset_lock+0x44/0x110 [drm]
> [  972.351573]  __pm_runtime_resume+0x47/0x70
> [  972.352737]  nouveau_connector_detect+0x373/0x470 [nouveau]
> [  972.353841]  ? _cond_resched+0x15/0x30
> [  972.354945]  ? ww_mutex_lock+0x30/0x60
> [  972.356044]  ? drm_modeset_lock+0x44/0x110 [drm]
> [  972.357146]  drm_helper_probe_single_connector_modes+0xd9/0x6c0
> [drm_kms_helper]
> [  972.358274]  ? printk+0x58/0x6f
> [  972.359400]  status_store+0xb2/0x180 [drm]
> [  972.360519]  kernfs_fop_write+0xf0/0x1a0
> [  972.361711]  __vfs_write+0x36/0x180
> [  972.362842]  ? rcu_read_lock_sched_held+0x55/0x60
> [  972.363974]  ? rcu_sync_lockdep_assert+0x2e/0x60
> [  972.365103]  ? __sb_start_write+0x115/0x170
> [  972.366241]  ? vfs_write+0x13e/0x1a0
> [  972.367365]  vfs_write+0xa5/0x1a0
> [  972.368486]  ksys_write+0x52/0xc0
> [  972.369596]  do_syscall_64+0x60/0x1a0
> [  972.370782]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  972.371890] RIP: 0033:0x7fc93e169ef4
> [  972.373012] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00
> 00
> 00 66 90 48 8d 05 f1 3a 2d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
> [  972.374214] RSP: 002b:00007ffcd7ad1918 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [  972.375421] RAX: ffffffffffffffda RBX: 0000000000000007 RCX:
> 00007fc93e169ef4
> [  972.376628] RDX: 0000000000000007 RSI: 000055aefe5c30c0 RDI:
> 0000000000000001
> [  972.377872] RBP: 000055aefe5c30c0 R08: 00007fc93e43a8c0 R09:
> 00007fc93f6cdb80
> [  972.379082] R10: 000000000000000a R11: 0000000000000246 R12:
> 00007fc93e439760
> [  972.380311] R13: 0000000000000007 R14: 00007fc93e434760 R15:
> 0000000000000007
> 
> I must not have noticed that back when I wrote these patches! Whoops.
> 
> Since there's going to be quite a number of changes I need to make to this
> I'm
> just going to make the changes myself! I'll make sure to Cc you with the
> respin
> 
> On Tue, 2018-10-23 at 19:19 -0700, Juston Li wrote:
> > From: Lyude <cpaul@redhat.com>
> > 
> > As observed with the latest ThinkPad docks, we unfortunately can't rely
> > on docks keeping us updated with hotplug events that happened while we
> > were suspended. On top of that, even if the number of connectors remains
> > the same between suspend and resume it's still not safe to assume that
> > there were no hotplugs, since a different monitor might have been
> > plugged into a port another monitor previously occupied. As such, we
> > need to go through all of the MST ports and check whether or not their
> > EDIDs have changed.
> > 
> > In addition to that, we also now return -EINVAL from
> > drm_dp_mst_topology_mgr_resume to indicate to callers that they need to
> > reset the MST connection, and that they can't rely on any other method
> > of reprobing.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lyude <cpaul@redhat.com>
> > Signed-off-by: Juston Li <juston.li@intel.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 94 ++++++++++++++++++++++++++-
> >  1 file changed, 93 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 5ff1d79b86c4..88abebe52021 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/i2c.h>
> >  #include <drm/drm_dp_mst_helper.h>
> >  #include <drm/drmP.h>
> > +#include <drm/drm_edid.h>
> >  
> >  #include <drm/drm_fixed.h>
> >  #include <drm/drm_atomic.h>
> > @@ -2201,6 +2202,64 @@ void drm_dp_mst_topology_mgr_suspend(struct
> > drm_dp_mst_topology_mgr *mgr)
> >  }
> >  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
> >  
> > +static bool drm_dp_mst_edids_changed(struct drm_dp_mst_topology_mgr *mgr,
> > +				     struct drm_dp_mst_port *port)
> > +{
> > +	struct drm_device *dev;
> > +	struct drm_connector *connector;
> > +	struct drm_dp_mst_port *dport;
> > +	struct drm_dp_mst_branch *mstb;
> > +	struct edid *current_edid, *cached_edid;
> > +	bool ret = false;
> > +
> > +	port = drm_dp_get_validated_port_ref(mgr, port);
> > +	if (!port)
> > +		return false;
> > +
> > +	mstb = drm_dp_get_validated_mstb_ref(mgr, port->mstb);
> > +	if (mstb) {
> > +		list_for_each_entry(dport, &port->mstb->ports, next) {
> > +			ret = drm_dp_mst_edids_changed(mgr, dport);
> > +			if (ret)
> > +				break;
> > +		}
> > +
> > +		drm_dp_put_mst_branch_device(mstb);
> > +		if (ret)
> > +			goto out;
> > +	}
> > +
> > +	connector = port->connector;
> > +	if (!connector || !port->aux.ddc.algo)
> > +		goto out;
> > +
> > +	dev = connector->dev;
> > +	mutex_lock(&dev->mode_config.mutex);
> > +
> > +	current_edid = drm_get_edid(connector, &port->aux.ddc);
> > +	if (connector->edid_blob_ptr)
> > +		cached_edid = (void *)connector->edid_blob_ptr->data;
> > +	else
> > +		return false;
> > +
> > +	if ((current_edid && cached_edid && memcmp(current_edid, cached_edid,
> > +						   sizeof(struct edid)) != 0)
> > > > 
> > 
> > +	    (!current_edid && cached_edid) || (current_edid && !cached_edid))
> > {
> > +		ret = true;
> > +		DRM_DEBUG_KMS("EDID on %s changed, reprobing connectors\n",
> > +			      connector->name);
> > +	}
> > +
> > +	mutex_unlock(&dev->mode_config.mutex);
> > +
> > +	kfree(current_edid);
> > +
> > +out:
> > +	drm_dp_put_port(port);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * drm_dp_mst_topology_mgr_resume() - resume the MST manager
> >   * @mgr: manager to resume
> > @@ -2210,9 +2269,15 @@ EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
> >   *
> >   * if the device fails this returns -1, and the driver should do
> >   * a full MST reprobe, in case we were undocked.
> > + *
> > + * if the device can no longer be trusted, this returns -EINVAL
> > + * and the driver should unconditionally disconnect and reconnect
> > + * the dock.
> >   */
> >  int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
> >  {
> > +	struct drm_dp_mst_branch *mstb;
> > +	struct drm_dp_mst_port *port;
> >  	int ret = 0;
> >  
> >  	mutex_lock(&mgr->lock);
> > @@ -2246,8 +2311,35 @@ int drm_dp_mst_topology_mgr_resume(struct
> > drm_dp_mst_topology_mgr *mgr)
> >  		drm_dp_check_mstb_guid(mgr->mst_primary, guid);
> >  
> >  		ret = 0;
> > -	} else
> > +
> > +		/*
> > +		 * Some hubs also forget to notify us of hotplugs that
> > happened
> > +		 * while we were in suspend, so we need to verify that the
> > edid
> > +		 * hasn't changed for any of the connectors. If it has been,
> > +		 * we unfortunately can't rely on the dock updating us with
> > +		 * hotplug events, so indicate we need a full reconnect.
> > +		 */
> > +
> > +		/* MST's I2C helpers can't be used while holding this lock */
> > +		mutex_unlock(&mgr->lock);
> > +
> > +		mstb = drm_dp_get_validated_mstb_ref(mgr, mgr->mst_primary);
> > +		if (mstb) {
> > +			list_for_each_entry(port, &mstb->ports, next) {
> > +				if (drm_dp_mst_edids_changed(mgr, port)) {
> > +					ret = -EINVAL;
> > +					break;
> > +				}
> > +			}
> > +
> > +			drm_dp_put_mst_branch_device(mstb);
> > +		}
> > +	} else {
> >  		ret = -1;
> > +		mutex_unlock(&mgr->lock);
> > +	}
> > +
> > +	return ret;
> >  
> >  out_unlock:
> >  	mutex_unlock(&mgr->lock);
-- 
Cheers,
	Lyude Paul

