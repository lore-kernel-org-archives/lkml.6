Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A002BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718E7206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718E7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJDXS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:18:27 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34807 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJDXS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:18:27 -0400
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1MjSsm-1fRqaN1qeo-00kxz7; Thu, 04 Oct 2018 18:23:57 +0200
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1MjSsm-1fRqaN1qeo-00kxz7; Thu, 04 Oct 2018 18:23:57 +0200
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/2] reboot: Make restart_handler_list a blocking notifier chain.
Date:   Thu,  4 Oct 2018 18:23:38 +0200
Message-Id: <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nCzxF+ZBR69lODzj8Sb8zf4e+pgpLEDOAGIoMHli4slgeMLR+Xi
 PvwOQSlOzD9XXW2NL82jHgXalJtxnj/XMwdCbKqfR7uo5Q+nCimn7ik4OdtXJSDqCaAwt1F
 5x972HBT0FOh0WI8ZjBLinx1kyPbOwqKjDlwNt2opHCjj9QwgvXm+YFnIR3ejd6GYsHXsoK
 tstnm+qz5Qjy1qHnvwyZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5z/exxThLzE=:DzJjP45pwgFwCHCxM+bclZ
 s2GWeFz8TP1HRABlU82jIIufWjUR7afhZUXeZ5Lq2qEt5LK5/aZpr64QNCzRl36PlptDeMwi0
 W0NdMhKUqlxYwytZ+IiFE73JQoQrJc8OtE9ffO3R2bxqNt/wXCIqRGD1HwHp1OKbUV1su8Ub6
 jTWGhXnEjWOub2CyHhO+9uUK7my4vsM9cvaCAYs5rSzlAFv1NMIMYinE1CCPA2ZrzhCStpWkV
 LpxPbxzjQa6qD17HOuD/37OBB5vh91RG54AKvb7O5yhbCLJU0RTKdoVLnEdOt4aW/xLLlv1q4
 9eWayN93bTQ+1pmqP5AqoRwS0QS8PpxUNvxdW4ymffaa7EK5lVHnT3muYct/ZWH3wj3H0adoj
 SeKVZ8GpKHO9z2qp0hcMwlLk2FoH5ioX4iIfUcXPz7MBdVwsEKMEP9bno07da0Kfc9UNha0ar
 /IuWodhbmI8YaY4CqV/2lPOXzcNBNa99s009rw/lR7DUBhRWD4qA10GLtUkK3MBSGFgKUOqg7
 GMJUVvyhaV18kv3DJAqgpaFhavNHo/enQ6wKd1o5CLbOevV2L2mozjHTBmkqPXAkSMJSCtjFj
 LFaNLm/AGQ8L7ILQOMQUjo+R9CdWgRa/fMSpTSki8uqvi/vPkGNaeZJY9MO6h0qdG/pV9Ydr6
 +NwPrTNx+UiHF0nOgBEWyVJeclU/VTadCX0M8bSR9Q9+bEJAuPCPF8HozSZaM4tberwU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many users of restart_handlers are sleeping in their callbacks.  Some
are doing infinite loops or calling driver code that may sleep or
perform operation on slow busses, like i2c.

This is not allowed in an atomic notifier chain, which is what
restart_handler_list currently is, so use a blocking notifier chain
instead.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 kernel/reboot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 8fb44dec9ad7..f0ba0008dbde 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(devm_register_reboot_notifier);
  *	Notifier list for kernel code which wants to be called
  *	to restart the system.
  */
-static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
+static BLOCKING_NOTIFIER_HEAD(restart_handler_list);
 
 /**
  *	register_restart_handler - Register function to be called to reset
@@ -172,12 +172,12 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
  *	hardware is expected to register with low priority to ensure that
  *	it only runs if no other means to restart the system is available.
  *
- *	Currently always returns zero, as atomic_notifier_chain_register()
+ *	Currently always returns zero, as blocking_notifier_chain_register()
  *	always returns zero.
  */
 int register_restart_handler(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&restart_handler_list, nb);
+	return blocking_notifier_chain_register(&restart_handler_list, nb);
 }
 EXPORT_SYMBOL(register_restart_handler);
 
@@ -192,7 +192,7 @@ EXPORT_SYMBOL(register_restart_handler);
  */
 int unregister_restart_handler(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&restart_handler_list, nb);
+	return blocking_notifier_chain_unregister(&restart_handler_list, nb);
 }
 EXPORT_SYMBOL(unregister_restart_handler);
 
@@ -209,7 +209,7 @@ EXPORT_SYMBOL(unregister_restart_handler);
  */
 void do_kernel_restart(char *cmd)
 {
-	atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
+	blocking_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
 }
 
 void migrate_to_reboot_cpu(void)
-- 
2.19.0

