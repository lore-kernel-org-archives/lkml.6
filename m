Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804276-2-18283071776353720621
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
    t=1521804275; b=uIwd0aHwTsGfvAZnWVv7mIYX/2P3JgTuuxHdfmH9mr8bPBA
    nd28L/tUKwkC9Cj2kxV1T5+InWr+TcH79oM5PmKBPT9HkWY9INL88HWJ8K23VReV
    IH/hGOJEvftVPdCViNZJRfXPvPlHz+EM8AtwMa4j5VeIZDja/dMeyOpa35gzCKw5
    UdHqmMIP04zw3TcG+Mf99leGnc61h6Ss8/OPOP9R1adb60z5we/qAGGyzdQfhbXe
    KGgBRPGZ5F7W4pd6YnMKkM9G6WugUcMVLvcsw3EE9T9SSSIhIW02S1Si6KK2Fe4E
    HR3HR/IzZeOR/N8DUETqNkSYXvqZirXkVrA/0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804275; bh=o61HV5zUmbzQ+hbB8ocweivZbH
    npKZYUuBI22/QCChg=; b=P5UTsigFdntZFe7lc7m4IfycsanKnZ6Z56IFmg2LKA
    Y6SScOgUMhCk+9LAD5AA4c8AI6CxpLEpS2Z1HyIOy6tGi3DmFXy3jct+xG91Tsc9
    rPQdcLZCUngP8GPANoPQikJsR35mtQ8fqKTc7kO5xCzEzv/k/lXvXYfA2drg5iul
    aKMWD5yo/axJanYqgfFADBD5bo4LeLfzlTsVO8cohCGGbLet9thoaLD/OCg72RpB
    fBx1+/v3VXooQdZYhNRNjSbe5OsRAtTx3YXZGCcxoxqDffr++LFBujUB9/0PuyYu
    fecXxtfTHZ3NgdEvTjP9OIlMs49EFtHvnQhN3GpFx3ZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1755363AbeCWKHp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755338AbeCWKHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 055/177] Fix driver usage of 128B WQEs when WQ_CREATE is V1.
Date: Fri, 23 Mar 2018 10:53:03 +0100
Message-Id: <20180323094207.775446512@linuxfoundation.org>
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

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 3f247de750b8dd8f50a2c1390e2a1238790a9dff ]

There are two versions of a structure for queue creation and setup that the
driver shares with FW. The driver was only treating as version 0.

Verify WQ_CREATE with 128B WQEs in V0 and V1.

Code review of another bug showed the driver passing
128B WQEs and 8 pages in WQ CREATE and V0.
Code inspection/instrumentation showed that the driver
uses V0 in WQ_CREATE and if the caller passes queue->entry_size
128B, the driver sets the hdr_version to V1 so all is good.
When I tested the V1 WQ_CREATE, the mailbox failed causing
the driver to unload.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_sli.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -13696,6 +13696,9 @@ lpfc_wq_create(struct lpfc_hba *phba, st
 	case LPFC_Q_CREATE_VERSION_1:
 		bf_set(lpfc_mbx_wq_create_wqe_count, &wq_create->u.request_1,
 		       wq->entry_count);
+		bf_set(lpfc_mbox_hdr_version, &shdr->request,
+		       LPFC_Q_CREATE_VERSION_1);
+
 		switch (wq->entry_size) {
 		default:
 		case 64:
