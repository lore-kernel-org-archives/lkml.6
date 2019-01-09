Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A2DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71772214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="en0QQLc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfAIDzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:55:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51069 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfAIDzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:55:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E979F119307;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Ok46tFcJgtlME1pfsnHQK5+Pv
        zg=; b=en0QQLc2+VxmZCMeF3q0DJ6epSt36wSmNXyaqmxlDk+VwPxLbN6Vi2J3l
        CasnCSLDeM2IobKgJ7SCsWeHPsDmdfFdQFgBRvKJHsHuqddW6Kh6X2tQXwnB9svO
        gCZ7BcwQg1kSS0L9zUPoBR4OJQ++pB7yMx90BxuvERQ5+fluks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E10AF119306;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D2BC1192FE;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 7F4A72DA05DD;
        Tue,  8 Jan 2019 22:55:45 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] vt: invoke notifier on screen size change
Date:   Tue,  8 Jan 2019 22:55:01 -0500
Message-Id: <20190109035504.8413-4-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109035504.8413-1-nicolas.pitre@linaro.org>
References: <20190109035504.8413-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
X-Pobox-Relay-ID: 71B86960-13C2-11E9-9F5D-70EFDD2159A7-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space using poll() on /dev/vcs devices are not awaken when a
screen size change occurs. Let's fix that.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/vt/vt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5b8b0e33f9..bba75560d1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1272,6 +1272,7 @@ static int vc_do_resize(struct tty_struct *tty, str=
uct vc_data *vc,
 	if (con_is_visible(vc))
 		update_screen(vc);
 	vt_event_post(VT_EVENT_RESIZE, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 	return err;
 }
=20
--=20
2.20.1

