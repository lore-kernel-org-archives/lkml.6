Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366930-1521215528-5-7344311504549180538
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
    t=1521215527; b=bjnpjIbumKDS9Kyqm7t5MAKVYINn7RyF3TADQ4AwMyr3R8i
    e41KeBrgLfgq93bnqCBWwsmvuCsSkvphWGFD0wKQB5vF/BnCCJOduoyYyWVjlz/1
    W7CgIPcyIKNZUnRc7AK1q1Im7cOKYx4HV+yef9lwpAWp4wEhrUWYmmKqfbd5wKK+
    ylhlhXfhDVpLQ6ENXDHiejeUjzYu9RB+wWX/U2dNXsQDh3fsXrZqPLVxuXla8O4Z
    dq23zvdRMKYx8OQBF1KA3EnqW0Y9EDIPk8IsrERJHbSXSR+PombN3e0BdhBW5BqH
    0TIcauV8H0/sVBaX7p2td0p+zJCv9OaMLgz/SoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215527; bh=qR7SHuFOQwDHDK3j8+6gpFsHmc
    J1MDWIovMNQZEbLlk=; b=l5zjtz2aIcyFPAdH9gxoSbHTiBN+m1r/HCZpyIHk5i
    k5uYZ7wsVWrANdkJ51qclSDYsh22Sg8V12dvmY7oyLMriKuyQGm7/mXt0ZPremyx
    UEZqKK7zoCla0UEu1+dCvbCj3vaf5PV/LHxtNZ5zMJzsFS8g6rverIUkTRHoVAGj
    vkZpYr1dBDNGkkcgDIOdEI2RkzAQwfinynXsIQ3KkLHRJsMDaZ2nkVqclnkCbJhf
    2vyGs6IdkMrweODSxg+Xb8yRZJNOQhPPuSG5loL9DLUCixiJCAxzm4FJv/zBY42u
    iCql+UJVqlojejU2ycfDpV6vuHncr0uBo0J4zWYhxnVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1754095AbeCPPvy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:51:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeCPPob (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Dongyang <dongyang.li@anu.edu.au>,
        Jason Ozolins <jason.ozolins@hpe.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 082/128] scsi: ses: dont ask for diagnostic pages repeatedly during probe
Date: Fri, 16 Mar 2018 16:23:43 +0100
Message-Id: <20180316152340.721657702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
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

From: Li Dongyang <dongyang.li@anu.edu.au>


[ Upstream commit 9c0a50022b8ac7e863e6ec8342fa476fe5d1d75c ]

We are testing if there is a match with the ses device in a loop by
calling ses_match_to_enclosure(), which will issue scsi receive
diagnostics commands to the ses device for every device on the same
host.  On one of our boxes with 840 disks, it takes a long time to load
the driver:

[root@g1b-oss06 ~]# time modprobe ses

real	40m48.247s
user	0m0.001s
sys	0m0.196s

With the patch:

[root@g1b-oss06 ~]# time modprobe ses

real	0m17.915s
user	0m0.008s
sys	0m0.053s

Note that we still need to refresh page 10 when we see a new disk to
create the link.

Signed-off-by: Li Dongyang <dongyang.li@anu.edu.au>
Tested-by: Jason Ozolins <jason.ozolins@hpe.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ses.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -615,13 +615,16 @@ static void ses_enclosure_data_process(s
 }
 
 static void ses_match_to_enclosure(struct enclosure_device *edev,
-				   struct scsi_device *sdev)
+				   struct scsi_device *sdev,
+				   int refresh)
 {
+	struct scsi_device *edev_sdev = to_scsi_device(edev->edev.parent);
 	struct efd efd = {
 		.addr = 0,
 	};
 
-	ses_enclosure_data_process(edev, to_scsi_device(edev->edev.parent), 0);
+	if (refresh)
+		ses_enclosure_data_process(edev, edev_sdev, 0);
 
 	if (scsi_is_sas_rphy(sdev->sdev_target->dev.parent))
 		efd.addr = sas_get_address(sdev);
@@ -652,7 +655,7 @@ static int ses_intf_add(struct device *c
 		struct enclosure_device *prev = NULL;
 
 		while ((edev = enclosure_find(&sdev->host->shost_gendev, prev)) != NULL) {
-			ses_match_to_enclosure(edev, sdev);
+			ses_match_to_enclosure(edev, sdev, 1);
 			prev = edev;
 		}
 		return -ENODEV;
@@ -768,7 +771,7 @@ page2_not_supported:
 	shost_for_each_device(tmp_sdev, sdev->host) {
 		if (tmp_sdev->lun != 0 || scsi_device_enclosure(tmp_sdev))
 			continue;
-		ses_match_to_enclosure(edev, tmp_sdev);
+		ses_match_to_enclosure(edev, tmp_sdev, 0);
 	}
 
 	return 0;
