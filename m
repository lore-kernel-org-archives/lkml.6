Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F3AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCD120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCD120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeICVsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:48:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeICVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:48:02 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ECE03D24;
        Mon,  3 Sep 2018 17:26:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 143/165] s390: fix br_r1_trampoline for machines without exrl
Date:   Mon,  3 Sep 2018 18:57:09 +0200
Message-Id: <20180903165702.724765517@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit 26f843848bae973817b3587780ce6b7b0200d3e4 upstream.

For machines without the exrl instruction the BFP jit generates
code that uses an "br %r1" instruction located in the lowcore page.
Unfortunately there is a cut & paste error that puts an additional
"larl %r1,.+14" instruction in the code that clobbers the branch
target address in %r1. Remove the larl instruction.

Cc: <stable@vger.kernel.org> # v4.17+
Fixes: de5cb6eb51 ("s390: use expoline thunks in the BPF JIT")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/net/bpf_jit_comp.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -518,8 +518,6 @@ static void bpf_jit_epilogue(struct bpf_
 			/* br %r1 */
 			_EMIT2(0x07f1);
 		} else {
-			/* larl %r1,.+14 */
-			EMIT6_PCREL_RILB(0xc0000000, REG_1, jit->prg + 14);
 			/* ex 0,S390_lowcore.br_r1_tampoline */
 			EMIT4_DISP(0x44000000, REG_0, REG_0,
 				   offsetof(struct lowcore, br_r1_trampoline));


