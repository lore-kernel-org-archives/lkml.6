Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeERVeI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:34:08 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39276 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeERVeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:34:05 -0400
X-Google-Smtp-Source: AB8JxZoGgPuXXnDOnL5XvMmn0Nwq+tAWlamfw4NsNz+t1LuaqQlmBwGDaxys85PWvMkl311JcTOmUg==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Armin Schindler <mac@melware.de>,
        Karsten Keil <isdn@linux-pingi.de>,
        netdev@vger.kernel.org (open list:ISDN SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] isdn: eicon: fix a missing-check bug
Date: Fri, 18 May 2018 16:33:47 -0500
Message-Id: <1526679228-1596-1-git-send-email-wang6495@umn.edu>
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

This patch reuses the data copied in
diva_xdi_open_adapter() and passes it to diva_xdi_write(). This way, the
above issues can be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/isdn/hardware/eicon/diva.c      | 20 +++++++++++++-------
 drivers/isdn/hardware/eicon/diva.h      |  5 +++--
 drivers/isdn/hardware/eicon/divasmain.c | 18 +++++++++++-------
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/isdn/hardware/eicon/diva.c b/drivers/isdn/hardware/eicon/diva.c
index 944a7f3..fa239d8 100644
--- a/drivers/isdn/hardware/eicon/diva.c
+++ b/drivers/isdn/hardware/eicon/diva.c
@@ -388,10 +388,9 @@ void divasa_xdi_driver_unload(void)
 **  Receive and process command from user mode utility
 */
 void *diva_xdi_open_adapter(void *os_handle, const void __user *src,
-			    int length,
+			    int length, diva_xdi_um_cfg_cmd_t *msg,
 			    divas_xdi_copy_from_user_fn_t cp_fn)
 {
-	diva_xdi_um_cfg_cmd_t msg;
 	diva_os_xdi_adapter_t *a = NULL;
 	diva_os_spin_lock_magic_t old_irql;
 	struct list_head *tmp;
@@ -401,21 +400,21 @@ void *diva_xdi_open_adapter(void *os_handle, const void __user *src,
 			 length, sizeof(diva_xdi_um_cfg_cmd_t)))
 			return NULL;
 	}
-	if ((*cp_fn) (os_handle, &msg, src, sizeof(msg)) <= 0) {
+	if ((*cp_fn) (os_handle, msg, src, sizeof(*msg)) <= 0) {
 		DBG_ERR(("A: A(?) open, write error"))
 			return NULL;
 	}
 	diva_os_enter_spin_lock(&adapter_lock, &old_irql, "open_adapter");
 	list_for_each(tmp, &adapter_queue) {
 		a = list_entry(tmp, diva_os_xdi_adapter_t, link);
-		if (a->controller == (int)msg.adapter)
+		if (a->controller == (int)msg->adapter)
 			break;
 		a = NULL;
 	}
 	diva_os_leave_spin_lock(&adapter_lock, &old_irql, "open_adapter");
 
 	if (!a) {
-		DBG_ERR(("A: A(%d) open, adapter not found", msg.adapter))
+		DBG_ERR(("A: A(%d) open, adapter not found", msg->adapter))
 			}
 
 	return (a);
@@ -437,7 +436,8 @@ void diva_xdi_close_adapter(void *adapter, void *os_handle)
 
 int
 diva_xdi_write(void *adapter, void *os_handle, const void __user *src,
-	       int length, divas_xdi_copy_from_user_fn_t cp_fn)
+	       int length, diva_xdi_um_cfg_cmd_t *msg,
+	       divas_xdi_copy_from_user_fn_t cp_fn)
 {
 	diva_os_xdi_adapter_t *a = (diva_os_xdi_adapter_t *) adapter;
 	void *data;
@@ -459,7 +459,13 @@ diva_xdi_write(void *adapter, void *os_handle, const void __user *src,
 			return (-2);
 	}
 
-	length = (*cp_fn) (os_handle, data, src, length);
+	if (msg) {
+		*(diva_xdi_um_cfg_cmd_t *)data = *msg;
+		length = (*cp_fn) (os_handle, (char *)data + sizeof(*msg),
+				   src + sizeof(*msg), length - sizeof(*msg));
+	} else {
+		length = (*cp_fn) (os_handle, data, src, length);
+	}
 	if (length > 0) {
 		if ((*(a->interface.cmd_proc))
 		    (a, (diva_xdi_um_cfg_cmd_t *) data, length)) {
diff --git a/drivers/isdn/hardware/eicon/diva.h b/drivers/isdn/hardware/eicon/diva.h
index b067032..eb454c5 100644
--- a/drivers/isdn/hardware/eicon/diva.h
+++ b/drivers/isdn/hardware/eicon/diva.h
@@ -20,10 +20,11 @@ int diva_xdi_read(void *adapter, void *os_handle, void __user *dst,
 		  int max_length, divas_xdi_copy_to_user_fn_t cp_fn);
 
 int diva_xdi_write(void *adapter, void *os_handle, const void __user *src,
-		   int length, divas_xdi_copy_from_user_fn_t cp_fn);
+		   int length, diva_xdi_um_cfg_cmd_t *msg,
+		   divas_xdi_copy_from_user_fn_t cp_fn);
 
 void *diva_xdi_open_adapter(void *os_handle, const void __user *src,
-			    int length,
+			    int length, diva_xdi_um_cfg_cmd_t *msg,
 			    divas_xdi_copy_from_user_fn_t cp_fn);
 
 void diva_xdi_close_adapter(void *adapter, void *os_handle);
diff --git a/drivers/isdn/hardware/eicon/divasmain.c b/drivers/isdn/hardware/eicon/divasmain.c
index b9980e8..b6a3950 100644
--- a/drivers/isdn/hardware/eicon/divasmain.c
+++ b/drivers/isdn/hardware/eicon/divasmain.c
@@ -591,19 +591,22 @@ static int divas_release(struct inode *inode, struct file *file)
 static ssize_t divas_write(struct file *file, const char __user *buf,
 			   size_t count, loff_t *ppos)
 {
+	diva_xdi_um_cfg_cmd_t msg;
 	int ret = -EINVAL;
 
 	if (!file->private_data) {
 		file->private_data = diva_xdi_open_adapter(file, buf,
-							   count,
+							   count, &msg,
 							   xdi_copy_from_user);
-	}
-	if (!file->private_data) {
-		return (-ENODEV);
+		if (!file->private_data)
+			return (-ENODEV);
+		ret = diva_xdi_write(file->private_data, file,
+				     buf, count, &msg, xdi_copy_from_user);
+	} else {
+		ret = diva_xdi_write(file->private_data, file,
+				     buf, count, NULL, xdi_copy_from_user);
 	}
 
-	ret = diva_xdi_write(file->private_data, file,
-			     buf, count, xdi_copy_from_user);
 	switch (ret) {
 	case -1:		/* Message should be removed from rx mailbox first */
 		ret = -EBUSY;
@@ -622,11 +625,12 @@ static ssize_t divas_write(struct file *file, const char __user *buf,
 static ssize_t divas_read(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos)
 {
+	diva_xdi_um_cfg_cmd_t msg;
 	int ret = -EINVAL;
 
 	if (!file->private_data) {
 		file->private_data = diva_xdi_open_adapter(file, buf,
-							   count,
+							   count, &msg,
 							   xdi_copy_from_user);
 	}
 	if (!file->private_data) {
-- 
2.7.4
