Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D68CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8A320873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8A320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbeK0UEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:04:07 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:33514 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbeK0UEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:04:06 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A9525B0475D02DCC9178;
        Tue, 27 Nov 2018 17:06:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAR96Ebx025384;
        Tue, 27 Nov 2018 17:06:14 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112717062860-13256242 ;
          Tue, 27 Nov 2018 17:06:28 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     peterz@infradead.org, acme@kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <yellowriver2010@hotmail.com>
Subject: [PATCH] perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())
Date:   Tue, 27 Nov 2018 17:06:10 +0800
Message-Id: <20181127090610.28488-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-27 17:06:28,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-27 17:06:09
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAR96Ebx025384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ERR=5FCAST inlined function instead of ERR=5FPTR(PTR=5FERR(...)).
This makes it more readable and also fix this warning detected
by err=5Fcast.cocci:
tools/perf/util/bpf-loader.c:1606:11-18: WARNING: ERR=5FCAST can be used wi=
th op

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Namhyung Kim <namhyung@kernel.org>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Wen Yang <yellowriver2010@hotmail.com>
CC: linux-kernel@vger.kernel.org
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f9ae1a993806..9a280647d829 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1603,7 +1603,7 @@ struct perf=5Fevsel *bpf=5F=5Fsetup=5Foutput=5Fevent(=
struct perf=5Fevlist *evlist, const cha
=20
 			op =3D bpf=5Fmap=5F=5Fadd=5Fnewop(map, NULL);
 			if (IS=5FERR(op))
-				return ERR=5FPTR(PTR=5FERR(op));
+				return ERR=5FCAST(op);
 			op->op=5Ftype =3D BPF=5FMAP=5FOP=5FSET=5FEVSEL;
 			op->v.evsel =3D evsel;
 		}
--=20
2.19.1

