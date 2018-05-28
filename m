Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939997AbeE1QSw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936724AbeE1KMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:12:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 151/185] usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS
Date: Mon, 28 May 2018 12:03:12 +0200
Message-Id: <20180528100109.698484447@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 946ef68ad4e45aa048a5fb41ce8823ed29da866a ]

Some UDC drivers (like the DWC3) expect that the response to a setup()
request is queued from within the setup function itself so that it is
available as soon as setup() has completed.

Upon receiving a setup request the function fs driver creates an event that
is made available to userspace. And only once userspace has acknowledged
that event the response to the setup request is queued.

So it violates the requirement of those UDC drivers and random failures can
be observed. This is basically a race condition and if userspace is able to
read the event and queue the response fast enough all is good. But if it is
not, for example because other processes are currently scheduled to run,
the USB host that sent the setup request will observe an error.

To avoid this the gadget framework provides the USB_GADGET_DELAYED_STATUS
return code. If a setup() callback returns this value the UDC driver is
aware that response is not yet available and can uses the appropriate
methods to handle this case.

Since in the case of function fs the response will never be available when
the setup() function returns make sure that this status code is used.

This fixed random occasional failures that were previously observed on a
DWC3 based system under high system load.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2987,7 +2987,7 @@ static int ffs_func_setup(struct usb_fun
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);
 
-	return 0;
+	return USB_GADGET_DELAYED_STATUS;
 }
 
 static void ffs_func_suspend(struct usb_function *f)
