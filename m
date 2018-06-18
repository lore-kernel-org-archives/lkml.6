Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74AFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C74920852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C74920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935109AbeFRO2w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:28:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43265 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934678AbeFRO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:28:47 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MhUQs-1fqJuV3AkU-00Mcb9; Mon, 18 Jun 2018 16:28:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Kees Cook <keescook@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: mon: use ktime_get_real_ts64 instead of getnstimeofday64
Date:   Mon, 18 Jun 2018 16:27:45 +0200
Message-Id: <20180618142839.3699997-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fU8xOp75BhWoz9TBb4HSYnkOo83bT5fQPfIfgdcU9FnrZ/G4LLi
 Ie0Ur1+SvgtWq5SbVoBHD9UtCNjJUFddcCLj4aNMT0pm7jWi6zEMFDDHXIKIubqffDb3Se2
 BpHbszReH2B2cWO8OZmZCDFK0bI7P51lOAPhhEgE/XYiVKs6hEV+JNlkrz4Zd8QIJxyFrzN
 vXGzXWVdWK7adKn+ThJ1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gyVLhTlpfKk=:MqCqiGn9NVmuGxTHw2fMEm
 Ys3OUFoCsl4mYW4bSMx7vo+/2D0FvJxe+toZtODT0DTh/H9SViQBcsLarlV34zcTxaGidXK7G
 rU0AE9tNtJHxDdBwAYF2s+oXXJggAoEGmH8pkCVYU0QvgQ73X+p8UPtfE+VnDwNQ0YcbfoVXE
 Cvjxd2B/sz1jsOZ97OwEaxU4Npa7fSwxERLezv+rhb2cPQiKwaIGMKz+nHIGiHTnW5XnqWFDo
 f47HgPoHOzOtEYxhMf3kH2T0ky7tSyVfemRBhU/6Liehg2WBk7Ld355vMl6pg+vloNkQ2MxeB
 d6GTjkW+PApI2BGoncz99wM///8KPOmIYeTcZxXwWX5QvW7BQQod9bbOQEULyCXfJ4/OWs+ha
 1AXl0qG8Sw7E4NELzM+68oCSf0qrKnBfq1J0pWXmOKI7PLUJrTwgcCYV227NiMREO8q3wtiZt
 lAKI3zCQUVh06ibsb8EtdxgPIeDCXAsP9B7KjY5ytMMbYzqXLfCqoO9ae5iLxwuViw3RebqWx
 O08KH03FsGG26sDn11IP7ZmtaQIqI+6sxfah5BFnxdokJW5/Eou0fnQ5w4bfuGp1VjLTZQUPR
 unb0cWz7TM0MHVpg5dXCA7R2RWgn3cPV9nFGaZKGp40vs424rVFpb0H0BZ2VXIAAg39sdloCT
 ELe7luOiBfLImPWPDQwsM7TRGzPHKQBkInGVdsyFX7QwkAae6JfoGQPm8hpdVYKMPJP4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two do the same thing, but we want to remove getnstimeofday64()
to have a more consistent interface.

It would be nice to use a monotonic clocksource here rather than
'real' time, but that would break the user interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/mon/mon_bin.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index ad2c082bd0fb..ac2b4fcc265f 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -95,8 +95,8 @@ struct mon_bin_hdr {
 	unsigned short busnum;	/* Bus number */
 	char flag_setup;
 	char flag_data;
-	s64 ts_sec;		/* getnstimeofday64 */
-	s32 ts_usec;		/* getnstimeofday64 */
+	s64 ts_sec;		/* ktime_get_real_ts64 */
+	s32 ts_usec;		/* ktime_get_real_ts64 */
 	int status;
 	unsigned int len_urb;	/* Length of data (submitted or actual) */
 	unsigned int len_cap;	/* Delivered length */
@@ -497,7 +497,7 @@ static void mon_bin_event(struct mon_reader_bin *rp, struct urb *urb,
 	struct mon_bin_hdr *ep;
 	char data_tag = 0;
 
-	getnstimeofday64(&ts);
+	ktime_get_real_ts64(&ts);
 
 	spin_lock_irqsave(&rp->b_lock, flags);
 
@@ -637,7 +637,7 @@ static void mon_bin_error(void *data, struct urb *urb, int error)
 	unsigned int offset;
 	struct mon_bin_hdr *ep;
 
-	getnstimeofday64(&ts);
+	ktime_get_real_ts64(&ts);
 
 	spin_lock_irqsave(&rp->b_lock, flags);
 
-- 
2.9.0

