Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B9DECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6424B20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MO+TauK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6424B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbeGWW2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:28:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34013 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbeGWW2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:28:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so341453pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hlCo+jEla7bCsy6IQBxQSeY02tTrx2HhS4JSBi4ALWU=;
        b=MO+TauK7LDH6jkMX1l6m+7wf+mQsguuP8Mf2VyUnuvbXCNJuhqTuSvhb6j6xDrwGjP
         UzSHiuSTXORCoLIMTUS6ypC9b9GefAWYE2vmxT28tFLUy7VOSUbR8BcfR/cD74E0xoJM
         S+QCp96ryqtpufM3kdYSG1ue3w9bPttSZuBWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hlCo+jEla7bCsy6IQBxQSeY02tTrx2HhS4JSBi4ALWU=;
        b=XgpfZKuBAssRfSix+gG5vHTernHhDOLLcpNfE4tgV8J21rEs1MZ4XxI0VO/emKokV+
         5i+XKfd96sJsb6pffAQhZh0krYig5Jjrt18PPhfmiSWhRAKWYo1VEHAr9Ftsnvy/oTri
         v5j9+sIVVgGUXrnWxtDzAVtR9BIINlFbh/qLejdvkFDbU/+beqVeGwpzt5GYSS5fgPLe
         K0yO1ctPTAXwt3kas8ofcxtqc7ax9oPsClnr4DIGi+J27g9JH1E2MfI8Frpfz6bswAwx
         sGkmouHpo9UyJfljAZcq6RIUi3OLjXwadkQ+jlc9S4qZlzpQbeCsRYDzjNawN7C4vnOG
         tCGA==
X-Gm-Message-State: AOUpUlHFHnboLPO526QbUjT4xFteuY04Mcg2AQo0t6PGAXDCFEkW48uB
        UZ8HOES1kJcxxfzgnmKJxOZXbqdgik4=
X-Google-Smtp-Source: AAOMgpep9vr6hS411o24oKWibIuz2EAw1cPrytA9/eikI7zTsEqTyZegJeo+9AdP5FfZ/2P+VOq5Ew==
X-Received: by 2002:a62:129a:: with SMTP id 26-v6mr14889103pfs.102.1532381140559;
        Mon, 23 Jul 2018 14:25:40 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id y33-v6sm13611453pga.41.2018.07.23.14.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:25:40 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, astrachan@google.com
Subject: [PATCH RFC] debugobjects: Make stack check warning more informative
Date:   Mon, 23 Jul 2018 14:25:31 -0700
Message-Id: <20180723212531.202328-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Recently we debugged an issue where debugobject tracking was telling
us of an annotation issue. Turns out the issue was due to the object in
concern being on a different stack which was due to another issue.

Discussing with tglx, he suggested printing the pointers and the
location of the stack for the currently running task. This helped find
the object was on the wrong stack. I turned the resulting patch into
something upstreamable, so that the error message is more informative
and can help in debugging for similar issues in the future.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/debugobjects.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 994be4805cec..24c1df0d7466 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -360,9 +360,12 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 
 	limit++;
 	if (is_on_stack)
-		pr_warn("object is on stack, but not annotated\n");
+		pr_warn("object %p is on stack %p, but NOT annotated.\n", addr,
+			 task_stack_page(current));
 	else
-		pr_warn("object is not on stack, but annotated\n");
+		pr_warn("object %p is NOT on stack %p, but annotated.\n", addr,
+			 task_stack_page(current));
+
 	WARN_ON(1);
 }
 
-- 
2.18.0.233.g985f88cf7e-goog

