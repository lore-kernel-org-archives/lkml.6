Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E4CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C9820821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GtNamkcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfBDTb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:31:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32960 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbfBDTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:31:56 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14JRt9u027836
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 11:31:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=vojjqhUG7G684hEmVJrow3/N0kOGV3UBHV/cg+ZuFAY=;
 b=GtNamkcGnbj2r83raz1OXm7vYdyjBo7A7/K86OC5Gk7Aawm5G4FWRuq8Of2senBXdMH8
 aYGCp7pwUSpI7j9cRVfpIbiemO5n1UuJRiTMJOq4Qy3ajnEQggbdN0iN51FVL0vth0S2
 pDY5c2YTqVt+IncHdQfHEnUACn+Y8SscKig= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qers58q41-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:31:54 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 4 Feb 2019 11:31:50 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 38DA162E1B4E; Mon,  4 Feb 2019 11:31:49 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] perf utils: silent "Couldn't synthesize bpf events" warning for EPERM
Date:   Mon, 4 Feb 2019 11:31:40 -0800
Message-ID: <20190204193140.719740-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesizing BPF events is only supported for root. Silent warning msg
when non-root user runs perf-record.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Reported-by: David Carrillo-Cisneros <davidca@fb.com>
Tested-by: David Carrillo-Cisneros <davidca@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 796ef793f4ce..62dda96b0096 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -236,8 +236,8 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 			pr_debug("%s: can't get next program: %s%s",
 				 __func__, strerror(errno),
 				 errno == EINVAL ? " -- kernel too old?" : "");
-			/* don't report error on old kernel */
-			err = (errno == EINVAL) ? 0 : -1;
+			/* don't report error on old kernel or EPERM  */
+			err = (errno == EINVAL || errno == EPERM) ? 0 : -1;
 			break;
 		}
 		fd = bpf_prog_get_fd_by_id(id);
-- 
2.17.1

