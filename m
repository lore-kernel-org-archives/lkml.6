Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413643-2-456806909340912618
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
    t=1519413642; b=ZvG0/DY0gKJcqc3xJ4QacSmHolKK+dDYMJzDTZ9dhavF+Qw
    TXEgRM58cgxDBud2drI7dTGEy1G1syJmgbOA6aMqJqsKYBT5WNJfUI3ZXN9ylJ6G
    tEQV6I6fJAPLXz2mVodZ4TmLVl4NcUxfBnqXAgqvYiOc753+RV+PFxxeJAhNHmWT
    AVeaK4IcsaAtAL4W/owBAfHcvJNolLmgB/kihOJnpFol1xwIpYms1WF5bBumDwKv
    QCJCWFOJ0AXK8+WZ4Kx2mIawJtQm7y8TDVpxtlDOrfOqCn8/Dw3DT9jQv4D77I1e
    QkZ87Clt8WzgPoYePK95bHGscY1h8jmuOtKbuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413642; bh=C6veyivqUR10blWSuf7VW0yFRd
    Ez78xauaN1jP7Zi3Q=; b=vzJhuZSEMdQ2Ebh4Le1d3xGg+ObL+X5be5F4PH9Gll
    LvWCZyF+0PCgYUgCV8AyNZY6Cvulu5HzA74AjWEj0aiOq/tjfY8mK5RRumDnTfZ+
    hhpZ1B1E/T7Iqwd+VSt3akhhx4pIqzxHfgo/E4cRWsn65680vIkDWobTGzWa0dpy
    2RDseegqnMZ7wyo3OqbrusLQ99+K12xfJv60juu4wYRwMwjYMKdx26piyTsfBYZW
    zd4vJVhXGOX/q2H+ipdNycmjyaED64GjfEeDEm7lvWp/JvtxyeJ6jGMrrilp+eMd
    otrirvQY405eexFibXxMM1/tMvV/IDK0JSH5qDUM34bQ==
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
        id S935176AbeBWSyL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964898AbeBWSyJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 106/159] PM / runtime: Fix handling of suppliers with disabled runtime PM
Date: Fri, 23 Feb 2018 19:26:54 +0100
Message-Id: <20180223170756.223462110@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>


[ Upstream commit 31eb7431805493e10f4731f366cf4d4e3e952035 ]

Prevent rpm_get_suppliers() from returning an error code if runtime
PM is disabled for one or more of the supplier devices it wants to
runtime-resume, so as to make runtime PM work for devices with links
to suppliers that don't use runtime PM (such links may be created
during device enumeration even before it is known whether or not
runtime PM will be enabled for the devices in question, for example).

Fixes: 21d5c57b3726 (PM / runtime: Use device links)
Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/runtime.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -276,7 +276,8 @@ static int rpm_get_suppliers(struct devi
 			continue;
 
 		retval = pm_runtime_get_sync(link->supplier);
-		if (retval < 0) {
+		/* Ignore suppliers with disabled runtime PM. */
+		if (retval < 0 && retval != -EACCES) {
 			pm_runtime_put_noidle(link->supplier);
 			return retval;
 		}
