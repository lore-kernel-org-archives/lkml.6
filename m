Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3909CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE43214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QyCZDEEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfAIDzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:55:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62701 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfAIDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:55:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFC68119305;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=O5HoLbt0EAT7EAsbBj0FKXLgN
        eQ=; b=QyCZDEEd537clSdq4Jx0eEd+9cdY7t6MpqT9WiVVk76i5IUEib3c0iIa7
        VL/B0YW6qCEXvzWm5IxNoEGdsGp9k1k1aKvSMv9yEQ2gztcwUqmu2Qp78xjlv8c/
        EcpttwAC5C09L2huRdvUQJqriXnWUGS3LkYnVoR0mlAUjD3AWc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5913119304;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 288741192FD;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 4EB392DA041D;
        Tue,  8 Jan 2019 22:55:45 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] vt: always call notifier with the console lock held
Date:   Tue,  8 Jan 2019 22:55:00 -0500
Message-Id: <20190109035504.8413-3-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109035504.8413-1-nicolas.pitre@linaro.org>
References: <20190109035504.8413-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
X-Pobox-Relay-ID: 719702DE-13C2-11E9-A82B-70EFDD2159A7-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every invocation of notify_write() and notify_update() is performed
under the console lock, except for one case. Let's fix that.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b9004bd087..5b8b0e33f9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2764,8 +2764,8 @@ static int do_con_write(struct tty_struct *tty, con=
st unsigned char *buf, int co
 	con_flush(vc, draw_from, draw_to, &draw_x);
 	vc_uniscr_debug_check(vc);
 	console_conditional_schedule();
-	console_unlock();
 	notify_update(vc);
+	console_unlock();
 	return n;
 }
=20
--=20
2.20.1

