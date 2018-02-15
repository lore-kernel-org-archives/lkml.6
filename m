Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719999-2-5940636406222772960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719999; b=HBUDoBUt02DE8VcTmqKSKxeuQBgfFpnfHNsvT43FtA4yrji
    t6s1yhK5b8zxosj6hRft+RzUFg4p80OY2G8zbaFrtcyzTjEAAKuciRUq0bjAGrzA
    F0hT/hoMei6W2KVgxMVWzdavPKYkaFAE6503d7hh116+Y2aHfayno/j8J8qND9XA
    3pqf9Gc0jcs1QzArF49BMEwb0+dXsMJC8h09GE10jCoDZYLRVLvDShYZfOnsL5rw
    YfAChA+gckq1AT1MS3qDt9F29GzKnM1po+XlxRtuP33xh1qtnO1G7kyDzZmit0Gy
    UZzwMduId/o2IGhvzVhkwR3cqYZfd1nhOeO5Kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719999; bh=WbIB6L68NPf8ayqm0d05G/cptZ
    /EEg2KozVDz2Hw+3M=; b=ujGu1B8/Ov2YFMQUFMHKDTXhu6qj2tiFPFT8xVW0/T
    ugDTOgDq6VCrzcoO73VIyqSaIqmPjkcBeZz/EJtPPFq6sTE2lD3uJdPuEsMAU6Vz
    VFU61qsqvee1wVJCqPaDQkwem+OL1CjjZVJExZ0lIHEscPSltcdP0ifaxnfd6efO
    y3stNy6x/LqymbedMAasaUz2k9h9L7UFdWx3f+U7q5tskfZVh1XKApDiq0kPPHPG
    Ej5Z/iZCiF6g0XXVCjL3chf7pg+lfXKd0yw5nyYvbQ9t8s9MLWtGxSMu1J15C0fp
    hr9HIiAl0fqNMhYlXzc3+QToogPT1eZpKVK+JzD/MBYA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162769AbeBOPXu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162744AbeBOPXr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 071/108] media: v4l2-ioctl.c: dont copy back the result for -ENOTTY
Date: Thu, 15 Feb 2018 16:17:08 +0100
Message-Id: <20180215151232.232798645@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 181a4a2d5a0a7b43cab08a70710d727e7764ccdd upstream.

If the ioctl returned -ENOTTY, then don't bother copying
back the result as there is no point.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2783,8 +2783,11 @@ video_usercopy(struct file *file, unsign
 
 	/* Handles IOCTL */
 	err = func(file, cmd, parg);
-	if (err == -ENOIOCTLCMD)
+	if (err == -ENOTTY || err == -ENOIOCTLCMD) {
 		err = -ENOTTY;
+		goto out;
+	}
+
 	if (err == 0) {
 		if (cmd == VIDIOC_DQBUF)
 			trace_v4l2_dqbuf(video_devdata(file)->minor, parg);
