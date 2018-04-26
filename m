Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524757341; cv=none;
        d=google.com; s=arc-20160816;
        b=ZuG7Lw0c+gLeUcsEqDP0V5lcW5ACj3on4hQ5iUBbRYZg+ikL1cmeQCqjMic1AfFl3u
         W+uSwb1r2K7zroUf2dpV8Y4EB5DG31sNR7knTyIWq2Jw7+g224tq1hVo7zS6aKcUeG+J
         v+4yYdyUnQrR+lwghqon51XdiadqUf6CpYWOtEE44e0rbbgsdwnG2v3OKzOsRxXP+2ID
         r0/5iMp0dLyAHTKJPxNv6LBJ4KiUuRPu/IBbOXpMJnTROBKHmpWaTb2L+gW6LqrmcBJW
         xbxM5MyI+gHw5OR9tGnijOcNwqRcSwjNCIBDECFlPSYjAvSYJBJJhROEUjjrDXHfd9Of
         aaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=lShAgALU82Oh7seLjPtDXPQIN9V2v/kS65BJsLnAkU4=;
        b=kZimSTVeFkhnqy21xKG9V9864D3+1O52hG+t2v8WzTQakTgBdQi8R5iVRzEh7YskbG
         nsfADctbSI1OhL+VF4e2m3fTcYs+bK30qQCtv4+TghIJycNK1C3AodI+SxkQp4Ez7dKs
         ETLX9uBLjxgG+rCKcmPSTlkFRPd2vv0jELIqODumlVpT7pYS/nOmJjtP6HgldjcCekzE
         CmBcXzzF080+JlgJKJIm0e143lRuu9kb32RfVpsmomelbHDhZCuEQlWAKx9ucGXhQBj2
         ScZvqP4mY/BhCfVZq1Jjl9o5xT6EVVQ7M855rwtX7sV0Is0mUhbLH8g4NBmy26i8VKRT
         AsmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HqA0b9NF;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HqA0b9NF;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/P6U5sETWDeaLcgcvbHqBVOVo8RW4vsRzL9tFLnZKyLBmbYZfdjP4+AzwTZM9FNE4E1gc/eA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memory_hotplug: use put_device() if device_register fail
Date: Thu, 26 Apr 2018 21:12:09 +0530
Message-Id: <2987b5bdb31e7c18cd837da0f1e32a98fecd3278.1524757165.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823954747248901?=
X-GMAIL-MSGID: =?utf-8?q?1598823954747248901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

if device_register() returned an error. Always use put_device()
to give up the initialized reference and release allocated memory.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/base/memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index bffe861..f5e5601 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -649,13 +649,19 @@ static const struct attribute_group *memory_memblk_attr_groups[] = {
 static
 int register_memory(struct memory_block *memory)
 {
+	int ret;
+
 	memory->dev.bus = &memory_subsys;
 	memory->dev.id = memory->start_section_nr / sections_per_block;
 	memory->dev.release = memory_block_release;
 	memory->dev.groups = memory_memblk_attr_groups;
 	memory->dev.offline = memory->state == MEM_OFFLINE;
 
-	return device_register(&memory->dev);
+	ret = device_register(&memory->dev);
+	if (ret)
+		put_device(&memory->dev);
+
+	return ret;
 }
 
 static int init_memory_block(struct memory_block **memory,
-- 
2.7.4
