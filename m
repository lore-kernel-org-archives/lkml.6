Return-Path: <mka@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522194991; cv=none;
        d=google.com; s=arc-20160816;
        b=ujni8ROU8EJ37S29B0A+P6pYTRFurp+rIyjhdcSxeEFvh5I2fRdLC+Y7WiefDUmeJu
         q1cBAPQmBRZXb2zszPsrPZuEOQ0iMNK7RLdgOlZsVZYW520BkM01NXCYfnJq41LT3edQ
         XJ5l/E+YwF/g5/4oNWQKV2+ojC9FhrLxNfw2qMUYUZs2D288wSKhB5ktkJwMZ487E4M8
         C3af3Fzf2XW7UwaZJDTojdwATV1gGQc8Da0e6YzJ+5K7S3hQaGhgAEqou2FYFKgUv2/2
         8dfqYf3KcY54rXTy/D2IjkLelkQNun0E7qrh4lNjdGX8dlFVwViw58dDwkOPsEO6gqGm
         FYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=EW3ra5+VVNrs8dMl9/hFvv0c7Pod61Q0Om6FjrQVFJA=;
        b=m3CApl+OgPdDEm2hdj4sR9fHe1NFJ9FlWUH6VIMVoWqDGnzR/7QUeuQAGy5Xe+O+Hw
         cibLWEAO+9zJ03wy7IHfJ+gEGrA0+7BzbKcGshLXURQDbbO5YS37gL1YqQ3egfc1k1Dz
         zFjXGahFPDumaX70d+S/ILtworI7YWUVgX4nk4x6iVRLCfI82uHcmeY7BNhFiTAYcUvk
         k1FULWElrrcYwMKXi8Czx6u8VdiQo4aPzmh+0OMzZn/UE1I9Kd11JeXU2qpgQ/rCoEqz
         D9MXgxISDIX571xFbzK2P7wKqlPRKhHVwT5NNI2jtXo3DkcRqv3r2FRSmKnfOQmmZMdf
         VTTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mka@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mka@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49Cmj4a7X2L37YRocnirq5p2riZ3KIlm50bj2pMTZiNY6XTsaV0ZssNcu2d1ir4Z9C1gzROeA==
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Manoj Gupta <manojgupta@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] debugfs: Check return value of debugfs_real_fops() for NULL
Date: Tue, 27 Mar 2018 16:55:53 -0700
Message-Id: <20180327235553.210165-1-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596137136019067169?=
X-GMAIL-MSGID: =?utf-8?q?1596137136019067169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

debugfs_real_fops() returns a NULL pointer when it is invoked without a
prior call to debugfs_file_get(). In code paths including this call it
is not strictly necessary to check the return value of
debugfs_real_fops(). However clang inlines debugfs_real_fops(), detects
the invalid dereferencing of the NULL pointer and drops the code path.
This leads to a bunch of objtool warnings when building with clang and
CONFIG_UNWINDER_ORC=y:

  fs/debugfs/file.o: warning: objtool: full_proxy_llseek() falls through to next function full_proxy_read()
  fs/debugfs/file.o: warning: objtool: full_proxy_read() falls through to next function full_proxy_write()
  fs/debugfs/file.o: warning: objtool: full_proxy_write() falls through to next function full_proxy_poll()
  fs/debugfs/file.o: warning: objtool: full_proxy_poll() falls through to next function full_proxy_unlocked_ioctl()
  fs/debugfs/file.o: warning: objtool: full_proxy_unlocked_ioctl() falls through to next function fops_u8_open()

Check the pointer returned by debugfs_real_fops() in all code paths to
make clang and objtool happy.

Debugged-by: Josh Poimboeuf <jpoimboe@redhat.com>
Debugged-by: Manoj Gupta <manojgupta@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 fs/debugfs/file.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index cd12e6576b48..427e185ecc8f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -183,7 +183,8 @@ static ret_type full_proxy_ ## name(proto)				\
 	if (unlikely(r))						\
 		return r;						\
 	real_fops = debugfs_real_fops(filp);				\
-	r = real_fops->name(args);					\
+	if (real_fops)							\
+		r = real_fops->name(args);				\
 	debugfs_file_put(dentry);					\
 	return r;							\
 }
@@ -217,7 +218,14 @@ static unsigned int full_proxy_poll(struct file *filp,
 		return POLLHUP;
 
 	real_fops = debugfs_real_fops(filp);
+	if (!real_fops) {
+		r = -ENXIO;
+		goto out;
+	}
+
 	r = real_fops->poll(filp, wait);
+
+out:
 	debugfs_file_put(dentry);
 	return r;
 }
-- 
2.17.0.rc1.321.gba9d0f2565-goog
