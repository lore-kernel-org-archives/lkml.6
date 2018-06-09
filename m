Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wPyeNtHyG1tfYAAAmS7hNA
	; Sat, 09 Jun 2018 15:32:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 72A2F608C8; Sat,  9 Jun 2018 15:32:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJRK8ZZb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9D0FF608BF;
	Sat,  9 Jun 2018 15:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D0FF608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeFIPcD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932341AbeFIPb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:59 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D6420896;
        Sat,  9 Jun 2018 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558318;
        bh=4ocQXgM48gCYYi6FjY2tJfR/++12OwPpAlwpW++3Jm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJRK8ZZb8EhREMVRnyxnKIa2gvfRwjxd/sgWNAYyWp6K9kMlKmuC2GEErjKXPt/PF
         eCqm2koF1eAmNTj+cqpVOBjYR8jTXhfBHxplF0knyRLS5Lvpm5/ktss/iuNsuqgMdQ
         xk1tA6NE1qqi6z6FrJFYHCFKTFSdn1t1rpHeSeRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 15/48] isdn: eicon: fix a missing-check bug
Date: Sat,  9 Jun 2018 17:29:27 +0200
Message-Id: <20180609145948.612797449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 6009d1fe6ba3bb2dab55921da60465329cc1cd89 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/hardware/eicon/diva.c      |   22 +++++++++++++++-------
 drivers/isdn/hardware/eicon/diva.h      |    5 +++--
 drivers/isdn/hardware/eicon/divasmain.c |   18 +++++++++++-------
 3 files changed, 29 insertions(+), 16 deletions(-)

--- a/drivers/isdn/hardware/eicon/diva.c
+++ b/drivers/isdn/hardware/eicon/diva.c
@@ -388,10 +388,10 @@ void divasa_xdi_driver_unload(void)
 **  Receive and process command from user mode utility
 */
 void *diva_xdi_open_adapter(void *os_handle, const void __user *src,
-			    int length,
+			    int length, void *mptr,
 			    divas_xdi_copy_from_user_fn_t cp_fn)
 {
-	diva_xdi_um_cfg_cmd_t msg;
+	diva_xdi_um_cfg_cmd_t *msg = (diva_xdi_um_cfg_cmd_t *)mptr;
 	diva_os_xdi_adapter_t *a = NULL;
 	diva_os_spin_lock_magic_t old_irql;
 	struct list_head *tmp;
@@ -401,21 +401,21 @@ void *diva_xdi_open_adapter(void *os_han
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
@@ -437,8 +437,10 @@ void diva_xdi_close_adapter(void *adapte
 
 int
 diva_xdi_write(void *adapter, void *os_handle, const void __user *src,
-	       int length, divas_xdi_copy_from_user_fn_t cp_fn)
+	       int length, void *mptr,
+	       divas_xdi_copy_from_user_fn_t cp_fn)
 {
+	diva_xdi_um_cfg_cmd_t *msg = (diva_xdi_um_cfg_cmd_t *)mptr;
 	diva_os_xdi_adapter_t *a = (diva_os_xdi_adapter_t *) adapter;
 	void *data;
 
@@ -459,7 +461,13 @@ diva_xdi_write(void *adapter, void *os_h
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
--- a/drivers/isdn/hardware/eicon/diva.h
+++ b/drivers/isdn/hardware/eicon/diva.h
@@ -20,10 +20,11 @@ int diva_xdi_read(void *adapter, void *o
 		  int max_length, divas_xdi_copy_to_user_fn_t cp_fn);
 
 int diva_xdi_write(void *adapter, void *os_handle, const void __user *src,
-		   int length, divas_xdi_copy_from_user_fn_t cp_fn);
+		   int length, void *msg,
+		   divas_xdi_copy_from_user_fn_t cp_fn);
 
 void *diva_xdi_open_adapter(void *os_handle, const void __user *src,
-			    int length,
+			    int length, void *msg,
 			    divas_xdi_copy_from_user_fn_t cp_fn);
 
 void diva_xdi_close_adapter(void *adapter, void *os_handle);
--- a/drivers/isdn/hardware/eicon/divasmain.c
+++ b/drivers/isdn/hardware/eicon/divasmain.c
@@ -591,19 +591,22 @@ static int divas_release(struct inode *i
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
@@ -622,11 +625,12 @@ static ssize_t divas_write(struct file *
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
