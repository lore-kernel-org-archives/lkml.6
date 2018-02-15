Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518719624-2-8155474182131865259
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
    t=1518719624; b=wZc8xw4hR/AMOBn/So9CiurWiTZjYQhR3F2NcWZLMLlDd9j
    wG/sH/ohBrM7dOMm0L3a8yot/2iw00yFd7RO4qU7KJrxNK1/ZMOQ1pYZPPP61XG/
    j84bSzfhpbwRfCtWGnlOJ59ffv7yWm4dlMrdSXUGVUx98XSmm7k8qaUtVVW0qIT1
    2bztBPsIpv0nlI5b4ddTb7hrHBni+OVQzVJs70PRXnHyzLBn+wzelFbhTlMxzi+z
    G6Xo0Ky/+otIVW1AoNhwPcYWa332kc9ixW+jmoLJBBi6yrMzlRTFvNqK/TFwcNJI
    2/+8Sjff66JMGFH0suiwmvMj8ye1uDhC95y9cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719624; bh=8QhCOmBeKkxBcAlaYw3BZAHtJd
    2LU4ykTaT1vOxrbPg=; b=io1tTwNTIQLuGxhsA89tMMhd2Cb2IM4kV445ZuJ5wC
    Pk19Y+wygrjEjohVnugSABl34lMkNrIMYXI105abgmOD8rMZZnOa20+h7YiZ8qAp
    BEPIYvcaSqRhFzuvrFGb2WnOAIBOKPwDxqcvr0waSC1VTdtxj5c1jM2H/ctQ7fVm
    yeUSGhXOibCbf6t0eN0JQ8dNEsjDP5fVRWgW5UZmMbyYPyOp0en2fPg3CozRDKBZ
    J5JiGVrkSvhV+HpMwtFsjRPXZ2xmRrit5Z/MbrS2Dpyy1tV2At9DyUX7o4O3UYtd
    SCXhN60dgW68f9zTSY3kzRIlotxWsvkSz/DonCnljqQw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163120AbeBOSd0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:33:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162960AbeBOPYp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 089/108] media: ts2020: avoid integer overflows on 32 bit machines
Date: Thu, 15 Feb 2018 16:17:26 +0100
Message-Id: <20180215151234.788606411@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit 81742be14b6a90c9fd0ff6eb4218bdf696ad8e46 upstream.

Before this patch, when compiled for arm32, the signal strength
were reported as:

Lock   (0x1f) Signal= 4294908.66dBm C/N= 12.79dB

Because of a 32 bit integer overflow. After it, it is properly
reported as:

	Lock   (0x1f) Signal= -58.64dBm C/N= 12.79dB

Fixes: 0f91c9d6bab9 ("[media] TS2020: Calculate tuner gain correctly")
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-frontends/ts2020.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/dvb-frontends/ts2020.c
+++ b/drivers/media/dvb-frontends/ts2020.c
@@ -369,7 +369,7 @@ static int ts2020_read_tuner_gain(struct
 		gain2 = clamp_t(long, gain2, 0, 13);
 		v_agc = clamp_t(long, v_agc, 400, 1100);
 
-		*_gain = -(gain1 * 2330 +
+		*_gain = -((__s64)gain1 * 2330 +
 			   gain2 * 3500 +
 			   v_agc * 24 / 10 * 10 +
 			   10000);
@@ -387,7 +387,7 @@ static int ts2020_read_tuner_gain(struct
 		gain3 = clamp_t(long, gain3, 0, 6);
 		v_agc = clamp_t(long, v_agc, 600, 1600);
 
-		*_gain = -(gain1 * 2650 +
+		*_gain = -((__s64)gain1 * 2650 +
 			   gain2 * 3380 +
 			   gain3 * 2850 +
 			   v_agc * 176 / 100 * 10 -
