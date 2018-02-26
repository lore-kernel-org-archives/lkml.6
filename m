Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3776141-1519677586-2-12906531363870015201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519677585; b=bRpbQ39M4cZiG9mHmMudjh2PO8Bj/AmSF1V+1mLG3EcWVjL
    5NWMV4XwWnPnWlm4DQVzet18eb2X8txiwo+yOLnOFRPjc5ZajS5YYFFv01V+dWt+
    Bwz53uAjj3qDRTPC5I6/mXePu04DriBWJD1lbbf6L0emKqryLD+3vy/ZpC7vHFLI
    /RXvPhSPd+UVOGWq/Rn4L/KQOme/5BIYpL+7KSIttYgyIQELA5HkvU1eB5jcEKrg
    DXh2WDu1JNze9MAbnPL0iX/52SKD5p5FUYmd0R4bZhfOWq5G2hCJLChLE0OiCtWf
    17tZthFzT5erF8Q6ScXzZokBZpcfodT06x8Fn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677585; bh=FsYTUblSK+T3hLI6+qisWdRG57
    C7CzETiH35oDmC2Bo=; b=ZMvyJJs7RYfphUi5LUmNS9pQxkjaQZoy/azR6YZX5W
    /8Wujf0FZdT57/ONKpkZVFJNFW2VHPYTuCiRU5KCnbtCu3AN3obj/xhHCKbxA65/
    jyPm5uGVK4q379v2G4nuoFrHtE8F491JvxjuIlhQn5o0stgJKvV8L28vMfSg5vVB
    ra+qQWTOn9Pr3BNVs2vuP10bTRU+2IFpJicRkbMyUIOGgVD5bYR2n9BKkJFINbVc
    Z2KXehFnEvzttHULa+xqMiFEbfhlGn8QnYS/mByHQga1pL9/BcwvCSVqxixaC9LX
    PUB9dtne+RFQNKMEfV+B1l50amTaPbuC62cDjJRDPPJA==
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
        id S1753676AbeBZU1Z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:27:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbeBZU1W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 06/64] scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info
Date: Mon, 26 Feb 2018 21:21:43 +0100
Message-Id: <20180226202153.711954770@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

commit c39813652700f3df552b6557530f1e5f782dbe2f upstream.

The fcp_rsp_info structure as defined in the FC spec has an initial 3
bytes reserved field. The ibmvfc driver mistakenly defined this field as
4 bytes resulting in the rsp_code field being defined in what should be
the start of the second reserved field and thus always being reported as
zero by the driver.

Ideally, we should wire ibmvfc up with libfc for the sake of code
deduplication, and ease of maintaining standardized structures in a
single place. However, for now simply fixup the definition in ibmvfc for
backporting to distros on older kernels. Wiring up with libfc will be
done in a followup patch.

Cc: <stable@vger.kernel.org>
Reported-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ibmvscsi/ibmvfc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -367,7 +367,7 @@ enum ibmvfc_fcp_rsp_info_codes {
 };
 
 struct ibmvfc_fcp_rsp_info {
-	__be16 reserved;
+	u8 reserved[3];
 	u8 rsp_code;
 	u8 reserved2[4];
 }__attribute__((packed, aligned (2)));
