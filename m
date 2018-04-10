Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AIpwx48iue6kissDR059OdVnnp+XZNJHfwu9nTakNTnqA0hiN9nWwIhIn3zl05egRLdrE5y595xA
ARC-Seal: i=1; a=rsa-sha256; t=1523366514; cv=none;
        d=google.com; s=arc-20160816;
        b=pFga49i8+NtoZBvuYrZeTYNVDtcXjje0FHUWTj6oxTPaeQ3jVDpV23JwbGg8u2wX6c
         tt6iv/6frgqlZzkKVrDLDxYJlzbHWoLJa9W1yh69nmh/X+u3O6InPXaws5on13ijw1uN
         2dD2SHeQl1qXWDx4AOOBq1GMHwvbQcOLcMzqP224bdLtNTVmlBI8yYjbc8PUcVMjhDiZ
         jz3FT5/BRYx2LUc3tpE7Pr2wkPUFe4xDPw91yubM1WEovnw1bKfiZiJ6SeHPb9qsfN+z
         xqN5L+A4viTNS5zb3z8fVWpRbLEJHAd0wfoEH/R+PSZJh6sFAGjzsdfkhfqh1x+6IJBa
         0EUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=aoc4CEYMtxTABXN1SYtHAK3mOjOsZllmRW7oEROSsqA=;
        b=fjhrnOyv/+2G9+s04+SkJTlfZ3SYv5Tw4q2xtXZlS4dltVzRy537WesxYSuCU6+O06
         4/gZcKkpj6BR33KexInyZWChQ2IGvl5VSXO0wLaSWNqwwr0ztbKNXyqgc6QMx9CR123S
         0G4RGHcYf74K3pTB3vWLtHyHHD34dtKehIfFSYMAD2ZO+6Ci0aANC2EB+uqoc83ldVFP
         javmcRg8WDDQr/Db7vQb4mL5NR/F8k3iuYAVr4bojhYh6KalLtXgJhcyOrO4EUoqKi7T
         85VToulHHS6PYBKsmbftjCxiS/Y3RvqBTxsgUK8ytX13/skZHfY93UEs33548zKfplLv
         amKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
Date: Tue, 10 Apr 2018 15:21:44 +0200
Message-Id: <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365566189003865?=
X-GMAIL-MSGID: =?utf-8?q?1597365566189003865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver_override implementation is susceptible to a race condition
when different threads are reading vs storing a different driver
override.  Add locking to avoid this race condition.

Cfr. commits 6265539776a0810b ("driver core: platform: fix race
condition with driver_override") and 9561475db680f714 ("PCI: Fix race
condition with driver_override").

Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/amba/bus.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 6ffd778352e6d953..36c5653ced5742b7 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -69,8 +69,12 @@ static ssize_t driver_override_show(struct device *_dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct amba_device *dev = to_amba_device(_dev);
+	ssize_t len;
 
-	return sprintf(buf, "%s\n", dev->driver_override);
+	device_lock(_dev);
+	len = sprintf(buf, "%s\n", dev->driver_override);
+	device_unlock(_dev);
+	return len;
 }
 
 static ssize_t driver_override_store(struct device *_dev,
@@ -78,7 +82,7 @@ static ssize_t driver_override_store(struct device *_dev,
 				     const char *buf, size_t count)
 {
 	struct amba_device *dev = to_amba_device(_dev);
-	char *driver_override, *old = dev->driver_override, *cp;
+	char *driver_override, *old, *cp;
 
 	if (count > PATH_MAX)
 		return -EINVAL;
@@ -91,12 +95,15 @@ static ssize_t driver_override_store(struct device *_dev,
 	if (cp)
 		*cp = '\0';
 
+	device_lock(_dev);
+	old = dev->driver_override;
 	if (strlen(driver_override)) {
 		dev->driver_override = driver_override;
 	} else {
 	       kfree(driver_override);
 	       dev->driver_override = NULL;
 	}
+	device_unlock(_dev);
 
 	kfree(old);
 
-- 
2.7.4
