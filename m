Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELudHqux/DBmxOv3mflkPqtTeD+0WXvDsWlfo5/0XQV6JC2OhE6K+f/nUHWR8q99E1xG6ZaZ
ARC-Seal: i=1; a=rsa-sha256; t=1521483150; cv=none;
        d=google.com; s=arc-20160816;
        b=JacONihd5swLgaoj0adXOP0u4xL9+gXESpRXYIBaFGuZ7gKp5WXY7n1E9d4dx57Zr+
         oVaM/2SqT5MCYy+af7mbto4sQ1e3OGrbrWccx1i9wc8oKZndZX3ubutg25XzZHA0/TlJ
         D2Y4KftCSpTebejkIF/pG8aNgHnelTI+dbIccprIro35CPRKTTZvxLU4jSsW2Cr/SDWG
         oVeSBKtdKwWDL0UMmgLJ4EkzvYYV06uDKnbIs5MOJKjmWfHqhK5a0aiw8POzaOsJobAC
         WNZ6o0TGoy+WDMxmomDPw/0T22PTCnJLiD0Wju1W7pIhWh3/7jXG43zh9YiPbAPyOWq4
         atLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=620kqG05OJAaPkSuSGPQw6+4IBMc8RP+0reTpSWcry0=;
        b=SPKgxTry4/K0bVggAGKalRJhQ7fZyxYzoczAXVny5jbcCkX1gJWyGI4B8b0XN0NKPq
         5u4mSvFdvuhDFD1/ebH89UrEcz4o8Xx5HzIlrBFfl/iUHHnwk5tk+T4FSrwtAmm8nMWI
         t5MV+uH6PttPSDfdmOf3kvUrJjbMzOiGyOoOXNgA2rEuWmNW9W3K2lF8pDHDvYKWdn88
         3/EMu2P4AzFzb7hRVrqCBNk4qTqrm5stMmg0wvNAHDzVZJny0rcRvS60pQEFFkczQ8Ux
         RVTHJw09HRuJIAXWGsKHP7e3ieEIylKLICOnkpr971Lairepe4SXghcloxzHi6YUwNFg
         FDKw==
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
Subject: [PATCH 4.4 018/134] perf probe: Return errno when not hitting any event
Date: Mon, 19 Mar 2018 19:05:01 +0100
Message-Id: <20180319171851.774653308@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390716323570935?=
X-GMAIL-MSGID: =?utf-8?q?1595390716323570935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -405,9 +405,9 @@ static int perf_del_probe_events(struct
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
