Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803399-2-7952757072026631439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803398; b=IewmPXr+RR79J28BlEvPocC7cHQ4FFBUraqdheucaLwoR7E
    WQrSelkt2IzYbSgdISjQbhjvsHSgDBR6Wr112ob7j5J9QQejCm3GVY7somz+ZGoz
    ZI48JyacpmSbTcKxogZjJMd62Ot+NKmLmJFnPKRXQr+/BiOlocgviZFrQO2rMFVm
    fth9hYySwjik8rLPGReJZE7tcdhlfPhj9jrgFnRjz5TgT7/vlv/PFYU4CTcx0nf3
    vwQGeXzPe5N0VYkp0aUpGkmOgezAfW36klJR+IUvPH67/KQngcbxLdM1LUG6Osd5
    SZ9FuXnhfQTIOS/O9jX/v633lr7fAu53g1pbHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803398; bh=qcRf0kWgFTIcZ4tynjNOv7GIGK
    Ghhob6otXMLvdIFO8=; b=fIicnobldSAdGjQBStA/iqYcO8Oe17YoLpdMdR2qrN
    S9o+TFDJMpToJN62AxYik4pBfWtbwfkkucOgmq98ZU9fugENMh5ppx28wND62qA0
    pJtDU7YciBt/+vZwND8sPtxi4MwrmlRzEYgPg7v+8IQgYNPQ184a92jykorgfk3n
    r7CVypQs2k/15EmZDzSZRUvmxZWeHFCEOo3rSrZ7V7WZhB0NH7znF4vy+qa9Ho2i
    mUKNnQLN4sBY8PbvlVV92CefrmY6ZzQ1EX7jy+evi2NyaxjZnR9paQaTe14b2+Gt
    DGTU9507+G/l3x6jItdm6xGn3uegpTJhBD7qWo5JGFLg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932592AbeCWKLc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:11:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932408AbeCWKLb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:11:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 144/177] serial: 8250_dw: Disable clock on error
Date: Fri, 23 Mar 2018 10:54:32 +0100
Message-Id: <20180323094211.556293732@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>


[ Upstream commit 8af016aa5a27c6a2505460eb4d83f1e70c38dc43 ]

If there is no clock rate for uartclk defined, disable the previously
enabled clock again.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 23f5b3fdd04e serial: 8250_dw: only get the clock rate in one place
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -464,7 +464,8 @@ static int dw8250_probe(struct platform_
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_clk;
 	}
 
 	data->pclk = devm_clk_get(dev, "apb_pclk");
