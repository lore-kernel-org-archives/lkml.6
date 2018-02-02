Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224+xVZGntcqxwKcV8+NSg3RiK+NbjYcvf25b2OnCV8WbG4SJof7OiiULisix3tBBz7MXHD/
ARC-Seal: i=1; a=rsa-sha256; t=1517591064; cv=none;
        d=google.com; s=arc-20160816;
        b=LnVk9sB4IglQILH+uxU9xdttI46XyrZ/Y6hCpnfTp2ZEdVMONCwbv02YAVQ/vWI3CG
         A9mtpLCn7ryLlpPvgTf6nsBsh4LLfYV67Od0gCG22fgKnAHydzSI2nSrA/FVZAHmof0U
         JlHXSQK6QXEgeVtKKOiH3BctimvOAWCtphbSoLOuTMcsQuQhKKUlAIqYEL1HON6oNZVC
         he2WtDOYBhVP7cIy38K5rA1mhHj29uIA5ImSJNrlr8TNPoe8BSuvG1h10tZBf0Crun5T
         dq7LqcCjqmIbiJsv+1xOaLd8DoQVthkp2tbUx8g7hJ6eeTyyHLn4OmIyBbPNnG25GC6F
         P+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=97Exe6pDb6TNgzeoQq2ul+9LqHIdvGezGsvvoTMepZ0=;
        b=Lr7C7sXYFFpFkBPNzqen6YYPfZyCMpdI2eJpzuBBKJ03Yx843YloepjGcM68IXxmjs
         TpdY66sSc7PBOE1Q9B35PIbVqcxoDG0Oq3cjCUiGyNVfD/khyhI8htD7EUkxUMYiUtC6
         XL0jPZNtoBMEcv/77w41qK4MoMl2a0EWss3tigRIQx30momxP5ud5NE0h5yEv548LDO5
         7m8MNKNWOLx1yFSHYY2PSND47F6Ynu8NxwLN3slqjMdkOGFbt1/ll5A7e9fcon6lEx1l
         E0oMTaXTGJ/n0Mas8vjXKTBKm7bj72gWkpmhdZlzfDYWodhkdu8eHE9siBbJwDRKx9uG
         i4QA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eduardo Otubo <otubo@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 39/86] xen-netfront: remove warning when unloading module
Date: Fri,  2 Feb 2018 17:57:59 +0100
Message-Id: <20180202140826.028009460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309348392869647?=
X-GMAIL-MSGID: =?utf-8?q?1591309567903030213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduardo Otubo <otubo@redhat.com>


[ Upstream commit 5b5971df3bc2775107ddad164018a8a8db633b81 ]

v2:
 * Replace busy wait with wait_event()/wake_up_all()
 * Cannot garantee that at the time xennet_remove is called, the
   xen_netback state will not be XenbusStateClosed, so added a
   condition for that
 * There's a small chance for the xen_netback state is
   XenbusStateUnknown by the time the xen_netfront switches to Closed,
   so added a condition for that.

When unloading module xen_netfront from guest, dmesg would output
warning messages like below:

  [  105.236836] xen:grant_table: WARNING: g.e. 0x903 still in use!
  [  105.236839] deferring g.e. 0x903 (pfn 0x35805)

This problem relies on netfront and netback being out of sync. By the time
netfront revokes the g.e.'s netback didn't have enough time to free all of
them, hence displaying the warnings on dmesg.

The trick here is to make netfront to wait until netback frees all the g.e.'s
and only then continue to cleanup for the module removal, and this is done by
manipulating both device states.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -86,6 +86,8 @@ struct netfront_cb {
 /* IRQ name is queue name with "-tx" or "-rx" appended */
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
+static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
+
 struct netfront_stats {
 	u64			packets;
 	u64			bytes;
@@ -2051,10 +2053,12 @@ static void netback_changed(struct xenbu
 		break;
 
 	case XenbusStateClosed:
+		wake_up_all(&module_unload_q);
 		if (dev->state == XenbusStateClosed)
 			break;
 		/* Missed the backend's CLOSING state -- fallthrough */
 	case XenbusStateClosing:
+		wake_up_all(&module_unload_q);
 		xenbus_frontend_closed(dev);
 		break;
 	}
@@ -2160,6 +2164,20 @@ static int xennet_remove(struct xenbus_d
 
 	dev_dbg(&dev->dev, "%s\n", dev->nodename);
 
+	if (xenbus_read_driver_state(dev->otherend) != XenbusStateClosed) {
+		xenbus_switch_state(dev, XenbusStateClosing);
+		wait_event(module_unload_q,
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateClosing);
+
+		xenbus_switch_state(dev, XenbusStateClosed);
+		wait_event(module_unload_q,
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateClosed ||
+			   xenbus_read_driver_state(dev->otherend) ==
+			   XenbusStateUnknown);
+	}
+
 	xennet_disconnect_backend(info);
 
 	unregister_netdev(info->netdev);
