Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583B2C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B592070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276793;
	bh=OSLyDtD8/6R59W91vHBHbDESVzOgGVB2Y3Lsewy5RRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dbt02JD1Br36QotvtHkMBkkJUrZnbjQFUK9s28oyVDR+fS2ZkRsL0NwlAVzuFLC/r
	 oaPHJ/AjpkppmzsGrBB0APU26PAaBjPLgyK8dZqw+g7aKu72wGUtfZN7C7+/CQ2GyV
	 Wcoq1nJhxPzQVLqQfyfjvafRKXwBDs/G5cAV3Lg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfBDKjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:39:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729837AbfBDKjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:39:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F7C52075B;
        Mon,  4 Feb 2019 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276787;
        bh=OSLyDtD8/6R59W91vHBHbDESVzOgGVB2Y3Lsewy5RRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWQy4I2hc+kFK32PUROnO8ediWdAl6Ve4atBFdueLQC+6tAttkOwBM48qtbwLpd2g
         GI1ZmcG9wtJftbBhUKI7Bh1AYaYOnAD5vWxIYCtmPpVvl8BjGKzop5pCEsbOiNtSdR
         QYdYR85uF7RuPestmyvEp13IPPY7lU+iCJ1cbOqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH 4.4 15/65] tty: Handle problem if line discipline does not have receive_buf
Date:   Mon,  4 Feb 2019 11:36:08 +0100
Message-Id: <20190204103612.951652448@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 27cfb3a53be46a54ec5e0bd04e51995b74c90343 upstream.

Some tty line disciplines do not have a receive buf callback, so
properly check for that before calling it.  If they do not have this
callback, just eat the character quietly, as we can't fail this call.

Reported-by: Jann Horn <jannh@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2297,7 +2297,8 @@ static int tiocsti(struct tty_struct *tt
 		return -EFAULT;
 	tty_audit_tiocsti(tty, ch);
 	ld = tty_ldisc_ref_wait(tty);
-	ld->ops->receive_buf(tty, &ch, &mbz, 1);
+	if (ld->ops->receive_buf)
+		ld->ops->receive_buf(tty, &ch, &mbz, 1);
 	tty_ldisc_deref(ld);
 	return 0;
 }


