Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525356957; cv=none;
        d=google.com; s=arc-20160816;
        b=PoIUbigTiQ7N5qjbLuYKe3P4QVS33JD1ck+NazzUDudItMYn3CI/lCspw2sailEnoq
         uBBjBz8FXz4IL+1rl41nyCjZNIkbJgXBo87LX6ruawr6nQ1nrEY+TxU7Hj3UqHQhmpw9
         QEzNMM1hg3CgVGcIKIK63+P0C/tFMCxThvbIVqg77CHas4Y9guuhIHWoQ96lnPNS6zvP
         ctHKtnlEbL698xcPtqTJLPMNOFxIvVYCCRsOQ3myKjnGHab8qBuOlG7UYhscf1ZvSs67
         CCGvT3SjxDya3qMq3CqqrP6Et1v7kJDrqh9HIqzl6R1bu/qJYeH/eEE4joSRNkPHxvH+
         JpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=o+ak8aT7T3uE1kdwTWR13dwi0UfLy2jLaOVdoh2IUAY=;
        b=sjfzXAfJpl68+YJxhzh5UG1VU9pYqCoF2vwCsNW1GaML83GJy/60w+IRGqPUDKAelS
         0V3M94TS5AoZGN4U642p2djZ3eaFdgMz8C22ykL1neB0wQKJgxplkOowkbboR/yw9aoS
         IjphXTfGS4RI1jty9ex0nR8n9XVWjUOs7Zt7Oya2sU52i3RLrscukvw5d2MkhZPOnAFH
         RI8cIFIfQJYzObxoa10T3a3mmb8SaSKaawLlmiTxPBVTQ4sD9Ql/k8pv7eb5jVbZgshB
         E8Ie45lAfTuWP/FfT97PQFjP9JAKznQMHSCnBmqZLpIq3c5tAZ2gyfwr0w0nc4Zqu3qL
         OssQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20120113 header.b=LsqUKggN;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20120113 header.b=LsqUKggN;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZptJtXiKJBDGbwE89q0SZRWIhadPxCAvvpndroOWisTrqqDu2K9+Rg0HJfCfSaZ0FKxnM9UiA==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@google.com>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 4/6] mm, arm64: untag user addresses in mm/gup.c
Date: Thu,  3 May 2018 16:15:42 +0200
Message-Id: <24ab244adc196fda8536cf2efb59cc654e1c234b.1525356769.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111199483906995?=
X-GMAIL-MSGID: =?utf-8?q?1599452696378632258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Here we also need to handle the case of tagged user
pointers.

Add untagging to gup.c functions that use user pointers for vma lookup.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 76af4cfeaf68..65a9566c96d3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -647,6 +647,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -801,6 +803,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.17.0.441.gb46fe60e1d-goog
