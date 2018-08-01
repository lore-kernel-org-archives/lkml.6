Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D248FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7F520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7F520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407832AbeHATRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:17:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406895AbeHATRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:17:47 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E369BD57;
        Wed,  1 Aug 2018 17:31:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 126/144] serial: core: Make sure compiler barfs for 16-byte earlycon names
Date:   Wed,  1 Aug 2018 18:52:33 +0200
Message-Id: <20180801164958.135424899@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit c1c734cb1f54b062f7e67ffc9656d82f5b412b9c ]

As part of bringup I ended up wanting to call an earlycon driver by a
name that was exactly 16-bytes big, specifically "qcom_geni_serial".

Unfortunately, when I tried this I found that things compiled just
fine.  They just didn't work.

Specifically the compiler felt perfectly justified in initting the
".name" field of "struct earlycon_id" with the full 16-bytes and just
skipping the '\0'.  Needless to say, that behavior didn't seem ideal,
but I guess someone must have allowed it for a reason.

One way to fix this is to shorten the name field to 15 bytes and then
add an extra byte after that nobody touches.  This should always be
initted to 0 and we're golden.

There are, of course, other ways to fix this too.  We could audit all
the users of the "name" field and make them stop at both null
termination or at 16 bytes.  We could also just make the name field
much bigger so that we're not likely to run into this.  ...but both
seem like we'll just hit the bug again.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -344,7 +344,8 @@ struct earlycon_device {
 };
 
 struct earlycon_id {
-	char	name[16];
+	char	name[15];
+	char	name_term;	/* In case compiler didn't '\0' term name */
 	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
 };


