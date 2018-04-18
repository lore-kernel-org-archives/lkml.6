Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZpdKf1PbQXy5AwoFRst0Emz6l0iYEkQyWCWv+CAh6SPzyQojsrYNutBz2dGirPz+xjWmLUR
ARC-Seal: i=1; a=rsa-sha256; t=1524057897; cv=none;
        d=google.com; s=arc-20160816;
        b=zP3rFr70TK0aR7YHdyt0fYuSN6JLNXZglaNnYCELOHKe7gZKyMRWauXkANI1uusyNX
         I8xX40pSMb25gkKMX/fh58YY8sF0xyrqcKsqfZHJBct4ykeY9sLVx33negOtYu9PrRv/
         gjqaKy00zVS8aRkvvhENoWOSQ+tcLVIhsAU53dd+vhGS56k9ber1CyFcrtA4EGt4VaQ3
         J83xg97SwMXb0VPnzHa4z04QaSHhxYRAz3cjubzOI0OVCQFHzUT66vhSqGpUjs4lCnxG
         9kyna762QDD/9htfrQtLERYG970El6RQSihiIubi2mZTDIdpGTPAC0loGryGHoCfP1ya
         HCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8hoxSwpOSdfWKayReu+qxtjt7ncsllrWaizx2bUlmI4=;
        b=iRcftCFH7I7PfivaG40S78gQz2I5UpL/Sj1P3EJEIIXiATJw4ka0vZ/kgnw9D54FsM
         mldSgZZLOYuBtfXW486ZhQHu/W/xa9CIWB150u2qMoWewb15TmfnacHiGj0YOL4eMmvx
         aZRWuxVH5HzdKxJVlB990S1JGnq1xva06ZqRP9fG1eixtY2SdMtEz2jt/+E2Msczvgfv
         MojcPMR8VTGkkj/0zp2MTgD43a/uEpaYQo8qHSp1vaC9/1q5Zhz8PO8MI1YOjoW2wU29
         tAu9t51HEgEoDABUY464OAgOalEe1sjXd11wf0Sl6JSCIsS7HWPG9gn1rr7cMXuxESJJ
         +DeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH resend 4/4] virt: vbox: Log an error when we fail to get the host version
Date: Wed, 18 Apr 2018 15:24:50 +0200
Message-Id: <20180418132450.11663-5-hdegoede@redhat.com>
In-Reply-To: <20180418132450.11663-1-hdegoede@redhat.com>
References: <20180418132450.11663-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598090533820721688?=
X-GMAIL-MSGID: =?utf-8?q?1598090533820721688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This was the only error path during probe without a message being logged
about what went wrong, this fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 7411a535fda2..2f3856a95856 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -727,8 +727,10 @@ static int vbg_query_host_version(struct vbg_dev *gdev)
 
 	rc = vbg_req_perform(gdev, req);
 	ret = vbg_status_code_to_errno(rc);
-	if (ret)
+	if (ret) {
+		vbg_err("%s error: %d\n", __func__, rc);
 		goto out;
+	}
 
 	snprintf(gdev->host_version, sizeof(gdev->host_version), "%u.%u.%ur%u",
 		 req->major, req->minor, req->build, req->revision);
-- 
2.17.0
