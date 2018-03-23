Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977995-1521800119-2-10476600731503239381
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
    t=1521800118; b=fIcMP9Q4EQdffseFiaTGJWoXB2VQsLFqNfRE5gaiKshsqF+
    jUkLGRAOGpNf7BRKm2WfKyv9JxkPyreDfSSMvKY2XBM1g7LTjazdH1t3uMTcTd8Q
    aNqrNQAasWoeZNmdsr1swgNU2IY15cAvqp61/BcrW3uNRMWsM3CFAJN3A3vypyIa
    n+asVRT1h3bH4qfYMRj/7pSwJolj8yok0nrg2OkHkTSA+PsNcFoEcKmohDPBd34y
    /GKkSdjdLPkDNISkWUaReal3BlwdjRgQ93v32btFSwwcyP/bWG07MCXITw5Xg0+Z
    TOzbyM8YwfwVr+/VFOOvH4llWJ3vn3yVYOJJXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521800118; bh=MuJjBN+q/7p0KoocwKEkcrhRTK
    9GyotTJb9Wxu9/gt0=; b=PA2sU0MmCe0GEMBrWlyslh95xkjU6Fz+EfSIP+mYTL
    bQzFCgAXGFRPrHYZacfa3xmCaTrctmBHUk+0RWVJHysYHSNm/e7Kn2mP4po+1RY4
    rAPR9snNDsn6C6wLIoJPMniaj+1hS3FzDKs3CQ9NTcveWldeAPFiQAaAHQccFQfx
    6Vqh/3xY2avXDQzz3eUpt3kmA4g+xf0/IdqGlGhePo8cp2YaruNgdPi4wNNmW7OX
    uraiJoiBqw/zOd7Ahb9View92YY9hFPg8Gd8xpIAO5bEETgag7cDlV4csknVimiA
    3YOBilGuEzSpgo2d0g56bUqQhnZXlfo9hFjgt6YFXujQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S933421AbeCWKPM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:15:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933400AbeCWKPJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:15:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 37/97] Fix driver usage of 128B WQEs when WQ_CREATE is V1.
Date: Fri, 23 Mar 2018 10:54:24 +0100
Message-Id: <20180323094159.737455073@linuxfoundation.org>
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
@@ -13493,6 +13493,9 @@ lpfc_wq_create(struct lpfc_hba *phba, st
 	case LPFC_Q_CREATE_VERSION_1:
 		bf_set(lpfc_mbx_wq_create_wqe_count, &wq_create->u.request_1,
 		       wq->entry_count);
+		bf_set(lpfc_mbox_hdr_version, &shdr->request,
+		       LPFC_Q_CREATE_VERSION_1);
+
 		switch (wq->entry_size) {
 		default:
 		case 64:
