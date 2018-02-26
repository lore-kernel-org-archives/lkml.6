Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519676275-2-8064755683471922203
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
    t=1519676275; b=uYG+OktuWk4EekELnZ2JOwCM5qgpvjeUHOp5vMPG4JTtXhL
    rxzPP8ERrpzQRqUliX5nsH6RRVFGuPhbP/SCAWVtY30lUc3XFgcyPnnO2Ettn9kD
    BHtnEB9M+A20o72ITep1gztKfuvbBRukQIC0qV2A+M8r5jKwlgiPJxAGz9lSg93l
    cLEycP3uKwTWhmYXeCrzh3/Lm3CutthYXfeyPEsCGLbnaif1HOSLs4yngrs8zFnH
    bltFfLCFbNSjsJWLgT0pV7zvxVqOq2E6C65l31HyEa8jeo0Z314LOeQQlSZpnTH4
    uHqleiYlo/scpuCpwh3UnCV+lqdzcmGH231EfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676275; bh=QtF4qS33JlHgs2Xov4g3KBZGk4
    fZCeEUPB9ySh7Zpu8=; b=pABjwq/HYufSW50P5zMPDH1BxOAdgLc8yCO5reqvA3
    jNLCNgaKJQ1O+uBihkFnP3/c4MeA460nlxeVsPJsMnNPzXdYLfAXn9cpsEl95IjC
    ovnaE2GCc6fzMDSaTigrGDMQZCk9C/LRxNjwoG4w/7DJ0xQk45kOULNNDDHZ6p6A
    e8wfVV5i9CNY9jQLv9Xu8lhYf6QkPvNGKBFcnl5PDhJByBJPbzLkLuyaVX7dRL1X
    HuuZqNDi0ypUlkYru39YcPAf2J52vFBkEDGjs9NQW8SCQZ1mPymBDyogplO8Zq+H
    QcMYMyi6nWcZn6s3Ch6TkK0LRlpmSvTB14ICvDLHjC3A==
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
        id S1752265AbeBZURk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:17:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeBZURg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.4 09/22] iio: buffer: check if a buffer has been set up when poll is called
Date: Mon, 26 Feb 2018 21:16:09 +0100
Message-Id: <20180226201559.147172835@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
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

From: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>

commit 4cd140bda6494543f1c1b0ccceceaa44b676eef6 upstream.

If no iio buffer has been set up and poll is called return 0.
Without this check there will be a null pointer dereference when
calling poll on a iio driver without an iio buffer.

Cc: stable@vger.kernel.org
Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/industrialio-buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -174,7 +174,7 @@ unsigned int iio_buffer_poll(struct file
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
-	if (!indio_dev->info)
+	if (!indio_dev->info || rb == NULL)
 		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
