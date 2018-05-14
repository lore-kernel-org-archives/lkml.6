Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpn6IsVhGzHPbhVtvOcYVqLfV9LNxyxmqOetGOeOmTv+14Cq3pNGmcPf9LafDlQv0O+0EtG
ARC-Seal: i=1; a=rsa-sha256; t=1526282287; cv=none;
        d=google.com; s=arc-20160816;
        b=OgKl/ZBPE8+O0oUcV5n8t007LWvIDmT+vFxKX7plo6L9d4R4vqFJi9YIhCBx95O099
         yrNMbOCAXoBJHiom1z4i8cObxQPlV5LuGPJ5U9uoKFaHdmQIUFAUaFQh08LA7c18qp2i
         4oG7+lpPVvo65uXYvD2jpIkMOF93vjrbRBKuIURjqi/bLhqGxMSLOThSyc+MrLjlB1lZ
         elCD5t+z4DfcPf57LlvcffHclu5AJdk/WWbLlktEM8kZ2AlMEoZ/eZVeB2fcIffZGtbb
         WKFY0r67kGMV3KxoblTvPE3lbto8xtepWNnn2P2+X6MXJiUA2mmM2ixCdVWwyXn6wLny
         yuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=MdAv0mnqumyLCDxX+8jQ8ym8dAIR2YYNzkkUN/y2hSo=;
        b=U0uKQl3EQ498IGFR7crfyYbiyYAeYTse6Ard2Erd7SRk4kaZN6bQrmEMH9FWN9YzXS
         pmH0DYQAQ7htdS2X43kfkMH1rSvJEvl4mEn7bjfQZ0iUeSxUET1PuVY3HXHPGQJ3GwG0
         CDmehqrRQhlFlyAV6XBnlznzYr+CegOx/3+QTl8Q2VTSuzI1TgnGmKvuQckwOovNfIGH
         YDd/W/M/6iZBpx0rlPa+gi0cz1WK3a91567DhsS3sda67pk06a3oajcORIeGu3zpK9R7
         5x3VEKPDvgj1t+4jI425/pY0F4AL7sa7Xltl0K1pEeLiqG8n++SN8W9WAKvTlqGPOR+v
         beeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZIK3DWa5;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZIK3DWa5;
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
Subject: [PATCH 4.14 59/62] perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]
Date: Mon, 14 May 2018 08:49:15 +0200
Message-Id: <20180514064819.749587801@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422462427122236?=
X-GMAIL-MSGID: =?utf-8?q?1600422976493190440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -863,8 +864,10 @@ perf_mmap_to_page(struct ring_buffer *rb
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
