Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9C3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6849B2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMsPnP0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfAXSHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:07:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34674 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfAXSHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:07:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id f7so7557947wrp.1;
        Thu, 24 Jan 2019 10:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+mli0xSXk2ghiIeou+iQu6b7dIljMmGB5zDKNfOwTc=;
        b=GMsPnP0NzZ+lEOLSnpeCpJbZ2wXAdhj4dZnr76MkTGwbYTStG9jdYcWYe+UhJT7x07
         HbesboogtJS4h3K3qUOMVlNJyNwPye8XRhIrCxsMqBu6dMP3ZqKtGSBj+rvfnSrxGg20
         IZxwHAGtmgrdDIlGBlCe/tD80o/cRX4+UPJ/2MyQvTycDau38crvHpbmqZ1U3kxd9Kn3
         voHhOebTN89DvC+2Czb/fMmLZ275uuU2X9PShXBaHaTyVez5Q/ghwB/3MftaL2gcEdVy
         za+LKnSgtVLjF8rS3frBmIrgS33c7QsF1cJTYI048F1CvGX1F35V4F56Kcj9UuwdAJsi
         LxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9+mli0xSXk2ghiIeou+iQu6b7dIljMmGB5zDKNfOwTc=;
        b=HvpqIJxfIWvRQ4ZBqLwK+oE+mVUXG7h+P7qzUiWQ32GfVvo6Jao0v9obyvnhmET3DB
         MiD6HemvwVBRe9CDGloXT5zYr6KbqXhS6atvo9bH9P/s0mWxK6VdLCHP74PRzvG/TQIu
         TzFyUZO5EYsowQc/6YKOycRCROuf9PnEXQloaenYyUh0VbUEGyUeAmdd68fuGgcvfG2a
         C3OL4/MV+Q6m6EfCBebpQP+n2ssS/t/JKuQ4SVutssywcmjuap5Dm2b0Z64Q5h6FrpNR
         35Cz/rNusBKUAFKfjSt6yGtI12TkHx2No/4kS/7+6s3YXD6zBdPSvN9hOa/VEgGm81F3
         U8rA==
X-Gm-Message-State: AJcUukcggs2yNXdgq8x2QaFdKmJ8CK/1JBPbFV+kL861Q0AJIiFEtcAb
        tWTptf2SaVfap8pVCYfR2fY=
X-Google-Smtp-Source: ALg8bN63lOvR0OgHzifOReN3O18SzENY1+lEzguq01mwJvGoXnOo99qLdc70oT7hGNUL/9RouglpCg==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr8531754wrn.257.1548353259561;
        Thu, 24 Jan 2019 10:07:39 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id x3sm99402358wrd.19.2019.01.24.10.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:07:38 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id DEEB01143573; Thu, 24 Jan 2019 19:07:37 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Annotate implicit fall through in l2cap_config_rsp
Date:   Thu, 24 Jan 2019 19:07:23 +0100
Message-Id: <20190124180724.20910-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit removes the following warning:

  net/bluetooth/l2cap_core.c:4223:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2a7fb517d460..a5b76e24940a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4244,6 +4244,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 				goto done;
 			break;
 		}
+		/* fall through */
 
 	default:
 		l2cap_chan_set_err(chan, ECONNRESET);
-- 
2.19.2

