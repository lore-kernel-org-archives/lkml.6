Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807187-2-16583929210857418372
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
    t=1521807187; b=edIHZH+oVmpX1Tcf4F7O9VAF9ceSyy4m/iTrrl+6HQOAhL8
    TSz4ySUOJaYZ+IJyW2/eZeEvANhQeIVzarTG35ZUO/7PKY23h+KS5O4YKo6MSpQ1
    PA4h9NRXsLmlMR0y2qNOzUc1KSbCtVq+Vb6vdueOm/BeUVlcGkRuHyquj3vMqYXH
    JhAua229cHFzrRRrsz0uGYM4PNqKJkai2Rw9k/QVfh8IXVV2jZVgtneOT5+0V+qs
    T1pbPX5VNRlAo2t/hcUUa9TTFSOrCXq0Uk1ay0sTIip65bgXYTSUBBVB83tes1LV
    cd/6mQcReSo2Uu8I+WbRBKZkD1xoff7dNDvVOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807187; bh=BeoQsw5ClQHDWUsCfE8NoQUTHT
    TKZqnCw5O+9lfLhK8=; b=rbeWjwjQ5GJUXTMaAPCqJ85de6htBORalRzz+T5LJ+
    Bqn/EVX8uHoMtqfxkxWPPPZaACH15pgJZt7krWZILyShCT9Oz4wKQmWEwTxYBGvo
    fvzhbwy8M+xOC36XJJYnR7BTLcLlMgUFVuREQdXT3i+/F2Ii+XqhFQfEKfm9L/Mn
    kALD58tfhJNFNYaALK0F8YqhKN0fUmN25m3/15+N/6YD75s7aahQFHR5uRBkd0D+
    wn6vd2IIcElboN+ngNkZ4ux1u48mNhTVFOfa3WVRbYAGheEPJyszmPbAu0s6PWwJ
    88XmODlHysJzsfPda05AnZiktOfwwCjchi9dAa51SpYQ==
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
        id S1752686AbeCWJ5W (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeCWJ5V (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 24/84] serial: 8250_dw: Disable clock on error
Date: Fri, 23 Mar 2018 10:53:38 +0100
Message-Id: <20180323095415.560007225@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -509,7 +509,8 @@ static int dw8250_probe(struct platform_
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_clk;
 	}
 
 	data->pclk = devm_clk_get(dev, "apb_pclk");
