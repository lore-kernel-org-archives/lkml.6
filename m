Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832CBECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDC820869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qeOyjRjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDC820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJTApg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:45:36 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57066 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeJTApg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:45:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id A88CB48
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZHXcCuXWJOIt for <linux-kernel@vger.kernel.org>;
        Fri, 19 Oct 2018 11:38:43 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 7EC36680
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:38:43 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id z15-v6so31700576iob.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=npkr3Ap+nbU6Y9xmbzRD8LGdLQPGqx/63i8SQZfzRPk=;
        b=qeOyjRjtZB6FdP/MFFOy8FZZTYnkNpwXYNHXQy1OqGWSSTARiRZYitfpQDyrUN3j/K
         tKjBdEVTrWDlXKxlkavSqWVtZ+dRUimlsC08SaNm75F4KR0mu+LmCoGe+FhIxzaiWf2v
         YWesg5cZooAr/1ZqyasUla6Nj5L1ToFyK7t2yOj0BtMRdmqg4WTGxouc+ntI/yFSkA8T
         Czi2L6Voy/TunfWq4zkpWWH9nWHBJNUzP0cAJv3Cnd9flDcrcGtkSGYO7oXzh7wZot5V
         br7krIjekrSuMpSQuIBUf9s7yLVwCnDeWWDa9QX7ulQ92pTAZv97f9lz5lZeA0dAH1z3
         KFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=npkr3Ap+nbU6Y9xmbzRD8LGdLQPGqx/63i8SQZfzRPk=;
        b=ouaYy+fyyvzSHHx7ZvTIiyx/vxzl2tJN2kAd4WUyCzOF47Q6CRFQ6ceBOFZE6K3pO7
         nHNAgJ+yT3seKEbdlcJMHze7ilHg4HCfTleeLNLC2HDsf57kdpHtQ7wJxwzC1tUsXxej
         2qFdYHIkuK8h7o1rzbC5AJ9GkkaWi77g70cQH9kS/iiD9piCYPrzwSYbgzW2BMiYubjv
         s7WGvte+QCgOZayCVJvcetU26B/18xV2aR4H8gI8aafOeWA5+lfjXyPcvhPoXmrYMtbd
         nlI/peVgg+1cboZVCAC73zMaL6ZDK5QY+BTObIcegbA4rjLlvyyC745axLScoChVIHFm
         o8og==
X-Gm-Message-State: ABuFfoiOqiFWoiV/VUjqWF5wtJjV5YFl4yLkRtfg9HPxbwqgNthdA2Ek
        bh6zw1wN6l3BWzhkv6bX7VLEB38X68iYhqrtGplXJgszKp2OiPedPbO0AwDngnVkNyavvKOG5+/
        7ipN0WwRA4ioMrxHJsuOiqiBkHE+I
X-Received: by 2002:a02:5953:: with SMTP id p80-v6mr28308739jab.111.1539967123194;
        Fri, 19 Oct 2018 09:38:43 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61cfTFJN7hJq7eNSEJTt8V0DRK/vNksOKMWVFVRhvivA/5AubTZCOuhoI+z10Lnv7aOxeWMPw==
X-Received: by 2002:a02:5953:: with SMTP id p80-v6mr28308729jab.111.1539967123010;
        Fri, 19 Oct 2018 09:38:43 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id s7-v6sm7614140iod.69.2018.10.19.09.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 09:38:41 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] can: janz-ican3: fix a missing-check bug
Date:   Fri, 19 Oct 2018 11:38:33 -0500
Message-Id: <1539967113-12352-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ican3_old_recv_msg(), the values in the MSYNC control registers are
firstly read to 'peer' and 'locl' from the IO memory region 'mod->dpm'
through ioread8(). Then the result of the bitwise XOR of 'locl' and 'peer'
is saved to 'xord'. After that, 'xord' is checked to see whether the flag
MSYNC_RB_MASK is set. If not, an error code ENOMEM will be returned to
indicate that there is no mbox for reading. Later on, the whole message,
including the control registers, is read from 'mod->dpm' to 'msg' through
memcpy_fromio(). However, after this read, there is no re-check on the
values of the control registers. Given that the device also has the
permission to access the IO memory region, it is possible that a malicious
device controlled by an attacker modify the values in the control registers
between these two reads. By doing so, the attacker can bypass the check on
the control registers and supply unexpected values, which can cause
undefined behavior of the kernel and introduce potential security risk.

This patch rewrites the values of the control registers in 'msg' after
memcpy_fromio(), using the values acquired from ioread8(). Through this
way, the above issue can be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/net/can/janz-ican3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 02042cb..45c6760 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -335,6 +335,8 @@ static int ican3_old_recv_msg(struct ican3_dev *mod, struct ican3_msg *msg)
 	mbox_page = (mbox == MSYNC_RB0) ? QUEUE_OLD_RB0 : QUEUE_OLD_RB1;
 	ican3_set_page(mod, mbox_page);
 	memcpy_fromio(msg, mod->dpm, sizeof(*msg));
+	msg->control = peer;
+	msg->spec = locl;
 
 	/*
 	 * notify the firmware that the read buffer is available
-- 
2.7.4

