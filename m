Return-Path: <souvik1997@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522438384; cv=none;
        d=google.com; s=arc-20160816;
        b=xk4+1LITHlQxCkRGfheGyHqwbFbwjCb9aY0DmMKt4ys/WTomDzs/9eKe/9hIVzw5PP
         u27+BZzPOvfi+LrbClOJmoOct/276K/asZe9L7Pm7y2HbdavbPav7Ok/TeyARz5cpg9W
         Lpicmt/Hc2s7IcnXrh8za76coRoR2285JPbUgzf48Z/YaENBp3k5HSdRe1Y+pmCI9Q0y
         VFD1wHKQokcU9Ys95RBpfTGY8nKh9EJQN12y3vHxKpiOJ81CK9omopoaCT1dBAR5pV6L
         c38SqOakH3X/LezyQ2Ir8STtEa2vXSyWabbhTn0HGRPrHHNQ6qEVkl5gSME9kgqGa8UW
         oqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=JA4QwysT65TL3p4+ugmPWGXMv3XAzR4LYvjH/UZkpEg=;
        b=U8oUWLFYFK814EzfwHV/U6pJeX27fYVWGa3Losro9p3LUB449P0v4Etvj0vSt2+qpQ
         nLrQPOC69ZzkPFfnnmq1xAmAeyz0Vowr0i+X8lFSxmB9NqxTUdyOkUr+ad77ghPeI9xc
         yPo1eJ2VI+yW7LSh4Kh90TVTYywutrxHYMlGWSlI+t/YEssjXJ0usEYIoDhxqMDzSWrt
         CbClddF+m9/fja0wPv0TAyE5EVvtCae2/7ZdYxquudsVq6TAgOS09SW4DfNxm8e6aZ4Q
         INMx1JGbqOiVtMftsWKwVm4wwP8gcyqKHtBktxgH3KEFKF7LfvuPrUHXIFmILLLl60EI
         AOEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YdFmk8WL;
       spf=pass (google.com: domain of souvik1997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=souvik1997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YdFmk8WL;
       spf=pass (google.com: domain of souvik1997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=souvik1997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49KZ7iI3PeHtvRAsDI7YCcsKh+nt/n00zGParnppSleFr+eg5WLhsHIz+eiTiU/2lfJA3msMA==
From: Souvik Banerjee <souvik1997@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: souvik1997@gmail.com,
	Eric Biggers <ebiggers@google.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shaohua Li <shli@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blktrace: fix comment in blktrace_api.h
Date: Fri, 30 Mar 2018 14:32:42 -0500
Message-Id: <20180330193243.26044-1-souvik1997@gmail.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596392351859701170?=
X-GMAIL-MSGID: =?utf-8?q?1596392351859701170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The `__u64 time` field of the blk_io_trace struct refers to
the time in nanoseconds, not in microseconds. It is set in
__blk_add_trace, which does the following:

    t->time = ktime_to_ns(ktime_get());

ktime_to_ns returns ktime_t in nanoseconds, not microseconds.

Signed-off-by: Souvik Banerjee <souvik1997@gmail.com>
---
 include/uapi/linux/blktrace_api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 3c50e07ee833..690621b610e5 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -101,7 +101,7 @@ enum blktrace_notify {
 struct blk_io_trace {
 	__u32 magic;		/* MAGIC << 8 | version */
 	__u32 sequence;		/* event number */
-	__u64 time;		/* in microseconds */
+	__u64 time;		/* in nanoseconds */
 	__u64 sector;		/* disk offset */
 	__u32 bytes;		/* transfer length */
 	__u32 action;		/* what happened */
-- 
2.16.3
