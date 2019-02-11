Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CACC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81B920700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="TJu5dp7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfBKOZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37816 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbfBKOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:03 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so26579723iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Bjd850XNZXI4fTB7GkNTYWYXmyT8nYTFelIdNuUjk3I=;
        b=TJu5dp7UGIivCkh7lXhsMgPxt2HtBF5nsD3z3tfWFWiiDjBMVq3T4RsVXuJUNsBjix
         mw9UWVTH6f5fC310sEcTHICcPu7cssiFTVu+rKbrAoOH0KQ11byAsAvkxH4ivkRB1Twa
         Hxyw1rM6LlemSF8FDDZ45UAY7aN6aRPxXU9bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bjd850XNZXI4fTB7GkNTYWYXmyT8nYTFelIdNuUjk3I=;
        b=sgxI4CIjD0WeTpmi800isVBU2rEFvC0CbbjDri1CyfVQlJEA6QnhfBfJF3fx7GiYpK
         HF60tyVlK0DGctWsMPcKJQbvFj72TN33BIL/iu0rurvIcDNd56elzHxJWp+qsS4ZdoMJ
         AeuCIJ7TQ0DjSVAn+GwxQMhzWDa2Jx4D0DxmQ8hjqBgAUf623rKxMVRM2oFi6Im+/gA/
         v4RGK7v6yH21a9OXorDmUezUMEMX8dWI2UEdUT5/E8+njznABgOTehJez4mHC0uuRnSl
         lRib09DYoDW4O+QAXMXRY/AJTdd6qssWDEDsioicJejjwt0AVzmcGP1kSf+rYmD+NFTB
         wMJw==
X-Gm-Message-State: AHQUAuZH5aDcgNA6Nx8to+IfHp6Gz37RKrSFPcF7bUkK6wAD9eOfzUK7
        v9sQYsTdys5p1C4zouC2Aru4Qg==
X-Google-Smtp-Source: AHgI3IaB79ov8guNl8Tzr3zb/S0HNUoi62Zifp7UCDzYauKLDlEsaFASyt9FInCxo371KGvMuDMT0Q==
X-Received: by 2002:a6b:ee19:: with SMTP id i25mr19099596ioh.149.1549895103038;
        Mon, 11 Feb 2019 06:25:03 -0800 (PST)
Received: from iscandar.digidescorp.com ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id j142sm5300878itj.40.2019.02.11.06.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:25:02 -0800 (PST)
From:   Steve Magnani <steve.magnani@digidescorp.com>
X-Google-Original-From: Steve Magnani <steve@digidescorp.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH] udf: disallow RW mount without valid integrity descriptor
Date:   Mon, 11 Feb 2019 08:24:38 -0600
Message-Id: <20190211142438.16599-1-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refuse to mount a volume read-write without a coherent Logical Volume
Integrity Descriptor, because we can't generate truly unique IDs without 
one.

This fixes a bug where all inodes created on a UDF filesystem following
mount without a coherent LVID are assigned UID 0.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
---
--- a/fs/udf/super.c	2018-11-16 06:43:00.622344354 -0600
+++ b/fs/udf/super.c	2019-02-11 08:08:00.478331631 -0600
@@ -1474,6 +1474,17 @@ static int udf_load_logicalvol(struct su
 	if (lvd->integritySeqExt.extLength)
 		udf_load_logicalvolint(sb, leea_to_cpu(lvd->integritySeqExt));
 	ret = 0;
+
+	if (!sbi->s_lvid_bh) {
+		/* We can't generate UIDs without a valid LVID */
+		if (sb_rdonly(sb))
+			UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
+		else {
+			udf_warn(sb, "Damaged or missing LVID, forcing "
+				     "readonly mount\n");
+			ret = -EACCES;
+		}
+	}
 out_bh:
 	brelse(bh);
 	return ret;
