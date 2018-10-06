Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED79C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FE92089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bAw3fxoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FE92089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJFXMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:12:41 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:58858 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJFXMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:12:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id DFD8211A3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Oct 2018 16:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w8_ySsCUFMME for <linux-kernel@vger.kernel.org>;
        Sat,  6 Oct 2018 11:08:45 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B2A371196
        for <linux-kernel@vger.kernel.org>; Sat,  6 Oct 2018 11:08:45 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id c21-v6so15193737ioi.14
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WSJTVJ0TLzuTsTNEy1WN/u44tdhSVKG6jXB1LUwC8ow=;
        b=bAw3fxoiy7D2exPDuGSpJVoioiM1OmMh4qGilFSk8NgMdD403bJRvpFt7Hao9plcHj
         Abgt5LirtVEpg6A+7h7//2f7yhClksoUfbN1uzwS+vdI/RGmx8uOzel+cJIj7RW+uxBG
         mG30wc0tf6U1JkrdE3DqOxd8T05chQp+xzkV2DNDL2J3vKMrMmn+G9ybgn3mmUBwyekN
         ZtZX0GhgMpx2Z20kzczBdaGqy8jnJbCkQr/QhIir1pJ4Uxzk7PI2J25+DSgHsm2gTAsG
         MKi2BFLZbQwVO4cwug9VqO0EkJC3rCsODdDYwNXujsIqBl5ox+/WuF3WyhHYp1MmUsQ6
         zAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WSJTVJ0TLzuTsTNEy1WN/u44tdhSVKG6jXB1LUwC8ow=;
        b=WLT6+zS4kk+IYMNpOrPlavGIt89PY/IPc1bII0X/gYVNraXGtVmdqtNt0EGho0HRfC
         xSTHC7EzQAeiARvTnEzqEybczPgFi0zUcmUN8dDq47e1Lqp2lvI3CUgy5+aPucWOzVuS
         pR3dIJmDQwts2UChWq3V6i4YkcmCTUjUeq+DZTy4xyRzKbc2wwzo6szh6JhhMKfSKjJT
         ah8rJTfipiNBG2SMDa77gF6E92mh1q5iHr7IAzEUP8JeqGcZo0onxwRJaWEySfUx38SH
         2wjkXehEdWp7jKgO5BMLU0jAAuConp1xvCVGTUQ0chtUmEN6B/wU5cMup1CPdWtu3sTx
         K/2g==
X-Gm-Message-State: ABuFfog1R9rjc4jLgpzrtIBF9ncqRNTv4d6NXj3BBIgXZvY1z4ZooVjh
        6rT6oGIwDSjpBQiKxDsI6/hzKPEDXJjlYw3kXz/tdVV/RvCRL641vrnYPA4YHE/qV0t1YfR6IYz
        Lv+sXy0Euh6BZBGaJoCnwD9dWj8bF
X-Received: by 2002:a6b:5306:: with SMTP id h6-v6mr11121231iob.117.1538842125360;
        Sat, 06 Oct 2018 09:08:45 -0700 (PDT)
X-Google-Smtp-Source: ACcGV636WmYiuacYVVNwQo+STBzoM/5AUiGm25RPM81BfzkD4Cs0nWjAbzFSHWbujkz/XRkPT3ONsg==
X-Received: by 2002:a6b:5306:: with SMTP id h6-v6mr11121224iob.117.1538842125161;
        Sat, 06 Oct 2018 09:08:45 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id y11-v6sm2838557ioa.24.2018.10.06.09.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Oct 2018 09:08:44 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390 NETWORK DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] s390/qeth: fix a missing-check bug
Date:   Sat,  6 Oct 2018 11:08:23 -0500
Message-Id: <1538842104-26018-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qeth_snmp_command(), the length of the user request is firstly copied
from the user-space buffer 'udata' to the kernel variable 'req_len' and
checked to see whether it is too large. If the check fails, an error code
EINVAL is returned. Otherwise, the execution continues and the whole buffer
is copied again from 'udata' and saved to the kernel buffer 'ureq'.
However, after the second copy, no re-check is enforced on the newly-copied
request length. Given that the buffer 'udata' is in the user space, a
malicious user can race to change the request length between the two
copies. In this way, the attacker can supply malicious data to the kernel
and cause undefined behavior.

This patch adds a re-check on the request length after the second copy from
the buffer 'udata'. If the newly-copied value is different from the value
obtained in the first copy, i.e., 'req_len', an error code EINVAL will be
returned after the buffer 'ureq' is freed.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/s390/net/qeth_core_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index de82824..6199743 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4613,6 +4613,10 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 		QETH_CARD_TEXT(card, 2, "snmpnome");
 		return PTR_ERR(ureq);
 	}
+	if (ureq->hdr.req_len != req_len) {
+		kfree(ureq);
+		return -EINVAL;
+	}
 	qinfo.udata_len = ureq->hdr.data_len;
 	qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
 	if (!qinfo.udata) {
-- 
2.7.4

