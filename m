Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802337-2-2580625708188306411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RHS_DOB 1.514,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802336; b=iNSErTpMLmyLeNwu7tWpldeIv6BE+LkbYAapostIHHpxNm2
    TgghN3KHi9SektKoM7Sv051y6N7ivXO04aUi8BJj/JWKof5GjLmVlaTbeAQdbfVv
    tDrWri3muFzde0us5kei5Kw43SM8zIeHUYrwQu5zjBQA8Zs7/1EOLstdbt2Q4TFm
    9kwm7sfIozQEvDxBt07UUT4QLmYK4DQF2qFyEYF4gC4qkszADilSq9A7h03cpbvD
    dlS9PRoZEpfkq9QAq0G2aKYSonwG7NYQuFJROwg5EnGe1OINSAkcXbALDqeKrwGe
    V3FXq8KUoGAtp/+AKNAQ05nn+83FjK0Vt69yr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802336; bh=HuZn/SpWU6nzDoshYtLnvXbYku
    L9eNslugSogniAqT0=; b=dAk41JhfodkXf9BSqe3B+VqXNvujzwD1/iVeLKaDZl
    n+6NWpZJ4+jPXQUQacNuNN94CC5aUK9gqMsliQK4EF/msi66w03FmiPm0x+73WgF
    XhCC+x9OHcgFgz+h1m8985JL618KA01upbnphDasbcCz8iIE570vQVP9/dfyAUJn
    9fLPya6fH/gWxs4h7VVMQn5eezZ9h7Gz53paDApeK7TOYV2mduuky8iyon36oOqX
    8kOTd5pscNscAs8gFE3wONGcgl3hnxNYR3nizehMhVyloTWNXHEEAU1a8ZtM6/iO
    PdQHay0G54D3nTCt9Sw7UJUlolCiSiyt19rjs2B8O8RA==
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
        id S1751909AbeCWKwB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:52:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755986AbeCWKOL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jasmin jessich <jasmin@anw.at>,
        Ralph Metzler <rjkm@metzlerbros.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 18/97] [media] media/dvb-core: Race condition when writing to CAM
Date: Fri, 23 Mar 2018 10:54:05 +0100
Message-Id: <20180323094158.512948472@linuxfoundation.org>
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

From: Jasmin J <jasmin@anw.at>


[ Upstream commit e7080d4471d805d921a9ea21b32f911a91e248cb ]

It started with a sporadic message in syslog: "CAM tried to send a
buffer larger than the ecount size" This message is not the fault
itself, but a consecutive fault, after a read error from the CAM. This
happens only on several CAMs, several hardware, and of course sporadic.

It is a consecutive fault, if the last read from the CAM did fail. I
guess this will not happen on all CAMs, but at least it did on mine.
There was a write error to the CAM and during the re-initialization
procedure, the CAM finished the last read, although it got a RS.

The write error to the CAM happened because a race condition between HC
write, checking DA and FR.

This patch added an additional check for DA(RE), just after checking FR.
It is important to read the CAMs status register again, to give the CAM
the necessary time for a proper reaction to HC. Please note the
description within the source code (patch below).

[mchehab@s-opensource.com: make checkpatch happy]

Signed-off-by: Jasmin jessich <jasmin@anw.at>
Tested-by: Ralph Metzler <rjkm@metzlerbros.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-core/dvb_ca_en50221.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -750,6 +750,29 @@ static int dvb_ca_en50221_write_data(str
 		goto exit;
 	}
 
+	/*
+	 * It may need some time for the CAM to settle down, or there might
+	 * be a race condition between the CAM, writing HC and our last
+	 * check for DA. This happens, if the CAM asserts DA, just after
+	 * checking DA before we are setting HC. In this case it might be
+	 * a bug in the CAM to keep the FR bit, the lower layer/HW
+	 * communication requires a longer timeout or the CAM needs more
+	 * time internally. But this happens in reality!
+	 * We need to read the status from the HW again and do the same
+	 * we did for the previous check for DA
+	 */
+	status = ca->pub->read_cam_control(ca->pub, slot, CTRLIF_STATUS);
+	if (status < 0)
+		goto exit;
+
+	if (status & (STATUSREG_DA | STATUSREG_RE)) {
+		if (status & STATUSREG_DA)
+			dvb_ca_en50221_thread_wakeup(ca);
+
+		status = -EAGAIN;
+		goto exit;
+	}
+
 	/* send the amount of data */
 	if ((status = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_SIZE_HIGH, bytes_write >> 8)) != 0)
 		goto exit;
