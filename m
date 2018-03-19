Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvyc+AislWcQTF9M4FMgpcYZvjWpXmqjQYOqUhe2FTnx76cFfo5pL8cqAOiQFYWH4TqGByB
ARC-Seal: i=1; a=rsa-sha256; t=1521483093; cv=none;
        d=google.com; s=arc-20160816;
        b=eteDjhoeh1YS3CRoxn8JMIkPoBCCvIQxU3WEGFr2fgz2VNPDFxdQb0Bs4USBTUzIA9
         hO8aIYD6CZUL+YiS/lG1YVVp7LrbRT2Sr4m97YR3i4zB8Fw2guozYFqmo3XYtpzmvQSM
         JMziheYXpJPnWOtLvVaxtoKCWAVAo+7nx2bFFJR+6Vp1IX/rjiLhOqAyp5EYaCfFtVJx
         /Wy34PhKdbIa7ZNW3cEz7m3++yUiKQcUrDFwSVFeunj04qkWz5krnM2RRG9vw5rXAkzm
         2gKVvNFryqbyag4rwPO/ysI3fAQrJonfWXR26Tq3FWu9UWBkTt9fhzQuBMPKHahDqVR7
         IK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=esd8n0ql2MaiMOU4Zx1kNH266I1MNoyBIxBmaQf0qMg=;
        b=NoYnap4n452p9nuVpbfAl8k6hgC0cQFoM292GiwotGAg6fOWLYnj35ypYtQvjikDJV
         FhTsz6ckralXjoJm7pe/aa3NonNB59suEmrOSjz5yPTTAod06BXtMKckwlQwuLQxZMnx
         CPgnScp6KjBxJ1uVglUFP0pQJDFaRhVAnyHh7YDWi6Bla8dJ/3hRkczTLt/+55iTvtLd
         tgIkFhOkxdEfzy4Kl49NAKxRwlE9BAOKdwqZ72dTOe3S2jC+WBRNCIN2aRXB7ni1pTT8
         +BOSRtQ2j3MY0VhbHS+JZC3fFZ1MzAFwq8ExfUJBfvex8zZwDv0j35lyexu53cUIXtXa
         EsTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Carrillo-Cisneros <davidcc@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	He Kuang <hekuang@huawei.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Turner <pjt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Simon Que <sque@chromium.org>,
	Stephane Eranian <eranian@google.com>,
	Wang Nan <wangnan0@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 38/68] perf session: Dont rely on evlist in pipe mode
Date: Mon, 19 Mar 2018 19:06:16 +0100
Message-Id: <20180319171833.192224667@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390656543207317?=
X-GMAIL-MSGID: =?utf-8?q?1595390656543207317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carrillo-Cisneros <davidcc@google.com>


[ Upstream commit 0973ad97c187e06aece61f685b9c3b2d93290a73 ]

Session sets a number parameters that rely on evlist. These parameters
are not used in pipe-mode and should not be set, since evlist is
unavailable. Fix that.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170410201432.24807-6-davidcc@google.com
[ Check if file != NULL in perf_session__new(), like when used by builtin-top.c ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/session.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -108,8 +108,14 @@ struct perf_session *perf_session__new(s
 			if (perf_session__open(session) < 0)
 				goto out_close;
 
-			perf_session__set_id_hdr_size(session);
-			perf_session__set_comm_exec(session);
+			/*
+			 * set session attributes that are present in perf.data
+			 * but not in pipe-mode.
+			 */
+			if (!file->is_pipe) {
+				perf_session__set_id_hdr_size(session);
+				perf_session__set_comm_exec(session);
+			}
 		}
 	}
 
@@ -122,7 +128,11 @@ struct perf_session *perf_session__new(s
 			pr_warning("Cannot read kernel map\n");
 	}
 
-	if (tool && tool->ordering_requires_timestamps &&
+	/*
+	 * In pipe-mode, evlist is empty until PERF_RECORD_HEADER_ATTR is
+	 * processed, so perf_evlist__sample_id_all is not meaningful here.
+	 */
+	if ((!file || !file->is_pipe) && tool && tool->ordering_requires_timestamps &&
 	    tool->ordered_events && !perf_evlist__sample_id_all(session->evlist)) {
 		dump_printf("WARNING: No sample_id_all support, falling back to unordered processing\n");
 		tool->ordered_events = false;
