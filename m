Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224iOBEVPXLS/Fp+cHOF1QzlFS19A+R6z2EBiuPEG9y26wLxspIoR78yRuWeOPgdzyfSoINo
ARC-Seal: i=1; a=rsa-sha256; t=1517855176; cv=none;
        d=google.com; s=arc-20160816;
        b=w9OHDerEVInG0d5zndvmKrtulPtiRlfWDhDT8vfEII0jjnkbgtHDpQnYasFm93Hvgg
         K2JkZYzVqMHD6kUjDioaBhdV1EmbyVK07BGVC2GbgP2wIJ/7KI50zLHIhfCYrDk1zGVp
         Xobms1ivxzI/AeLEpaC558SOhc1Ib2l8ZPodTQwxsOVK0VOhBpFM7Gxnm6hqG+twEIP+
         Q23KVCZQ8IMM0N3iRDnLOEHFhakHbHdKWAGZFmP5o6hIDWL4CZpwJwT4o1G4PkL4EoNs
         fGARJssiuy1pUMGdMmgnia9m5xSixuK7w0iX7hQX0hnTowZo1mpFz9XwltJDI1iAzjzk
         //7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DWork4z6GULtMT9qTcsUU124jH9YWkyhqXLzYoJu2PY=;
        b=oY5/lMnGVsCMOYyY5+c7Nrla3Uysm5SgFvg9UPs2t7kZJKUs6R6bemDLwOEAdXqJ3d
         GFpWHvfVKB12LBaFv+fDt8iVvQosHgGq1OAX844pHSMl19Yvo6jzt+ekXays0fkQIz1J
         f9Bl/5nzBw6NxPQYxw4BF8rQYGWikJf2TtVnzKZvT03yCJ9etXT9c0MbLxl2kb8/PjRw
         o7zvBjyEuMplpRAIcj9WMXrZo8FLskoz7gxJbQv6AWDRXSHdyWdJQFscTbW9og63+Pdt
         QrV5xWYk5NY/Vu1tFXB00+d5rhYX0lRCQXZzZA9WtrRS3GZry4+nhDnWYJWq3cvdl6Ur
         CaBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eduardo Otubo <otubo@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 15/36] xen-netfront: remove warning when unloading module
Date: Mon,  5 Feb 2018 10:23:43 -0800
Message-Id: <20180205182352.401594585@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586509413697592?=
X-GMAIL-MSGID: =?utf-8?q?1591586509413697592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -85,6 +85,8 @@ struct netfront_cb {
 /* IRQ name is queue name with "-tx" or "-rx" appended */
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
+static DECLARE_WAIT_QUEUE_HEAD(module_unload_q);
+
 struct netfront_stats {
 	u64			rx_packets;
 	u64			tx_packets;
@@ -2080,10 +2082,12 @@ static void netback_changed(struct xenbu
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
@@ -2305,6 +2309,20 @@ static int xennet_remove(struct xenbus_d
 
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
 
 	xennet_sysfs_delif(info->netdev);
