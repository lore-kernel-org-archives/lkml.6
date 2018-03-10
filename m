Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932919AbeCJExf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 23:53:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:64931 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932189AbeCJExd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 23:53:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,449,1515484800";
   d="scan'208";a="40742564"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
        Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] e1000e: Fix link check race condition
Thread-Topic: [PATCH 2/2] e1000e: Fix link check race condition
Thread-Index: AQHTtO5oYz5spVXvZkqQ2Wbb2ru4kaPI7W0g
Date: Sat, 10 Mar 2018 04:53:31 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C801AC3@ORSMSX101.amr.corp.intel.com>
References: <20180306015553.10441-1-bpoirier@suse.com>
 <20180306015553.10441-2-bpoirier@suse.com>
In-Reply-To: <20180306015553.10441-2-bpoirier@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Benjamin Poirier
> Sent: Monday, March 5, 2018 5:56 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>; Lennart Sorensen
> <lsorense@csclub.uwaterloo.ca>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 2/2] e1000e: Fix link check race condition
> 
> Alex reported the following race condition:
> 
> /* link goes up... interrupt... schedule watchdog */
> \ e1000_watchdog_task
> 	\ e1000e_has_link
> 		\ hw->mac.ops.check_for_link() ===
> e1000e_check_for_copper_link
> 			\ e1000e_phy_has_link_generic(..., &link)
> 				link = true
> 
> 					 /* link goes down... interrupt */
> 					 \ e1000_msix_other
> 						 hw->mac.get_link_status =
> true
> 
> 			/* link is up */
> 			mac->get_link_status = false
> 
> 		link_active = true
> 		/* link_active is true, wrongly, and stays so because
> 		 * get_link_status is false */
> 
> Avoid this problem by making sure that we don't set get_link_status = false
> after having checked the link.
> 
> It seems this problem has been present since the introduction of e1000e.
> 
> Link: https://lkml.org/lkml/2018/1/29/338
> Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 31 ++++++++++++++++-------
> ------
>  drivers/net/ethernet/intel/e1000e/mac.c     | 14 ++++++-------
>  2 files changed, 24 insertions(+), 21 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
