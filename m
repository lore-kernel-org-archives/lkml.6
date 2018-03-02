Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989504-3-7111805096679229973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989504; b=snaCGceVKumVaXlR6iqzG1C6tbl3riBWJnH7iaaOVN3Gc1U
    0tF9O4lYlqkoGYtyMn0331BmCs1TpaZ4JLJbpYiN/HIltOqHLg2W+iZNbxVTOg6A
    yEeUjdKY2UjMWTBK3pvvbFoApxDxtxcn6EsqLwdrqH3EpU9ii2rB0fJtkW7CBP1r
    NaSXx2zbLtLSCR5N3FcwhvcScDvry+2Z1ymQ56pjuhCsn++CncZE6eChrSfXStb+
    9R9IRp8HOJxjirKDiZ4DuOzr+PlMup5cW8zwgRA4fEnEVsWy/kd7OqTgYoXTVSBJ
    d4DB0fAQ6+1zKReS+KUkJrYI0/+M+uoVefbFmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989504; bh=UrT3wXaoSxSbm86q5BNUGVwmxv
    H5uDTHSLDpUa70CAU=; b=K289c8CFfCW/UMiGqv/j+kZIOLpQGy2gAe7i7Q6MZQ
    hvinrVjOvzMTSyJNM2ZYIQuPkfYD2mfk+121a3qLk/V6sNxysso2eEkvkQ/liY5i
    foU84I/BNhOHMUYLWKeoU/X9ov5Fav+BFeHH9C5w0Pr49s/5cAYFNVAiVax1V9kT
    /Bce78TuVMdXFlGGGuo3ybGstgwhkMqMwb+wxboM7FcRv8XgMnfcErZZZUNsl9SX
    lJBj929UGynv52l0Zw6li9ibsSMgLapVhcV3XIyb8AFZMhfmsAr0TUpXi04wXSId
    QwS5gUTbNlEhb7T4KwJ5qvdhQcTd9gHoWgoPOkTcr/Ng==
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
        id S1423334AbeCBIxf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:53:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423223AbeCBIxd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:53:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 22/24] xen/gntdev: Fix partial gntdev_mmap() cleanup
Date: Fri,  2 Mar 2018 09:51:19 +0100
Message-Id: <20180302084240.221910658@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit cf2acf66ad43abb39735568f55e1f85f9844e990 ]

When cleaning up after a partially successful gntdev_mmap(), unmap the
successfully mapped grant pages otherwise Xen will kill the domain if
in debug mode (Attempt to implicitly unmap a granted PTE) or Linux will
kill the process and emit "BUG: Bad page map in process" if Xen is in
release mode.

This is only needed when use_ptemod is true because gntdev_put_map()
will unmap grant pages itself when use_ptemod is false.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/gntdev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -817,8 +817,10 @@ unlock_out:
 out_unlock_put:
 	mutex_unlock(&priv->lock);
 out_put_map:
-	if (use_ptemod)
+	if (use_ptemod) {
 		map->vma = NULL;
+		unmap_grant_pages(map, 0, map->count);
+	}
 	gntdev_put_map(priv, map);
 	return err;
 }
