Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF2D2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfBNL0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:26:23 -0500
Received: from www.osadl.org ([62.245.132.105]:37553 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfBNL0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:26:23 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x1EBQ7jh020439;
        Thu, 14 Feb 2019 12:26:07 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] sysfs.txt: add note on available attribute macros
Date:   Thu, 14 Feb 2019 12:21:50 +0100
Message-Id: <1550143310-17463-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common cases of attributes should probably be using the __ATTR_XXX
macros to make code more concise and readable but the current sysfs.txt
does not point developers to those convenience macros. Further there is
no note in sysfs.txt currently explaining why trying to set a sysfs file
to mode 0666 will fail.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Note quite sure if this is the right place to place the note on mode 0666 
but it should be somewhere as any attempt to set 0666 will be reverted 
to 0664.

 Documentation/filesystems/sysfs.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
index 41411b0..c246142 100644
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.txt
@@ -116,6 +116,22 @@ static struct device_attribute dev_attr_foo = {
 	.store = store_foo,
 };
 
+Note as stated in include/linux/kernel.h "OTHER_WRITABLE?  Generally
+considered a bad idea." so trying to set a sysfs file writable for
+everyone will fail reverting to mode 0664.
+
+For this common cases sysfs.h provides convenience macros to
+make defining attributes easier as well as making code more
+concise and readable. The above case could be shortened to:
+
+static struct device_attribute dev_attr_foo = __ATTR_RW(foo);
+
+the list of helpers available is:
+__ATTR_RO(name): same as above with mode 0444
+__ATTR_WO(name): same as above with mode 0200
+__ATTR_RO_MODE(name, mode): allowing to pass in a specific mode
+__ATTR_RW(name): setting mode to 0644
+__ATTR_NULL: which sets the name to NULL
 
 Subsystem-Specific Callbacks
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.1.4

