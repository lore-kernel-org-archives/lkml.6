Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC231C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB5720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB5720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeLEL2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:28:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36228 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeLEL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:27:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so19270266wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mv4M80QNe/gvx+6AY2Y/e1w7QqEbyBf2PP4R6Cbblas=;
        b=SEJ1pCE0ihrniyx0IPO+y5bKLV5YQi9IevVkS3CHwQs3M1oRI+KFPcYlMMc3NDHH0G
         F2YphwCyOaBO01f69Iky+xBPDsmnYDyXUoA7K/cpWwKXV0QaHtTL1OxvWSxwubBvTXK8
         jT7mKSxYgF7KMOT1AsW/y/Z34RJ7by+LFyNbOQ6O3pemUjHR88yFeDdLHF0VVF1ue1CY
         TlZs+/Poc6yHoRPOJSlRhPS4bG7xs6XobJpdng3mmzrD5zSxQAYpNYPxL8+Exlsz1MEp
         E8R5LGwiM9/RIvc15Y4KoKFO7TogFU3/D7qlPgh09GdJi9bW9RhuwQJ2TlfMlPcaY9vj
         +ItA==
X-Gm-Message-State: AA+aEWZ+uWUly45XNMwQaUIPf33JYU4UYe6ec10GS8LYNVwEq3IiYEMk
        /fYdSN3S0xxIjSITKe8tiOsT3g==
X-Google-Smtp-Source: AFSGD/VxvSgveuJVCCxFD6GyP8F8KGPGP0hBjnGeUvOgwX2cb0LSbb/1nW8xXP142EmUOskJSiaQFg==
X-Received: by 2002:adf:8342:: with SMTP id 60mr20145179wrd.212.1544009274228;
        Wed, 05 Dec 2018 03:27:54 -0800 (PST)
Received: from alatyr.usersys.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d2sm14535027wrs.97.2018.12.05.03.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 03:27:53 -0800 (PST)
From:   Peter Rajnoha <prajnoha@redhat.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     msekleta@redhat.com, Peter Rajnoha <prajnoha@redhat.com>
Subject: [PATCH 2/2] kobject: add kernel/uevent_features sysfs file
Date:   Wed,  5 Dec 2018 12:27:45 +0100
Message-Id: <20181205112745.12276-3-prajnoha@redhat.com>
In-Reply-To: <20181205112745.12276-1-prajnoha@redhat.com>
References: <20181205112745.12276-1-prajnoha@redhat.com>
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

Signed-off-by: Peter Rajnoha <prajnoha@redhat.com>
---
 kernel/ksysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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

