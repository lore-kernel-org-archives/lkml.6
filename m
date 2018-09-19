Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41255C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200E2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0200E2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbeITCSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:18:41 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56771 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731460AbeITCSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:18:41 -0400
X-IronPort-AV: E=Sophos;i="5.53,395,1531778400"; 
   d="scan'208";a="347124368"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 22:38:47 +0200
Date:   Wed, 19 Sep 2018 22:38:47 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sean Paul <sean@poorly.run>,
        kbuild-all@01.org
Subject: Re: [PATCH 1/6] drm/dp_mst: Introduce drm_dp_mst_connector_atomic_check()
 (fwd)
Message-ID: <alpine.DEB.2.21.1809192237110.2433@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't think you can update the loop index variable in
list_for_each_entry, because the mcro uses th index variable to get to the
next element.  Perhaps list_for_each_entry_safe would be more suitable?

julia

---------- Forwarded message ----------
Date: Thu, 20 Sep 2018 04:30:13 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/6] drm/dp_mst: Introduce
    drm_dp_mst_connector_atomic_check()

CC: kbuild-all@01.org
In-Reply-To: <20180918230637.20700-2-lyude@redhat.com>
References: <20180918230637.20700-2-lyude@redhat.com>
TO: Lyude Paul <lyude@redhat.com>
CC: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
CC: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sean Paul <sean@poorly.run>

Hi Lyude,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next]
[also build test WARNING on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lyude-Paul/Fix-legacy-DPMS-changes-with-MST/20180919-203434
base:   git://anongit.freedesktop.org/drm-intel for-linux-next
:::::: branch date: 8 hours ago
:::::: commit date: 8 hours ago

>> drivers/gpu/drm/drm_dp_mst_topology.c:3144:1-20: iterator with update on line 3145

# https://github.com/0day-ci/linux/commit/f8df31d5221b9a6da6698d4a37e622253bb17cdc
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout f8df31d5221b9a6da6698d4a37e622253bb17cdc
vim +3144 drivers/gpu/drm/drm_dp_mst_topology.c

3f3353b7 Pandiyan, Dhinakaran 2017-04-20  3131
f8df31d5 Lyude Paul           2018-09-18  3132  static bool
f8df31d5 Lyude Paul           2018-09-18  3133  drm_dp_mst_connector_still_exists(struct drm_connector *connector,
f8df31d5 Lyude Paul           2018-09-18  3134  				  struct drm_dp_mst_topology_mgr *mgr,
f8df31d5 Lyude Paul           2018-09-18  3135  				  struct drm_dp_mst_branch *mstb)
f8df31d5 Lyude Paul           2018-09-18  3136  {
f8df31d5 Lyude Paul           2018-09-18  3137  	struct drm_dp_mst_port *port;
f8df31d5 Lyude Paul           2018-09-18  3138  	bool exists = false;
f8df31d5 Lyude Paul           2018-09-18  3139
f8df31d5 Lyude Paul           2018-09-18  3140  	mstb = drm_dp_get_validated_mstb_ref(mgr, mstb);
f8df31d5 Lyude Paul           2018-09-18  3141  	if (!mstb)
f8df31d5 Lyude Paul           2018-09-18  3142  		return false;
f8df31d5 Lyude Paul           2018-09-18  3143
f8df31d5 Lyude Paul           2018-09-18 @3144  	list_for_each_entry(port, &mstb->ports, next) {
f8df31d5 Lyude Paul           2018-09-18 @3145  		port = drm_dp_get_validated_port_ref(mgr, port);
f8df31d5 Lyude Paul           2018-09-18  3146  		if (!port)
f8df31d5 Lyude Paul           2018-09-18  3147  			continue;
f8df31d5 Lyude Paul           2018-09-18  3148
f8df31d5 Lyude Paul           2018-09-18  3149  		exists = (port->connector == connector ||
f8df31d5 Lyude Paul           2018-09-18  3150  			  (port->mstb &&
f8df31d5 Lyude Paul           2018-09-18  3151  			   drm_dp_mst_connector_still_exists(connector, mgr,
f8df31d5 Lyude Paul           2018-09-18  3152  							     port->mstb)));
f8df31d5 Lyude Paul           2018-09-18  3153
f8df31d5 Lyude Paul           2018-09-18  3154  		drm_dp_put_port(port);
f8df31d5 Lyude Paul           2018-09-18  3155  		if (exists)
f8df31d5 Lyude Paul           2018-09-18  3156  			break;
f8df31d5 Lyude Paul           2018-09-18  3157  	}
f8df31d5 Lyude Paul           2018-09-18  3158
f8df31d5 Lyude Paul           2018-09-18  3159  	drm_dp_put_mst_branch_device(mstb);
f8df31d5 Lyude Paul           2018-09-18  3160  	return exists;
f8df31d5 Lyude Paul           2018-09-18  3161  }
f8df31d5 Lyude Paul           2018-09-18  3162

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
