Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C33DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BFC20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4W3IQzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BFC20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeKLIRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732118AbeKLIRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BDA223CB;
        Sun, 11 Nov 2018 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975275;
        bh=IUsf6lA51QmkWma12+mxQv1CfQ1ucATupAFc6CKouIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4W3IQzg+YzhRAC7Zk4RWRM6RxKu9apyvz4lOIa718RPsXu/uKYe1Upop3VEynoqT
         2rp5Zl2r4W1F1G7snBn3/dYh9YBQlYQiyOFOEeVuFOX4EMoYhDS4EgUtQ4NIewlt4/
         AP012uyAySvJkK966smnHTldZlnLwB7ZGKfcXiv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 185/361] signal: Always deliver the kernels SIGKILL and SIGSTOP to a pid namespace init
Date:   Sun, 11 Nov 2018 14:18:52 -0800
Message-Id: <20181111221646.272431889@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 3597dfe01d12f570bc739da67f857fd222a3ea66 ]

Instead of playing whack-a-mole and changing SEND_SIG_PRIV to
SEND_SIG_FORCED throughout the kernel to ensure a pid namespace init
gets signals sent by the kernel, stop allowing a pid namespace init to
ignore SIGKILL or SIGSTOP sent by the kernel.  A pid namespace init is
only supposed to be able to ignore signals sent from itself and
children with SIG_DFL.

Fixes: 921cf9f63089 ("signals: protect cinit from unblocked SIG_DFL signals")
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/signal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1035,7 +1035,7 @@ static int __send_signal(int sig, struct
 
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info == SEND_SIG_FORCED)))
+			from_ancestor_ns || (info == SEND_SIG_PRIV) || (info == SEND_SIG_FORCED)))
 		goto ret;
 
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;


