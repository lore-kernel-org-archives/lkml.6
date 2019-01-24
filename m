Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919E6C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634C32082C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2PXFZrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfAXSHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:07:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40125 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfAXSHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:07:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so4033358wmf.5;
        Thu, 24 Jan 2019 10:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BeYJT0Z/72s44LJc0KKufww5He7xJOSI991sA39Lbhc=;
        b=q2PXFZrOM/z/diJ3NnNBKWMlk1VoribLeZ7TW4zBpAuGa6RGQga/gFJhWTByadXhfc
         cjDHdXDkrvU7skdSqL3syKu7aAyixMVtwHkJhpMgCJBLgGmLWEo/9EV5/M/Emkkj28xi
         yJ4bZz1rwhtW+KmVNvnkM9j5DajZXpILqNuPR9OZ4MdN8jwZlDpIl9HOks6v5RuCCbuA
         16xLPwNBiCVxNeDc8JjE4hNvNdpDvIddnK++M3iWG9gW76AIs5g3M8H8iSKUAIWx3Kln
         U2v/lgfDgf0SRM329AY/T9wrLPKi+DcG4woIeLxK6jIFEWB1sOsw4H8DjlfaFkow7t/d
         xbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BeYJT0Z/72s44LJc0KKufww5He7xJOSI991sA39Lbhc=;
        b=AN1Ks4XQpnABqz1xaPZcCibyaJcHRsafiekvbemlONGozxPGU4bUlRRmFNQ7Ux5884
         LYU7HUSjPmNPhnqeZgTiabfoHxQuXnAdwPN2+y3g5Rgk1N1RqFWkDLuppSplA1WhjWdE
         hlgiw5Ee7STBCFZ3UOcB3yTkpEFn17nlQeePCaH8z4mvTlyaZOe/D69CdirHrWXGIQAS
         +6NoQjuvYlYsURKkeuyu3Ct5BuaBc2tsy+dpbI8rYNIBpIOmLFPjFhIOfvTkC4BGc224
         nnVWNhVl/b9j+tKwSC8BgFvEcaFWfh2LTnrcgC81ZSLU4tw6yRQAA7trlJx1yAlqP3/R
         Ekig==
X-Gm-Message-State: AJcUukd9NejAG3mu0SBDhO9pcWUx0fC93Qxl3T9QL+ankek13xUyFrPd
        dIkkAoH26O4FYmyE83QOjso=
X-Google-Smtp-Source: ALg8bN4AR9FkpiEi8UgqYmeyXS7F3KaRT/apSMnXHNDsY25y80ula8XtkhVhBYcLKGMhFJI89E9A8Q==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr3502164wmd.151.1548353261479;
        Thu, 24 Jan 2019 10:07:41 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id v132sm61758566wme.20.2019.01.24.10.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:07:40 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 922D71143574; Thu, 24 Jan 2019 19:07:39 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Correctly annotate implicit fall through in __rfcomm_dlc_close
Date:   Thu, 24 Jan 2019 19:07:24 +0100
Message-Id: <20190124180724.20910-2-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190124180724.20910-1-malat@debian.org>
References: <20190124180724.20910-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case put the fall through comment on a separate line so
as to match the regular expression expected by GCC.

This commit removes the following warning:

  net/bluetooth/rfcomm/core.c:479:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 net/bluetooth/rfcomm/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 1a635df80643..caaae6accafa 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -480,9 +480,8 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 			__rfcomm_dlc_disconn(d);
 			break;
 		}
-		/* if closing a dlc in a session that hasn't been started,
-		 * just close and unlink the dlc
-		 */
+		/* fall through - if closing a dlc in a session that hasn't */
+		/* been started, just close and unlink the dlc */
 
 	default:
 		rfcomm_dlc_clear_timer(d);
-- 
2.19.2

