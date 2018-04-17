Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/pa3FfPHpBKSp+fr8FnLEB1O2hXViOTf8E75vLyNSoqeLZErDO4uSA2G6nK16AMoLg/R1/
ARC-Seal: i=1; a=rsa-sha256; t=1523981135; cv=none;
        d=google.com; s=arc-20160816;
        b=GAJboVLgXlc57b3ZozbHSCBy3sLzJ9JKq0HIKYCNeYr9UgfRJ8DUrOsxzKYId0RNCc
         qQqHvbphM2Q9RTVnvBfahzTyYBosJHbYELifDIj0cbv3NVQHzp/rvcv10CMHsCD1UDIo
         54G4cnE2vQi3mPRH9EosA1+mMeU4r6UBXzr0EGPf0qzrzoJWypjerTPoD/OyiczMbGkS
         NSA7PumO+ovERPcGcashn91y+MtNhJN+0/ELYUEFNsnrLld6l+yRObImJ3yWVXb1MKZ1
         59tvQZOsXuzdqPGe+GHYjcm22rb4SAf36BDkcDp43kClczmmvsV3tSV4xLnxbQQNBSsz
         Xr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9Hqi5ssF5i9sN2syXwMJaQAWbkX711AB0NYywtZUUyg=;
        b=vkvfsC9xX+Dei6gx0gO3p5LxEcKpwpWSCFmMJrBA8OaM2GUzMRUk6INArIjwKs0Q+N
         EYH3NCWoHM2Hd1x0qID//gReN4Uo/2J5xKHlmE7Hf25dM2zpLoiqvImHStyDz7gnTiar
         EmI/DrK3S7IV8FVCMHJGNUgxr26L6SVfA8ISZxjWTliLmNoMMWeut9skMdR7mISyQ9+y
         eUJq+8Sjwgr+or552HxEcDeb1+PDQJe/37r7Uj16uDJjvAqJvNk6ApFJmF3UOeC+l9FU
         HfgpBSyu9N8nvu9MlmE5+vVYOonvUlxPUvnMIvVRDrjrzX8D/d136dlWfYav8jLznBKa
         VY+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 48/53] mm/gup_benchmark: handle gup failures
Date: Tue, 17 Apr 2018 17:59:13 +0200
Message-Id: <20180417155725.410047334@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009875820230550?=
X-GMAIL-MSGID: =?utf-8?q?1598010043831585525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 09e35a4a1ca8b9988ca9b8557d17948cd6c0808b upstream.

Patch series "mm/get_user_pages_fast fixes, cleanups", v2.

Turns out get_user_pages_fast and __get_user_pages_fast return different
values on error when given a single page: __get_user_pages_fast returns
0.  get_user_pages_fast returns either 0 or an error.

Callers of get_user_pages_fast expect an error so fix it up to return an
error consistently.

Stress the difference between get_user_pages_fast and
__get_user_pages_fast to make sure callers aren't confused.

This patch (of 3):

__gup_benchmark_ioctl does not handle the case where get_user_pages_fast
fails:

 - a negative return code will cause a buffer overrun

 - returning with partial success will cause use of uninitialized
   memory.

[akpm@linux-foundation.org: simplification]
Link: http://lkml.kernel.org/r/1522962072-182137-3-git-send-email-mst@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/gup_benchmark.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -23,7 +23,7 @@ static int __gup_benchmark_ioctl(unsigne
 	struct page **pages;
 
 	nr_pages = gup->size / PAGE_SIZE;
-	pages = kvmalloc(sizeof(void *) * nr_pages, GFP_KERNEL);
+	pages = kvzalloc(sizeof(void *) * nr_pages, GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
 
@@ -41,6 +41,8 @@ static int __gup_benchmark_ioctl(unsigne
 		}
 
 		nr = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
+		if (nr <= 0)
+			break;
 		i += nr;
 	}
 	end_time = ktime_get();
