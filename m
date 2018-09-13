Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E14C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFD320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFD320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeIMS7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:59:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbeIMS73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:59:29 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8BB0D19;
        Thu, 13 Sep 2018 13:49:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, kernel-team@android.com,
        Arnd Bergmann <arnd@arndb.de>, astrachan@google.com
Subject: [PATCH 4.14 096/115] debugobjects: Make stack check warning more informative
Date:   Thu, 13 Sep 2018 15:31:56 +0200
Message-Id: <20180913131829.348190121@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Fernandes (Google) <joel@joelfernandes.org>

commit fc91a3c4c27acdca0bc13af6fbb68c35cfd519f2 upstream.

While debugging an issue debugobject tracking warned about an annotation
issue of an object on stack. It turned out that the issue was due to the
object in concern being on a different stack which was due to another
issue.

Thomas suggested to print the pointers and the location of the stack for
the currently running task. This helped to figure out that the object was
on the wrong stack.

As this is general useful information for debugging similar issues, make
the error message more informative by printing the pointers.

[ tglx: Massaged changelog ]

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: kernel-team@android.com
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: astrachan@google.com
Link: https://lkml.kernel.org/r/20180723212531.202328-1-joel@joelfernandes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/debugobjects.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -322,9 +322,12 @@ static void debug_object_is_on_stack(voi
 
 	limit++;
 	if (is_on_stack)
-		pr_warn("object is on stack, but not annotated\n");
+		pr_warn("object %p is on stack %p, but NOT annotated.\n", addr,
+			 task_stack_page(current));
 	else
-		pr_warn("object is not on stack, but annotated\n");
+		pr_warn("object %p is NOT on stack %p, but annotated.\n", addr,
+			 task_stack_page(current));
+
 	WARN_ON(1);
 }
 


