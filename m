Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523460171; cv=none;
        d=google.com; s=arc-20160816;
        b=T461VlO5ENLApTqfKGMnmJwE++0jkUCibbvrRESrzTQ3PBRwe+FZkO5pFPTeB0FfAF
         vqDY+VaqTOkAiiGniOzcjQSxRNzIY/y+isfn7wbYwz8eUIeeUfL5eEs2fEfqUOoMBoSZ
         +py5nB7/TG01YTW7b2K9gik0zzfooCG+Evw6752HH7oPMPRYMDxrP4B0D3bteIXOsSZn
         l2PyeVTC0PEYR2Q5frEUcUYm79xv3GfsQG7nPLwAM6QtRNawEAzSLDbqpUYI1hmXarLH
         7BBMhkVRAk2md+XsG8lDYtDnK3kA2mhlHReJL+XxKus1ZNopFtG4QeEz8HjUBBfx44Ao
         Getg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=0WLkwDDAmJBMsuije6Ne2n58XPT2GXnQ4A/MHNMnLDk=;
        b=VWH7z9j5OU1gNGcfUMXcUm4orVMQC4E55cevgw85h9I0FIcEzUihf67KKgdv4eIApN
         9feIz34Hcd4W5aCWqNeZNATqSymvTt0rFcEXodWF9xj46N2oQberNT6Jjq+7bSSjw34E
         wgC6zLv3+PEjnm0DnN4yKy/i8bYXAebRJXvOQncTsF9FyOeyy5XzpUd57PorHLyIh6qu
         oeebWgUTiMW/56SdWBJP2ZVvRqYYN2r9J0By+ckzAmWuMFXPLF2221jUXncu5sh4D/bo
         HATxFrXNPvhy+or/9qTZ8NBnqQyH6D6TDGP43MZkgePbhDzpf6tNc+6TQ9Zr7z1ZKgiz
         roKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qoiLz1TW;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qoiLz1TW;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49OHpMQ8X67M/9TwWh4S+Wf+9kp59eLtWOsmNG7qA0hFG6uzgkK2t5C7qmzIH7xAZuXKA29gA==
From: Dmitry Vyukov <dvyukov@google.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] kobject: don't use WARN for registration failures
Date: Wed, 11 Apr 2018 17:22:43 +0200
Message-Id: <20180411152243.101848-1-dvyukov@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597463772984519976?=
X-GMAIL-MSGID: =?utf-8?q?1597463772984519976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This WARNING proved to be noisy. The function still returns an error
and callers should handle it. That's how most of kernel code works.
Downgrade the WARNING to pr_err() and leave WARNINGs for kernel bugs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com
Reported-by: syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com
Reported-by: syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com
Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>

---

For the record, here are only currently open syzbot bugs for this WARNING
(not counting older bugs and various duplicates). None of them were
acted on:

WARNING: kobject bug in gfs2_sys_fs_add
https://syzkaller.appspot.com/bug?id=057673a56dab61b3a447989b67f10b205111c8f4

WARNING: kobject bug in br_add_if
https://syzkaller.appspot.com/bug?id=3e0339080acd6a2a350a900bc6533b03f5498490

WARNING: kobject bug in netdev_queue_update_kobjects
https://syzkaller.appspot.com/bug?id=86a8e2ab50527d5a5eb4fad2fc15df609f22d86a

WARNING: kobject bug in device_add
https://syzkaller.appspot.com/bug?id=57eba87aff7669512fb68e56a932b01805342d13

For context see discussion here:
https://groups.google.com/d/msg/syzkaller-bugs/JZ9QSEaA_HA/wWvpywtBBQAJ
---
 lib/kobject.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index e1d1f290bf35..18989b5b3b56 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -233,13 +233,12 @@ static int kobject_add_internal(struct kobject *kobj)
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			WARN(1,
-			     "%s failed for %s with -EEXIST, don't try to register things with the same name in the same directory.\n",
-			     __func__, kobject_name(kobj));
+			pr_err("%s failed for %s with -EEXIST, don't try to register things with the same name in the same directory.\n",
+			       __func__, kobject_name(kobj));
 		else
-			WARN(1, "%s failed for %s (error: %d parent: %s)\n",
-			     __func__, kobject_name(kobj), error,
-			     parent ? kobject_name(parent) : "'none'");
+			pr_err("%s failed for %s (error: %d parent: %s)\n",
+			       __func__, kobject_name(kobj), error,
+			       parent ? kobject_name(parent) : "'none'");
 	} else
 		kobj->state_in_sysfs = 1;
 
-- 
2.17.0.484.g0c8726318c-goog
