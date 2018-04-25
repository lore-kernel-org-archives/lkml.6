Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/DHXSCAtys1can8gnBmVBDCCTRHW9BEtuxl1t5OFUXAGuhitML13Z7pYSiSSwZMF3HgPum
ARC-Seal: i=1; a=rsa-sha256; t=1524653041; cv=none;
        d=google.com; s=arc-20160816;
        b=sjyZcvaetdKf5WD4ckGhVifTN7cz91FIF75270XOqUqF3u1RPrgFNFf7PGZO9r3wcu
         gV4dEE9HqtxkbSckVtvrx4EBGROUZ9YDZHfWsGJyHlKmf6zLxj3QFbnrfpi0iWG2gR8M
         8Vhln6hK36tKfMa40QqXCYNnqVumIl+qoePf9bv0pQOTQJ5i8SS5zxeuwsTgGDSYqMkS
         NBCSU+NRnrh631Ru1s/XnjKKtA7m1aTb+bI4835gi0+nsTZOZuLsNO/DLz/45u0LTWuF
         MiTB21WVtescOCJB+r3ZG5cLY1RRi77L4tGZwngw3yt8JM7XppITnNrGbWbQViDSLLyn
         Ui0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aE3Ds4fkmW5dYH4oQL8TNFjRhqJZCXdfEO33/o+GFPU=;
        b=eqDbr8+EW2AIblTFd8/FoKIZsNYc6xCrqg9z2W5EUcpBWnP79YOQdNMlwW3llBua4w
         Dmofvxw+P3I/H7/sgNhSa6tadvlgMmIdBb3Dqno14mSBCoMW+blHho0/nfGN/s04WEiT
         150hS/MZvVoAwW7YDQFT1mBLVzrIAVK4kz42ne2s+TJlpsleKkz9oKqaPSRiLl7im8Pl
         m1E0LJuLASkrbaH8PyourhDwi4iKEYg45UYqgqSj00/whS4ixLaxsLxyDYZrq223LTUr
         70zjlfMZrAKnT1XhyMZsIfKOgu2eJ1tokIxgVU/xWpjfkDANsfZc7B8dLij6UXQKFXd8
         E3jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia Zhang <zhang.jia@linux.alibaba.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	jolsa@redhat.com,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 163/183] vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping vsyscall user page
Date: Wed, 25 Apr 2018 12:36:23 +0200
Message-Id: <20180425103249.076681278@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714587379024076?=
X-GMAIL-MSGID: =?utf-8?q?1598714587379024076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia Zhang <zhang.jia@linux.alibaba.com>


[ Upstream commit 595dd46ebfc10be041a365d0a3fa99df50b6ba73 ]

Commit:

  df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")

... introduced a bounce buffer to work around CONFIG_HARDENED_USERCOPY=y.
However, accessing the vsyscall user page will cause an SMAP fault.

Replace memcpy() with copy_from_user() to fix this bug works, but adding
a common way to handle this sort of user page may be useful for future.

Currently, only vsyscall page requires KCORE_USER.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jolsa@redhat.com
Link: http://lkml.kernel.org/r/1518446694-21124-2-git-send-email-zhang.jia@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/init_64.c |    3 +--
 fs/proc/kcore.c       |    4 ++++
 include/linux/kcore.h |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1180,8 +1180,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 
 	/* Register memory areas for /proc/kcore */
-	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
-			 PAGE_SIZE, KCORE_OTHER);
+	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
 
 	mem_init_print_info(NULL);
 }
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -510,6 +510,10 @@ read_kcore(struct file *file, char __use
 			/* we have to zero-fill user buffer even if no read */
 			if (copy_to_user(buffer, buf, tsz))
 				return -EFAULT;
+		} else if (m->type == KCORE_USER) {
+			/* User page is handled prior to normal kernel page: */
+			if (copy_to_user(buffer, (char *)start, tsz))
+				return -EFAULT;
 		} else {
 			if (kern_addr_valid(start)) {
 				/*
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -10,6 +10,7 @@ enum kcore_type {
 	KCORE_VMALLOC,
 	KCORE_RAM,
 	KCORE_VMEMMAP,
+	KCORE_USER,
 	KCORE_OTHER,
 };
 
