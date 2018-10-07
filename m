Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81002C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BC020882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BC020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJGWEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:04:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbeJGWEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E056983F3F;
        Sun,  7 Oct 2018 14:57:04 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA96D6A224;
        Sun,  7 Oct 2018 14:57:02 +0000 (UTC)
Date:   Sun, 7 Oct 2018 16:57:37 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH net v2 2/2] net/smc: retain old name for diag_mode field
Message-ID: <20181007145737.GA24137@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 07 Oct 2018 14:57:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c601171d7a60 ("net/smc: provide smc mode in smc_diag.c") changed
the name of diag_fallback field of struct smc_diag_msg structure
to diag_mode.  However, this structure is a part of UAPI, and this change
breaks user space applications that use it ([1], for example).  Since
the new name is more suitable, convert the field to a union that provides
access to the data via both the new and the old name.

[1] https://gitlab.com/strace/strace/blob/v4.24/netlink_smc_diag.c#L165

Fixes: c601171d7a60 ("net/smc: provide smc mode in smc_diag.c")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/smc_diag.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 6180c6d..8cb3a6f 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -20,7 +20,10 @@ struct smc_diag_req {
 struct smc_diag_msg {
 	__u8		diag_family;
 	__u8		diag_state;
-	__u8		diag_mode;
+	union {
+		__u8	diag_mode;
+		__u8	diag_fallback; /* the old name of the field */
+	};
 	__u8		diag_shutdown;
 	struct inet_diag_sockid id;
 
-- 
2.1.4

