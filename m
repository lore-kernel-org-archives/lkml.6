Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8150C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABA42070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MDP5Eu2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfAIDzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:55:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52600 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfAIDzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:55:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E323119309;
        Tue,  8 Jan 2019 22:55:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=6xfC+s0P4dYOGWNJOn3g1/ibg
        c4=; b=MDP5Eu2gJD2ROAPU0wxTvj2CVPzy8yKEYZV71nwHKfZ9rHDqt6m1fEOnH
        /X76HlTKqVhRWhcY/kbT6/mpvyUd41e5R8aJMlMmCS542jKSsyEPWDhiaySinge3
        giVGP/1mADbnphsrvVtDyihR8c59aRF4oWb0UHO5EnCWN7Z324=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23627119308;
        Tue,  8 Jan 2019 22:55:47 -0500 (EST)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CF2C119300;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id A91942DA06DA;
        Tue,  8 Jan 2019 22:55:45 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] vcsa: clamp header values when they don't fit
Date:   Tue,  8 Jan 2019 22:55:02 -0500
Message-Id: <20190109035504.8413-5-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109035504.8413-1-nicolas.pitre@linaro.org>
References: <20190109035504.8413-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
X-Pobox-Relay-ID: 71D63472-13C2-11E9-BDB8-70EFDD2159A7-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /dev/vcsa* devices have a fixed char-sized header that stores the
screen geometry and cursor location. Let's make sure it doesn't contain
random garbage when those values exceed 255. If ever it becomes necessary
to convey larger screen info to user space then a larger header in the
not-yet-implemented /dev/vcsua* devices should be considered.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/vt/vc_screen.c | 5 +++--
 drivers/tty/vt/vt.c        | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 2384ea85ff..3dba60825c 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -335,8 +335,9 @@ vcs_read(struct file *file, char __user *buf, size_t =
count, loff_t *ppos)
 			if (p < HEADER_SIZE) {
 				size_t tmp_count;
=20
-				con_buf0[0] =3D (char)vc->vc_rows;
-				con_buf0[1] =3D (char)vc->vc_cols;
+				/* clamp header values if they don't fit */
+				con_buf0[0] =3D min(vc->vc_rows, 0xFFu);
+				con_buf0[1] =3D min(vc->vc_cols, 0xFFu);
 				getconsxy(vc, con_buf0 + 2);
=20
 				con_buf_start +=3D p;
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bba75560d1..f519c22e70 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4591,8 +4591,9 @@ EXPORT_SYMBOL_GPL(screen_pos);
=20
 void getconsxy(struct vc_data *vc, unsigned char *p)
 {
-	p[0] =3D vc->vc_x;
-	p[1] =3D vc->vc_y;
+	/* clamp values if they don't fit */
+	p[0] =3D min(vc->vc_x, 0xFFu);
+	p[1] =3D min(vc->vc_y, 0xFFu);
 }
=20
 void putconsxy(struct vc_data *vc, unsigned char *p)
--=20
2.20.1

