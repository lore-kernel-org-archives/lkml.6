Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFEBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CD4205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ZvR726vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CD4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeK0HxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:53:15 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42996 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeK0HxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:53:14 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4FA038365B;
        Tue, 27 Nov 2018 09:57:50 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1543265870;
        bh=7SVxkwO39Zx6kpU0je3dtu+C3sldZhdQX6fdfmltJuo=;
        h=From:To:Cc:Subject:Date;
        b=ZvR726vzcaPee0RxUzC+ngleMtiQZ0vuXxwewP/cwtrDM/0AtTJChGHz/RGo0TrKW
         tx6g4vpHQ0QI4eZVou7V79PZUPwiZ+6I0rkqsm7NjwnqS2jENv5NIpG5h4/WEbyyEx
         BCO9n3GmF6yPBoNJZx2AJp699vEpY8qvTDfOvN+U5a03QRc/TEUD2cIyyjFlaS7Ulb
         s0Cx29re9t5+5fFPFJzciD389ifQuMEf4gZiZnSixZoVWwn4Der3JBWmsitCO3kZTm
         x6PO3saVOJZzbeVKwjQeJuBQbie8603LZUi5fWdlp0QkfWlYqZ4REaRLlBDEVNAOuS
         MAih65EFD+9hw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bfc5e4d0000>; Tue, 27 Nov 2018 09:57:49 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.31])
        by smtp (Postfix) with ESMTP id 61E4713EEC9;
        Tue, 27 Nov 2018 09:57:55 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id DA255606DD; Tue, 27 Nov 2018 09:57:49 +1300 (NZDT)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH RESEND] tty/sysrq: Do not call sync directly from sysrq_do_reset()
Date:   Tue, 27 Nov 2018 09:57:23 +1300
Message-Id: <20181126205723.14478-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq_do_reset() is called in softirq context, so it cannot call
sync() directly. Instead, call orderly_reboot(), which creates a work
item to run /sbin/reboot, or do emergency_sync and restart if the
command fails.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
=20drivers/tty/sysrq.c | 3 +--
=201 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index ad1ee5d01b53..f2ca32c1ad7c 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -660,8 +660,7 @@ static void sysrq_do_reset(struct timer_list *t)
=20
=20	state->reset_requested =3D true;
=20
-	ksys_sync();
-	kernel_restart(NULL);
+	orderly_reboot();
=20}
=20
=20static void sysrq_handle_reset_request(struct sysrq_state *state)
--=20
2.19.2
