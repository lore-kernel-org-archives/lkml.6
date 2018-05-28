Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422792AbeE1LCV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164907AbeE1LCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:02:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 452/496] vfio-ccw: fence off transport mode
Date: Mon, 28 May 2018 12:03:57 +0200
Message-Id: <20180528100338.947065688@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cornelia Huck <cohuck@redhat.com>

[ Upstream commit 9851bc77e62499957567e7c39a5beba7d6de6296 ]

vfio-ccw only supports command mode for channel programs, not transport
mode. User space is supposed to already take care of that and pass us
command-mode ORBs only, but better make sure and return an error to
the caller instead of trying to process tcws as ccws.

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/cio/vfio_ccw_fsm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -129,6 +129,11 @@ static void fsm_io_request(struct vfio_c
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
