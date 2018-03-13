Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520955391-2-5558178548526906368
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955390; b=SQ4D4RrkZp9BzxWqlbiLOqVuy15Cd1hyZ8gqzJap4R9LIjk
    RlabcwFr9Hk1PsBaw7F/wTMfI2BUKMaiYt7fotTX4j1tvWOC2zQOq8siWwO2J4OM
    s9O1VV5/W0Lvlzt4Me1zfbAMiDmz+QsVnEM4rUPbgAHIUvpWACfUfVJlBe1kB2Hh
    4iGz2qCBqkwc1GT4xicHjeRzUFimgjnZ9Uja/BT099W22+sHKWttjJEm/vbLlkis
    M4bkCNhciI2tZqRBbkTomVXSgxiT51LLjEJFPkc7w0eeNjSkfEP3iE4MhAGOwcfa
    qGJuehfXPhYkLHx44dtsmbQfIXlNSIHNdYHDPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955390; bh=pEboMKG3St6a5XmqXWtDidioyg
    UaZgghDzqhTXsyb74=; b=owTzaFO52DyqJOcMHPImSouVy349jln3mhUI8DkubF
    yjtNuSk7A5fF+9NDYYl79tFeL8EoKOGrJF1ShL8fLSg8nInc7aXyyzhcOwPRrXUi
    fTB4l0WGvMpyylqGS+rPysZOh2hdg+6277XoCiuA9bXkpdnXzKT5ZeoAAdRMoWDJ
    hLz8LAbt2AOd5HbF5F7+TqqVVGfQn0uCMdpwqshtmAzZS2Ze6edgfyeUx880wDRf
    yC9a0322VmBstLbMmSmD3kaPHtsA+A3Pkp4GAiBekZ+Imj7cNHNhQJd0s1L3OfjL
    hLMnIoNj9J4iW/lHrfx34FGdmJdqsnlS63Vg/AXq/9yQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S934203AbeCMPg0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:36:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934168AbeCMPgZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:36:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sawan Chandak <sawan.chandak@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 032/140] scsi: qla2xxx: Fix NPIV host cleanup in target mode
Date: Tue, 13 Mar 2018 16:23:55 +0100
Message-Id: <20180313152500.263801807@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
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

From: Sawan Chandak <sawan.chandak@cavium.com>

commit 3be63b1e1838e35ce93e83f19573e949f4b389b4 upstream.

Add check to make sure we are cleaning up global target host list only
for NPIV hosts

Fixes: bdbe24de281e2 ("scsi: qla2xxx: Cleanup NPIV host in target mode during config teardown")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Sawan Chandak <sawan.chandak@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1561,8 +1561,11 @@ static void qlt_release(struct qla_tgt *
 
 	btree_destroy64(&tgt->lun_qpair_map);
 
-	if (ha->tgt.tgt_ops && ha->tgt.tgt_ops->remove_target)
-		ha->tgt.tgt_ops->remove_target(vha);
+	if (vha->vp_idx)
+		if (ha->tgt.tgt_ops &&
+		    ha->tgt.tgt_ops->remove_target &&
+		    vha->vha_tgt.target_lport_ptr)
+			ha->tgt.tgt_ops->remove_target(vha);
 
 	vha->vha_tgt.qla_tgt = NULL;
 
