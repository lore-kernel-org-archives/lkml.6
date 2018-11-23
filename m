Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122BFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC5520865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC5520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395439AbeKXFUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:20:33 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:60761 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeKXFUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:20:32 -0500
Received: from cpc118554-reig6-2-0-cust775.6-3.cable.virginm.net ([86.18.95.8] helo=xylophone.i.decadent.org.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gQGIC-0001Ki-Pf; Fri, 23 Nov 2018 18:35:04 +0000
Date:   Fri, 23 Nov 2018 18:35:03 +0000
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] selftests/bpf: Add the ability to test for a log message
 on success
Message-ID: <20181123183503.v3gl42innv4zbilw@xylophone.i.decadent.org.uk>
References: <20181123183356.5q4bu47zpj5wdufb@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123183356.5q4bu47zpj5wdufb@xylophone.i.decadent.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to test that code is being patched when it should be.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 tools/testing/selftests/bpf/test_verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 0f3f97a401c9..e71b7f2e5f17 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -76,6 +76,8 @@ struct bpf_test {
 	int fixup_percpu_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
+	const char *infostr;
+	const char *infostr_unpriv;
 	uint32_t retval, retval_unpriv;
 	enum {
 		UNDEF,
@@ -14232,7 +14234,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	int prog_len, prog_type = test->prog_type;
 	struct bpf_insn *prog = test->insns;
 	int map_fds[MAX_NR_MAPS];
-	const char *expected_err;
+	const char *expected_err, *expected_info;
 	uint32_t expected_val;
 	uint32_t retval;
 	int i, err;
@@ -14253,6 +14255,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		       test->result_unpriv : test->result;
 	expected_err = unpriv && test->errstr_unpriv ?
 		       test->errstr_unpriv : test->errstr;
+	expected_info = unpriv && test->infostr_unpriv ?
+			test->infostr_unpriv : test->infostr;
 	expected_val = unpriv && test->retval_unpriv ?
 		       test->retval_unpriv : test->retval;
 
@@ -14272,6 +14276,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 			       strerror(errno));
 			goto fail_log;
 		}
+		if (expected_info && !strstr(bpf_vlog, expected_info)) {
+			printf("FAIL\nMissing expected info message!\n\tEXP: %s\n\tRES: %s\n",
+			      expected_info, bpf_vlog);
+			goto fail_log;
+		}
 	} else {
 		if (fd_prog >= 0) {
 			printf("FAIL\nUnexpected success to load!\n");
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


