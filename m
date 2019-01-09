Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A73C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E72820883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a3lYeLFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfAIEBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:01:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59751 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfAIEBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:01:52 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 23:01:51 EST
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20A1E4D5FF;
        Tue,  8 Jan 2019 22:55:51 -0500 (EST)
        (envelope-from nicolas.pitre@linaro.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=zys7wzfBEXI8WLsQRJK2ztCU7
        R8=; b=a3lYeLFy7EbcTJGngJRCZXzWIerFwm5osXoz1Caw0aMbhcPJ2HiS5BfLz
        duHedGMFUOFBCa4zLYEUX/9LOUVLRczB9jlubgg6cgLQjvb51pL/r2fVb/7JeAD2
        2jCqLkU3LU+lzLEWkRuTbwx118uCUoK0cpzrSVPPMo30A+QKas=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 193254D5FE;
        Tue,  8 Jan 2019 22:55:51 -0500 (EST)
        (envelope-from nicolas.pitre@linaro.org)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B1314D5FD;
        Tue,  8 Jan 2019 22:55:48 -0500 (EST)
        (envelope-from nicolas.pitre@linaro.org)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 1562C2DA06F5;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] vcs: fasync(): make it consistent with poll()
Date:   Tue,  8 Jan 2019 22:55:04 -0500
Message-Id: <20190109035504.8413-7-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109035504.8413-1-nicolas.pitre@linaro.org>
References: <20190109035504.8413-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
X-Pobox-Relay-ID: 72BF9086-13C2-11E9-959D-90A5DACCD188-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use POLLPRI not POLLIN to wait for data with poll() as there is
never any incoming data stream per se. Let's use the same semantic
with fasync() for consistency, including the fact that a vt may go away.

No known user space ever relied on the SIGIO reason so far, let alone
FASYNC, so the risk of breakage is pretty much nonexistent.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/vt/vc_screen.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 1bbe2a30cd..1d887113ff 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -93,9 +93,18 @@ vcs_notifier(struct notifier_block *nb, unsigned long =
code, void *_param)
 	struct vcs_poll_data *poll =3D
 		container_of(nb, struct vcs_poll_data, notifier);
 	int currcons =3D poll->cons_num;
-
-	if (code !=3D VT_UPDATE && code !=3D VT_DEALLOCATE)
+	int fa_band;
+
+	switch (code) {
+	case VT_UPDATE:
+		fa_band =3D POLL_PRI;
+		break;
+	case VT_DEALLOCATE:
+		fa_band =3D POLL_HUP;
+		break;
+	default:
 		return NOTIFY_DONE;
+	}
=20
 	if (currcons =3D=3D 0)
 		currcons =3D fg_console;
@@ -106,7 +115,7 @@ vcs_notifier(struct notifier_block *nb, unsigned long=
 code, void *_param)
=20
 	poll->event =3D code;
 	wake_up_interruptible(&poll->waitq);
-	kill_fasync(&poll->fasync, SIGIO, POLL_IN);
+	kill_fasync(&poll->fasync, SIGIO, fa_band);
 	return NOTIFY_OK;
 }
=20
--=20
2.20.1

