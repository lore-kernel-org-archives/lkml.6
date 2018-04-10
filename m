Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AIpwx4/7cyMKV1Ei0ljD0/FjB8UgIeFv4NrgP7XBBlqXB1BhB0ylF3trGRO5mBTx38m1bsi3e0Mi
ARC-Seal: i=1; a=rsa-sha256; t=1523366515; cv=none;
        d=google.com; s=arc-20160816;
        b=DaHwdv9tEutE2nTvNi1Te46hw0zFAOVWiv0GeWNBQgAkIZrkbLJoSRgdJaYtC1GBkv
         i/CgXSKNpTWZjlU5o/e+z0epCBHnWGs4JVofmUhPhur5sXgCQStWnKsFCd7MQdapF+PB
         59rqd4dCJ71lKnBfImw3CX38Lprt710u5oDMpjIBUJnIykXt/lVEcv+bHGheTmOkfLQo
         jwNwr8fKGsmhfBzJpw831LBHAhrIUSE35e+U14dTcMunpzWEbvyXlvSGvg8WLo7eCCJZ
         vSTMcSqO+2z5szW+IUloE9KoVwFoOK4NucSEoaFfPFe/Csjr3k2iWFAsvvH3pl0b+re3
         cJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=hEbN5SCb8hlel0UTdBIgIXD49akFLV03F/2E7L8GAIQ=;
        b=ktZY3XYQdZgCK/knyh20v3QliWS6zlr0JT1kyGuOgpYLX/3R8ZfEs5ClNbW7yo0Eke
         GtGcrS1hicRwKtdPaJQ1jbiNcpGSOqo4s8eTUT3PLyc0UOiqpfdwaSjXmjVP5SQq5zwQ
         wbPF4o3gvyAqBty8OSFnxc+4QDLJzCppD+NPb332BfFK0OsGbCNJwPmRxYgUPsMS/qhD
         XGhdrKOBazdkZBLDQmMoeQHyrGAefYmYBJyxBcXXVnnsV3tXFbAbFKHN8uG/UaTAhC2e
         +iuCfRFpYK6p4jw7B5P26fL4va0DaQ17/d2gKClhAQvF0zOZHR6we3WZO5Zx5YEiniKc
         DuPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:18 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/4] ARM: amba: Make driver_override output consistent with other buses
Date: Tue, 10 Apr 2018 15:21:43 +0200
Message-Id: <1523366506-19832-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567321703916?=
X-GMAIL-MSGID: =?utf-8?q?1597365567321703916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For AMBA devices with unconfigured driver override, the
"driver_override" sysfs virtual file is empty, while it contains
"(null)" for platform and PCI devices.

Make AMBA consistent with other buses by dropping the test for a NULL
pointer.

Note that contrary to popular belief, sprintf() handles NULL pointers
fine; they are printed as "(null)".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/amba/bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228d2f021123..6ffd778352e6d953 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -70,9 +70,6 @@ static ssize_t driver_override_show(struct device *_dev,
 {
 	struct amba_device *dev = to_amba_device(_dev);
 
-	if (!dev->driver_override)
-		return 0;
-
 	return sprintf(buf, "%s\n", dev->driver_override);
 }
 
-- 
2.7.4
