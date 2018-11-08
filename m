Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FCBECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B921220825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="MCUGjObE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B921220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeKIEgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:36:17 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:61701 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeKIEgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1541703567; x=1573239567;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QXnDituIZ9win6qVC9KoJnjwrBgkMuF0lvbTNnhU0Vg=;
  b=MCUGjObEcbZ0kIG9K10EuKSp+ZU2vtt3JVTVya3MKAtN3H03O0KTnE9v
   QXQLZxcsBf8VRuWVXmfbZ3zHwjRUiPImgTxI25/de6jxzg06E2J5XD9mk
   +Q1OIq7GWF9QJVqwj+PiXYAlRGUdmPL+pDqLB0YGa78HdNEmTwYP1tT+f
   Y=;
X-IronPort-AV: E=Sophos;i="5.54,480,1534809600"; 
   d="scan'208";a="372533464"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 18:59:21 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wA8IxI5T125445
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 8 Nov 2018 18:59:20 GMT
Received: from EX13D08UEB001.ant.amazon.com (10.43.60.245) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 8 Nov 2018 18:59:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEB001.ant.amazon.com (10.43.60.245) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 8 Nov 2018 18:59:19 +0000
Received: from dev-dsk-mheyne-1a-d7497a7f.eu-west-1.amazon.com (10.15.98.203)
 by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 8 Nov 2018 18:59:19 +0000
Received: by dev-dsk-mheyne-1a-d7497a7f.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id 62A82B03BF; Thu,  8 Nov 2018 18:59:19 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     Christoph Hellwig <hch@lst.de>,
        Maximilian Heyne <mheyne@amazon.de>,
        Torsten Mehlan <tomeh@amazon.de>,
        Uwe Dannowski <uwed@amazon.de>, Amit Shah <aams@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>, <stable@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fs: fix lost error code in dio_complete
Date:   Thu, 8 Nov 2018 18:58:34 +0000
Message-ID: <20181108185835.17803-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e259221763a40403d5bb232209998e8c45804ab8 ("fs: simplify the
generic_write_sync prototype") reworked callers of generic_write_sync(),
and ended up dropping the error return for the directio path. Prior to
that commit, in dio_complete(), an error would be bubbled up the stack,
but after that commit, errors passed on to dio_complete were eaten up.

This was reported on the list earlier, and a fix was proposed in
https://lore.kernel.org/lkml/20160921141539.GA17898@infradead.org/, but
never followed up with.  We recently hit this bug in our testing where
fencing io errors, which were previously erroring out with EIO, were
being returned as success operations after this commit.

The fix proposed on the list earlier was a little short -- it would have
still called generic_write_sync() in case `ret` already contained an
error. This fix ensures generic_write_sync() is only called when there's
no pending error in the write. Additionally, transferred is replaced
with ret to bring this code in line with other callers.

Reported-by: Ravi Nankani <rnankani@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
CC: Torsten Mehlan <tomeh@amazon.de>
CC: Uwe Dannowski <uwed@amazon.de>
CC: Amit Shah <aams@amazon.de>
CC: David Woodhouse <dwmw@amazon.co.uk>
CC: stable@vger.kernel.org
---
v2: add description for s/transferred/ret/ change

 fs/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 722d17c88edb..41a0e97252ae 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -325,8 +325,8 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 		 */
 		dio->iocb->ki_pos += transferred;
 
-		if (dio->op == REQ_OP_WRITE)
-			ret = generic_write_sync(dio->iocb,  transferred);
+		if (ret > 0 && dio->op == REQ_OP_WRITE)
+			ret = generic_write_sync(dio->iocb, ret);
 		dio->iocb->ki_complete(dio->iocb, ret, 0);
 	}
 
-- 
2.16.5




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


