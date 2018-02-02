Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591666-2-9025666127044159164
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591665; b=S5YX/ma702Ajo1UPmeji/ZHD9oDOxKTvYMxBpqAQtv+MCBb
    QQ2YNFjsTwj/fiB273Ad34umLa00M1W4fc9x8l334/kXbv0stfSeWE9eTETcWpNQ
    EIWWGTayyLBVKJUZ6blXr589TVjKFCUX8DCH2gSCksdORkibhnWHAgtqYno3SsuV
    H10B6sV48BD10HgejhDqvh9w4LBrXOKm77hmiP9co6+CfRLSl121y1PULS1XawxY
    PaOR7uMB8myWnbiX/ls5jn5QgKNuzY+BcuMhbsV5GTR0BUfDsYrSNs5wASQHQSvj
    IXR47XXyxvW8WKMSVQ3uGKB4cNJE0izjLazuHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591665; bh=EY+5m2+u6p9C4WuvCbuyf9kSPM
    4+GNLN3Y0xyeO1WFg=; b=oQkDrgWcc8vtZQDTIOTxBs0b9ZHN0pvPrVc84Y6uxo
    UjBFg55ffgCqy5QLRhzpMaCscCcwM+OAd9iAGVxNFjlNnO2bsBkG/CJ8oml2nT32
    vP+cf12jbQzUK/SzPMeY7gTGLErn6ms6Eo8uuRTmLFhnGVPGsewFABDZZGs8BEYT
    76wY96ACjeMw7IXE/k8nOOLX9YL/7ayLZnUrRYuqBKFqbqBSufFVXb7E8hcktC+z
    yMYaMtk8cqmYcUi9oJhM4uB+XWo9zR0l3BBQ67QzC6MwBF7qr6zI3A/2FQgvyPNL
    jO2mlgQ5nve32+Dmlg7pxmvqjs0Adtl4MWqfppLrfYtw==
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
        id S1753616AbeBBROX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:14:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753588AbeBBROO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:14:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH 4.14 153/156] test_firmware: fix missing unlock on error in config_num_requests_store()
Date: Fri,  2 Feb 2018 17:58:54 +0100
Message-Id: <20180202140847.315236310@linuxfoundation.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

commit a5e1923356505e46476c2fb518559b7a4d9d25b1 upstream.

Add the missing unlock before return from function
config_num_requests_store() in the error handling case.

Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_firmware.c |    1 +
 1 file changed, 1 insertion(+)

--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -371,6 +371,7 @@ static ssize_t config_num_requests_store
 	if (test_fw_config->reqs) {
 		pr_err("Must call release_all_firmware prior to changing config\n");
 		rc = -EINVAL;
+		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
 	mutex_unlock(&test_fw_mutex);
