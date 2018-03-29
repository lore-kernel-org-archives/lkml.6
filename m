Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx49zHagCCqmNEWc0Orq12qYps9tIt+Dfa7qf0HJF2MF1ATNwk2PqkpaybBm1wcXlO3Fh9ctP
ARC-Seal: i=1; a=rsa-sha256; t=1522337344; cv=none;
        d=google.com; s=arc-20160816;
        b=iVUIE8jtMSaQfpqLNve7slgph8QphVClSA5VqKES4uwW5cdUQur/zm4duiK/ZKqkaA
         1TI6C5g5Mhv+IjPrDvzyOrGgFpjE9TCxyIEn923QkPBrU3+Mmo/2RPkPsScqYmSYpkfM
         RLwIu9Yh8nzqJSQx+BTFTY1+n1vLdJ/y9Ol1NV+XL7IQV6urtH46/liMJfxrd9Kk2d+y
         cSu6oegQWUAnNhKQM282dUorQ+zfUKJWN6/LNgyv1eYATBGuGfkUg9rOPfipLoPeqis4
         Clz2Tk/s+EapfHgetBwmnpmxTT3wmVFmnQ/ANQOl9oxZuKa7/yfEC1nHcgxspUxwBA/x
         EQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PTljvnt0UbHR/0aSeRrop9zdt0aZI+tTH4XrcgoC2lU=;
        b=ssuonWKKQwP4ACP4DVe0QWbXsADCUXAwQvkOl9s0WAxDINkXx6AZy3bGcTQnxPXPys
         ZMh8F3vXi2nSvl8rH9r3zraafX0kymKeRNO8GIixrt3LCTZRwQL2LZ9H8PXAP8mUg8tF
         8vsE3Ur4JjyUMDyoC549QOP++x/ramZQhphGYRpVU3Or8MFmB87iD8uX81hRqhmE4xDl
         ZWovxbqoIpUMikFnXgy76Yu1uwN9HLza/CKs62l77mDKGabpbQU+qwKMCVGeKXZbJLQQ
         TiXvpRxPzozofaFNPHQLpotRCkdcNHRMhOpu60idPUzGfwlbBnqJ+p8QZRD0APXDjZBs
         /neg==
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
	Michael Thayer <michael.thayer@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] virt: vbox: Log an error when we fail to get the host version
Date: Thu, 29 Mar 2018 17:28:57 +0200
Message-Id: <20180329152857.32694-4-hdegoede@redhat.com>
In-Reply-To: <20180329152857.32694-1-hdegoede@redhat.com>
References: <20180329152857.32694-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596270817967002344?=
X-GMAIL-MSGID: =?utf-8?q?1596286403557916873?=
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
2.17.0.rc1
