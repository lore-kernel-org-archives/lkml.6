Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C86DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2321479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B2321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeHPVsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:48:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeHPVsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:48:43 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EF20CC4;
        Thu, 16 Aug 2018 18:48:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        security@kernel.org, kernel-team@android.com
Subject: [PATCH 4.18 20/22] Bluetooth: hidp: buffer overflow in hidp_process_report
Date:   Thu, 16 Aug 2018 20:45:36 +0200
Message-Id: <20180816171557.318550452@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
References: <20180816171556.502583508@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Salyzyn <salyzyn@android.com>

commit 7992c18810e568b95c869b227137a2215702a805 upstream.

CVE-2018-9363

The buffer length is unsigned at all layers, but gets cast to int and
checked in hidp_process_report and can lead to a buffer overflow.
Switch len parameter to unsigned int to resolve issue.

This affects 3.18 and newer kernels.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Fixes: a4b1b5877b514b276f0f31efe02388a9c2836728 ("HID: Bluetooth: hidp: make sure input buffers are big enough")
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: security@kernel.org
Cc: kernel-team@android.com
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hidp/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -431,8 +431,8 @@ static void hidp_del_timer(struct hidp_s
 		del_timer(&session->timer);
 }
 
-static void hidp_process_report(struct hidp_session *session,
-				int type, const u8 *data, int len, int intr)
+static void hidp_process_report(struct hidp_session *session, int type,
+				const u8 *data, unsigned int len, int intr)
 {
 	if (len > HID_MAX_BUFFER_SIZE)
 		len = HID_MAX_BUFFER_SIZE;


