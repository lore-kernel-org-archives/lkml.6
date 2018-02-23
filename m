Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Ig8zAbqu3IgRbS/xprohtFev/pmFzBCheHtwsJ2kHxK+EXqAq2wap7qB4sFX3pthIAwZi
ARC-Seal: i=1; a=rsa-sha256; t=1519412319; cv=none;
        d=google.com; s=arc-20160816;
        b=Lgx5nOH6CK2Qb1ODuJDnewu6oTiQQ2FdS3zYKtN+cp/KehiZ654emftcK+oZo0gADr
         U530yg27IFcu2D6W4+G3jpFBUizRztzZfzanocZBaW6AAoUs8Lf2nYx9QKy/k8qORxdN
         OGYHvYLyKlZ47p51UgokxBI8oM0npTiY8DUGJCrSK/ucqwgzxzWmG+HZv/TvWbywwEEU
         gGCIEMSqGwtECHH1QovH/cnOCns8U8FtX9dA63OWyxSgpd8/5HI2jI/n+nSu5vbO+E3C
         4XKlnEc+QzojI6b8RHuK3c40QIzJXyjp+k8uwSTi4lhV9GHrcjoduA5YJmbjxaShO0Tt
         7Xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qH5y7EcZN16NOhYzdGghET4RwtKQkdsqLCAvcRYn6W8=;
        b=Irn3bCFuaBKgy+W8XlVak7xBwoEwdZtrd6uyef46v+LJZBCk6HLIWkiX2Z0NmNteKh
         hVLVbt0XAE45sBJRqgQpm5e4T9KPC4vtH0YQX3SvshFZdACKxvtRDvQ+hvDMoF/e3AAF
         Jw6iSOnEqrVx3e/t1bbLaCA4vZjwsaj7GQw2GTp9kK58SRSrnRx/e7GGJ+sTaIIeTGLi
         1av7ZzJKEfyzzzFFRAse/ioK03eIhmY2I3f4EEusFnUjlPxx3S54rkPxbR9N8iTX0H6E
         QeQEazShsUOlWISBqVK62XtdWL1Yx5XeVZ5mXseQQX3hYjwG64WNCy1btekUiuyp1vTO
         42kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhengjun Xing <zhengjun.xing@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.15 39/45] xhci: xhci debugfs device nodes werent removed after device plugged out
Date: Fri, 23 Feb 2018 19:29:18 +0100
Message-Id: <20180223170721.532274481@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219292265434804?=
X-GMAIL-MSGID: =?utf-8?q?1593219292265434804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit 8c5a93ebf7ac56d47f879b3c7c2f8c83b40c2cdb upstream.

There is a bug after plugged out USB device, the device and its ep00
nodes are still kept, we need to remove the nodes in xhci_free_dev when
USB device is plugged out.

Fixes: 052f71e25a7e ("xhci: Fix xhci debugfs NULL pointer dereference in resume from hibernate")
Cc: <stable@vger.kernel.org> # v4.15
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3552,12 +3552,10 @@ static void xhci_free_dev(struct usb_hcd
 		virt_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
 		del_timer_sync(&virt_dev->eps[i].stop_cmd_timer);
 	}
-
+	xhci_debugfs_remove_slot(xhci, udev->slot_id);
 	ret = xhci_disable_slot(xhci, udev->slot_id);
-	if (ret) {
-		xhci_debugfs_remove_slot(xhci, udev->slot_id);
+	if (ret)
 		xhci_free_virt_device(xhci, udev->slot_id);
-	}
 }
 
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
