Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZojDZ4UNKALB/yaxgQMRZHK4tYXinLABd48Rh3ilJ21w8ex7MxSIdi2EJUKWQN6uQnahVdj
ARC-Seal: i=1; a=rsa-sha256; t=1526281797; cv=none;
        d=google.com; s=arc-20160816;
        b=yU8+7/bot8qZZGbZcZvtRIx5OrI886xZJ4hMo212LJgdFuILyEoll9j13m+K6v1IOj
         gDgJ05oFoNJ6yknPm0lFqefZRHaN4DWNy9y0NdSnIy7SeKdPoSjHwWlCL82k1NZ2a4zh
         IfaScWaDmbolkZGWbNA8wuVgS3zM6OZpWj+o2y6MAPXTC9WXFHLq31sr5cUhnlrXSM+P
         a7QUlUSGDjflbmw6/9M30Ng9FfRy7StPoWJycgQIyqRdFy2ciqYTTDjXjShGeeGMVlqv
         pxSxTnk7Bo6TlnaNfmLKy8biLq/n09wJs3zAuKAzaPEJW1AzXcF62YTPU7ZMsFuacM2P
         XR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=iyHwu3KgxB0jijuOQJQOYm6ksMbKdgQhPuVD0/JZKAg=;
        b=dE5S/NwMrVUv2XdJtnQ6qsZvhmWgbPNp+h92Y74J5rA2ubuyIi6YSgeVcSp54dSyLD
         3DpNial+1Ob6kivp4G+ogVAFOQpY/FdT1wZPS8pNlfk4m6RMpKWWSdUFbqrCooOaaIh9
         CYDte/Vrs1LqCFlmUqVG+FkhQfrSo0L35ySryLAy7kgeLHKepSfpG5HBmN64ntKiM4Oj
         wUWo345Gt6otYjofTvaDW3EDxJ9bbWGhtRCVKkJo+ZaPCQEGxPpqo3hgbkwyb71MYeXN
         43rwHTtK6cvdwzUssi4hMigsVFU1l5VFZX2jG3CU6inUcXU6EvoZM9lbUdyuKrEafZOY
         yacQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vLy3q+Sw;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vLy3q+Sw;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 55/56] perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]
Date: Mon, 14 May 2018 08:49:00 +0200
Message-Id: <20180514064759.985903547@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422462427122236?=
X-GMAIL-MSGID: =?utf-8?q?1600422462427122236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 4411ec1d1993e8dbff2898390e3fed280d88e446 upstream.

> kernel/events/ring_buffer.c:871 perf_mmap_to_page() warn: potential spectre issue 'rb->aux_pages'

Userspace controls @pgoff through the fault address. Sanitize the
array index before doing the array dereference.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/ring_buffer.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/circ_buf.h>
 #include <linux/poll.h>
+#include <linux/nospec.h>
 
 #include "internal.h"
 
@@ -779,8 +780,10 @@ perf_mmap_to_page(struct ring_buffer *rb
 			return NULL;
 
 		/* AUX space */
-		if (pgoff >= rb->aux_pgoff)
-			return virt_to_page(rb->aux_pages[pgoff - rb->aux_pgoff]);
+		if (pgoff >= rb->aux_pgoff) {
+			int aux_pgoff = array_index_nospec(pgoff - rb->aux_pgoff, rb->aux_nr_pages);
+			return virt_to_page(rb->aux_pages[aux_pgoff]);
+		}
 	}
 
 	return __perf_mmap_to_page(rb, pgoff);
