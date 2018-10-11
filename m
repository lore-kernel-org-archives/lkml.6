Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B2EC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE504213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkUU7f0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE504213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeJKXEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F632098A;
        Thu, 11 Oct 2018 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272193;
        bh=MGpnLfR1pUUVZ9wPHarK+aO8CLw2ApA9XeOwM1M0+j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkUU7f0mPIFDiq4Bx/k3BzNaLj0g5bdtR3Z7RvxvOzKRVFcfGLCSkCUUY+z9vf/vM
         iNrey0toflPIkUGYOZdB8lqfhmkPLZi4dWZ92BR1ECxMQi6dcENNMFc9WkeyMvQvRQ
         uxG9TfLqyp7VLTo00rxB0zM+WnLuMpyKoHoMzBCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Behmer <jbehmer@google.com>,
        Vaibhav Nagarnaik <vnagarnaik@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 3.18 004/120] ring-buffer: Allow for rescheduling when removing pages
Date:   Thu, 11 Oct 2018 17:33:05 +0200
Message-Id: <20181011152549.682409910@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Nagarnaik <vnagarnaik@google.com>

commit 83f365554e47997ec68dc4eca3f5dce525cd15c3 upstream.

When reducing ring buffer size, pages are removed by scheduling a work
item on each CPU for the corresponding CPU ring buffer. After the pages
are removed from ring buffer linked list, the pages are free()d in a
tight loop. The loop does not give up CPU until all pages are removed.
In a worst case behavior, when lot of pages are to be freed, it can
cause system stall.

After the pages are removed from the list, the free() can happen while
the work is rescheduled. Call cond_resched() in the loop to prevent the
system hangup.

Link: http://lkml.kernel.org/r/20180907223129.71994-1-vnagarnaik@google.com

Cc: stable@vger.kernel.org
Fixes: 83f40318dab00 ("ring-buffer: Make removal of ring buffer pages atomic")
Reported-by: Jason Behmer <jbehmer@google.com>
Signed-off-by: Vaibhav Nagarnaik <vnagarnaik@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ring_buffer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1542,6 +1542,8 @@ rb_remove_pages(struct ring_buffer_per_c
 	tmp_iter_page = first_page;
 
 	do {
+		cond_resched();
+
 		to_remove_page = tmp_iter_page;
 		rb_inc_page(cpu_buffer, &tmp_iter_page);
 


