Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx490oJOtoEYRJqqJ5JzamYVHc2A1tEsRv2TxWLDmCfIYgU0vWK4ZtIexA/9o7fSv8/y3UDbH
ARC-Seal: i=1; a=rsa-sha256; t=1523472997; cv=none;
        d=google.com; s=arc-20160816;
        b=NYbFOTmttVQkRyVC3CgfBBJe7Y2MyM16zqlPwJdgwN7UsZnd0yqIwZeTFsirA71hf0
         BkQT9/ncxZAHnaoBfN8pv2qJDcjeDw23NFu9LvzxxIZa7YsCtDVAa/IJgK+EdFiL+E+q
         TdZAT8hyw0XXdiaQ+XqLZ8fIupnKR55RU1CrpvDHuz53Hy4kaU8L0fZuIw5hgLCo+wzq
         e6wcjO/OukE/KfKT3KLXyWgnin8fWcx75O5QSagZV138YuEPmZ4qYonKQS8hYJuvyoB/
         XNQWCWfw0ULAbmpQP5RHtF941JEyt+ukhnTcPxkh1OUZuZYwHAyO61sQ3OzO3TJcFiiF
         dvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6aZZWtnZY4iXqDTl5imZE0yEJjew+t0jpOCf7zIVEVc=;
        b=qcJ0X/gIfHnrUd+td8tpzJAWzKQiu2scijM1svZMWyq407u8+ERlLkTb3uaXi1S56d
         GxJIebxcWZcThcNoxf8JZE+GkBc71DcUufUmmZy1yBbd0xrnlvP3fIJDsEfh7KDEfsLw
         fIT+oEJRBLnjykAc3tDxwQIdmOsTFuxwWoDqkceyKnKlkmu454wF1/X5+bUf/FMRNAkF
         kUTlFgukcm7QHY2cXoqLLbC8drQxMJHKMji2SEBg7yVdKq6XUFpGtQpSw6x/0K/pN8u4
         Fhchm9whC/lSaxn510X/CXAPgRLAqZNhFGSegHdQI+3kJS0q7MIjjaPbOZWgBKkBpFu2
         bp5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 092/310] perf/core: Fix error handling in perf_event_alloc()
Date: Wed, 11 Apr 2018 20:33:51 +0200
Message-Id: <20180411183626.202918527@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477222029432094?=
X-GMAIL-MSGID: =?utf-8?q?1597477222029432094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 36cc2b9222b5106de34085c4dd8635ac67ef5cba ]

We don't set an error code here which means that perf_event_alloc()
returns ERR_PTR(0) (in other words NULL).  The callers are not expecting
that and would Oops.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
Link: http://lkml.kernel.org/r/20170522090418.hvs6icgpdo53wkn5@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9289,8 +9289,10 @@ perf_event_alloc(struct perf_event_attr
 		event->addr_filters_offs = kcalloc(pmu->nr_addr_filters,
 						   sizeof(unsigned long),
 						   GFP_KERNEL);
-		if (!event->addr_filters_offs)
+		if (!event->addr_filters_offs) {
+			err = -ENOMEM;
 			goto err_per_task;
+		}
 
 		/* force hw sync on the address filters */
 		event->addr_filters_gen = 1;
