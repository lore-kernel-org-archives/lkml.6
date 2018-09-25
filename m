Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1174C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F72083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996F72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeIYWni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeIYWni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:43:38 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E076C307D912;
        Tue, 25 Sep 2018 16:35:20 +0000 (UTC)
Received: from redhat.com (ovpn-120-50.rdu2.redhat.com [10.10.120.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id E61A9308BDBA;
        Tue, 25 Sep 2018 16:35:18 +0000 (UTC)
Date:   Tue, 25 Sep 2018 12:35:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matthias.bgg@gmail.com, Liam.Merwick@oracle.com,
        Jim.Quigley@oracle.com, linux-crypto@vger.kernel.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>, dgilbert@redhat.com
Subject: [PATCH] hwrng: document the quality field
Message-ID: <20180925162924.378725-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 25 Sep 2018 16:35:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

quality field is currently documented as being 'per mill'.  In fact the
math involved is:

                add_hwgenerator_randomness((void *)rng_fillbuf, rc,
                                           rc * current_quality * 8 >> 10);

thus the actual definition is "bits of entropy per 1024 bits of input".

The current documentation seems to have confused multiple people
in the past, let's fix the documentation to match code.

An alternative is to change core to match driver expectations, replacing
	rc * current_quality * 8 >> 10
with
	rc * current_quality / 1000
but that has performance costs, so probably isn't a good option.

Fixes: 0f734e6e768 ("hwrng: add per-device entropy derating")
Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


 drivers/char/hw_random/core.c | 4 ++--
 include/linux/hw_random.h     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index aaf9e5afaad4..95be7228f327 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -44,10 +44,10 @@ static unsigned short default_quality; /* = 0; default to "off" */
 
 module_param(current_quality, ushort, 0644);
 MODULE_PARM_DESC(current_quality,
-		 "current hwrng entropy estimation per mill");
+		 "current hwrng entropy estimation per 1024 bits of input");
 module_param(default_quality, ushort, 0644);
 MODULE_PARM_DESC(default_quality,
-		 "default entropy content of hwrng per mill");
+		 "default entropy content of hwrng per 1024 bits of input");
 
 static void drop_current_rng(void);
 static int hwrng_init(struct hwrng *rng);
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index bee0827766a3..c0b93e0ff0c0 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -33,7 +33,8 @@
  *			and max is a multiple of 4 and >= 32 bytes.
  * @priv:		Private data, for use by the RNG driver.
  * @quality:		Estimation of true entropy in RNG's bitstream
- *			(per mill).
+ *			(in bits of entropy per 1024 bits of input;
+ *			valid values: 1 to 1024, or 0 for unknown).
  */
 struct hwrng {
 	const char *name;
-- 
MST
