Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591588-2-728985680584122956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591588; b=ZpE8ZlDkLPE074lBCM1ZK1dpeCK0rZdUhTfxYTmXCz9qZP0
    pYjOCHunDaDr4aIiDuXgnYD46IuZQsRJMvvfQ18ZB4rm0v2sMXQVio6+Oi83LeJZ
    45Tkpze8qPOhAr0pICIkZT40hpkVV32xW+Q/v7+cfF+ZofL2VVxOAiNJb5hYN1hJ
    TaEMfJLuoJ+NS+PUCxeundaTznIya36VYEX+CLaXXBgA/teSkV+hJ3eRtUz5xZd5
    v+5ET5VArnOohdH8c6E49WEupYNJ9aZCYIXaJDHErysgUnDONFYbyCExNFEAkcbX
    VuaXfyOnooEzBFIk58A5bxrKjCHHXNXysK1+sNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591588; bh=5Rk7b6f0Ba0jyvW7X4Rry+9GPw
    NXSLW4uVHGei82T5M=; b=YF6J2EMMMU99yZdcT29iNcqVatF0umNyr/1bQifHyD
    V0TbFiTw3VLGddSQ1OboRFcS5tx6RZCwv/Sj5XfSz9tRpV8NfVnqHSR2hUlwsJZX
    YZ0/W+NrqqsJwdCU7Lk3Kf72840sIlinLyIinAgr6U4pfgkHU1lgj1gx890S4eWO
    Gd5JfkwER1jpBZgiZ9BX/2v1Ce8E5t0Gs0Ri2rhYDAAGit254zLIi2y/PQuNPTlt
    OCx6vHiUo2eUlbloSp2C9PyUFuPPU1eRXrkwZ6gWjvjNrWusTVTd2TNSTf/kqdT3
    KuAwDxxAMDx42hW7PRYz7Vd8EDfjqQBeigbtdYqrfL3Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeBBRNF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:13:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeBBRNC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:13:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 102/156] SUNRPC: Allow connect to return EHOSTUNREACH
Date: Fri,  2 Feb 2018 17:58:03 +0100
Message-Id: <20180202140844.815058277@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 4ba161a793d5f43757c35feff258d9f20a082940 ]

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtsock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2437,6 +2437,7 @@ static void xs_tcp_setup_socket(struct w
 	case -ECONNREFUSED:
 	case -ECONNRESET:
 	case -ENETUNREACH:
+	case -EHOSTUNREACH:
 	case -EADDRINUSE:
 	case -ENOBUFS:
 		/*
