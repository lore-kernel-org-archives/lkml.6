Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49rrSaiDb2rc2d4m37ixsA/R/i9BSsGGJOb0PzlH5f1RLs2QOMkebUa6Vm29aciJ96hzI9e
ARC-Seal: i=1; a=rsa-sha256; t=1523399818; cv=none;
        d=google.com; s=arc-20160816;
        b=fBeGgWR9SuPBqIfxjoRhTl4PZXdvNB6PBAzbpmBKwGIZzoHgfOpntVtzsoo4jsVSIV
         kAzVxGU2xXxhR4/D9uGeLea2NagC/xuxo1Vx/9dO6pnVHjRi9aWtbLU08eBu8BQb0+DN
         DvA3xd6xeOYJvU+k5+l3rvdz3ZndRMRRLTSAIqUZyhOKY9Y9ecWbE3RO+8iEV5z4lRqN
         yPGzeQnq9uvqXqw5wgpqhypxYNRLXbUFn2gLAQgTFFrSrpxoLTb5XKOrQlyTulGpbL2w
         pxFwtVT0ywYrZlGkboit+TNNz+5bobsYD/sETOu7vQChlWLMZEzL+McTyfS+llBH6w0e
         uDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S8erZqKI4xM145zcUmy+eT2pF1c/qDFT5Cv84HnxwR4=;
        b=eQ3nYKj5uz66zpAyt0DccytQAoCcrUHe0shgbVmfWvh80IaJ55dy4hguC9ext21aeI
         QOpe/ZIPTKTV9yZtp07BheJo+GjbRfon8onRNlN6hCackj+LiWPytUUvUQwTkJy+c6nl
         2KQDfegzmBpJbXsVMJ+L1b93Km4fO+dyplcszuTHe7XHHbEX6rdveRk3RCtwOe3Eb+Gj
         TG+CVANlrXcDxO0YxMlI3KriTrTPHgti9IzoPhvhBgZpKHI5EhkCzxsAvxuJRqTng0KB
         KOFZYcc2fdsDpSoLdWwX5JN7DeuZOM1hs1Aqusevt/Aovkxm1/4zrwnkSNoQiFu8uyy/
         kPHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jin Yao <yao.jin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 046/138] perf report: Fix a no annotate browser displayed issue
Date: Wed, 11 Apr 2018 00:23:56 +0200
Message-Id: <20180410212907.441055486@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400008123802873?=
X-GMAIL-MSGID: =?utf-8?q?1597400488035440676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jin Yao <yao.jin@linux.intel.com>


[ Upstream commit 40c39e3046411f84bab82f66783ff3593e2bcd9b ]

When enabling '-b' option in perf record, for example,

  perf record -b ...
  perf report

and then browsing the annotate browser from perf report (press 'A'), it
would fail (annotate browser can't be displayed).

It's because the '.add_entry_cb' op of struct report is overwritten by
hist_iter__branch_callback() in builtin-report.c. But this function doesn't do
something like mapping symbols and sources. So next, do_annotate() will return
directly.

        notes = symbol__annotation(act->ms.sym);
        if (!notes->src)
                return 0;

This patch adds the lost code to hist_iter__branch_callback (refer to
hist_iter__report_callback).

v2:

Fix a crash bug when perform 'perf report --stdio'.

The reason is that we init the symbol annotation only in browser mode, it
doesn't allocate/init resources for stdio mode.

So now in hist_iter__branch_callback(), it will return directly if it's not in
browser mode.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1514284963-18587-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-report.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -162,12 +162,28 @@ static int hist_iter__branch_callback(st
 	struct hist_entry *he = iter->he;
 	struct report *rep = arg;
 	struct branch_info *bi;
+	struct perf_sample *sample = iter->sample;
+	struct perf_evsel *evsel = iter->evsel;
+	int err;
+
+	if (!ui__has_annotation())
+		return 0;
+
+	hist__account_cycles(sample->branch_stack, al, sample,
+			     rep->nonany_branch_mode);
 
 	bi = he->branch_info;
+	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+	if (err)
+		goto out;
+
+	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+
 	branch_type_count(&rep->brtype_stat, &bi->flags,
 			  bi->from.addr, bi->to.addr);
 
-	return 0;
+out:
+	return err;
 }
 
 static int process_sample_event(struct perf_tool *tool,
