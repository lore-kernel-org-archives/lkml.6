Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr98mIVsjvKczMW5nLr2bMz6AwnOGzSnqbvlQmt16/G4NV/PlBfQlMX5xP8KkXknF36RY5S
ARC-Seal: i=1; a=rsa-sha256; t=1526937796; cv=none;
        d=google.com; s=arc-20160816;
        b=WN5Z9t/yAkUo52AkQlM7SJ2pTz0X79ubyKtMxcoNVM+NJJpFzCLuVVuYVVWkYMC9Iy
         3IPjQ+wso8NKFjEMV++jgjkBBcnEFJ/Fjbst5EnAu9ORgbSqQaTjqkLKzTL7Y+UAZa9D
         y4KCTBbW9iI8s7rTW+8DvDU/LzAcgLlQhqNnhuqzGhpn6WWDHlBrsodeetN14M6Co+FE
         kvO8iD+ndP8Cxe8Vys3vRCiF1RPf1J4oXXP9kfzCBKdN9ggAMkzzBptmAo1fwzSfy1qa
         hi/hk/WpmOwSHyY1a2hpzPUcbwG34zPjSLNQBs3QbIx6rzlc2Xng1EORR+0pMN7D2UN3
         mKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HocnZaxKl28O52yXCF3zY0vJAKpMDfU1Pkdy2gHPv6k=;
        b=Amrm5EhybdDs3TLDuSZMuvhXUtW4jUD5yL6tN+HwThuK0jWNjzGmPfsiNxYhkTaOYd
         ChSbaNzNBKWg4feKTx3A6Z13b0/IgijezJnwXdV4yKV/4kXphy/fV+4jPUQXKXgSwxWo
         5Lzeh1T7MprWtF7CjImsZARnmkgrGPw9QRooBL2xmpuyXXyr4YpStx8WsB7OxNmaLvNH
         pauMfCG50QWbEVw3CGZXF45ZYaNVxG4bk7bv/kDXdor9mFhhZCVSXJFCRrIPdiPia2rj
         /e/ZH8g3X+KQMc3EblzxcHjtvVFgDfcR+dGpeLaVZZbdZ1kHANfGwE083GUV4q0I40Og
         D2Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dAvruYnQ;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dAvruYnQ;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.16 003/110] usbip: usbip_host: delete device from busid_table after rebind
Date: Mon, 21 May 2018 23:11:00 +0200
Message-Id: <20180521210504.136082974@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109757512536317?=
X-GMAIL-MSGID: =?utf-8?q?1601110327061043988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit 1e180f167d4e413afccbbb4a421b48b2de832549 upstream.

Device is left in the busid_table after unbind and rebind. Rebind
initiates usb bus scan and the original driver claims the device.
After rescan the device should be deleted from the busid_table as
it no longer belongs to usbip_host.

Fix it to delete the device after device_attach() succeeds.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_main.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -186,6 +186,9 @@ static ssize_t rebind_store(struct devic
 	if (!bid)
 		return -ENODEV;
 
+	/* mark the device for deletion so probe ignores it during rescan */
+	bid->status = STUB_BUSID_OTHER;
+
 	/* device_attach() callers should hold parent lock for USB */
 	if (bid->udev->dev.parent)
 		device_lock(bid->udev->dev.parent);
@@ -197,6 +200,9 @@ static ssize_t rebind_store(struct devic
 		return ret;
 	}
 
+	/* delete device from busid_table */
+	del_match_busid((char *) buf);
+
 	return count;
 }
 
