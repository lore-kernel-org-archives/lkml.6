Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/x6yAnx+xzFthu+CMBk+quEY5SlkYVL5Wbg/+6n45Hd0IYsS0BTR2ui/gEUHsa8HsFlBYZ
ARC-Seal: i=1; a=rsa-sha256; t=1524652945; cv=none;
        d=google.com; s=arc-20160816;
        b=HGUOHO94fJ8P8E1k+wT98jM+Zkp7bUAfkxSSg17teGLNjmr9mqXh3Z+14JRsAqYpCh
         A9CbsmHzGyNDYXScSaF/A4wlspPlP61cUaLslJ7ddIQt2zs1+N4Sliks6vc4O0fRLxva
         KW+6XiZOiMe/fiJbOAWdYkeW6cedb7k13+A6pBocruikaqBNnG8bmeePeSBSothniTa4
         GqbT0pq1jqzJ1tpdxHzqj4w8nKSXIWufM3o/PZ0zzekcY+zdlim48vGzejAEVv5wHcI7
         CW3S6gyf7LB6JhaqDAU38sgSLLvexeNLiJcor/SyDmcdOcoKPAkp8qY7HyPvBDzTNqY0
         g/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V9aO9p9VVzJQh+P+X6cyEEKbvh6yLdEefsCiBpfDH8M=;
        b=heIxzI1X4o2Wu2gr/HmS2Jt+ZX0Gpy1MafQd3NApdzSBs1eR1QeLIpMOE7LsvhaEql
         u8zSOE1H+4ajB+LFQ4P0J6BuwD//2kFBPendMa0M0lHS5fEShg9/b3+IleRwwXzgBqc6
         HScKgEbLVbeU+jBJexNHNV4gq8sQKVgpn6q2Y3et2O5FcC269Fenxt4Mv2zsdeGeovDp
         DGFO4VQMFk7Zv9QOvYrC/20yQ432FJkSxlTh2fhHLYpz7gwoFmz69R7D+yD3M10O6Ck0
         TFUqshG1sreC/so4rQSbpAMxRNwAzcHKef6rEKauAYWz7TI/F+E1mz8XDWJyBPE6K++8
         3oKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Len Brown <len.brown@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Nicolas Pitre <nico@linaro.org>,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Pavel Machek <pavel@ucw.cz>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 127/183] x86/power: Fix swsusp_arch_resume prototype
Date: Wed, 25 Apr 2018 12:35:47 +0200
Message-Id: <20180425103247.536189965@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714487087145399?=
X-GMAIL-MSGID: =?utf-8?q?1598714487087145399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 328008a72d38b5bde6491e463405c34a81a65d3e ]

The declaration for swsusp_arch_resume marks it as 'asmlinkage', but the
definition in x86-32 does not, and it fails to include the header with the
declaration. This leads to a warning when building with
link-time-optimizations:

kernel/power/power.h:108:23: error: type of 'swsusp_arch_resume' does not match original declaration [-Werror=lto-type-mismatch]
 extern asmlinkage int swsusp_arch_resume(void);
                       ^
arch/x86/power/hibernate_32.c:148:0: note: 'swsusp_arch_resume' was previously declared here
 int swsusp_arch_resume(void)

This moves the declaration into a globally visible header file and fixes up
both x86 definitions to match it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Link: https://lkml.kernel.org/r/20180202145634.200291-2-arnd@arndb.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/power/hibernate_32.c |    2 +-
 arch/x86/power/hibernate_64.c |    2 +-
 include/linux/suspend.h       |    2 ++
 kernel/power/power.h          |    3 ---
 4 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -145,7 +145,7 @@ static inline void resume_init_first_lev
 #endif
 }
 
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
 
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -174,7 +174,7 @@ out:
 	return 0;
 }
 
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
 
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -384,6 +384,8 @@ extern int swsusp_page_is_forbidden(stru
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
+extern asmlinkage int swsusp_arch_suspend(void);
+extern asmlinkage int swsusp_arch_resume(void);
 
 extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
 extern int hibernate(void);
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -104,9 +104,6 @@ extern int in_suspend;
 extern dev_t swsusp_resume_device;
 extern sector_t swsusp_resume_block;
 
-extern asmlinkage int swsusp_arch_suspend(void);
-extern asmlinkage int swsusp_arch_resume(void);
-
 extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
 extern int hibernate_preallocate_memory(void);
