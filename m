Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054F4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35EF20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35EF20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeIHB67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIHB67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:59 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB398FA4;
        Fri,  7 Sep 2018 21:16:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.18 078/145] livepatch: Validate module/old func name length
Date:   Fri,  7 Sep 2018 23:09:04 +0200
Message-Id: <20180907210910.782975829@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

commit 6e9df95b76cad18f7b217bdad7bb8a26d63b8c47 upstream.

livepatch module author can pass module name/old function name with more
than the defined character limit. With obj->name length greater than
MODULE_NAME_LEN, the livepatch module gets loaded but waits forever on
the module specified by obj->name to be loaded. It also populates a /sys
directory with an untruncated object name.

In the case of funcs->old_name length greater then KSYM_NAME_LEN, it
would not match against any of the symbol table entries. Instead loop
through the symbol table comparing them against a nonexisting function,
which can be avoided.

The same issues apply, to misspelled/incorrect names. At least gatekeep
the modules with over the limit string length, by checking for their
length during livepatch module registration.

Cc: stable@vger.kernel.org
Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/livepatch/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -678,6 +678,9 @@ static int klp_init_func(struct klp_obje
 	if (!func->old_name || !func->new_func)
 		return -EINVAL;
 
+	if (strlen(func->old_name) >= KSYM_NAME_LEN)
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&func->stack_node);
 	func->patched = false;
 	func->transition = false;
@@ -751,6 +754,9 @@ static int klp_init_object(struct klp_pa
 	if (!obj->funcs)
 		return -EINVAL;
 
+	if (klp_is_module(obj) && strlen(obj->name) >= MODULE_NAME_LEN)
+		return -EINVAL;
+
 	obj->patched = false;
 	obj->mod = NULL;
 


