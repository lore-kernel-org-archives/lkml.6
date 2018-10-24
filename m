Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2C6C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AFA2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Mmgvb709"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AFA2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeJXV2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:28:32 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:34634 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeJXV2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:28:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4592D14A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k1NYrGFrOo2S for <linux-kernel@vger.kernel.org>;
        Wed, 24 Oct 2018 08:00:29 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 182D8185
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 08:00:29 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id v125-v6so4831232ita.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rwcky7LJkVmyfsGGJtlYEZ51gfnlASc6OrvnfxFV96c=;
        b=Mmgvb709BEIXK4CV82w0fH7biqrRt8DJRubbULl/KgABtDQNp5wxzZsJ82tnBf7K8H
         q/U6V9EF4STv+MI5dZKZqkjaWgRvf8kZIfLToYB6H1uCjaE2eyRHySTADP8vtx72hIEB
         TB2hsZUgLTxrqqc995jfi81yyxVARRZK2sQ0J83DwzRJca02QqIoXOnb4S3OuIat7Y9Q
         Se2GGtXlTO5LXlNbNygA/Z6t1adortrkF/XLamqILAFcOlzLayNZ9wNdwcW2CeLiUoBL
         xmi2b/OaS+8xhTLi260xcK40SOix7WVFnvywfnx8WhT3rq7Zb2RVKTVHjE0MKaW7Xk/h
         cshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rwcky7LJkVmyfsGGJtlYEZ51gfnlASc6OrvnfxFV96c=;
        b=ftk5cFqvIQdYm4tMTGXcMzrBK2/mbr6lEpQauJIwpAJsl8HuxZT1y6O7qIv8NIVWj9
         srQ9Kyl500FFZW2+C+JGZHnYlOhMcQOMShRc9yz9CncXCgmCkBIHfJ117Fn5P48JkEOz
         T47FPLVvzcf4x3dbF+L+TKhegJf3pCcEetL5kYsd4vwYOvGcRLjC5DIwebJODI0+QWyh
         pn2RNRdwdbQyTmVGCA9nODTCW6yf4IZ41foRsR81SFKHVnFCtjX4K09vdKwVwAA+JRyA
         A9z8aMdEaTpbgcntHdyYwIwR+QQZGBHGwzNFvft804no9mT2ydnZ8IaO+LOdFJ1DuXBo
         /hoQ==
X-Gm-Message-State: AGRZ1gLrzS8FC/bIbQSa22xphP++GLR2K5QL+uDFGTpSmpbg0wHOD21B
        91i+bH0pV0FXV4kDghZq9+1sZW21DIiu6R+aVTWw7WhBHYGB0cj1EGhnoal6FIa3TufijQvExTV
        IP9/U2OalSz4BtkzWsYIZn6SMcSxK
X-Received: by 2002:a6b:b8d4:: with SMTP id i203-v6mr13902390iof.287.1540386028700;
        Wed, 24 Oct 2018 06:00:28 -0700 (PDT)
X-Google-Smtp-Source: AJdET5fkwa4jpzd0Wg+tipvR71NyXDUPboKCDWKS9tH4wLBiaeDPaBCV1W6aX9Qf+GUPh+ktebIU0A==
X-Received: by 2002:a6b:b8d4:: with SMTP id i203-v6mr13902378iof.287.1540386028494;
        Wed, 24 Oct 2018 06:00:28 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id 4-v6sm1638282ioy.55.2018.10.24.06.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 06:00:27 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        linux-kernel@vger.kernel.org (open list:BPF (Safe dynamic programs and
        tools))
Subject: [PATCH v2] bpf: btf: Fix a missing-check bug
Date:   Wed, 24 Oct 2018 08:00:19 -0500
Message-Id: <1540386020-30680-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In btf_parse(), the header of the user-space btf data 'btf_data' is firstly
parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the header
is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
verified. If no error happens during the verification process, the whole
data of 'btf_data', including the header, is then copied to 'data' in
btf_parse(). It is obvious that the header is copied twice here. More
importantly, no check is enforced after the second copy to make sure the
headers obtained in these two copies are same. Given that 'btf_data'
resides in the user space, a malicious user can race to modify the header
between these two copies. By doing so, the user can inject inconsistent
data, which can cause undefined behavior of the kernel and introduce
potential security risk.

To avoid the above issue, this patch copies the parsed header from
'btf->hdr' to 'data'. The remaining part in 'data' is still copied from the
user-space 'btf_data'.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 kernel/bpf/btf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 378cef7..b52a834a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2152,6 +2152,7 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf = NULL;
+	u32 hdr_len;
 	u8 *data;
 	int err;
 
@@ -2200,7 +2201,15 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
 	btf->data_size = btf_data_size;
 	btf->nohdr_data = btf->data + btf->hdr.hdr_len;
 
-	if (copy_from_user(data, btf_data, btf_data_size)) {
+	/*
+	 * The header at btf_data could be modified by a malicious user
+	 * after it is parsed. So we copy the parsed header here. The
+	 * remaining part is still copied from btf_data.
+	 */
+	hdr_len = min_t(u32, btf->hdr.hdr_len, sizeof(btf->hdr));
+	memcpy(data, &btf->hdr, hdr_len);
+	if (copy_from_user(data + hdr_len, (u8 __user *)btf_data + hdr_len,
+				btf_data_size - hdr_len)) {
 		err = -EFAULT;
 		goto errout;
 	}
-- 
2.7.4

