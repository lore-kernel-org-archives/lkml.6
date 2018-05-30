Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeE3LMU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:12:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60758 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752666AbeE3LHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Oliver Neukum" <oneukum@suse.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.240562010@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 051/153] USB: cdc-acm: Do not log urb submission
 errors on disconnect
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f0386c083c2ce85284dc0b419d7b89c8e567c09f upstream.

When disconnected sometimes the cdc-acm driver logs errors like these:

[20278.039417] cdc_acm 2-2:2.1: urb 9 failed submission with -19
[20278.042924] cdc_acm 2-2:2.1: urb 10 failed submission with -19
[20278.046449] cdc_acm 2-2:2.1: urb 11 failed submission with -19
[20278.049920] cdc_acm 2-2:2.1: urb 12 failed submission with -19
[20278.053442] cdc_acm 2-2:2.1: urb 13 failed submission with -19
[20278.056915] cdc_acm 2-2:2.1: urb 14 failed submission with -19
[20278.060418] cdc_acm 2-2:2.1: urb 15 failed submission with -19

Silence these by not logging errors when the result is -ENODEV.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/class/cdc-acm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -353,7 +353,7 @@ static int acm_submit_read_urb(struct ac
 
 	res = usb_submit_urb(acm->read_urbs[index], mem_flags);
 	if (res) {
-		if (res != -EPERM) {
+		if (res != -EPERM && res != -ENODEV) {
 			dev_err(&acm->data->dev,
 					"%s - usb_submit_urb failed: %d\n",
 					__func__, res);
