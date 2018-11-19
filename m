Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155992145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvncSMja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155992145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbeKTDHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387429AbeKTDHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:07:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA0521104;
        Mon, 19 Nov 2018 16:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645809;
        bh=xfpyyCFgWCFlilJRDAYViV1XCEaUaGqkPQpJEnU4+78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvncSMjaTSxNu4g2ao/ApeSJlp+qOCj5KjWR+ELXkTt4MFmzqYXxdG+q8D+34V2YL
         Noq/7iyq9eFXKZgTzGiW6ZvCKrPDCLE38bI0w1ONAnOFQqQvN1xHlYNz8M/FPjg4vg
         Gzg+heYHXU3WMbDMwV1EcO0Aelkfb97XTru5OFzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "Cc: Johan Hovold" <johan@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4.18 097/171] termios, tty/tty_baudrate.c: fix buffer overrun
Date:   Mon, 19 Nov 2018 17:28:13 +0100
Message-Id: <20181119162634.471983832@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: H. Peter Anvin <hpa@zytor.com>

commit 991a25194097006ec1e0d2e0814ff920e59e3465 upstream.

On architectures with CBAUDEX == 0 (Alpha and PowerPC), the code in tty_baudrate.c does
not do any limit checking on the tty_baudrate[] array, and in fact a
buffer overrun is possible on both architectures. Add a limit check to
prevent that situation.

This will be followed by a much bigger cleanup/simplification patch.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Requested-by: Cc: Johan Hovold <johan@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_baudrate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -77,7 +77,7 @@ speed_t tty_termios_baud_rate(struct kte
 		else
 			cbaud += 15;
 	}
-	return baud_table[cbaud];
+	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
 }
 EXPORT_SYMBOL(tty_termios_baud_rate);
 
@@ -113,7 +113,7 @@ speed_t tty_termios_input_baud_rate(stru
 		else
 			cbaud += 15;
 	}
-	return baud_table[cbaud];
+	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
 #else
 	return tty_termios_baud_rate(termios);
 #endif


