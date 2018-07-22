Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AB5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AEB20671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y799woNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AEB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbeGVTpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:45:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36377 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbeGVTpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:45:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so7272822plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9MUoaZsKcddeXtPBiHiGdukpu8On0Dk+IpTYcMP2h+I=;
        b=Y799woNBmnBOrfK2/GAm/Yipmv5eGNmLJSOzvGsmqrzfpEO6IWboLMwr0wvrHqXLyE
         VIz/qiiECfMYHsMqmEdycyF06t3YuSPpkHYXfoWL/teJhzVevLLBGkF7/0fCSNIIm22O
         LD5laUvKqsRxm/ZcoUCGItld3ysBMhJS1sk7QxH5ezM/7Out5bujHF59L5dBFFhB3ry+
         P4/OsdzCKf+z4w7R673yVtlAjW0qGfBR0fwZGARctTgqU0Y5DC0OaOUbY/5cxJEzjcz+
         fPcTwroWsCy+ZzLUhLkITYjesf3TumvFZ6iUZVCItHc7ehQZgCO24jKBUoHGMhNzneWA
         hE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9MUoaZsKcddeXtPBiHiGdukpu8On0Dk+IpTYcMP2h+I=;
        b=V0VQSevLfcis99QHTi8XbqUBazcxFlmrSsc+4uU3uvZEuCQfTNExOVwtGoKMS2KTO+
         h1J5hik1pMDqNKPq2e4NFh6LrzklEsrWZSE7hf+Jd7O/zGDqrMt8uIBcdtD1rrP/Yq8E
         SHHZ55CeoprHwPQSHbuOz2ar6pBUiceXwMg7xQYOy0e5RpE3xMY0s89jhJePuByvsK9m
         xuE+T/VCfNdWMAbvignD63lbb5YmAzLjtRTnBXMMx0VWtC9PHkCrfXfTFHZ1sHLXSQWz
         wZi24qulv2D8FSPnuA80SWnTLfPt5IklbuoqbHbSMHJLU0YxI+vjzjYuZpuGsvhZPj9i
         SNfA==
X-Gm-Message-State: AOUpUlE333HqtbqqEHbsFJY9Y6u9TU2/0vrcTLNxsPXmJGC7M0hNtGjj
        1uKfMfi8mbQXgs5nQLJ41yA=
X-Google-Smtp-Source: AAOMgpfXaA8Qx3xSesPxeJLPeeIncy7lWhwXrkbf1/rIOo7Q956YPLnH9l6E0PD9fUsjwB9XNEWA7Q==
X-Received: by 2002:a17:902:548f:: with SMTP id e15-v6mr10005692pli.317.1532285288063;
        Sun, 22 Jul 2018 11:48:08 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g15-v6sm16423619pfg.98.2018.07.22.11.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Jul 2018 11:48:07 -0700 (PDT)
Date:   Mon, 23 Jul 2018 00:18:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: dgnc: dgnc_tty.c: Avoid '(' at the end of line
Message-ID: <20180722184756.GA21198@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring the first argument to the previous line,
remove a superfluous () in the second argument
by using !, and align the lines to match open
parenthesis. Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes since v1:
 - Remove a superfluous () and use ! instead, in the second argument.
---
 drivers/staging/dgnc/dgnc_tty.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index 9f9b9a5b4b27..f91eaa1c3b67 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -883,10 +883,9 @@ static int dgnc_tty_open(struct tty_struct *tty, struct file *file)
 	 * touched safely, the close routine will signal the
 	 * ch_flags_wait to wake us back up.
 	 */
-	rc = wait_event_interruptible(
-				ch->ch_flags_wait,
-				(((ch->ch_tun.un_flags |
-				ch->ch_pun.un_flags) & UN_CLOSING) == 0));
+	rc = wait_event_interruptible(ch->ch_flags_wait,
+				      !((ch->ch_tun.un_flags |
+				      ch->ch_pun.un_flags) & UN_CLOSING));
 	/* If ret is non-zero, user ctrl-c'ed us */
 	if (rc)
 		return -EINTR;
-- 
2.17.1

