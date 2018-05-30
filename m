Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeE3LPt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:15:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60697 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751692AbeE3LHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:25 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Jia-Ju Bai" <baijiaju1990@gmail.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.502970112@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 030/153] USB: serial: io_edgeport: fix possible
 sleep-in-atomic
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@gmail.com>

commit c7b8f77872c73f69a16528a9eb87afefcccdc18b upstream.

According to drivers/usb/serial/io_edgeport.c, the driver may sleep
under a spinlock.
The function call path is:
edge_bulk_in_callback (acquire the spinlock)
   process_rcvd_data
     process_rcvd_status
       change_port_settings
         send_iosp_ext_cmd
           write_cmd_usb
             usb_kill_urb --> may sleep

To fix it, the redundant usb_kill_urb() is removed from the error path
after usb_submit_urb() fails.

This possible bug is found by my static analysis tool (DSAC) and checked
by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Johan Hovold <johan@kernel.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/io_edgeport.c | 1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2387,7 +2387,6 @@ static int write_cmd_usb(struct edgeport
 		dev_err(&edge_port->port->dev,
 		    "%s - usb_submit_urb(write command) failed, status = %d\n",
 							__func__, status);
-		usb_kill_urb(urb);
 		usb_free_urb(urb);
 		atomic_dec(&CmdUrbs);
 		return status;
