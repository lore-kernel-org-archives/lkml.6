Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67915C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB6F21920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbfBOHeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:34:23 -0500
Received: from www.osadl.org ([62.245.132.105]:47006 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfBOHeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:34:23 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x1F7YCNR007759;
        Fri, 15 Feb 2019 08:34:12 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] sysfs.txt: add note on available attribute macros
Date:   Fri, 15 Feb 2019 08:29:48 +0100
Message-Id: <1550215788-19883-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common cases of attributes wrappers should probably be using the
__ATTR_XXX macros to make code more concise and readable but the current
sysfs.txt does not point developers to those convenience macros. Further
there is no note in sysfs.txt currently explaining why trying to set a
sysfs file to mode 0666 will fail respectively revert to 0664.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

V2: the descriptions were not too helpful as noted by 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    so lets see if V2 is any better...

 Documentation/filesystems/sysfs.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
index 41411b0..b003123 100644
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.txt
@@ -116,6 +116,27 @@ static struct device_attribute dev_attr_foo = {
 	.store = store_foo,
 };
 
+Note as stated in include/linux/kernel.h "OTHER_WRITABLE?  Generally
+considered a bad idea." so trying to set a sysfs file writable for
+everyone will fail reverting to RO mode for "Others".
+
+For the common cases sysfs.h provides convenience macros to make
+defining attributes easier as well as making code more concise and
+readable. The above case could be shortened to:
+
+static struct device_attribute dev_attr_foo = __ATTR_RW(foo);
+
+the list of helpers available to define your wrapper function is:
+__ATTR_RO(name): assumes default name_show and mode 0444
+__ATTR_WO(name): assumes a name_store only and is restricted to mode
+                 0200 that is root write access only.
+__ATTR_RO_MODE(name, mode): fore more restrictive RO access currently
+                 only use case is the EFI System Resource Table
+                 (see drivers/firmware/efi/esrt.c)
+__ATTR_RW(name): assumes default name_show, name_store and setting
+                 mode to 0644.
+__ATTR_NULL: which sets the name to NULL and is used as end of list
+                 indicator (see: kernel/workqueue.c)
 
 Subsystem-Specific Callbacks
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.1.4

