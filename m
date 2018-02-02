Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591819-2-3010470827321149343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591818; b=Z+U+KoJWWzmB3L29KtKuWR/cVsaIaKiGs6ipDnF7w8YWNml
    BLVYwCurRoeBFRkMsNx6ey9c0fc6Xw5yGozozjVDxOwf0bFrt3cwsIBVHxmt3DIg
    FvdX40GJDLgQQLvMpfufmW1wL5k+KZtXmstUiCtSYyq0I2SrBacXX5kT5bOG/GBI
    6lybDugZ1/ewtNVYN8tOB8eG18cYodvV69zikuCapkHGpSj1ScBEhpzpVLNtRakE
    hkoeJhuhrMrOHdmJY07W2wZ4YUNdSJ+XoaJMNwx+gFTMCTeTZ71NAPxnqHc8vcOE
    PnUjUK2lndppCRLLP+MjD/A3QFjSnzHXSg8prbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591818; bh=FBXi8meEScZlEneKHZGmjuUIN4
    AgkX1VnYSnFn6+xKE=; b=PjEMg/cLtKLVCUVMTaEvdh45hZY2lSgrAelpvv7lpj
    BUmFAl6xsL6xLvE8vAO7/PLLdzhvjF+zZyxTEpKKLxFl1O5iVXecOb5ncMiruNOS
    wNVuMvFPAtozWeWR3AITP6npz8KrBK0iqI2fZ8dY0LSrup16pJLn8dOLTXxZ6XSQ
    8VT6VPVOqz+pRsTk+aST0//cQd+djpEA5QbiI27k4HI8wsWbw9GP3ZDv49rG/lHb
    sx7R0OfFwKmzlMR9TLLQHbZesAx7+j1l/KRf9wBWgQ4YHl55vkjckWYXiZij/bUv
    ZNm6xz7SDya2vDCHir+TpmVTiEmDz0ivLHbLvquyKMBQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeBBRQz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:16:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbeBBRQv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:16:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Raghava Aditya Renukunta
        <RaghavaAditya.Renukunta@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 24/55] scsi: aacraid: Fix udev inquiry race condition
Date: Fri,  2 Feb 2018 17:58:42 +0100
Message-Id: <20180202140828.711529542@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

commit f4e8708d3104437fd7716e957f38c265b0c509ef upstream.

When udev requests for a devices inquiry string, it might create multiple
threads causing a race condition on the shared inquiry resource string.

Created a buffer with the string for each thread.

Fixes: 3bc8070fb75b3315 ([SCSI] aacraid: SMC vendor identification)
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aacraid/aachba.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -913,8 +913,16 @@ static void setinqstr(struct aac_dev *de
 	memset(str, ' ', sizeof(*str));
 
 	if (sup_adap_info->adapter_type_text[0]) {
-		char *cp = sup_adap_info->adapter_type_text;
 		int c;
+		char *cp;
+		char *cname = kmemdup(sup_adap_info->adapter_type_text,
+				sizeof(sup_adap_info->adapter_type_text),
+								GFP_ATOMIC);
+
+		if (!cname)
+			return;
+
+		cp = cname;
 		if ((cp[0] == 'A') && (cp[1] == 'O') && (cp[2] == 'C'))
 			inqstrcpy("SMC", str->vid);
 		else {
@@ -923,7 +931,7 @@ static void setinqstr(struct aac_dev *de
 				++cp;
 			c = *cp;
 			*cp = '\0';
-			inqstrcpy(sup_adap_info->adapter_type_text, str->vid);
+			inqstrcpy(cname, str->vid);
 			*cp = c;
 			while (*cp && *cp != ' ')
 				++cp;
@@ -937,8 +945,8 @@ static void setinqstr(struct aac_dev *de
 			cp[sizeof(str->pid)] = '\0';
 		}
 		inqstrcpy (cp, str->pid);
-		if (c)
-			cp[sizeof(str->pid)] = c;
+
+		kfree(cname);
 	} else {
 		struct aac_driver_ident *mp = aac_get_driver_ident(dev->cardtype);
 
