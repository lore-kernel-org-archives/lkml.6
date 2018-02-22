Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeBVPkG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:40:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933023AbeBVPkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:40:04 -0500
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/1] vfio-ccw: fence off transport mode
Date: Thu, 22 Feb 2018 16:39:59 +0100
Message-Id: <20180222153959.31272-2-cohuck@redhat.com>
In-Reply-To: <20180222153959.31272-1-cohuck@redhat.com>
References: <20180222153959.31272-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfio-ccw only supports command mode for channel programs, not transport
mode. User space is supposed to already take care of that and pass us
command-mode ORBs only, but better make sure and return an error to
the caller instead of trying to process tcws as ccws.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index c30420c517b1..ff6963ad6e39 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -124,6 +124,11 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
 		orb = (union orb *)io_region->orb_area;
 
+		/* Don't try to build a cp if transport mode is specified. */
+		if (orb->tm.b) {
+			io_region->ret_code = -EOPNOTSUPP;
+			goto err_out;
+		}
 		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
 					      orb);
 		if (io_region->ret_code)
-- 
2.13.6
