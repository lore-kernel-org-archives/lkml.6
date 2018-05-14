Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpNGDFbGFdTDfX9BLfnf/l7jvkCLQr6erau0IXJ/w82gPqvyssK5bxgjeeSYeAFse/tEJWw
ARC-Seal: i=1; a=rsa-sha256; t=1526282394; cv=none;
        d=google.com; s=arc-20160816;
        b=gdptvC1R8KhfJRP8f9W7qNjtGjfpCxpre7nlJ6GHInVQGFP5k1mFF1DcUkeEWceP/P
         CgC4EmxF/aCp1e5LZzWdc0SnUaj84Rkl+m3EqL5BNYNSOJ1rnbzNY7dz5QbyvVQmT/Yg
         qVkkzsNX/K18s+lJbaXP5qMq1c7n7HW/JOPnQUWoIzGemmpx7+a342q0bJ/RCZkGgxOY
         uZWhJuGMQhREsdE8n3aM4tceRRjy9CEtgEUSy5eibdj1Faf3VQ9ED8HPc6oLIfHxYiX1
         wM6E8tjl74Z+hYSRMNvyV7E6bx9d+Ivk39uHf25SO6cssPz40RAUOI+hUvlB8DpyMD9r
         dFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CYSUTY3n79BkXQIU5fgnF17V6I8HyKMnIjucrd+0kig=;
        b=p5fQhrjhY4UM1sSh39MVrGUdUn3eiC5pSv3sk2wEjI1MwYzb/IjOw6/n+76R+lubwc
         LEUYPvulbhV47uE4Z1JGMuJSFwE+0+uyolwxCBJRzHgezcIU2CQMZwce+vLfehJuUpIN
         jsMKggW7vCV9sKA2LuMWZWsBoekvY9v6Bl/OrdqE2bbqGAvoJkGbwDr8kh4CFrjqvz3A
         rpWKfbDHeWIldT9WVA64LhV4OtUHs58FPdU6gt70sKSzdqo5ypMGSreQmfjSbxQyK25T
         RZNFOKctBnc6/O57UgpKr2jaWFIYvQ9c4oLfYslVXeQGTbEgmY8nlj70RI8d3/c0s7p+
         X8MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QGTru99h;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QGTru99h;
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
Subject: [PATCH 4.16 71/72] perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]
Date: Mon, 14 May 2018 08:49:28 +0200
Message-Id: <20180514064828.057552342@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422462427122236?=
X-GMAIL-MSGID: =?utf-8?q?1600423088113803226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -867,8 +868,10 @@ perf_mmap_to_page(struct ring_buffer *rb
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
