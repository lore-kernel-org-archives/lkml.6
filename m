Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635EC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47D5223C9
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdcKKaUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47D5223C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeGGB5Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:57:25 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:40099 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeGGB5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:57:24 -0400
Received: by mail-vk0-f74.google.com with SMTP id y200-v6so5310485vky.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=dcPk+tq3cvixsMiyOLcul6u6PWepF26UtRnspe8t0NQ=;
        b=EdcKKaUAM+2kksA9f9d9nMbZoN60rauwdtYsAMPaF+WeRi66WaGq8c2RyMpRxS3oZx
         DVu9BMmtwyTcNTaBAeIjy9DdLFYdmHyUaP1ha6JE4ewglEmcWPWGDWTP7ulU5KXwwc9O
         OQujRv+c89TjP4NUIyplmdX7ilvbBTZ/HRqI3hBEnFlYhrH4griJQ4ShzdoV85a8CaQx
         c35B0i0dTc/AOjLeK04j/v1L5YVYX9zHlVeGdsQQH9NEN+NBSPoHgQDYIsYFb+Mhr87v
         heLbqGY67MB7K17NGiqTrdPMJ+jVTGJ1U7NPoCtq1gE2p/U4ZrgI4WIV9Mr4jaUnYzDJ
         0fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=dcPk+tq3cvixsMiyOLcul6u6PWepF26UtRnspe8t0NQ=;
        b=b5KyemJXT+d89sSD7hSBdR1gZwdrSoLJwaKbX8kF2F5ci2tlL01H2ZUPg74pOh6vch
         AkoTs7CvvzhQoAk52fhk3CFexNDY6jyQWyZYea5pZ+RASh7OBlbCBIvrdprA7hYl6y/3
         SHm8Qwt8fTPycqaYT7yAg7jrN4SQul/18W/0cTqFnrE4AOQOcpAKUgSAMytYs0BTNHJv
         RcSPHM7qsIj8/km+Hxu9DFCT+4xROlj2iIzJ6GKWQIvXSDVJpFYMNhJoJCAJBIEwwZxr
         hVPcLdbF/zQXpbMahr9F4/evTt83cKtoDZysGnQNsPAm4B+9+cfEK9ay9f26Jt8Jionx
         BcEw==
X-Gm-Message-State: APt69E3ItfpCRq7+JeY7ren8IGVyTx6RmLH1JACDwKPmNuXSpCWoHPGa
        OwIbZQqJj6lyFwMRh+e9iFTOcpvPobI=
X-Google-Smtp-Source: AAOMgpc9IOHm3RbYD9Qh8t8iWVR0ZBLHJ+dbUMTUxF1F9gdE6lyH9mJAM4UBpJRBD2m/pn8/lOya/gb7w44=
MIME-Version: 1.0
X-Received: by 2002:ab0:7051:: with SMTP id v17-v6mr5641970ual.26.1530928643219;
 Fri, 06 Jul 2018 18:57:23 -0700 (PDT)
Date:   Fri,  6 Jul 2018 18:56:16 -0700
Message-Id: <20180707015616.25988-1-dancol@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
From:   Daniel Colascione <dancol@google.com>
To:     joelaf@google.com, ast@fb.com
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF_SYNCHRONIZE waits for any BPF programs active at the time of
BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
RCU data structure operations with respect to active programs. For
example, userspace can update a map->map entry to point to a new map,
use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
complete, and then drain the old map without fear that BPF programs
may still be updating it.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 include/uapi/linux/bpf.h |  1 +
 kernel/bpf/syscall.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b7db3261c62d..4365c50e8055 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -98,6 +98,7 @@ enum bpf_cmd {
 	BPF_BTF_LOAD,
 	BPF_BTF_GET_FD_BY_ID,
 	BPF_TASK_FD_QUERY,
+	BPF_SYNCHRONIZE,
 };
 
 enum bpf_map_type {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d10ecd78105f..60ec7811846e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (cmd == BPF_SYNCHRONIZE) {
+		if (uattr != NULL || size != 0)
+			return -EINVAL;
+		err = security_bpf(cmd, NULL, 0);
+		if (err < 0)
+			return err;
+		/* BPF programs are run with preempt disabled, so
+		 * synchronize_sched is sufficient even with
+		 * RCU_PREEMPT.
+		 */
+		synchronize_sched();
+		return 0;
+	}
+
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
 		return err;
-- 
2.18.0.203.gfac676dfb9-goog

