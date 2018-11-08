Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34126ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D415C214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdXpg2dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415C214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbeKIHsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbeKIHr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:59 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4BC2089F;
        Thu,  8 Nov 2018 22:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715027;
        bh=0WKRTrWj4tZh26KdzS7dyEq8LoVQWnbTNFNURxTXAkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdXpg2dcoPi44AycDpUTRAe6ZEepKrqcduTjm9h2SDe3ugvUBDHDquPu0gHt//xRX
         x6JXk/50opZc+1piSew+VdjkFqSQpdIVQroWuJ8TxSrkFRg1Slg2jK0qmdsWYGNqQV
         rhqkJ5qdZtpcH3qyQ4vNU7daJrVwPBO2vWim/OaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        eric.dumazet@gmail.com, bp@alien8.de
Subject: [PATCH 4.18 29/34] x86/tsc: Force inlining of cyc2ns bits
Date:   Thu,  8 Nov 2018 13:52:58 -0800
Message-Id: <20181108215140.687607980@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

commit 4907c68abd3f60f650f98d5a69d4ec77c0bde44f upstream.

Looking at the asm for native_sched_clock() I noticed we don't inline
enough. Mostly caused by sharing code with cyc2ns_read_begin(), which
we didn't used to do. So mark all that __force_inline to make it DTRT.

Fixes: 59eaef78bfea ("x86/tsc: Remodel cyc2ns to use seqcount_latch()")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: eric.dumazet@gmail.com
Cc: bp@alien8.de
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181011104019.695196158@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tsc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -60,7 +60,7 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
-void cyc2ns_read_begin(struct cyc2ns_data *data)
+void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
 
@@ -77,7 +77,7 @@ void cyc2ns_read_begin(struct cyc2ns_dat
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
 }
 
-void cyc2ns_read_end(void)
+void __always_inline cyc2ns_read_end(void)
 {
 	preempt_enable_notrace();
 }
@@ -123,7 +123,7 @@ static void __init cyc2ns_init(int cpu)
 	seqcount_init(&c2n->seq);
 }
 
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+static __always_inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
 	unsigned long long ns;


