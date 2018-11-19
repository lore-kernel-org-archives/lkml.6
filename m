Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF84214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwKN/818"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF84214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406637AbeKTD3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405880AbeKTD3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521B22146D;
        Mon, 19 Nov 2018 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647084;
        bh=MXOXQrBPGN4RPjoDit9HYD7tGv8FIRcxeoDAbxOjwnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwKN/818tMR8Acl6ggfM4kD82UeAEQP+KQB8n7p+tPg4hAtARcIySeoHcDw42u1Ed
         U1RvXTh5d6NAs84S+QWgprDSXO4bWWQ2JR9dQ4FimZ0dQRtqcnE5dEJ3kkstV4Yyob
         FlsQR0lPeaZqXbrapAie3bNu7sIGyGCoxRG+K048=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 27/90] signal: Always deliver the kernels SIGKILL and SIGSTOP to a pid namespace init
Date:   Mon, 19 Nov 2018 17:29:09 +0100
Message-Id: <20181119162625.307109934@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
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
@@ -1042,7 +1042,7 @@ static int __send_signal(int sig, struct
 
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info == SEND_SIG_FORCED)))
+			from_ancestor_ns || (info == SEND_SIG_PRIV) || (info == SEND_SIG_FORCED)))
 		goto ret;
 
 	pending = group ? &t->signal->shared_pending : &t->pending;


