Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB441C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907D72089C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LfsGLEkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907D72089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeGYSbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:31:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33747 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbeGYSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:31:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so5748685pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cOkOdsnhkmu9fl8PYXdiXrAD1ILM0CG7LQC0wWds1fI=;
        b=LfsGLEkYumlRpUBJHo8XyDgLdPEHZELu1CnCxv7m5oxI1JBmq+7rRyXYNBLxMXl+kn
         qv2S0ZmGVKFKxxMePILtqPs1s3ao0sD6ycsryVRSsSJo86aPUguJiZq4j4CHbOc2CT7f
         KC4k8Th7hEROIA+AMfgzjinOrjRrA+eRxFV6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cOkOdsnhkmu9fl8PYXdiXrAD1ILM0CG7LQC0wWds1fI=;
        b=W1kdWId9hlVGMCp+QQCgBvBSi4wkdOeF/Z8L71PiOkZPnycxd7JR8Y6QN8pmFnxFXb
         PllYaknMKvTV6A5+csGhnQu12265+ZZ4HE/wfGt1e8mRUW8jit3ON2B9P2xAA8F1fQ0Y
         loFfi0rzR7YWYmxU/YEiiEWsDZ/M/Xa/PMUdrZBDLxINQgIHnE8EExLJUgUloSUNkAOS
         TPOJkPLHAza92uSOV4tdq06iSB4iAIpgAbBrCCePVPEPtT9cOF/uB/WySp7VHmKSDe+j
         eC0cDoM4chfiM35lkOPTb6TpE/j193IHXuvVkwryEBOfK21iBeAoUWmb4MoNWsHl8yq7
         hzeg==
X-Gm-Message-State: AOUpUlHAz49rbJDNwYIngttlIl5EyHALbCPZxvu6oEYJxbzRt39y7GCo
        0EYyguE1wZZuWLadZfU0u6rNmw==
X-Google-Smtp-Source: AAOMgpfK8L1qENsPeiPVrgeFsq96+cOURZSRT6UZPNOYdUWGAL+S+g6HEWvGLpEQsIcrAgswRVExCA==
X-Received: by 2002:a62:1a4a:: with SMTP id a71-v6mr23109828pfa.190.1532539151743;
        Wed, 25 Jul 2018 10:19:11 -0700 (PDT)
Received: from zsm-linux.mtv.corp.google.com ([2620:0:1000:1511:965:9e30:3027:44b2])
        by smtp.googlemail.com with ESMTPSA id f18-v6sm32681529pff.29.2018.07.25.10.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 10:19:10 -0700 (PDT)
From:   Zubin Mithra <zsm@chromium.org>
To:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, groeck@chromium.org, zsm@chromium.org
Subject: [PATCH v2] tracefs: Annotate tracefs_ops with __ro_after_init
Date:   Wed, 25 Jul 2018 10:19:01 -0700
Message-Id: <20180725171901.4468-1-zsm@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tracefs_ops is initialized inside tracefs_create_instance_dir and not
modified after. tracefs_create_instance_dir allows for initialization
only once, and is called from create_trace_instances(marked __init),
which is called from tracer_init_tracefs(marked __init). Also, mark
tracefs_create_instance_dir as __init.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 fs/tracefs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bea8ad876bf9..7098c49f3693 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -53,7 +53,7 @@ static const struct file_operations tracefs_file_operations = {
 static struct tracefs_dir_ops {
 	int (*mkdir)(const char *name);
 	int (*rmdir)(const char *name);
-} tracefs_ops;
+} tracefs_ops __ro_after_init;
 
 static char *get_dname(struct dentry *dentry)
 {
@@ -478,7 +478,8 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  *
  * Returns the dentry of the instances directory.
  */
-struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *parent,
+__init struct dentry *tracefs_create_instance_dir(const char *name,
+					  struct dentry *parent,
 					  int (*mkdir)(const char *name),
 					  int (*rmdir)(const char *name))
 {
-- 
2.18.0.233.g985f88cf7e-goog

