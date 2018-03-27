Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/mwIHRGZMW7e/O3riaBRzuSPZLgdQlY4x1HpxSGA3tdMHrAusBkeVPtgw0R6HBddhhDDW1
ARC-Seal: i=1; a=rsa-sha256; t=1522168971; cv=none;
        d=google.com; s=arc-20160816;
        b=oeeX1Dm1MMnkennybra3sja26tItaoTsw0lk6U4OLFo6VKZfGXjSrg6EhsQdkv2FiT
         zroZg4Kwr1dqny/IaS3uOpIIs+258WKFWJiFmJpsSUgncyaJjo4rYVLzjZwt87OnT6sh
         84OrBcV5TxSkOX+4bTFYphCUPYf+cGzyGOmO5NYAgQi5hIz4JrD+cLrXMmccfpej+ZHY
         STihh6GTHY3H3yPrH71eKuXC2u59mHBfDiWADPoOlhNzRr98gUvnIJpoj14XgLsQn63+
         MZPfeJu7Ooid3I+qXgEBnFWOuGbgGIkqMR8nQUnYjddG3Rw/N8ZLacptk8X8u4mOAERE
         MzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uzNDd4jR2u4aR2gvvgrWkgGaA3u8xKMxukprg/5hOrE=;
        b=EsugeVND5yOm1KH9DQIoD5aj1z+SWOQ0SXPw/J+EdaFELY/oA7hZok+htbEvKyZK6l
         xxSINNlLNZB0bCnB4+kr5WakRuQlG+mT/mHqpHKYvmNhtrhm27QbfGExugE02YmYxXJM
         YeOWIVjAD2YYkVcU25IRMBpNOgv96M+9uAYpkug22QKU5kxnyMLp4TgaZWEpANCRAInc
         6FxpNihkNadIRaQN1DYzkDJaBcfzKg5QjWxn2z+SMYPVagCzGJlznEOwJStDFpffSHnE
         OGe6EyCCoeNcnnLe2JChAmKYSpZIbHehyDV6s2Rohn4VSypGn2mWa15XkGrz5Z9Oz/NS
         5yKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.15 096/105] trace/bpf: remove helper bpf_perf_prog_read_value from tracepoint type programs
Date: Tue, 27 Mar 2018 18:28:16 +0200
Message-Id: <20180327162803.916571825@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109851123386111?=
X-GMAIL-MSGID: =?utf-8?q?1596109851123386111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yhs@fb.com>

commit f005afede992e265bb98534b86912bb669ccd0d2 upstream.

Commit 4bebdc7a85aa ("bpf: add helper bpf_perf_prog_read_value")
added helper bpf_perf_prog_read_value so that perf_event type program
can read event counter and enabled/running time.
This commit, however, introduced a bug which allows this helper
for tracepoint type programs. This is incorrect as bpf_perf_prog_read_value
needs to access perf_event through its bpf_perf_event_data_kern type context,
which is not available for tracepoint type program.

This patch fixed the issue by separating bpf_func_proto between tracepoint
and perf_event type programs and removed bpf_perf_prog_read_value
from tracepoint func prototype.

Fixes: 4bebdc7a85aa ("bpf: add helper bpf_perf_prog_read_value")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/bpf_trace.c |   68 +++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -636,7 +636,41 @@ static const struct bpf_func_proto bpf_g
 	.arg3_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_perf_prog_read_value_tp, struct bpf_perf_event_data_kern *, ctx,
+static const struct bpf_func_proto *tp_prog_func_proto(enum bpf_func_id func_id)
+{
+	switch (func_id) {
+	case BPF_FUNC_perf_event_output:
+		return &bpf_perf_event_output_proto_tp;
+	case BPF_FUNC_get_stackid:
+		return &bpf_get_stackid_proto_tp;
+	default:
+		return tracing_func_proto(func_id);
+	}
+}
+
+static bool tp_prog_is_valid_access(int off, int size, enum bpf_access_type type,
+				    struct bpf_insn_access_aux *info)
+{
+	if (off < sizeof(void *) || off >= PERF_MAX_TRACE_SIZE)
+		return false;
+	if (type != BPF_READ)
+		return false;
+	if (off % size != 0)
+		return false;
+
+	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(__u64));
+	return true;
+}
+
+const struct bpf_verifier_ops tracepoint_verifier_ops = {
+	.get_func_proto  = tp_prog_func_proto,
+	.is_valid_access = tp_prog_is_valid_access,
+};
+
+const struct bpf_prog_ops tracepoint_prog_ops = {
+};
+
+BPF_CALL_3(bpf_perf_prog_read_value, struct bpf_perf_event_data_kern *, ctx,
 	   struct bpf_perf_event_value *, buf, u32, size)
 {
 	int err = -EINVAL;
@@ -653,8 +687,8 @@ clear:
 	return err;
 }
 
-static const struct bpf_func_proto bpf_perf_prog_read_value_proto_tp = {
-         .func           = bpf_perf_prog_read_value_tp,
+static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
+         .func           = bpf_perf_prog_read_value,
          .gpl_only       = true,
          .ret_type       = RET_INTEGER,
          .arg1_type      = ARG_PTR_TO_CTX,
@@ -662,7 +696,7 @@ static const struct bpf_func_proto bpf_p
          .arg3_type      = ARG_CONST_SIZE,
 };
 
-static const struct bpf_func_proto *tp_prog_func_proto(enum bpf_func_id func_id)
+static const struct bpf_func_proto *pe_prog_func_proto(enum bpf_func_id func_id)
 {
 	switch (func_id) {
 	case BPF_FUNC_perf_event_output:
@@ -670,34 +704,12 @@ static const struct bpf_func_proto *tp_p
 	case BPF_FUNC_get_stackid:
 		return &bpf_get_stackid_proto_tp;
 	case BPF_FUNC_perf_prog_read_value:
-		return &bpf_perf_prog_read_value_proto_tp;
+		return &bpf_perf_prog_read_value_proto;
 	default:
 		return tracing_func_proto(func_id);
 	}
 }
 
-static bool tp_prog_is_valid_access(int off, int size, enum bpf_access_type type,
-				    struct bpf_insn_access_aux *info)
-{
-	if (off < sizeof(void *) || off >= PERF_MAX_TRACE_SIZE)
-		return false;
-	if (type != BPF_READ)
-		return false;
-	if (off % size != 0)
-		return false;
-
-	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(__u64));
-	return true;
-}
-
-const struct bpf_verifier_ops tracepoint_verifier_ops = {
-	.get_func_proto  = tp_prog_func_proto,
-	.is_valid_access = tp_prog_is_valid_access,
-};
-
-const struct bpf_prog_ops tracepoint_prog_ops = {
-};
-
 static bool pe_prog_is_valid_access(int off, int size, enum bpf_access_type type,
 				    struct bpf_insn_access_aux *info)
 {
@@ -754,7 +766,7 @@ static u32 pe_prog_convert_ctx_access(en
 }
 
 const struct bpf_verifier_ops perf_event_verifier_ops = {
-	.get_func_proto		= tp_prog_func_proto,
+	.get_func_proto		= pe_prog_func_proto,
 	.is_valid_access	= pe_prog_is_valid_access,
 	.convert_ctx_access	= pe_prog_convert_ctx_access,
 };
