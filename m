Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3078CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5FF21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6MyOG07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5FF21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbeKTDHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:07:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387501AbeKTDHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:07:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8809020C01;
        Mon, 19 Nov 2018 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645804;
        bh=KhvDJbfRfvk/YFIempkZroejV0MySe12016TcK3qtyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6MyOG07ROIDSyydVYgabCJehWILhzMes6kF6sKD/WcGqwxsUoC9J669lg6GIWpUp
         0ZMckMjk6EVs+QoMUMZKjyKNFdELv3Ry4zo/SRmoS/iXl81Dxv+686uE0D6d2SasgY
         BklbDF4k0oBT7wwzS8Xeo7LgZy0xuPEGl45eoDMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, GwanYeong Kim <gy741.kim@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Borislav Petkov <bp@suse.de>,
        Alok Kataria <akataria@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org, x86-ml <x86@kernel.org>
Subject: [PATCH 4.18 095/171] x86/cpu/vmware: Do not trace vmware_sched_clock()
Date:   Mon, 19 Nov 2018 17:28:11 +0100
Message-Id: <20181119162634.211879353@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 15035388439f892017d38b05214d3cda6578af64 upstream.

When running function tracing on a Linux guest running on VMware
Workstation, the guest would crash. This is due to tracing of the
sched_clock internal call of the VMware vmware_sched_clock(), which
causes an infinite recursion within the tracing code (clock calls must
not be traced).

Make vmware_sched_clock() not traced by ftrace.

Fixes: 80e9a4f21fd7c ("x86/vmware: Add paravirt sched clock")
Reported-by: GwanYeong Kim <gy741.kim@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Alok Kataria <akataria@vmware.com>
CC: GwanYeong Kim <gy741.kim@gmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>
CC: virtualization@lists.linux-foundation.org
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181109152207.4d3e7d70@gandalf.local.home
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/vmware.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -77,7 +77,7 @@ static __init int setup_vmw_sched_clock(
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
 
-static unsigned long long vmware_sched_clock(void)
+static unsigned long long notrace vmware_sched_clock(void)
 {
 	unsigned long long ns;
 


