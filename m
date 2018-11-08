Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C93C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDF320857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqu9zncw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDF320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeKIHdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbeKIHdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:53 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA1E52089F;
        Thu,  8 Nov 2018 21:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714185;
        bh=zgauN9iHt7/UEVkahZze35T8Cbp+SOpTffBWHfWfPtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqu9zncwEzjxzn+YQ89xBdEJsoPn2U80FrJb6w+20Su42GxUhB5Hjm5g929nh9Pu1
         NBcmbXiBPNsyMuoC2Rxrij2XqrbyiZrINjlTwy8HWMW4v3nefgppuHBJhWkU42WyQg
         1W0eiPDg9+6kaCNcCSxZYbwhDTe18otf5OPOYY74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Miloslav=20Trma=C4=8D?= <mitr@redhat.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 108/144] tty: audit: Fix audit source
Date:   Thu,  8 Nov 2018 13:51:19 -0800
Message-Id: <20181108215105.691822021@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6b2a3d628aa752f0ab825fc6d4d07b09e274d1c1 ]

The data to audit/record is in the 'from' buffer (ie., the input
read buffer).

Fixes: 72586c6061ab ("n_tty: Fix auditing support for cannonical mode")
Cc: stable <stable@vger.kernel.org> # 4.1+
Cc: Miloslav Trmač <mitr@redhat.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
Acked-by: Laura Abbott <labbott@fedoraproject.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_tty.c     | 2 +-
 drivers/tty/tty_audit.c | 2 +-
 include/linux/tty.h     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0ed99ad74bee..f53682bb30cf 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -195,7 +195,7 @@ static inline int tty_copy_to_user(struct tty_struct *tty,
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	tty_audit_add_data(tty, to, n, ldata->icanon);
+	tty_audit_add_data(tty, from, n, ldata->icanon);
 	return copy_to_user(to, from, n);
 }
 
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 90ca082935f6..3d245cd3d8e6 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -265,7 +265,7 @@ static struct tty_audit_buf *tty_audit_buf_get(struct tty_struct *tty,
  *
  *	Audit @data of @size from @tty, if necessary.
  */
-void tty_audit_add_data(struct tty_struct *tty, unsigned char *data,
+void tty_audit_add_data(struct tty_struct *tty, const void *data,
 			size_t size, unsigned icanon)
 {
 	struct tty_audit_buf *buf;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 4858a3b79b7a..47d0bfa536e7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -587,7 +587,7 @@ extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
-extern void tty_audit_add_data(struct tty_struct *tty, unsigned char *data,
+extern void tty_audit_add_data(struct tty_struct *tty, const void *data,
 			       size_t size, unsigned icanon);
 extern void tty_audit_exit(void);
 extern void tty_audit_fork(struct signal_struct *sig);
@@ -595,8 +595,8 @@ extern void tty_audit_tiocsti(struct tty_struct *tty, char ch);
 extern void tty_audit_push(struct tty_struct *tty);
 extern int tty_audit_push_current(void);
 #else
-static inline void tty_audit_add_data(struct tty_struct *tty,
-		unsigned char *data, size_t size, unsigned icanon)
+static inline void tty_audit_add_data(struct tty_struct *tty, const void *data,
+				      size_t size, unsigned icanon)
 {
 }
 static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
-- 
2.17.1



