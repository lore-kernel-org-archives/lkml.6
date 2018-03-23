Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsnz2ib+pP93ffCNGyvfrdlunzK4KE5I1DqA78h1MgamrYLOweLLuyNfxuW1n8IJ4ebD9OP
ARC-Seal: i=1; a=rsa-sha256; t=1521800214; cv=none;
        d=google.com; s=arc-20160816;
        b=WrxE6fXn/nmfRDPFcbO0UBjZOmSClVUwvczhJ2da/sfH9RlkJkXayHA8yR3SZRc2W7
         t7RbsHGUpwz6mkGNsdEvcMU2CSC4cElm1rwbXlysi5PXjRHiPIMWbxMbnjP8c/p0JUsh
         AUD0b5TR+b/rqU7AqLbZ7lww+qJziV4G6nwhWYSZ6tbzUjiuPl0Sh0DJLjXmhmjN8PUU
         ChYooEf1ihfg2XI89/27V59V8BDgY3r5r759zO37o0iWsxIXabIC2znkRwRxjSG10Ipu
         zervN/5DyGxXhkQ2Fvb/4F/RmV8Q4CWXjEd5iMZzlmoldMqFUOkbOudsh/0RLNzGh4ga
         eAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Et/rm7wp16e4NxLphpRIWrsECtr2hPIIbjEJrRLm5iE=;
        b=YMBkd/Q+CYdkynWztYuiIHV8iTzENvHLu7AzrLqdFEFZn6Ujujgx2ic4qyHuNvh4+c
         2XZC5Mw2qdJCjYcq5S0cDKcwWGJHmsoypYUaxRM+a2vTB7iGVy0Rjj1aFzAsY/XpfY9X
         PQZYV0pXY3nJpy71rIvqMORQtrXW1JljWaY/lMAtLU9pk5mZgu0cSr8VN/lXRgV/zoZZ
         fUckp94mUGNOBJlXkzVkPemhIWXkgxQxEoEqsFnno0mG0wZOEX6e2hoqw74lX2cZ9MH2
         42S0/N5m+Pou7VkNA2iooNC4m99jalLqZlcfZebD/Ijm6EwpJMf43mjKN79yS2Ws0cZE
         NILw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kim Phillips <kim.phillips@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 72/97] perf tests kmod-path: Dont fail if compressed modules arent supported
Date: Fri, 23 Mar 2018 10:54:59 +0100
Message-Id: <20180323094201.635160482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722764578541420?=
X-GMAIL-MSGID: =?utf-8?q?1595723181364158929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kim Phillips <kim.phillips@arm.com>


[ Upstream commit 805b151a1afd24414706a7f6ae275fbb9649be74 ]

__kmod_path__parse() uses is_supported_compression() to determine and
parse out compressed module file extensions.  On systems without zlib,
this test fails and __kmod_path__parse() continues to strcmp "ko" with
"gz".  Don't do this on those systems.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 3c8a67f50a1e ("perf tools: Add kmod_path__parse function")
Link: http://lkml.kernel.org/r/20170503131402.c66e314460026c80cd787b34@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/kmod-path.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -60,6 +60,7 @@ int test__kmod_path__parse(void)
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_USER, false);
 
+#ifdef HAVE_ZLIB_SUPPORT
 	/* path                alloc_name  alloc_ext   kmod  comp  name   ext */
 	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, true, "[x]", "gz");
 	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, true, NULL , "gz");
@@ -95,6 +96,7 @@ int test__kmod_path__parse(void)
 	M("x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("x.ko.gz", PERF_RECORD_MISC_USER, false);
+#endif
 
 	/* path            alloc_name  alloc_ext  kmod  comp   name             ext */
 	T("[test_module]", true      , true     , true, false, "[test_module]", NULL);
