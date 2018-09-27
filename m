Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A52C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D2E20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D2E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeI0P2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:28:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeI0P2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:28:16 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB2D51117;
        Thu, 27 Sep 2018 09:10:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 4.18 50/88] fork: report pid exhaustion correctly
Date:   Thu, 27 Sep 2018 11:03:31 +0200
Message-Id: <20180927090306.894709743@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>

commit f83606f5eb007adc33bc8541ede00590f477bdeb upstream.

Make the clone and fork syscalls return EAGAIN when the limit on the
number of pids /proc/sys/kernel/pid_max is exceeded.

Currently, when the pid_max limit is exceeded, the kernel will return
ENOSPC from the fork and clone syscalls.  This is contrary to the
documented behaviour, which explicitly calls out the pid_max case as one
where EAGAIN should be returned.  It also leads to really confusing error
messages in userspace programs which will complain about a lack of disk
space when they fail to create processes/threads for this reason.

This error is being returned because alloc_pid() uses the idr api to find
a new pid; when there are none available, idr_alloc_cyclic() returns
-ENOSPC, and this is being propagated back to userspace.

This behaviour has been broken before, and was explicitly fixed in
commit 35f71bc0a09a ("fork: report pid reservation failure properly"),
so I think -EAGAIN is definitely the right thing to return in this case.
The current behaviour change dates from commit 95846ecf9dac ("pid:
replace pid bitmap implementation with IDR AIP") and was I believe
unintentional.

This patch has no impact on the case where allocating a pid fails because
the child reaper for the namespace is dead; that case will still return
-ENOMEM.

Link: http://lkml.kernel.org/r/20180903111016.46461-1-ktsanaktsidis@zendesk.com
Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR AIP")
Signed-off-by: KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Gargi Sharma <gs051095@gmail.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/pid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -195,7 +195,7 @@ struct pid *alloc_pid(struct pid_namespa
 		idr_preload_end();
 
 		if (nr < 0) {
-			retval = nr;
+			retval = (nr == -ENOSPC) ? -EAGAIN : nr;
 			goto out_free;
 		}
 


