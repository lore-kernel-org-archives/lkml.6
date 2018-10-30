Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E505AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69DF20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="h+6VyBDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69DF20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeJaGyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:54:09 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:31568 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbeJaGyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540936736; x=1572472736;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ulXauuLE2yNyr7a4rI5BK89njn86knnx0RtvbNaaQ+s=;
  b=h+6VyBDGPtQpk/jJI1e6segyLRnOJLEPKtVLH5eJMZhQDdhIHk3ixHab
   Fisx2ihqKbb0RtsNHspju39iRdyWAN9p8uQeTfRAIAnuUfbW7fSovMSgY
   IPCHbBJHr5EwnhQV3GCndaBUKfbhaZw97Nu6gXaZMunG69IusNEaeBvrc
   c=;
X-IronPort-AV: E=Sophos;i="5.54,446,1534809600"; 
   d="scan'208";a="639353382"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Oct 2018 21:58:53 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9ULwm1E067762
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 30 Oct 2018 21:58:52 GMT
Received: from EX13D08UEE004.ant.amazon.com (10.43.62.182) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Oct 2018 21:58:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE004.ant.amazon.com (10.43.62.182) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Oct 2018 21:58:52 +0000
Received: from dev-dsk-mheyne-1a-d7497a7f.eu-west-1.amazon.com (10.15.98.203)
 by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 30 Oct 2018 21:58:51 +0000
Received: by dev-dsk-mheyne-1a-d7497a7f.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id C1D51A96E7; Tue, 30 Oct 2018 21:58:51 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     Christoph Hellwig <hch@lst.de>,
        Maximilian Heyne <mheyne@amazon.de>, <stable@vger.kernel.org>,
        Torsten Mehlan <tomeh@amazon.de>,
        Uwe Dannowski <uwed@amazon.de>, Amit Shah <aams@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: fix lost error code in dio_complete
Date:   Tue, 30 Oct 2018 21:57:39 +0000
Message-ID: <20181030215739.4557-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.2
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
error.  This fix ensures generic_write_sync() is only called when
there's no pending error in the write.

CC: stable@vger.kernel.org
Reported-by: Ravi Nankani <rnankani@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Signed-off-by: Torsten Mehlan <tomeh@amazon.de>
Signed-off-by: Uwe Dannowski <uwed@amazon.de>
Signed-off-by: Amit Shah <aams@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 fs/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 093fb54cd316..199146036093 100644
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
2.16.2

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

