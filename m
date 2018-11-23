Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D8A20865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D8A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437204AbeKXFUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:20:41 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:60779 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395385AbeKXFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:20:40 -0500
Received: from cpc118554-reig6-2-0-cust775.6-3.cable.virginm.net ([86.18.95.8] helo=xylophone.i.decadent.org.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gQGIK-0001LL-HD; Fri, 23 Nov 2018 18:35:12 +0000
Date:   Fri, 23 Nov 2018 18:35:10 +0000
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests/bpf: Add test case for defence against SSB
 exploitation
Message-ID: <20181123183510.irdednmxibfal5mu@xylophone.i.decadent.org.uk>
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

Test that the defence added by commit af86ca4e3088 "bpf: Prevent
memory disambiguation attack" is actually being applied.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 tools/testing/selftests/bpf/test_verifier.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index e71b7f2e5f17..ca21a63541b0 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -13927,6 +13927,21 @@ static struct bpf_test tests[] = {
 		.result = ACCEPT,
 	},
 	{
+		"reference tracking: defend against SSB exploitation",
+		.insns = {
+			BPF_MOV32_IMM(BPF_REG_2, 1),
+			/* stack[-1] = (integer) 1 */
+			BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
+			/* stack[-1] = (pointer) context */
+			BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+			BPF_MOV32_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.infostr_unpriv = "patching in sanitization against SSB at 2",
+		.result_unpriv = ACCEPT,
+		.result = ACCEPT,
+	},
+	{
 		"calls: ctx read at start of subprog",
 		.insns = {
 			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

