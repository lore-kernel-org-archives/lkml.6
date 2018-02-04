Return-Path: <Jason@zx2c4.com>
X-Google-Smtp-Source: AH8x2254c8bUeDrU1FwZsdGvyxecEIYXrXG7WiqfIAU5Wp2a683teST2Bjs4yhCagYANrAuJv34W
ARC-Seal: i=1; a=rsa-sha256; t=1517782081; cv=none;
        d=google.com; s=arc-20160816;
        b=r1c3E50WWqhCHr3zLc5n4fMJJoIXG7ICYjGUQAaM3EodAJZtv6i248bPzDJbZ+CcA0
         JPRlAOt1H568lSFVeJNQJuYWBgzx1tsRfoX1oWa6eVxlx8uVMkKUE7JztFv/V3xfDOiI
         a9P/MPqUdrwy6NYyuDFhHPh8wsdJv3qG4wQeMzvICThjoGEbN7ZUjM60d6JEJrVVPLJA
         3njK8ik/+MBfPGY9X7sm5oVPHREn+qlFhGSfUnWldnZVgUNQfH//9yTQPAmyaZ8pbzeZ
         8fIBEpuoAxZEujSPbLyTYXnORSxkvHVBB36XMdXgdWPPNxDU5PXe6dsHoyIZll/uoTtB
         3QIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=t3RbKZtssbt+82Djxa+mVOhqKk3q7vM786Skcj2SA7E=;
        b=hjGl58BSbKS08Fy8Ii1iInYKDKjGySziPsKBr1Si87CMs+bQtCeX4rR/udnIr1ACVa
         G+t8GJoMzH1VU+XtGVSDr4AX0RzIxqAcYLM4CN3vKTMmsUCZF0GqlYBLw403zmDuddyc
         5FkTqTe2zTAlzx1HyUYlXtPKfDiKuKTszlfux7d2/dQI0+kKiEQfoZAghR1ueSd1b5l2
         2vuEk+LFGUTzR3ePo+8gx5JUREMsBHJYgahGIdeYXFSfpvot9KUSjV5HOjqGNCJM1GSU
         TydPgqTXbMRDnAViJZPertJCcaqBN6h/T+7ZoTomkONhjC5iiIZuo0nBSJfS0ai/2mhB
         HrWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@zx2c4.com header.s=mail header.b=lkxHYhTN;
       spf=pass (google.com: domain of jason@zx2c4.com designates 192.95.5.64 as permitted sender) smtp.mailfrom=Jason@zx2c4.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=zx2c4.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@zx2c4.com header.s=mail header.b=lkxHYhTN;
       spf=pass (google.com: domain of jason@zx2c4.com designates 192.95.5.64 as permitted sender) smtp.mailfrom=Jason@zx2c4.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=zx2c4.com
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tytso@mit.edu,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: always fill buffer in get_random_bytes_wait
Date: Sun,  4 Feb 2018 23:07:46 +0100
Message-Id: <20180204220746.12441-1-Jason@zx2c4.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591509863893639891?=
X-GMAIL-MSGID: =?utf-8?q?1591509863893639891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the unfortunate event that a developer fails to check the return
value of get_random_bytes_wait, or simply wants to make a "best effort"
attempt, for whatever that's worth, it's much better to still fill the
buffer with _something_ rather than catastrophically failing in the case
of an interruption. This is both a defense in depth measure against
inevitable programming bugs, as well as a means of making the API a bit
more useful.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/random.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 4024f7d9c77d..2ddf13b4281e 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -85,10 +85,8 @@ static inline unsigned long get_random_canary(void)
 static inline int get_random_bytes_wait(void *buf, int nbytes)
 {
 	int ret = wait_for_random_bytes();
-	if (unlikely(ret))
-		return ret;
 	get_random_bytes(buf, nbytes);
-	return 0;
+	return ret;
 }
 
 #define declare_get_random_var_wait(var) \
-- 
2.16.1
