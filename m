Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsAi84s2rwa21BDwpEOE6PX37sE2+A5XnyZ67a93SvBDp3yT5jhNxaeSlrXsqXxvnKiabJB
ARC-Seal: i=1; a=rsa-sha256; t=1519410835; cv=none;
        d=google.com; s=arc-20160816;
        b=QsOUg7RhZfQ1nv9KvZIy8xbNPAOKpxfzZTrBo42KFrVC9uVtRpja9/cn+Rs+u8/OqX
         If+SszRsU7gcr0nXSozfIYxfG4xv67jw+AaZ6s/wiiNyvyL2XuJDZHBEJ7Y3ONNGCTkY
         mV/LpGkgLqBfmMvBRIXrJrO0yUzi+kfIqk3cGrRxRjZK7cf62vgiIyXbqY+sDBNovs9A
         jz8BDk5lVppVPjxq0JJg7IHTTPEMHlKX12Y1957OSfvF/9jd+ocne17UmFveaLRQ9TOu
         cpJgjWLWeDdTA0+MgDR2uIPSCI4r5WvHxl1KyYNBUw5wui5dy5R/RqZ9JmpKoJ0Eu+gL
         LaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dKGWQdsAHE4ADxYjxNoqoOolS+aXuDH+T7A3SjaBRCo=;
        b=zFY5ILZ4xezPXY7vs6yOOxcy1GJNSrK+aMcMu3MzuPIzDDPS2ini9RIB0FIgalChC2
         UF0fofM9kN7gf8Cihke6cgz4xosmprztyuttG8xEV9RfBMLpx+Szd5Z7+1j5nr41E7ZS
         H4+fwUlgQPTsXVNR8E8F/ByRoFYOawA2aYx0hm5kRdygAJCv7jfOFJh76CMKADSG0Vvp
         A2y46G+l3KCKBnNlGv9Dw+c2EztLT7GBlTHSwzcSfEbd3j7TCFxxB4RjCjo8DIzKcJNQ
         z+S+PQ7lBExnjB6tlEtUGZL95BhDvmtlpBsxnFlAjBtdmova3xiSsNCQwfOt2svhV8Tr
         HLvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.4 029/193] usbip: keep usbip_device sockfd state in sync with tcp_socket
Date: Fri, 23 Feb 2018 19:24:22 +0100
Message-Id: <20180223170330.617450280@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217572786296075?=
X-GMAIL-MSGID: =?utf-8?q?1593217736188766574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -87,6 +87,7 @@ static ssize_t store_sockfd(struct devic
 			goto err;
 
 		sdev->ud.tcp_socket = socket;
+		sdev->ud.sockfd = sockfd;
 
 		spin_unlock_irq(&sdev->ud.lock);
 
@@ -186,6 +187,7 @@ static void stub_shutdown_connection(str
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 
 	/* 3. free used data */
@@ -280,6 +282,7 @@ static struct stub_device *stub_device_a
 	sdev->ud.status		= SDEV_ST_AVAILABLE;
 	spin_lock_init(&sdev->ud.lock);
 	sdev->ud.tcp_socket	= NULL;
+	sdev->ud.sockfd		= -1;
 
 	INIT_LIST_HEAD(&sdev->priv_init);
 	INIT_LIST_HEAD(&sdev->priv_tx);
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -797,6 +797,7 @@ static void vhci_shutdown_connection(str
 	if (vdev->ud.tcp_socket) {
 		sockfd_put(vdev->ud.tcp_socket);
 		vdev->ud.tcp_socket = NULL;
+		vdev->ud.sockfd = -1;
 	}
 	pr_info("release socket\n");
 
@@ -844,6 +845,7 @@ static void vhci_device_reset(struct usb
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
+		ud->sockfd = -1;
 	}
 	ud->status = VDEV_ST_NULL;
 
