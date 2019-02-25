Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324F2217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130656;
	bh=+HqvbztWS41dTfCTKDEuQPaDpcvbHXcLvU+KlvvQDiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zMSID4CE7wVVg8ptUbi+/FhftaN/uGHaZ5x0dwuXSIdmou+p1MEHBrHQZNN/uQ3NI
	 fq748c5kW7j7S65m4sY5XF9fpJbFjikdpsTR76BNzt6+HkZ+hrnJk1jQcN4jGHL78c
	 o3Y9Qb/ulob5iBrRN0mNaohy7cdLwEKq8VUs5XvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbfBYVhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387476AbfBYVha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFBA21841;
        Mon, 25 Feb 2019 21:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130650;
        bh=+HqvbztWS41dTfCTKDEuQPaDpcvbHXcLvU+KlvvQDiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNZOmr68PZeIoC2BDemyAqWxgTFdV+FdvS6vsSGv7y0sUYQKg2G61n2X/hcA1gWQp
         O+3QrukaVWS0dT8eEDCGLPxJGQ1euggRTDIUIHT9QX4torJBX06bunGCmW2zQf/+aS
         iV1uww3i/O1YpnKzI3sd/nRRTV+gztVoBI2D4lF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.20 181/183] netfilter: nfnetlink_osf: add missing fmatch check
Date:   Mon, 25 Feb 2019 22:12:34 +0100
Message-Id: <20190225195125.689322452@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <ffmancera@riseup.net>

commit 1a6a0951fc009f6d9fe8ebea2d2417d80d54097b upstream.

When we check the tcp options of a packet and it doesn't match the current
fingerprint, the tcp packet option pointer must be restored to its initial
value in order to do the proper tcp options check for the next fingerprint.

Here we can see an example.
Assumming the following fingerprint base with two lines:

S10:64:1:60:M*,S,T,N,W6:      Linux:3.0::Linux 3.0
S20:64:1:60:M*,S,T,N,W7:      Linux:4.19:arch:Linux 4.1

Where TCP options are the last field in the OS signature, all of them overlap
except by the last one, ie. 'W6' versus 'W7'.

In case a packet for Linux 4.19 kicks in, the osf finds no matching because the
TCP options pointer is updated after checking for the TCP options in the first
line.

Therefore, reset pointer back to where it should be.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nfnetlink_osf.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -66,6 +66,7 @@ static bool nf_osf_match_one(const struc
 			     int ttl_check,
 			     struct nf_osf_hdr_ctx *ctx)
 {
+	const __u8 *optpinit = ctx->optp;
 	unsigned int check_WSS = 0;
 	int fmatch = FMATCH_WRONG;
 	int foptsize, optnum;
@@ -155,6 +156,9 @@ static bool nf_osf_match_one(const struc
 		}
 	}
 
+	if (fmatch != FMATCH_OK)
+		ctx->optp = optpinit;
+
 	return fmatch == FMATCH_OK;
 }
 


