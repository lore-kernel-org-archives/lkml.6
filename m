Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22DBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FA02083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762846;
	bh=9STYW6/nmRDU2jygyBiG9Xs9jSQr94rb+DOL2rRRyvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2lhYw1j9AT/VhzpkV/MU7H9cUUZTDnhhnym3XE5PD1IINU6H1A/IRXdknO+9ffL9H
	 KTw9PhkcY77MOQyTOEUsGgjUz2u1z4M4I0C/oZX9kbDWC0inU3mFKe6UdM0qxpyKYb
	 gn01OFRINSvAcky1Cto5Mmw0im9Y35fU7gjFYUoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfA2LyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfA2Lv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E082083B;
        Tue, 29 Jan 2019 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762718;
        bh=9STYW6/nmRDU2jygyBiG9Xs9jSQr94rb+DOL2rRRyvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOSe0orWiluZMMHct87kbLAEhUG0yemdXvBbT63e8m25AwU79iQn5Ja0s/KoB1JXH
         T3wrL34SfPMu1iclamUKLnPQst49KZfafHX5K+CwDY8CKucQ25y2/krUa8z8u1UFOR
         GIwrg7WXRJimzciKt57b2RnyaSJPmrsx4dP+ew5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.9 35/44] vt: invoke notifier on screen size change
Date:   Tue, 29 Jan 2019 12:36:30 +0100
Message-Id: <20190129113142.753603951@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 0c9b1965faddad7534b6974b5b36c4ad37998f8e upstream.

User space using poll() on /dev/vcs devices are not awaken when a
screen size change occurs. Let's fix that.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -956,6 +956,7 @@ static int vc_do_resize(struct tty_struc
 	if (con_is_visible(vc))
 		update_screen(vc);
 	vt_event_post(VT_EVENT_RESIZE, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 	return err;
 }
 


