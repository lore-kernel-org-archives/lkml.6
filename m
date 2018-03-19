Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKV9g+6gnZiC6qE6B0ZLoj1kDY/cKJeApbsRs3luDNEAR60pUGLSXV2AaIM1xw1e3ZUzzn
ARC-Seal: i=1; a=rsa-sha256; t=1521483581; cv=none;
        d=google.com; s=arc-20160816;
        b=po63GE6gxjTX9YSMsMHBACkB7RGYO7S+t/kzO8OSednTuflZApzCn2X6pBq1dzgaOS
         c0iNCnYL1OBrhPzxescbufXd2OptzkP3JnjdX1prDRDYSzQKxSG0if2l+aV89tkfaW3Q
         ZebkNPpyYEpd86GaghMgN1XF2VbtQBoSklrskaZwJKajDN/jVILsVXa33ANpdn0hl3iZ
         Gk0c3VUsPWtn13xnT63YBDCYp57C7OnrwJWbSHZTzCP/z0oHXLUyOzKlvT60UG8ntYiZ
         W4u/8Fc5FJu/EXZIQzqQIDMiQMrBNowHhJ5qMbAX7gKI2pdXWxX2ocCVTmUtltD9gIU4
         Efmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nktBnKoikKDSiVEENCBOKxGfur9hbNu1LaWmwSz5Ld0=;
        b=Hb6IE1MwyIwOrQiVaDrrwcD8RZfc6LRzR07dlxOu0Wf4S+ar7YbY14Vj1JX+xF+MNM
         FjSzUi/8V3gKpb/QoAAtJQNctbE2bNWdiX6KYMYKKrnxFvsjG5pHbpz8ajyid5qn9dFh
         lZZGVBP4+jiu0NsJcTkFhc7pkvwgoTZVWmZewhZS+Qt/nWNNYOaaV/+4kk9hQJzqLAqx
         O5b0jfRRcIPqRn/Zr/+4Qu6WZS204K6ELmcH/p1okUaMdl0J3u9fIBQfD5ebqqeP6gUD
         hzimYeT0HL9HOOZSRbCUGYNG6TDS7GPRBSHsUxGjWdJy6w4bpRH1dOZKIsZ7O3b6Okr4
         0ZSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wang Nan <wangnan0@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 042/241] perf probe: Return errno when not hitting any event
Date: Mon, 19 Mar 2018 19:05:07 +0100
Message-Id: <20180319180752.941046771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390716323570935?=
X-GMAIL-MSGID: =?utf-8?q?1595391167530491207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kefeng Wang <wangkefeng.wang@huawei.com>


[ Upstream commit 70946723eeb859466f026274b29c6196e39149c4 ]

On old perf, when using 'perf probe -d' to delete an inexistent event,
it returns errno, eg,

  -bash-4.3# perf probe -d xxx  || echo $?
  Info: Event "*:xxx" does not exist.
    Error: Failed to delete events.
  255

But now perf_del_probe_events() will always set ret = 0, different from
previous del_perf_probe_events(). After this, it returns errno again,
eg,

  -bash-4.3# ./perf probe -d xxx  || echo $?
  "xxx" does not hit any event.
    Error: Failed to delete events.
  254

And it is more appropriate to return -ENOENT instead of -EPERM.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: dddc7ee32fa1 ("perf probe: Fix an error when deleting probes successfully")
Link: http://lkml.kernel.org/r/1489738592-61011-1-git-send-email-wangkefeng.wang@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-probe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -442,9 +442,9 @@ static int perf_del_probe_events(struct
 	}
 
 	if (ret == -ENOENT && ret2 == -ENOENT)
-		pr_debug("\"%s\" does not hit any event.\n", str);
-		/* Note that this is silently ignored */
-	ret = 0;
+		pr_warning("\"%s\" does not hit any event.\n", str);
+	else
+		ret = 0;
 
 error:
 	if (kfd >= 0)
