Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD000C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83812218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USSi4n0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeL3N3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 08:29:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43725 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeL3N3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 08:29:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so11835571pgk.10;
        Sun, 30 Dec 2018 05:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F2L2T9oJgmNfEnAFbFUxwgnELqEvEC5ITjkVMEaYPJk=;
        b=USSi4n0S30API4z7/ouBePwh45GO7jTnSPZNg0Bqw/BLcGXjG6REfD3Jr9CZ1rNH+S
         2SOTMSmxkO29x9WqajuDri3RyymknXJb3dOpM9Zv32lEDhJeMrFLPAjbQf20gEl/h0Th
         rVWAdwxP1mNeUDV6PhKNrgow8qY0rzTBQEMw0RBTgnvYxAkZlb07amyCT6fp4AeBVzxl
         u8gG2Mi/Zfa3a2PMXB2MSL1BADj8PJhBk5e8atPDs65pHXNKY/2ozXtHMDiOvcndQWCF
         Yi9BLNh4pzQiIgTY51KGr7NMbqeGoEXrKe+VpCdze9fqG7+vyxlvdNahJjXdc04hPHCM
         6CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2L2T9oJgmNfEnAFbFUxwgnELqEvEC5ITjkVMEaYPJk=;
        b=NSuOKHKZHGg9XwrPRil1ZolnO8Ww5TVxAeVlVY9ZNY4AEi8AsN/uMacYlzFzSEb6Mo
         AXVsnlxl5a539I4H2RFE2XSkUp8G4WodxSUgBe7lruTDol3Jfv9/qko5PpG5an/0MLoK
         fmyOG5L+YXU2x4JkiDpC2PMG0RVJGbEzixEC+tv7k7agbxh2WJEPjgwWWqccfK1U/Q5o
         rYZ/wkqh/oodaP3XgYUSLec3LNb+NB3Ocxe/2hmOiNINg3ofIxE9O/NRK5EU1mbo6zfy
         da/tW+4mnXuuDnyJEb/RWCLePqmVWLeBMxCL9baN2rD3nn8T+dJekMVf156ijdY/3gft
         53hQ==
X-Gm-Message-State: AJcUuke9PG34v+1x5nKU0G/nhjKca9K2Z5keXYgboxuGIwao3WfJ2wE9
        j128YKW5XuZnLhC4G9w7AYme53X8
X-Google-Smtp-Source: ALg8bN7LRCtqzDiWWUqlZL85LxgZzSkQOfol1vIor2N3Mnx1DeDFFGq5YXcW1pYqZtxFRutnRjIFdQ==
X-Received: by 2002:a63:4566:: with SMTP id u38mr4472393pgk.4.1546176563247;
        Sun, 30 Dec 2018 05:29:23 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id n73sm74103091pfj.148.2018.12.30.05.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 05:29:22 -0800 (PST)
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
Subject: [PATCH 0/2] [RFC] sysfs: Add hook for checking the file capability of opener
Date:   Sun, 30 Dec 2018 21:28:54 +0800
Message-Id: <20181230132856.24095-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have some discussion in the following mail loop about checking
capability in sysfs write handler:
    https://lkml.org/lkml/2018/9/13/978

Sometimes we check the capability in sysfs implementation by using
capable function. But the checking can be bypassed by opening sysfs
file within an unprivileged process then writing the file within a
privileged process. The tricking way has been exposed by Andy Lutomirski
for CVE-2013-1959.

Because the sysfs_ops does not forward the file descriptor to the
show/store callback, there doesn't have chance to check the capability
of file's opener. This patch adds the hook to sysfs_ops that allows
different implementation in object and attribute levels for checking
file capable before accessing sysfs interfaces.

The callback function of kobject sysfs_ops is the first implementation
of new hook. It casts attribute to kobj_attribute then calls the file
capability callback function of attribute level. The same logic can
be implemented in other sysfs file types, like: device, driver and
bus type. 

The capability checking logic in wake_lock/wake_unlock sysfs interface
is the first example for kobject. It will check the opener's capability.

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

Lee, Chun-Yi (2):
  sysfs: Add hook for checking the file capable
  PM / Sleep: Checking the file capability when writing wak lock
    interface

 fs/sysfs/file.c         |  8 ++++++++
 include/linux/kobject.h |  2 ++
 include/linux/sysfs.h   |  2 ++
 kernel/power/main.c     | 14 ++++++++++++++
 kernel/power/wakelock.c |  6 ------
 lib/kobject.c           | 26 ++++++++++++++++++++++++++
 6 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.13.6

