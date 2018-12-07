Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B31C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD792083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD792083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLGLqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:46:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGLqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:46:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so3528757wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 03:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkIn75tXF5e383FIg4XjF0+ALl+K3Lv7Y9UyN0H8wtE=;
        b=gJanz2U0ZC7BXUQg3NThlZ8xGp+PPV/HBaVwcoOKgWfnBoG9PkFlhsCMvkXBaxTeni
         kRU2s5Vm04hkrc8XhLQk+k5RUVQT2SmLtVAoLK3B+oLX9hqKMTnebLUpDuGfoA9GGeLa
         C/acnczhK6nri/6D+kKl1z0Vv8orTU81n1Nx5vMesWC4aCMBg7DQNTL/XpocZGrgiisG
         CMaRNprG7WPxtdWkXY/TyVZVr+zYdjhQ4tCrQh9oIf0uJl/RElZmwxHHu1VdRaBJ7jWT
         a1Z6V/Ra08JXFUnIsKP8hOHo2dx12mfqBOV06mtKg7OqHSICoS0P/eOqzrL02E/oy+Q6
         JOZQ==
X-Gm-Message-State: AA+aEWbbfRsgIHuIiSv2a+T5BYFCFGPl41FK7YWDfdlj/1zZPOiNPNXc
        dtAw0kkIengjy8WjE8b9lhvNbernwOM=
X-Google-Smtp-Source: AFSGD/WO+FLysdB5OTX9j1HSDxpo7MQ8itMPZYJKShsPBiW3h/woS6oGC9sZfhX5RF/emf9BFxY5dg==
X-Received: by 2002:adf:8484:: with SMTP id 4mr1475359wrg.249.1544183189168;
        Fri, 07 Dec 2018 03:46:29 -0800 (PST)
Received: from alatyr.usersys.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s66sm4503154wmf.34.2018.12.07.03.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 03:46:28 -0800 (PST)
From:   Peter Rajnoha <prajnoha@redhat.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     msekleta@redhat.com, Peter Rajnoha <prajnoha@redhat.com>
Subject: [PATCH v2] kobject: add kernel/uevent_features sysfs file
Date:   Fri,  7 Dec 2018 12:46:07 +0100
Message-Id: <20181207114607.26981-1-prajnoha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use extended format when writing /sys/.../uevent files to
generate synthetic uevents, introduced with commit f36776fafbaa
("kobject: support passing in variables for synthetic uevents").

Before using this extended format, we need to know if it's supported
and kernel version check may not be appropriate in all cases - there
are possible differences from upstream kernel in distributions with
backports.

This patch adds /sys/kernel/uevent_features file which currently lists
'synthargs' string to denote that the kernel is able to recognize the
extended synthetic uevent arguments. Userspace can easily check for
the feature then.

Updates for v2:
        Add Documentation/ABI/testing/sysfs-kernel-uevent_features.

Signed-off-by: Peter Rajnoha <prajnoha@redhat.com>
---
 .../ABI/testing/sysfs-kernel-uevent_features         | 12 ++++++++++++
 kernel/ksysfs.c                                      |  8 ++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-uevent_features

diff --git a/Documentation/ABI/testing/sysfs-kernel-uevent_features b/Documentation/ABI/testing/sysfs-kernel-uevent_features
new file mode 100644
index 000000000000..10b1d07c5ef9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-uevent_features
@@ -0,0 +1,12 @@
+What:           /sys/kernel/uevent_features
+Date:           December 2018
+KernelVersion:  4.21
+Contact:        Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+                Reading from this file returns space-separated list of
+                supported uevent features in current kernel.
+
+                Possible values:
+                        synthargs: passing additional variables for synthetic
+                                   uevents is supported (see also related
+                                   sysfs-uevent ABI documentation)
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 46ba853656f6..d893d7442f61 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -37,6 +37,13 @@ static ssize_t uevent_seqnum_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
+static ssize_t uevent_features_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "synthargs\n");
+}
+KERNEL_ATTR_RO(uevent_features);
+
 #ifdef CONFIG_UEVENT_HELPER
 /* uevent helper program, used during early boot */
 static ssize_t uevent_helper_show(struct kobject *kobj,
@@ -213,6 +220,7 @@ EXPORT_SYMBOL_GPL(kernel_kobj);
 static struct attribute * kernel_attrs[] = {
 	&fscaps_attr.attr,
 	&uevent_seqnum_attr.attr,
+	&uevent_features_attr.attr,
 #ifdef CONFIG_UEVENT_HELPER
 	&uevent_helper_attr.attr,
 #endif
-- 
2.19.2

