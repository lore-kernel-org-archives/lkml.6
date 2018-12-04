Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA902081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0ZLwjEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA902081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLDULI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:11:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51379 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:11:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so10977069wmh.1;
        Tue, 04 Dec 2018 12:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0V8p0CTYgcbpfzrxiZxqv+Go/DUrlDa0VjPxfipib4g=;
        b=X0ZLwjEaNOUa1WKo3BwTeiqJDnneBYr329xK2+6f3GHGAy0bhFu9VFvnZBvNlSgj0t
         CpNjBS+B2JGD738GAnrw6UBeE4Qn7DE2DOLdDCLWCH86NmIIVfp0HzQN+IpG0OOaALi9
         02oYxtVRUY/CtX/exCzXk3mVsmiwE0kg7x+F06ksT8cXZU0YQeXp1qVU3rYbRKNJhZuQ
         aSBSuFb23+66uw6+2xhpSym4JHYJVFmQbtyhxHVIJ1PorvJycVuHb5LOeWOJME6yQrNb
         CuuZ4utdSo+UhVMrBbuD/M5Ce3hMHZZe/PsO24Eq/v1INkvr2PLBpZwNYjSxs4PJvqWA
         HtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0V8p0CTYgcbpfzrxiZxqv+Go/DUrlDa0VjPxfipib4g=;
        b=dgjcMHXRpzl+xy+XUxcNey2h/qk/u8w9SN9v/IG3CRGsySNFXNeGAwzrIcKgyrIYMS
         sBB2F+Ts03/AJhIEebFAGMUneGzdCl4ghWPB1BgnltlKkAnFFS3k3A6MzQo59KZxNmBy
         rUC95IjebyTPy/h6PjZ7lBaNaksiW4nOHZxzw42VPCs5pneoOJWvXAN3U3PBURspIqda
         tbBhc3iB46/D5DEuawAKs9C3ysxUhEH3D1nwMUkW0MYm0YPXaA/EJx2zb8henCLSRs5i
         5Cy0u9IZyOKuNtPiopO5wQFTW1a7Md5NsbZxvfv4jS8RFC5rTvLp40EuzgGCuYc48MPO
         VqHw==
X-Gm-Message-State: AA+aEWZlxAcxPH64WmdcMAjj8XkXsNcvZWf1GsBEFufs42YU0T4yDD5U
        SpjtSB8kzi32YdFq+eibacg=
X-Google-Smtp-Source: AFSGD/VL6HrNh+uyfKtVCrz1bfOHbhpEX+/m0AJS1zdtoNbHVt/AHf8xQnf0FXBFraMD/lSrIjKoMQ==
X-Received: by 2002:a1c:174f:: with SMTP id 76mr12834444wmx.116.1543954265494;
        Tue, 04 Dec 2018 12:11:05 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id w8sm22270181wrv.7.2018.12.04.12.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:11:03 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 62E151144AA5; Tue,  4 Dec 2018 21:11:02 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     trivial@kernel.org, kernel-janitors@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: jz4780: annotate implicit fall throughs
Date:   Tue,  4 Dec 2018 21:10:57 +0100
Message-Id: <20181204201057.30733-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203212214.8862-1-malat@debian.org>
References: <20181203212214.8862-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings. Fix them up.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: fix subject prefix non sense

 drivers/mtd/nand/raw/jz4780_bch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
index 731c6051d91e..7201827809e9 100644
--- a/drivers/mtd/nand/raw/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/jz4780_bch.c
@@ -136,8 +136,10 @@ static void jz4780_bch_read_parity(struct jz4780_bch *bch, void *buf,
 	switch (size8) {
 	case 3:
 		dest8[2] = (val >> 16) & 0xff;
+		/* fall through */
 	case 2:
 		dest8[1] = (val >> 8) & 0xff;
+		/* fall through */
 	case 1:
 		dest8[0] = val & 0xff;
 		break;
-- 
2.19.2

