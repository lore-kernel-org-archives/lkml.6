Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523286259; cv=none;
        d=google.com; s=arc-20160816;
        b=b2cDzA+sEd3CyWuwCLcbvejV6lapWPJl3bRFXvGRiszVTc/+wmbmGwCEE8jFOTxt0o
         7IjhCmHx8opnqbbpDUrrwrVAEkohf4QHdVMn3nEE4OJnwOzkQ94J5kJ/ZpQr9zvS3GVd
         GHkwSBU7+rOx8xdWiflK6KyDWyEAyDtGiVAUaB1Q6f3pLAhNVwaHKV4SIY04urFDKu38
         lwmiPR15xAyJODv7dWm1w1h9E3Oopsshf+d7bNzQbfygV07VoH4z4adYBaIIbLq+utMI
         h7zKBB054h9Sq+gH+jMPP8lq+epooXl78iYj3Za4g2nBwd8zP6EFmh9P9RvvX1gIZCbn
         qu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=0MHfCDeR33w2xt5HIg9PiHknGU61a0eTblmtXOTYqik=;
        b=hz34K4YrgbwNYYj2eeuTypo0XKwadtW0IOATQ6uwzvU9SvAJDxpuLNFHqG0wsc3cDS
         LcBidrxomBxs0x0j9HtQEIhBfG1F5N+lwvhlX9+MYRFuHQw/S9/aMj6LEjzQkYtFqQWc
         fAqUh9CbvuqEBqRZbboHQoCNWBIEW1370GKHr4GWkWthabq4Sk9ZhyJQZaYAZ6on7njt
         Jxel5YOMMbJIxfWio7sM6KuV9LeWIG9uQFZfGRfdsJNKqRXLSy9NpB566QccPLFSRZfi
         CZFh0RrRKGB4Txj7NvxxyBUPUgvqbwBKpL5/UdYQW9Z7oJBU7JYQz412NEvOWAgcV6DI
         Ht2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f3VruVWT;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f3VruVWT;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48yTwFlYasopKEge9O1v0/v/h40WotHY7/eNRcF4KPnSzidesHkZFNyXCqXq/nSrpGow608lQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: boris.ostrovsky@oracle.com,
	jgross@suse.com,
	gregkh@linuxfoundation.org
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/4] xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_device_alloc
Date: Mon,  9 Apr 2018 23:04:12 +0800
Message-Id: <1523286252-26455-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597281412929880248?=
X-GMAIL-MSGID: =?utf-8?q?1597281412929880248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pcistub_device_alloc() is never called in atomic context.

The call chain ending up at pcistub_device_alloc() is:
[1] pcistub_device_alloc() <- pcistub_seize() <- pcistub_probe()
pcistub_probe() is only set as ".probe" in struct pci_driver.
This function is not called in atomic context.

Despite never getting called from atomic context,
pcistub_device_alloc() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/xen/xen-pciback/pci_stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 9e480fd..fecc536 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -71,7 +71,7 @@ static struct pcistub_device *pcistub_device_alloc(struct pci_dev *dev)
 
 	dev_dbg(&dev->dev, "pcistub_device_alloc\n");
 
-	psdev = kzalloc(sizeof(*psdev), GFP_ATOMIC);
+	psdev = kzalloc(sizeof(*psdev), GFP_KERNEL);
 	if (!psdev)
 		return NULL;
 
-- 
1.9.1
