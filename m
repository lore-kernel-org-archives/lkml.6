Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9725C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E6920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PZ2OcmJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfAQXRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:17:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57878 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbfAQXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:17:38 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HNEAEN015653
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:17:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=EW6Ss/Xc6/uYPcEVb35Qc4pfjivpYzKRttF5jugJZbI=;
 b=PZ2OcmJC/A7vECFi3j3BqFoBiAjowePgvQ12zm6wAKRyJHoROGSfUmaor6A6HvaGxirU
 iZIavKfpSciHHEC4Ffet/onatkxrD1nv7CeyRxXcXSRYw9UFay6B6/bz2rJ07uW6m3Zc
 B9D08wDdvL4EB7rLFG4HuwROD5U1HyJcdZY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2q317a8dg9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:17:37 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 17 Jan 2019 15:17:35 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1AB9C62E214C; Thu, 17 Jan 2019 15:17:32 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH kallsyms, bpf 0/3] kallsym_tree for dynamic ksymbols
Date:   Thu, 17 Jan 2019 15:17:27 -0800
Message-ID: <20190117231730.2413466-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set includes Peter's work to merge multiple trees for different types
of dynamic kallsyms (BPF, ftrace, etc.). Symbols for BPF programs are
migrated to use kallsym_tree.

I have made minor changes to Peter's patches, and tested them with BPF
programs and perf utility.

Thanks,
Song

Peter Zijlstra (3):
  rbtree_latch: Introduce latch_tree_first() and latch_tree_next()
  kallsyms: Introduce kallsym_tree for dynamic symbols
  bpf: migrate symbols for BPF programs to kallsym_tree

 include/linux/bpf.h          |   7 +-
 include/linux/filter.h       |  42 --------
 include/linux/kallsyms.h     |  16 +++
 include/linux/rbtree_latch.h |  54 ++++++++++
 kernel/bpf/core.c            | 167 ++++-------------------------
 kernel/events/core.c         |  35 ------
 kernel/extable.c             |   6 +-
 kernel/kallsyms.c            | 201 ++++++++++++++++++++++++++++++++---
 8 files changed, 281 insertions(+), 247 deletions(-)

--
2.17.1
