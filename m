Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520451954-2-1162487212712337572
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
    t=1520451952; b=WRMiIgXtYcN7+QNjaLn0syUqL3Wke95XzgSMhGtmDZubEHI
    Ok/BwPNMiInK8wKwmHgVdE4TT7tXjsEqpRW6mvMz8kp7doN4Ew68wI6LMcmKnPtX
    Sqmiq18E5MErRK86FvkRUm06Z+DS7FUiFd8lVT8PfVAdgR3vmB51wHmp/Onf87if
    cMHsjK+2bSRZRSk2iLrMCicRez2XOpi4bVJWZF/R/tFfLJeWa60IrnFRrhXBZbuV
    7fzI2pvOVbcvRUGDeuGwi35U8ctFN3dsLe791hg+AbCsXx+C/h72ZC0ucoeRcjCA
    TKXbJsFq+j0YHjT9xT/f95nvbwgtKyJLVYAOYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451952; bh=Uf7TqdIrW+meg14VCZftgv+sTF
    UEkZRB8eC/3hiQjjE=; b=cxLUX+vA8u1/c6vn8YOlB8P3TboRJ775nQIk4l3wOE
    K68qMdC0RLMwVIIMP10CxsZH28bAZUfCeOzvnrtzq7Z1ZcdllVedXjoE1Tu58fW1
    LAV7QJWn3YFsSd61b52UwPZ4VsIA2r15dq9FAwiq3dQaoCO7evpSrnAZbxABcaoW
    NhLi7o6nTTITgvTLlOp3duLwmkRJTgrRozUJaF+7Gp5n1hZPnUXnPRdv6x0l2sKG
    C+5v8o0vePyXfEVNTrEv32k0+QAIeyjv/gCcFmJWDm1scTmzqzfFNp/chUIWKBdh
    I6pzHSUJpStEh4B0CI0G40BhwlG9/SVoS+5DL+HxKoFg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965392AbeCGTpt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:45:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965391AbeCGTpq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:45:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 041/110] net: ipv4: dont allow setting net.ipv4.route.min_pmtu below 68
Date: Wed,  7 Mar 2018 11:38:24 -0800
Message-Id: <20180307191045.010229697@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>


[ Upstream commit c7272c2f1229125f74f22dcdd59de9bbd804f1c8 ]

According to RFC 1191 sections 3 and 4, ICMP frag-needed messages
indicating an MTU below 68 should be rejected:

    A host MUST never reduce its estimate of the Path MTU below 68
    octets.

and (talking about ICMP frag-needed's Next-Hop MTU field):

    This field will never contain a value less than 68, since every
    router "must be able to forward a datagram of 68 octets without
    fragmentation".

Furthermore, by letting net.ipv4.route.min_pmtu be set to negative
values, we can end up with a very large PMTU when (-1) is cast into u32.

Let's also make ip_rt_min_pmtu a u32, since it's only ever compared to
unsigned ints.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -128,10 +128,13 @@ static int ip_rt_redirect_silence __read
 static int ip_rt_error_cost __read_mostly	= HZ;
 static int ip_rt_error_burst __read_mostly	= 5 * HZ;
 static int ip_rt_mtu_expires __read_mostly	= 10 * 60 * HZ;
-static int ip_rt_min_pmtu __read_mostly		= 512 + 20 + 20;
+static u32 ip_rt_min_pmtu __read_mostly		= 512 + 20 + 20;
 static int ip_rt_min_advmss __read_mostly	= 256;
 
 static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
+
+static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
+
 /*
  *	Interface to generic destination cache.
  */
@@ -2934,7 +2937,8 @@ static struct ctl_table ipv4_route_table
 		.data		= &ip_rt_min_pmtu,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &ip_min_valid_pmtu,
 	},
 	{
 		.procname	= "min_adv_mss",
