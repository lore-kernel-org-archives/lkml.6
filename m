Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A284C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0367E20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUDq8N14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0367E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeKIIH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbeKIHiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:14 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D0720989;
        Thu,  8 Nov 2018 22:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714445;
        bh=TvUHD2TB0lc69ia0pqARE9d3gdweuUHmMcoHyrUloNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUDq8N14xttRRD94gN+C2ZvKGIz2l0/ce6MxLnx0AcRqVDNzcW1bS9jugd+3ejHOS
         JzrBKPtR0K7P0FpZk6pPNpVZyYAgxQ3fpvTdef9myeAcbTF9H5N/HJAhTw4uI6gCER
         xf0589crvR1DYN2GTLWRgiHavcwctMMAiUSs2u/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 093/114] net: sched: gred: pass the right attribute to gred_change_table_def()
Date:   Thu,  8 Nov 2018 13:51:48 -0800
Message-Id: <20181108215109.183893142@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 38b4f18d56372e1e21771ab7b0357b853330186c ]

gred_change_table_def() takes a pointer to TCA_GRED_DPS attribute,
and expects it will be able to interpret its contents as
struct tc_gred_sopt.  Pass the correct gred attribute, instead of
TCA_OPTIONS.

This bug meant the table definition could never be changed after
Qdisc was initialized (unless whatever TCA_OPTIONS contained both
passed netlink validation and was a valid struct tc_gred_sopt...).

Old behaviour:
$ ip link add type dummy
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0
RTNETLINK answers: Invalid argument

Now:
$ ip link add type dummy
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0
$ tc qdisc replace dev dummy0 parent root handle 7: \
     gred setup vqs 4 default 0

Fixes: f62d6b936df5 ("[PKT_SCHED]: GRED: Use central VQ change procedure")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_gred.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -444,7 +444,7 @@ static int gred_change(struct Qdisc *sch
 	if (tb[TCA_GRED_PARMS] == NULL && tb[TCA_GRED_STAB] == NULL) {
 		if (tb[TCA_GRED_LIMIT] != NULL)
 			sch->limit = nla_get_u32(tb[TCA_GRED_LIMIT]);
-		return gred_change_table_def(sch, opt);
+		return gred_change_table_def(sch, tb[TCA_GRED_DPS]);
 	}
 
 	if (tb[TCA_GRED_PARMS] == NULL ||


