Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523409431; cv=none;
        d=google.com; s=arc-20160816;
        b=okCnr13KICkz5oJpOEqQ9QNklsmdmg96d8ZJlEHzI5Z+5amyX059drNeCDSu428IYa
         +diNdpt9OMYtbmUarKFpm6fuvpqq8bdS/9COtif4AqMTIvEszMNSG02p69R+l/jsZp99
         p44218DiA2yf9y2AAfVyR+HT5eXReutbU+HdA5w3CryWcS7LenDZS+2M10HOKEcWG/2n
         uOS73h9OWyjCeWndgTEGSkn1BhPJmQTmah2O1wU6tnJTRWKL2P1rg5MinjDPEw63vtms
         Vuke478qAVZnlss1VnmNXS3uICOwA7FtbImNrNZKldsz7ktwVfMM9EXrRS1RrUB7damq
         6LCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ERITuvzwk45WMY0fHpHNUyZDbx3YfmdOyHSDK/C3ATc=;
        b=j0DEdIYkTfHJGdXDHd76an65220bwzb5Hx8vat2Y266ijyNnL85ZoYQ3gQsO2zcIHA
         TPdusFP2qcgwC6yBqlfG7WlDjTecxb9g0wJelw6XbsPhPSqhu2shQZnEZoALM9mD3AkA
         10bozZNW+etm+gOx+HlbuwrBW68/PTOmwXrm6fHbmb7H7IpHABqrOXIdDbVAN5ot5WkR
         oT4mPKo0VEOnYcdYT2stDYDXW6AlQDKD/q0FFaQepWVBhG3PybB8Q9WZ5SicjxLbJ5vY
         T1fKbl+BH4PBusrM5OHXCXYTfwKw7eo4jE/irn6j7iWjj/7axk7FeeIv9hanBe/cg1CU
         fCGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MalOCdBY;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MalOCdBY;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48Chi+RPrrUMsFcmqLs5+6vcAvQ8p71cQVEUggSFy/CuSkMnzdTm994A4cJqdiT8osfecKzjw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: boris.ostrovsky@oracle.com,
	jgross@suse.com,
	gregkh@linuxfoundation.org
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_reg_add
Date: Wed, 11 Apr 2018 09:15:31 +0800
Message-Id: <1523409331-1214-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597410567936443415?=
X-GMAIL-MSGID: =?utf-8?q?1597410567936443415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pcistub_reg_add() is never called in atomic context.

pcistub_reg_add() is only called by pcistub_quirk_add, which is 
only set in DRIVER_ATTR().

Despite never getting called from atomic context,
pcistub_reg_add() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/xen/xen-pciback/pci_stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 9e480fd..9d92bed 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -1149,7 +1149,7 @@ static int pcistub_reg_add(int domain, int bus, int slot, int func,
 	}
 	dev = psdev->dev;
 
-	field = kzalloc(sizeof(*field), GFP_ATOMIC);
+	field = kzalloc(sizeof(*field), GFP_KERNEL);
 	if (!field) {
 		err = -ENOMEM;
 		goto out;
-- 
1.9.1
