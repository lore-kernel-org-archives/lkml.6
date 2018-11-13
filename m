Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E893C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0512243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK+ChHM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0512243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeKNGQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:16:25 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42215 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeKNGQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:16:25 -0500
Received: by mail-yw1-f65.google.com with SMTP id l2-v6so6311185ywb.9;
        Tue, 13 Nov 2018 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fOLxB5SbrWg2mxlzqt0Xgj9bBC+U68lAJfHs13rndqs=;
        b=CK+ChHM0Q0vmnMKLQKfuuWFwMLHPDJ+GoPJHfXdh1y+WS2hwDnxt38baL7D6e9KYHA
         Wqjte8qOt3bQVade1JoZtdv4JlUCG3xHoXpuFmvQEP69U2uegaTVum17RLHOVIT14OsP
         5l9SZW0GaM0EMBjn6lKHrQSsS8axklAAEpTdciUWxji4xddpCDPt/dvoe8XPUXNBdZAu
         Fioan6CcAi/AUunOAQHRHS0y5pI5FZvgAALeFPg1nBT7xxHkA8CNx1YBN70DgWevlxwQ
         IMrl+FkibG1htRJknIvmmWNcMt9QLKlq3W3VIPupQmmH7lg1lvK63NVmiKHFBcIB+9tM
         pVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fOLxB5SbrWg2mxlzqt0Xgj9bBC+U68lAJfHs13rndqs=;
        b=TaqGepVtGgdMYsjuF9DmZKmZj7a9rt28S6AncFinmClVMfsYmftIRJysCRcyGZxjsY
         BmE+o/OyaSILeisccmmVT1wN3/qw6FPveLfdFF1Qiyl8dxQ9kzk0bPeAHmMiLiGls7fm
         pyrZ/NaAyTdAboPrBco9F23fHHGt3yuJFxU0NOfI/Tyufn+vOF+ndwVMH99KuA7D71wo
         J+CN3qddKaoMh5tdKbOVUpQH2wy30AWxyPpBOqRFwziQgY/VKE/piRV2XGRoO4OTvUTp
         WdSvYFCIfmEfBendnxmov+HKRon8/UK9qZZWcfwx+HiFb8b4J1bSEWhhbggfK+fWficT
         mr/Q==
X-Gm-Message-State: AGRZ1gKtdd/31WZAjTvEKUnWa7oXN62BpnKuE42o+tpwGgON/JvOdkdJ
        Z/A+1Wz/jDtGEIQjeDhMtcw=
X-Google-Smtp-Source: AJdET5fLUWbh8gOlPJ+VDfbiXYLZK071wiPxe2MynRxHQIV236RnKM06hwBn85P4TZ6HTfu9ODxD5Q==
X-Received: by 2002:a81:5ec6:: with SMTP id s189-v6mr6449332ywb.126.1542140200014;
        Tue, 13 Nov 2018 12:16:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id p7-v6sm5274748ywd.75.2018.11.13.12.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:16:39 -0800 (PST)
Date:   Tue, 13 Nov 2018 12:16:37 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-4.21 2/2] cgroup: Add .__DEBUG__. prefix to debug
 file names
Message-ID: <20181113201637.GO2509588@devbig004.ftw2.facebook.com>
References: <20181113201339.GN2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113201339.GN2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From c1bbd933e5fae83f96acd3f748bb01a0300b315d Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 13 Nov 2018 12:06:41 -0800

Clearly mark the debug files and hide them by default by prefixing
".__DEBUG__.".

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cgroup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ed7f0bfe6429..e06994fd4e34 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1400,12 +1400,15 @@ static char *cgroup_file_name(struct cgroup *cgrp, const struct cftype *cft,
 	struct cgroup_subsys *ss = cft->ss;
 
 	if (cft->ss && !(cft->flags & CFTYPE_NO_PREFIX) &&
-	    !(cgrp->root->flags & CGRP_ROOT_NOPREFIX))
-		snprintf(buf, CGROUP_FILE_NAME_MAX, "%s.%s",
-			 cgroup_on_dfl(cgrp) ? ss->name : ss->legacy_name,
+	    !(cgrp->root->flags & CGRP_ROOT_NOPREFIX)) {
+		const char *dbg = (cft->flags & CFTYPE_DEBUG) ? ".__DEBUG__." : "";
+
+		snprintf(buf, CGROUP_FILE_NAME_MAX, "%s%s.%s",
+			 dbg, cgroup_on_dfl(cgrp) ? ss->name : ss->legacy_name,
 			 cft->name);
-	else
+	} else {
 		strscpy(buf, cft->name, CGROUP_FILE_NAME_MAX);
+	}
 	return buf;
 }
 
-- 
2.17.1

