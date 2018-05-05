Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeEETdC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 15:33:02 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:43674 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeEETc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 15:32:59 -0400
X-Google-Smtp-Source: AB8JxZoRdfIpxLj5IcS25avFieaLEk6jxOrqUNifmjGjV4CtJS15AAsWFcbQtgslkgt/DSY/xsplfA==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Armin Schindler <mac@melware.de>,
        Karsten Keil <isdn@linux-pingi.de>,
        netdev@vger.kernel.org (open list:ISDN SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] isdn: eicon: fix a missing-check bug
Date: Sat,  5 May 2018 14:32:46 -0500
Message-Id: <1525548766-13017-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In divasmain.c, the function divas_write() firstly invokes the function
diva_xdi_open_adapter() to open the adapter that matches with the adapter
number provided by the user, and then invokes the function diva_xdi_write()
to perform the write operation using the matched adapter. The two functions
diva_xdi_open_adapter() and diva_xdi_write() are located in diva.c.

In diva_xdi_open_adapter(), the user command is copied to the object 'msg'
from the userspace pointer 'src' through the function pointer 'cp_fn',
which eventually calls copy_from_user() to do the copy. Then, the adapter
number 'msg.adapter' is used to find out a matched adapter from the
'adapter_queue'. A matched adapter will be returned if it is found.
Otherwise, NULL is returned to indicate the failure of the verification on
the adapter number.

As mentioned above, if a matched adapter is returned, the function
diva_xdi_write() is invoked to perform the write operation. In this
function, the user command is copied once again from the userspace pointer
'src', which is the same as the 'src' pointer in diva_xdi_open_adapter() as
both of them are from the 'buf' pointer in divas_write(). Similarly, the
copy is achieved through the function pointer 'cp_fn', which finally calls
copy_from_user(). After the successful copy, the corresponding command
processing handler of the matched adapter is invoked to perform the write
operation.

It is obvious that there are two copies here from userspace, one is in
diva_xdi_open_adapter(), and one is in diva_xdi_write(). Plus, both of
these two copies share the same source userspace pointer, i.e., the 'buf'
pointer in divas_write(). Given that a malicious userspace process can race
to change the content pointed by the 'buf' pointer, this can pose potential
security issues. For example, in the first copy, the user provides a valid
adapter number to pass the verification process and a valid adapter can be
found. Then the user can modify the adapter number to an invalid number.
This way, the user can bypass the verification process of the adapter
number and inject inconsistent data.

To avoid such issues, this patch adds a check after the second copy in the
function diva_xdi_write(). If the adapter number is not equal to the one
obtained in the first copy, (-4) will be returned to divas_write(), which
will then return an error code -EINVAL.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/isdn/hardware/eicon/diva.c      | 6 +++++-
 drivers/isdn/hardware/eicon/divasmain.c | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/eicon/diva.c b/drivers/isdn/hardware/eicon/diva.c
index 944a7f3..46cbf76 100644
--- a/drivers/isdn/hardware/eicon/diva.c
+++ b/drivers/isdn/hardware/eicon/diva.c
@@ -440,6 +440,7 @@ diva_xdi_write(void *adapter, void *os_handle, const void __user *src,
 	       int length, divas_xdi_copy_from_user_fn_t cp_fn)
 {
 	diva_os_xdi_adapter_t *a = (diva_os_xdi_adapter_t *) adapter;
+	diva_xdi_um_cfg_cmd_t *p;
 	void *data;
 
 	if (a->xdi_mbox.status & DIVA_XDI_MBOX_BUSY) {
@@ -461,7 +462,10 @@ diva_xdi_write(void *adapter, void *os_handle, const void __user *src,
 
 	length = (*cp_fn) (os_handle, data, src, length);
 	if (length > 0) {
-		if ((*(a->interface.cmd_proc))
+		p = (diva_xdi_um_cfg_cmd_t *) data;
+		if (a->controller != (int)p->adapter) {
+			length = -4;
+		} else if ((*(a->interface.cmd_proc))
 		    (a, (diva_xdi_um_cfg_cmd_t *) data, length)) {
 			length = -3;
 		}
diff --git a/drivers/isdn/hardware/eicon/divasmain.c b/drivers/isdn/hardware/eicon/divasmain.c
index b9980e8..a03c658 100644
--- a/drivers/isdn/hardware/eicon/divasmain.c
+++ b/drivers/isdn/hardware/eicon/divasmain.c
@@ -614,6 +614,9 @@ static ssize_t divas_write(struct file *file, const char __user *buf,
 	case -3:
 		ret = -ENXIO;
 		break;
+	case -4:
+		ret = -EINVAL;
+		break;
 	}
 	DBG_TRC(("write: ret %d", ret));
 	return (ret);
-- 
2.7.4
