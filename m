Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+F3FunuP5nyzm7+sVO3FeGLKfSuQbaIE76q37nlNcWMkwM7ZyWuhTcCln5l03MCvxoK4m3
ARC-Seal: i=1; a=rsa-sha256; t=1523472627; cv=none;
        d=google.com; s=arc-20160816;
        b=n700OlKNl77unHfwKDlkB0CB236oGs/3EX36BTTaKTmnCbqSocE5r+QgXk6yCLujpM
         rmDqvFjhq5Sh2KBFlzSkyLbh3sBNylDSKpZrSaBHwFthTYXohPTz+mRJ7wBlZRSAjWmr
         5KOtCem+s4814MphM0UQsz7FZqDCHiEKXZ0emjiewUgOaSdJVwtaVB7vSPIyxuHGUqFu
         Icnje6PiStRC+Si8CgYtumTs108oG+cuk/dgo8UfJLOe/oSFlUWXpHRInXNJ5Xrt61Rz
         vWBopSiMk8xKgj6tKaxN9y+GfkjwKdrJSoJ/dqTObx1MrzkCvqOfG/N9iyLcaHHR6R+f
         aFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2Pk5nxmAfxWnfrHLg3Bccy0H5vA/oWK7dtOw4363jSw=;
        b=VAoY0FgATZxLRpfpGEKRPWTppfxbyhIT+D3l4+23CdoIIbPqnJKZtnRUnjF2kPcO6z
         m6hpo+ITgO/XwFtUxAEsjKI2pbbbVB+lXE+sYbN4Y6Z5nLVy0+vW2uELBM8GFZ6NWyfg
         yb7yFDxsIq4P25e7I5AWlwg1avIrvGuBrRk4lv/BKDRPJ925Ty4HBfviRYaiKVSQUOXM
         pd77uE24cL7NxpRKy2zPdmECPQKF55kpf8/bQdrAtOQWuSZwK8vkFalJD9YfmuQY1E0l
         1tZeBBP5ImTFhisuK6LS+GYSgrNDxSKeUOVsujbCOVcTDlWu0AY15A4T8GK9EE8lICoM
         mTnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Wang Nan <wangnan0@huawei.com>,
	kernel-team@lge.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 136/190] perf tests: Decompress kernel module before objdump
Date: Wed, 11 Apr 2018 20:36:22 +0200
Message-Id: <20180411183600.526029566@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476266422257828?=
X-GMAIL-MSGID: =?utf-8?q?1597476833983864710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>


[ Upstream commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 ]

If a kernel modules is compressed, it should be decompressed before
running objdump to parse binary data correctly.  This fixes a failure of
object code reading test for me.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170608073109.30699-8-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/code-reading.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -182,6 +182,8 @@ static int read_object_code(u64 addr, si
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
+	const char *objdump_name;
+	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -242,9 +244,25 @@ static int read_object_code(u64 addr, si
 		state->done[state->done_cnt++] = al.map->start;
 	}
 
+	objdump_name = al.map->dso->long_name;
+	if (dso__needs_decompress(al.map->dso)) {
+		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
+						 decomp_name,
+						 sizeof(decomp_name)) < 0) {
+			pr_debug("decompression failed\n");
+			return -1;
+		}
+
+		objdump_name = decomp_name;
+	}
+
 	/* Read the object code using objdump */
 	objdump_addr = map__rip_2objdump(al.map, al.addr);
-	ret = read_via_objdump(al.map->dso->long_name, objdump_addr, buf2, len);
+	ret = read_via_objdump(objdump_name, objdump_addr, buf2, len);
+
+	if (dso__needs_decompress(al.map->dso))
+		unlink(objdump_name);
+
 	if (ret > 0) {
 		/*
 		 * The kernel maps are inaccurate - assume objdump is right in
