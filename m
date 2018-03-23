Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802427-2-337420025102963107
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
    t=1521802426; b=OSgshZn4Yv6izFEQoU8XHv9HlUOTs3ZffKXjIa5rKIZhzOs
    FLqWF7+H+0xXgQ22NndIzJuAM5GUXhBb4i2OCZVwlGtTFpwo5igWlVnBj9oTFApi
    IWf/Wvsqa4OOi9vN1nBOgXEPG2L3oosHt7XYPgejWvbkD0DZXE5LeANtMEcu2AKP
    KT1grJr9QI/hjQ0SaXTUshP9p2jtLddMwvPp7XQLO3650llzBOu0c4c+S+uSBs2E
    Fjtm+ELemGnJhIs4AofEx+vJWqQ0v4BxhFWXtUC/ZeUFYyL8jkvxhLhCHJuuDLn8
    O2fLS7vAuRbQ9mXAKUpi/kMBhZT/aFhaRhwBUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802426; bh=eg/amKB/TFtxMiyX40QFxiyDbJ
    wY41kaG+UFNxUbOp8=; b=K7R2OjgRA8klPknWE1UbA2hFEl02lPTBeAfS0SSBrw
    KQDXsJyvrGhLhBjC+U/zNfMDte7szyysGSCmDoEULrW3Hhpkosz11PqMCrieFqOx
    oh5MqbnSUr+4w3P08yf0N4mZMCsVGlzVBkBl684i1aye4AC/KweG+hH6bpc6AwKn
    4Ol7iXh7ukrNHtfUCwa9lElgbUbH2d9j3nEEiPUJVBs3RrrCBFPr659m/iRR1l9s
    TZpgwrBjwla70wLoonkQ4lHHW3AZW3MvUzAmY+mKW/kw8fESAtuIYAecoLANlomr
    mX+AAfiNhl3JsufwdUZcRUjNMZCp9nrY1mjU8eS9uDDg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1752113AbeCWKxc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:53:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755920AbeCWKNq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsa@cumulusnetworks.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 17/97] net: ipv6: send unsolicited NA on admin up
Date: Fri, 23 Mar 2018 10:54:04 +0100
Message-Id: <20180323094158.453909558@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsa@cumulusnetworks.com>


[ Upstream commit 4a6e3c5def13c91adf2acc613837001f09af3baa ]

ndisc_notify is the ipv6 equivalent to arp_notify. When arp_notify is
set to 1, gratuitous arp requests are sent when the device is brought up.
The same is expected when ndisc_notify is set to 1 (per ndisc_notify in
Documentation/networking/ip-sysctl.txt). The NA is not sent on NETDEV_UP
event; add it.

Fixes: 5cb04436eef6 ("ipv6: add knob to send unsolicited ND on link-layer address change")
Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ndisc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1686,6 +1686,8 @@ static int ndisc_netdev_event(struct not
 	case NETDEV_CHANGEADDR:
 		neigh_changeaddr(&nd_tbl, dev);
 		fib6_run_gc(0, net, false);
+		/* fallthrough */
+	case NETDEV_UP:
 		idev = in6_dev_get(dev);
 		if (!idev)
 			break;
