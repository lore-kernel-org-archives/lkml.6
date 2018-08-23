Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF4CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ECC2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ECC2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeHWP7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:59:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:56812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbeHWP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:59:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEF06AD0C;
        Thu, 23 Aug 2018 12:29:34 +0000 (UTC)
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] Properly interpret indirect call in perf annotate.
To:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Message-ID: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
Date:   Thu, 23 Aug 2018 14:29:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------0328B748A44F4D19A89A1CE5"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0328B748A44F4D19A89A1CE5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The patch changes interpretation of:
callq  *0x8(%rbx)

from:
  0.26 │     → callq  *8
to:
  0.26 │     → callq  *0x8(%rbx)

in this can an address is followed by a register, thus
one can't parse only address.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
 tools/perf/util/annotate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)



--------------0328B748A44F4D19A89A1CE5
Content-Type: text/x-patch;
 name="0001-Properly-interpret-indirect-call-in-perf-annotate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Properly-interpret-indirect-call-in-perf-annotate.patch"

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4268b948e0e..e32ead4744bd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 
 indirect_call:
 	tok = strchr(endptr, '*');
-	if (tok != NULL)
-		ops->target.addr = strtoull(tok + 1, NULL, 16);
+	if (tok != NULL) {
+		endptr++;
+
+		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
+		 * Do not parse such instruction.  */
+		if (strstr(endptr, "(%r") == NULL)
+			ops->target.addr = strtoull(endptr, NULL, 16);
+	}
 	goto find_target;
 }
 


--------------0328B748A44F4D19A89A1CE5--
