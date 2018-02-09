Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518183917-2-14683555255684303201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518183917; b=iMIh9KhoBVVKihkY/zMRlJ4LzgUaTvmvbzo52NzvDZw5t7s
    XkTpQ7HfAmtYHGkfOTZvHHX9SxjMLWe3bUzNKp/xkvmd+kt0l5QMvHc+Y0ALoKKw
    EMoRZNVdqMKS/g3y7uprnHPzEz3lbNM8nXphD6m3vy9vgM8YhorasP57ZUocYOwU
    tmVvyvnmxFxheMxcy71sLk+Aiot5xeIFcmqg8o2kZ5wKb9XKNcuEeh0Zz4atpIVf
    uKpkYtsb5MDO8U2xo4dB78CEgsOTf40ELRol5AKlgJggFLZhqrw5p1PuiHywNE8C
    0vNZY5NwhFNLNZ8hMLmRtXTNwyEr2Rzgl7HkPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518183917; bh=CMT0SuCvdlz4LxEQRs1dN3YayF
    fpsEVnN5QCsaskPp8=; b=gkvDMj6copfUtC/I1jciWWT5oN95E2KM+Pv7u0EUxG
    AaXwkBqqk9806bMmXO963OfV1ZJGdStSwvIRvnHahTN1t75bcBGGOl8hp13vnucR
    1fTnowpHoujZWY5oMmCcxZNCA7c8Xfu+W4H0EeJ+CTMj9MebM/kgQy4PNiwDJc/T
    zS9SWINIdRSuQa6RLTVZWtfmhtb4nLn3v/a6h/UW7+2dkky+uHLQZIsU6L+jQWy+
    k7+QdtnNglCwFHq2dW7JJp/pGuPQblksdjG5Q3vnYsQL+GnsNGyf+Ir4b1C1M5la
    Vb4KPPlma8YsvlYb8xFebN/QesKF99HxDAHEmwEpn67w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeBINpN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeBINpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Beyers Cronje <bcronje@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 14/22] tcp_bbr: fix pacing_gain to always be unity when using lt_bw
Date: Fri,  9 Feb 2018 14:40:03 +0100
Message-Id: <20180209133935.096742447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neal Cardwell <ncardwell@google.com>


[ Upstream commit 3aff3b4b986e51bcf4ab249e5d48d39596e0df6a ]

This commit fixes the pacing_gain to remain at BBR_UNIT (1.0) when
using lt_bw and returning from the PROBE_RTT state to PROBE_BW.

Previously, when using lt_bw, upon exiting PROBE_RTT and entering
PROBE_BW the bbr_reset_probe_bw_mode() code could sometimes randomly
end up with a cycle_idx of 0 and hence have bbr_advance_cycle_phase()
set a pacing gain above 1.0. In such cases this would result in a
pacing rate that is 1.25x higher than intended, potentially resulting
in a high loss rate for a little while until we stop using the lt_bw a
bit later.

This commit is a stable candidate for kernels back as far as 4.9.

Fixes: 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reported-by: Beyers Cronje <bcronje@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_bbr.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -481,7 +481,8 @@ static void bbr_advance_cycle_phase(stru
 
 	bbr->cycle_idx = (bbr->cycle_idx + 1) & (CYCLE_LEN - 1);
 	bbr->cycle_mstamp = tp->delivered_mstamp;
-	bbr->pacing_gain = bbr_pacing_gain[bbr->cycle_idx];
+	bbr->pacing_gain = bbr->lt_use_bw ? BBR_UNIT :
+					    bbr_pacing_gain[bbr->cycle_idx];
 }
 
 /* Gain cycling: cycle pacing gain to converge to fair share of available bw. */
@@ -490,8 +491,7 @@ static void bbr_update_cycle_phase(struc
 {
 	struct bbr *bbr = inet_csk_ca(sk);
 
-	if ((bbr->mode == BBR_PROBE_BW) && !bbr->lt_use_bw &&
-	    bbr_is_next_cycle_phase(sk, rs))
+	if (bbr->mode == BBR_PROBE_BW && bbr_is_next_cycle_phase(sk, rs))
 		bbr_advance_cycle_phase(sk);
 }
 
