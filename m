Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELv3VAY8BZclJoLKD0T5uAiu2p7mFewgR/kQlre0s+YEVHn/UoYavulNb+rXAfZMAUVpsemz
ARC-Seal: i=1; a=rsa-sha256; t=1519836614; cv=none;
        d=google.com; s=arc-20160816;
        b=UqFszrCuwhq6hflKXldi2eETTonaMPxLsN1Win7yyi6JBI7qwp2yTWPxCRTs8va2Kt
         Qsgq3MfkiFBZ5rH02Bt8LDU2RFums4yQtWZ9P5l/ZTgeedoxUVgIP1YkUvhewrga0n2C
         u01PEdK6QKOvlYgA4+42r3kH/R2QngDL+L/AgalPcXDY84IrSJtb9NTeUCv+QCVbufQz
         XNxKXhk70EWSlTh2shK3hGb415aA8d9gjvuUbA1PxGp5M6bKiwdhdaa0R6Ik5Es9uFii
         u4TFvOyetLkW8TrQn6JCEhd+EK7gAZsHjKJsF1DGs4H2ygg+bvUNbKZWUeCXKIGrK4nv
         8iGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=TkvVKiDdrSdhTcQorRw5nwSma3dKcjPAp28SJiYvvHs=;
        b=AlSxEQigr8tcsl9RydUDz0VDHkVHAonLgm2qIKPuTYNOa4Fv6eEmdJ506SSrToyf6z
         xDCAP7tpRT/mi/MCxgzn8lSUIWoTQbfcouxpn0qh9JPfNO1R9KzABmLikCjb33RmhtS8
         JKvWUXmqxvr4/G54kRyaZY/KKGuwfWG0Def0JMfnQZOWXcUSq1bmg5XA49Ikqrq22WLl
         6Eo79ZQgL7dDH53Epr8xErcaiDrA0hdlo7tXGc1+C2O2bnxUEujnmf/+/s2Uwd6k1wgd
         XBAnR6tnVPqHHYQJKVBwjnA/A8EDGWKicfd3t6md5SJh7PiiDTqn7K+CowblREm4IjkV
         ugpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "William Breathitt Gray" <vilhelm.gray@gmail.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.126018723@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 028/254] isa: Prevent NULL dereference in isa_bus
 driver callbacks
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658658225391842?=
X-GMAIL-MSGID: =?utf-8?q?1593664198144202984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: William Breathitt Gray <vilhelm.gray@gmail.com>

commit 5a244727f428a06634f22bb890e78024ab0c89f3 upstream.

The isa_driver structure for an isa_bus device is stored in the device
platform_data member of the respective device structure. This
platform_data member may be reset to NULL if isa_driver match callback
for the device fails, indicating a device unsupported by the ISA driver.

This patch fixes a possible NULL pointer dereference if one of the
isa_driver callbacks to attempted for an unsupported device. This error
should not occur in practice since ISA devices are typically manually
configured and loaded by the users, but we may as well prevent this
error from popping up for the 0day testers.

Fixes: a5117ba7da37 ("[PATCH] Driver model: add ISA bus")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/base/isa.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -39,7 +39,7 @@ static int isa_bus_probe(struct device *
 {
 	struct isa_driver *isa_driver = dev->platform_data;
 
-	if (isa_driver->probe)
+	if (isa_driver && isa_driver->probe)
 		return isa_driver->probe(dev, to_isa_dev(dev)->id);
 
 	return 0;
@@ -49,7 +49,7 @@ static int isa_bus_remove(struct device
 {
 	struct isa_driver *isa_driver = dev->platform_data;
 
-	if (isa_driver->remove)
+	if (isa_driver && isa_driver->remove)
 		return isa_driver->remove(dev, to_isa_dev(dev)->id);
 
 	return 0;
@@ -59,7 +59,7 @@ static void isa_bus_shutdown(struct devi
 {
 	struct isa_driver *isa_driver = dev->platform_data;
 
-	if (isa_driver->shutdown)
+	if (isa_driver && isa_driver->shutdown)
 		isa_driver->shutdown(dev, to_isa_dev(dev)->id);
 }
 
@@ -67,7 +67,7 @@ static int isa_bus_suspend(struct device
 {
 	struct isa_driver *isa_driver = dev->platform_data;
 
-	if (isa_driver->suspend)
+	if (isa_driver && isa_driver->suspend)
 		return isa_driver->suspend(dev, to_isa_dev(dev)->id, state);
 
 	return 0;
@@ -77,7 +77,7 @@ static int isa_bus_resume(struct device
 {
 	struct isa_driver *isa_driver = dev->platform_data;
 
-	if (isa_driver->resume)
+	if (isa_driver && isa_driver->resume)
 		return isa_driver->resume(dev, to_isa_dev(dev)->id);
 
 	return 0;
