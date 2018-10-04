Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B636DC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861FD21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861FD21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJDJte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:49:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727469AbeJDJtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:49:09 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w942vPng016755
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 19:57:58 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2mw493s2vw-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 19:57:58 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.21) with Microsoft SMTP Server (TLS) id 14.3.319.2; Wed, 3 Oct
 2018 19:57:57 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)  id
 02ABF760B50; Wed,  3 Oct 2018 19:57:50 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     "David S . Miller" <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <luto@amacapital.net>,
        <viro@zeniv.linux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/6] fs: wire in BPF_CGROUP_FILE_OPEN hook
Date:   Wed, 3 Oct 2018 19:57:46 -0700
Message-ID: <20181004025750.498303-3-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004025750.498303-1-ast@kernel.org>
References: <20181004025750.498303-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable cgroup-bpf BPF_CGROUP_FILE_OPEN hook after security_file_open() LSM hook.
Similarly to other cgroup-bpf hooks it's gated by static key 'cgroup_bpf_enabled'
and has zero overhead until bpf prog is attached to that hook.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 fs/open.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..7e1170863f40 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -759,6 +759,10 @@ static int do_dentry_open(struct file *f,
 	if (error)
 		goto cleanup_all;
 
+	error = BPF_CGROUP_RUN_PROG_FILE_FILTER(f);
+	if (error)
+		goto cleanup_all;
+
 	error = break_lease(locks_inode(f), f->f_flags);
 	if (error)
 		goto cleanup_all;
-- 
2.17.1

