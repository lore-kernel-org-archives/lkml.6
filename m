Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227JrRJOCMNPjVl+e1ZyL9kaHok/cQTCMkKCR0bBoFbOgcrb1gk8Wr1xxKCMFmhlBoag27bc
ARC-Seal: i=1; a=rsa-sha256; t=1519411271; cv=none;
        d=google.com; s=arc-20160816;
        b=yVbj36b7WB+KbzGsx4FeLSiTdaeVh+wjWmUazHZWOqV4z539xK3ywq+ykcLoqMHm7F
         42MU5ryHPw7sbrYYqAXTQ0BQy9AIhPs/gAaRR9O6Cpy67PgF83TvGENUYzXEgn8VnNGC
         e0SP8c3azNC2wUpbH+GdDOjwooGJtlPiDB9CPbxkFD8RrKnVAVC1zvIOKX0aPe7lys7U
         LdFweStSbmaqRH3fEyblD8LIchE6bb1MoBhnSJpu38vLjFzkRsaOkQLBswD5BMpHvxTc
         d1QakEkqHLBqFz4lRScBCfNE9H0qxaSTIJtipm3tyeXucrbTD6LiR9JrNSZMja3QEBdj
         TAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zOmmE8Rh6SwuMiKhMRIgcENgXyQ1KiUW47QBlnBR7NE=;
        b=lZWJjhbFxGfWxbkMVz1TmeJ3eQbPVqMy2as9pWgO8/IyseKZJsOSUwJV5kSF4Gxs6/
         kR6OHdSYEPbGm7kij58m+BYsEzsRWsV0nCSvWX/UWCZJher+Z3p+py6k7Zd8qY65ydoq
         AdzjN1BDs6TW+EdIoz7bwkAIl/IEs5rl5ZNLe2wGjpcqCUD6z+riCQNdeFbRgXeGkXWT
         zJrnkfj496ZOIvAsvoICR+sjHpEWFRBTLVv6oLDjddyjbccH1nYnj+AATiJl189cTvBz
         f1qQOu3asw9MdA6KpP82bzplX3nvXYGJxe850V2aB4jIx5Ghw6BeBExAIw1Sdub7ZfXm
         9YWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	torvalds@linux-foundation.org,
	alan@linux.intel.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 179/193] vfs, fdtable: Prevent bounds-check bypass via speculative execution
Date: Fri, 23 Feb 2018 19:26:52 +0100
Message-Id: <20180223170354.207391528@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218194144060029?=
X-GMAIL-MSGID: =?utf-8?q?1593218194144060029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

(cherry picked from commit 56c30ba7b348b90484969054d561f711ba196507)

'fd' is a user controlled value that is used as a data dependency to
read from the 'fdt->fd' array.  In order to avoid potential leaks of
kernel memory values, block speculative execution of the instruction
stream that could issue reads based on an invalid 'file *' returned from
__fcheck_files.

Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727418500.33451.17392199002892248656.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/fdtable.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/nospec.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -81,8 +82,10 @@ static inline struct file *__fcheck_file
 {
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 
-	if (fd < fdt->max_fds)
+	if (fd < fdt->max_fds) {
+		fd = array_index_nospec(fd, fdt->max_fds);
 		return rcu_dereference_raw(fdt->fd[fd]);
+	}
 	return NULL;
 }
 
