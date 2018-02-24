Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x225vhFeGwfOMsraKQEXCDpsWhpLTdk/rYCUvUBoHoJnBBq3XUT5R4lVbVTLpqt84x7MkV5Fb
ARC-Seal: i=1; a=rsa-sha256; t=1519441257; cv=none;
        d=google.com; s=arc-20160816;
        b=bLbZTx7sJq5QCeTTHNZ0c1Eas1uxHCb7kfrz4C9cC/3iErJx+TEGsmXQ0aQgIAxSjK
         uYx4qP3h10U6CygpH+HkiT/wXTVtFpNxi+sUxzSuUsN1hpbR/Il1XVDojSwk+Gx9Ce3m
         Thib1zTCnfdNBxba9JManm5mElmFwDPUvJUal8f13YarV9rV9EFBTV8oBOf7AYqcpEM1
         oz2mj24MgUC+M8Hl5BeEDVviLhfNbM5r9hpvC1q38iJRk19qvb89O9rOJ1BTIxs3rXWx
         b0Bgq0cOK35htTGpId9boLQEHOpYHslRKFu8/BoeDqTrohGFQpTQP6sVZzQoz7QvdnBn
         FwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter
         :arc-authentication-results;
        bh=OCE3fF+7jxP7YFZQZFIPZ+mMY5NJe7hn6HmpC6lyzRM=;
        b=B7USOwBblwsnXWL/vO6qHcw1h3TzwBRpycq9wB19Om+4CIlSLdQnEBR5susnGKfm5h
         fV5gyiBsEK0Bj4wTYDK2uqR7AxoIhdS6JenfBFudrhOU+StDM5pAC3Oh5zKyF1geIMHv
         cxkfcAys2QYXRMyoRiogGrqPWpTVlgZI8xcn1YUaLf+CTUKh5X5xQr+ASi9Ws+Nm0CKQ
         77uXoIQd/NYPTk5jLxc/h8/JuGpIW9APjLz9mmGycxDk5nvobHpOyg+xisYWPIybpVyo
         eqjNbplHuxXWtivx3gNSpqUtw8OBNAE56xZH3lHn34NfYJvuV61qipo0NoRC2f6gLdfw
         GU4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B57E21719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: akpm@linux-foundation.org
Cc: keescook@chromium.org,
	dmitry.torokhov@gmail.com,
	jeyu@redhat.com,
	rusty@rustcorp.com.au,
	mmarek@suse.com,
	pmladek@suse.com,
	mbenes@suse.cz,
	jpoimboe@redhat.com,
	linux@roeck-us.net,
	ebiederm@xmission.com,
	matt.redfearn@imgtec.com,
	dan.carpenter@oracle.com,
	colin.king@canonical.com,
	danielmentz@google.com,
	dcb314@hotmail.com,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] test_kmod: fix limit check on number of test devices created
Date: Fri, 23 Feb 2018 19:00:46 -0800
Message-Id: <20180224030046.24238-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593249635638091156?=
X-GMAIL-MSGID: =?utf-8?q?1593249635638091156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As reported by Dan the parentheses is in the wrong place, and since
unlikely() call returns either 0 or 1 it's never less than zero.
The second issue is that signed integer overflows like "INT_MAX + 1" are
undefined behavior.

Since num_test_devs represents the number of devices, we want to stop
prior to hitting the max, and not rely on the wrap arround at all. So
just cap at num_test_devs + 1, prior to assigning a new device.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 lib/test_kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index e372b97eee13..0e5b7a61460b 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1141,7 +1141,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
 	mutex_lock(&reg_dev_mutex);
 
 	/* int should suffice for number of devices, test for wrap */
-	if (unlikely(num_test_devs + 1) < 0) {
+	if (num_test_devs + 1 == INT_MAX) {
 		pr_err("reached limit of number of test devices\n");
 		goto out;
 	}
-- 
2.16.2
