Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE50CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82122208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82122208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeH1APR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:15:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbeH1APR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:15:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDD9F40073BE;
        Mon, 27 Aug 2018 20:27:06 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-211.bos.redhat.com [10.18.17.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC145202704E;
        Mon, 27 Aug 2018 20:27:06 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 7DCF7C0B2A; Mon, 27 Aug 2018 16:27:06 -0400 (EDT)
Date:   Mon, 27 Aug 2018 16:27:06 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] sysctl: do not allow a 64bit value write in a 32bit knob
Message-ID: <20180827202706.olt3saqjzzzyax6i@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 27 Aug 2018 20:27:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 27 Aug 2018 20:27:06 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'aris@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing to a sysctl file that uses proc_dointvec_minmax like user/max_uts_namespaces
a larger than 32 bit value won't cause an error as expected but instead will zero
its value:
	# echo 214748364800000 > max_uts_namespaces
	# cat max_uts_namespaces
	0

This patches fixes it.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4ac9b9a..243f277 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2486,7 +2486,8 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 	if (write) {
 		int val = *negp ? -*lvalp : *lvalp;
 		if ((param->min && *param->min > val) ||
-		    (param->max && *param->max < val))
+		    (param->max && *param->max < val) ||
+		    *lvalp >> (sizeof(int) * 8))
 			return -EINVAL;
 		*valp = val;
 	} else {
