Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951739-1517591520-2-918249580888624232
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
    t=1517591520; b=S7IjfqROM2h1hsE99yYIqwijFdAbQwPlvRnNL2aM8+G9jvV
    jRLGC7eqX7zd/iNwdi2AruaC4X70fKb3g1plO8ADuoHwb7F/oVru7/uolkMU1UOv
    lBvIbsHxVxMhcshAOFKAh18QXMI0+RfydXpn01Jw6XBH98cBJmiz3YZPLSNm01JE
    qTUGMxz+JdJWMRnx5yNO5C7IR+CURPmbFI+AApKw/cWtCGw10Q22nJWRwXbe36XM
    tNhD97z3JW1ceRh31cw8AybCKI0zI60ANRKFyLYWkDEFuqVb0Ym+W8+DX24xxZhW
    n6Hz/W5hp8I9i9UnbMb4lmKX24yLW7CWCX3ym8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591520; bh=I9tUJDBkBxC4dm76IEndzDWYwk
    kZgGbE6ZzqryfKStk=; b=G3pPn4SS/uI4U96ALU+gKzTn7h8DF0/9weR6NlGcwp
    mPvm78qMQNCphXZ5kQnUkdETInzpkxkn37ktdz80CG0SbZm0gb9KSMAqOqNgqMCw
    oY4EqnWO4BAlvJ/j6B8KkPDBmIlIFEiH76ORvMPXQdh2KqZ40km79s+3VFLSPMXB
    Es8PBnwxiZD24P3CG4viTLFP40oDSajHCFzlDPSWQl3cnNObdLgz8wvQKX9u1thP
    ULgbV4+Go5gOotQj/D/g1zblhA/bN4csFYwYMiJVd1HPKJdZdyeoK15yUBJ5Va/3
    l+7CdiIGFKpZ4EStERmqr3X0CqDWygNBxGEQ7RXyVmVw==
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
        id S1753420AbeBBRLu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:11:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeBBRLq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:11:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 074/156] sctp: set sender next_tsn for the old result with ctsn_ack_point plus 1
Date: Fri,  2 Feb 2018 17:57:35 +0100
Message-Id: <20180202140843.628645681@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 52a395896a051a3d5c34fba67c324f69ec5e67c6 ]

When doing asoc reset, if the sender of the response has already sent some
chunk and increased asoc->next_tsn before the duplicate request comes, the
response will use the old result with an incorrect sender next_tsn.

Better than asoc->next_tsn, asoc->ctsn_ack_point can't be changed after
the sender of the response has performed the asoc reset and before the
peer has confirmed it, and it's value is still asoc->next_tsn original
value minus 1.

This patch sets sender next_tsn for the old result with ctsn_ack_point
plus 1 when processing the duplicate request, to make sure the sender
next_tsn value peer gets will be always right.

Fixes: 692787cef651 ("sctp: implement receiver-side procedures for the SSN/TSN Reset Request Parameter")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -541,7 +541,7 @@ struct sctp_chunk *sctp_process_strreset
 		i = asoc->strreset_inseq - request_seq - 1;
 		result = asoc->strreset_result[i];
 		if (result == SCTP_STRRESET_PERFORMED) {
-			next_tsn = asoc->next_tsn;
+			next_tsn = asoc->ctsn_ack_point + 1;
 			init_tsn =
 				sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + 1;
 		}
