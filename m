Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACAEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A024C20811
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVDR7UL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeL3N3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 08:29:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38051 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeL3N3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 08:29:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so12318331pfi.5;
        Sun, 30 Dec 2018 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nWBrAT2ylqKn+nLRC8jRd1IkzOsVy3gKj5LQnJixJBo=;
        b=vVDR7UL33exP6gkPgMUAzVpDkTW9B5OkhP4+/Gakpd7uCwNoGz6wFYPJCXr09Q1KC0
         5Qr6f3ybdgEJNYhLG4HBUTbwn21xcAR4yT7qD6a/8juniWu6U6To2emcqFK1sJN3cME5
         38JBqNePcBcsDWXfzKwVvZEe/6hSV35fOppj4aeEhSlqwuVfP0T1YRZ9GyywYgvqbXYa
         +kDIC5F0Lzlo1pexqbOmYSkq+cRxm728BKLJth5d9BbhdCHRdO33TbwJjO77DdOjX0wu
         FzuzGdFLnjvYwfCd3zY2XWyJSzpctH3DpT5KDfglDcqrPyWf0cQ+42X0gPK73+Dj95J5
         8HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nWBrAT2ylqKn+nLRC8jRd1IkzOsVy3gKj5LQnJixJBo=;
        b=MUbG/MWfvWSlDda0BQ4GNeCllA/2XHHPCmQzNwkbOAwrIrp2IjPDS+VVeBFpIDem9m
         iG1apSeLuZaqyvsKNJo/j0wgmRGzzycxDFUKbWjDiBvaowl4yYQDWkNjd2qB42FnytvL
         t7eog/FmVPBc14ygskH/qPsjKw08sKXSbZxqY91g3TGByPcpEnijQUTTJRgAPv/LogEt
         wS35KfzhWbum1CTxnnr/6Pv1jijbSYOLzNa+A3kyBgdBSN0fxLkiiybudkhTlJN9ewAA
         2CEwFy4yynmW3cdD8/YlNF8dM0orXW1O6SDxXvOgaDkdD2hZeA00vSuhp8nhjQ40JpoP
         YHFQ==
X-Gm-Message-State: AA+aEWbktlL7j+lM0kNcb0fCzdp+vkBz22bJavHatszGj7u2IhOkRTEJ
        ploZOKWopqDywYaEauA7myI=
X-Google-Smtp-Source: AFSGD/XZGc9ldQuUk2sVOd4tjypodmefDFyGtTeW5TY41a7xrZ5CQU+55/hQWGrE06E+ogcegnHccg==
X-Received: by 2002:a62:e704:: with SMTP id s4mr35326229pfh.124.1546176575317;
        Sun, 30 Dec 2018 05:29:35 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id n73sm74103091pfj.148.2018.12.30.05.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 05:29:34 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/2] PM / Sleep: Check the file capability when writing wake lock interface
Date:   Sun, 30 Dec 2018 21:28:56 +0800
Message-Id: <20181230132856.24095-3-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181230132856.24095-1-jlee@suse.com>
References: <20181230132856.24095-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wake lock/unlock sysfs interfaces check that the writer must has
CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
by opening sysfs file within an unprivileged process and then writing
the file within a privileged process. The tricking way has been exposed
by Andy Lutomirski in CVE-2013-1959.

Here is an example that it's a simplified version from CVE-2013-1959
to bypass the capability checking of wake_lock sysfs:

int main(int argc, char* argv[])
{
        int fd, ret = 0;

        fd = open("/sys/power/wake_lock", O_RDWR);
        if (fd < 0)
                err(1, "open wake_lock");

        if (dup2(fd, 1) != 1)
                err(1, "dup2");
        sleep(1);
        execl("./string", "string");

        return ret;
}

The string is a privileged program that it can be used to write
string to wake_lock interface. The main unprivileged process opens
the sysfs interface and overwrites stdout. So the privileged
process will write to wake_lock.

This patch implemented the callback of file capable checking hook
in kobject attribute level. It will check the opener's capability.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Joe Perches <joe@perches.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 kernel/power/main.c     | 14 ++++++++++++++
 kernel/power/wakelock.c |  6 ------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 98e76cad128b..265199efedc1 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -661,6 +661,11 @@ static ssize_t wake_lock_store(struct kobject *kobj,
 	return error ? error : n;
 }
 
+static bool wake_lock_store_file_capable(const struct file *file)
+{
+	return file_ns_capable(file, &init_user_ns, CAP_BLOCK_SUSPEND);
+}
+
 power_attr(wake_lock);
 
 static ssize_t wake_unlock_show(struct kobject *kobj,
@@ -678,6 +683,11 @@ static ssize_t wake_unlock_store(struct kobject *kobj,
 	return error ? error : n;
 }
 
+static bool wake_unlock_store_file_capable(const struct file *file)
+{
+	return file_ns_capable(file, &init_user_ns, CAP_BLOCK_SUSPEND);
+}
+
 power_attr(wake_unlock);
 
 #endif /* CONFIG_PM_WAKELOCKS */
@@ -803,6 +813,10 @@ static int __init pm_init(void)
 	power_kobj = kobject_create_and_add("power", NULL);
 	if (!power_kobj)
 		return -ENOMEM;
+#ifdef CONFIG_PM_WAKELOCKS
+	wake_lock_attr.store_file_capable = wake_lock_store_file_capable;
+	wake_unlock_attr.store_file_capable = wake_unlock_store_file_capable;
+#endif
 	error = sysfs_create_group(power_kobj, &attr_group);
 	if (error)
 		return error;
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 4210152e56f0..52a4cfe55eb5 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -205,9 +205,6 @@ int pm_wake_lock(const char *buf)
 	size_t len;
 	int ret = 0;
 
-	if (!capable(CAP_BLOCK_SUSPEND))
-		return -EPERM;
-
 	while (*str && !isspace(*str))
 		str++;
 
@@ -251,9 +248,6 @@ int pm_wake_unlock(const char *buf)
 	size_t len;
 	int ret = 0;
 
-	if (!capable(CAP_BLOCK_SUSPEND))
-		return -EPERM;
-
 	len = strlen(buf);
 	if (!len)
 		return -EINVAL;
-- 
2.13.6

