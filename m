Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49kFs6UbEHK33FcbiQ0Mq5TN2ukJ0C5mN8j5A2TQPCbDe32ZWDkc8tsT02IFU/eBQJW34lE
ARC-Seal: i=1; a=rsa-sha256; t=1523473373; cv=none;
        d=google.com; s=arc-20160816;
        b=NkyfnHBXvj3sXT3+pOoGaWauASeef8iIbUUbsBg0oRc46+KAHfJvv69v+8VD/wFnhM
         QBosx2TnbGH5nVkG3hl/fJwlGpJPRLpc7gLFWiZaKh2DnWU4ZezCDQnPts1BlwdaTQlW
         upBBmLTAg7cK7AGqc+sJdXBz4f2YtReAQCixumEXvXVs+IuqdZs+cXFMI+t+Jlzpm/aw
         Vt1ASOnWLF/+W7lG29uIBCa9bMzWtYOfoLZ5m8rh21EbuVmxt0UmcbOaO1eg/L5Qld+T
         DjqPALcMY+GrQmCwG/mW+ygKyUn/oatx11DL1S2jFnL5z+ZQ36qKjJL8Yqv4fiASqohY
         b6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4WQwZMlGzXWs4kHllUCGnH+/AXa9JoX1x77lneFud3E=;
        b=ZRMJpCctMYfSjV/hZfGpQrAualrlWX8CipsgSBu4E76CVuLsYyOlOoOR4Fai0PG1Vj
         kp751zDeMi7A+U3RXd8hCQcgUKna5RoHgYQ7VdEv/gxOQUymFOwUzmy4ms7b203Fq5yE
         5jIMW+D7LwCfB+dRLUwN5hXP2jeJjcFRM6luwm93/KrfJ99y3rHly/5o9kqbA1XSaujj
         rb6Xl5cPzlh3s8IExBM+SEEbEGugiWw3chMIKVUr2MOAkQyOXVHj3bZvzJ4zCajNbmwb
         PEPJBeiDv8A3vZLc4cVO8HxdDlzogFHrCUNlyJ3BhNG1TX9hILqli67cWGQJlYzaPCQl
         0pVw==
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
Subject: [PATCH 4.9 225/310] perf tests: Decompress kernel module before objdump
Date: Wed, 11 Apr 2018 20:36:04 +0200
Message-Id: <20180411183632.205543444@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476266422257828?=
X-GMAIL-MSGID: =?utf-8?q?1597477615869945227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -224,6 +224,8 @@ static int read_object_code(u64 addr, si
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
+	const char *objdump_name;
+	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -284,9 +286,25 @@ static int read_object_code(u64 addr, si
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
