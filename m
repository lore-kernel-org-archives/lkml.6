Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+XNhjcCGUlT/qFyEbueDiuFwSEfOnJXndRpUsqaEpWStDCs5VUvp4GSBjiPks9JaKEZzEB
ARC-Seal: i=1; a=rsa-sha256; t=1523980975; cv=none;
        d=google.com; s=arc-20160816;
        b=PxfMEvZbUYDjqib3drcTh+89sDhkqGVMomAhA75Rs2UWoYBb+NYebwd3HfbY64GbeX
         TgjbeK95Oj2bml++PgzRAB4RAn+TO2/pi5i5xo5aqYmiQm63lylQaiUPg6Ax2UEP2B2O
         yAGiAfCtU0/jfCOZMD0/yH0chBWvW/ebufe6wwwBmFKxtR23pXfecD3soBbwtBW3IvhG
         wWuRj1n7ad43kWyln19lw8uPbyF725yDuoIeeM1cTvcc3PROl1GHM6cGauDi1m+zB42F
         ygAg0p2KEEhbig8xZvctHxHK47F7nthNc6lpqsQfA6EFeW8IIwXi/4onRbd/UzsR+qBI
         HulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qxznT3jt8kVxh2Fp+zdVJ3m3TFLhMnw/58hCfiQET0g=;
        b=Y1/GrVmEYdZ6KaQXZBUpqL/XkFBq8TH2N/kcu3UAiTZDtLJryxJTxsT1ncOn+YB7bV
         X3szA3cWiD5PXu/1OGbPJRPa9AoLjuxdeNY1puvzBdOHrDW8zqJrnwec8/F5flTk9rOm
         zHoxWAN56Y1JNrX5OVpz9GGyhKcqQmJXFRwNhqs/Cd5BpKeT98cI3GTl2qo7Fm/sEj+m
         9Ia56IUk9LfX9EIb7T+/qpORqj8QFRdpOoNF5QhM8LstDgE+0AtQqRG1hjDCiiPfGYsn
         ARQU47IZm1vNBWK/Zz69Lioz71YUQmEuoT97iT/i/0jr+i1b2n+G3Pxp6j9iQuBQUEvt
         Hqsw==
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
Subject: [PATCH 4.16 64/68] mm/gup_benchmark: handle gup failures
Date: Tue, 17 Apr 2018 17:58:17 +0200
Message-Id: <20180417155751.942473855@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009875820230550?=
X-GMAIL-MSGID: =?utf-8?q?1598009875820230550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
