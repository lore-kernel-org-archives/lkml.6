Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDJKNe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:13:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:22587 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeDJKNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:13:33 -0400
Subject: Re: KASAN: null-ptr-deref Read in xattr_getsecurity
To: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <0000000000008d2e0d05697a693d@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
Date: Tue, 10 Apr 2018 19:13:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000008d2e0d05697a693d@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 904d07a6eb014f3df0c5a1ebfcfd4323276a9a76 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 10 Apr 2018 15:15:16 +0900
Subject: [PATCH] commoncap: Handle memory allocation failure.

syzbot is reporting NULL pointer dereference at xattr_getsecurity() [1],
for cap_inode_getsecurity() is returning sizeof(struct vfs_cap_data) when
memory allocation failed. Return -ENOMEM if memory allocation failed.

[1] https://syzkaller.appspot.com/bug?id=a55ba438506fe68649a5f50d2d82d56b365e0107

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 8db6c34f1dbc8e06 ("Introduce v3 namespaced file capabilities")
Reported-by: syzbot <syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com>
Cc: stable <stable@vger.kernel.org> # 4.14+
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 security/commoncap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index 48620c9..1ce701f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -449,6 +449,8 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 				magic |= VFS_CAP_FLAGS_EFFECTIVE;
 			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 			cap->magic_etc = cpu_to_le32(magic);
+		} else {
+			size = -ENOMEM;
 		}
 	}
 	kfree(tmpbuf);
--
1.8.3.1
