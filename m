Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvvqKeBiCJwE1eVWCTRGyJwcWFlaSeXx8kIseQ5K9iQjD7dXUAuctxbVzKy8vgjnL6e5Hex
ARC-Seal: i=1; a=rsa-sha256; t=1519412325; cv=none;
        d=google.com; s=arc-20160816;
        b=xmlKwjlvO7PTE9Vu1it1CfSFwn8NqyABAH6KT1dpA3p1AyJQTZyFY0qslf61zrLacY
         kIGKPVkQhfvvxC6RPNWPyCIdnIQ03OFGXgO/5jd0HfKYDgJipfnUIUxoP5X6IwfvOsXO
         VlyjBuNifkwS+799AM1c0AX99/a6PYe8Choch/U0IK0obxhmB/QxVho3nmVqETmY4OCZ
         ahjfb1xaXXg25PBIYQgT6ysvPQJIopLVXggRPru9UIBQZANCJynJd9o7DGaVKTAeISeW
         Et4EZS5xe/tg6Tv9Ym4z0iKkSa7GcvHY2XNQ4FnvzRROTSJyzkWjER++kcRUg/I8hHi8
         1KMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1ir5Y+4lagmAwwRuPdMGE3C8X+s7Q2tu2XHl6VWqh1k=;
        b=E0lJ2MFT4qLtg7t4QBxxCc7pbf/S/FeIEkRDicIr+LlOlw6fUIt+v6yZ+gqThMSJXB
         oxjzTegc5j3uoRC8teISZmny1/j7QamoNaabYXj/V5IiXcRP8WdsNk/PY204SR92LFr1
         fLDeNUbNZPxChV7o552s57Dkr0RqlWo8eQg49Jf1F20oMa0ut6OC8o2kGWj2TRm/uSpr
         iGxEv+E1kkk+znpfGuxCAn4d2ly+fvUMwmBb3TSjxgYmmPN5YsaPrbPSWjftr+qCEX+v
         x6os58L6Caifpf037xIKdw/bTOBqcVs3RZQsEvX2H5jJSd0DAJBXxAcxJZNVvXTqP/uv
         3Jdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.15 41/45] usbip: keep usbip_device sockfd state in sync with tcp_socket
Date: Fri, 23 Feb 2018 19:29:20 +0100
Message-Id: <20180223170721.895702679@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217572786296075?=
X-GMAIL-MSGID: =?utf-8?q?1593219298042303544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 009f41aed4b3e11e6dc1e3c07377a10c20f1a5ed upstream.

Keep usbip_device sockfd state in sync with tcp_socket. When tcp_socket
is reset to null, reset sockfd to -1 to keep it in sync.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c |    3 +++
 drivers/usb/usbip/vhci_hcd.c |    2 ++
 2 files changed, 5 insertions(+)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -73,6 +73,7 @@ static ssize_t store_sockfd(struct devic
 			goto err;
 
 		sdev->ud.tcp_socket = socket;
+		sdev->ud.sockfd = sockfd;
 
 		spin_unlock_irq(&sdev->ud.lock);
 
@@ -172,6 +173,7 @@ static void stub_shutdown_connection(str
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 
 	/* 3. free used data */
@@ -266,6 +268,7 @@ static struct stub_device *stub_device_a
 	sdev->ud.status		= SDEV_ST_AVAILABLE;
 	spin_lock_init(&sdev->ud.lock);
 	sdev->ud.tcp_socket	= NULL;
+	sdev->ud.sockfd		= -1;
 
 	INIT_LIST_HEAD(&sdev->priv_init);
 	INIT_LIST_HEAD(&sdev->priv_tx);
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -984,6 +984,7 @@ static void vhci_shutdown_connection(str
 	if (vdev->ud.tcp_socket) {
 		sockfd_put(vdev->ud.tcp_socket);
 		vdev->ud.tcp_socket = NULL;
+		vdev->ud.sockfd = -1;
 	}
 	pr_info("release socket\n");
 
@@ -1030,6 +1031,7 @@ static void vhci_device_reset(struct usb
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 	ud->status = VDEV_ST_NULL;
 
