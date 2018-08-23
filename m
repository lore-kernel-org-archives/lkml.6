Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30100C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86B4208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86B4208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbeHWLvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:51:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeHWLvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:51:48 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 294D8C7B;
        Thu, 23 Aug 2018 08:23:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 097/217] netfilter: nf_log: fix uninit read in nf_log_proc_dostring
Date:   Thu, 23 Aug 2018 09:53:30 +0200
Message-Id: <20180823075509.878182176@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Jann Horn <jannh@google.com>

[ Upstream commit dffd22aed2aa1e804bccf19b30a421e89ee2ae61 ]

When proc_dostring() is called with a non-zero offset in strict mode, it
doesn't just write to the ->data buffer, it also reads. Make sure it
doesn't read uninitialized data.

Fixes: c6ac37d8d884 ("netfilter: nf_log: fix error on write NONE to [...]")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_log.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -440,6 +440,10 @@ static int nf_log_proc_dostring(struct c
 	if (write) {
 		struct ctl_table tmp = *table;
 
+		/* proc_dostring() can append to existing strings, so we need to
+		 * initialize it as an empty string.
+		 */
+		buf[0] = '\0';
 		tmp.data = buf;
 		r = proc_dostring(&tmp, write, buffer, lenp, ppos);
 		if (r)


