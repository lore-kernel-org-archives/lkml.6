Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415705-2-11345802100234900349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415705; b=oUypBqk4BqwF67MM4StzIiQPSf5HRBxP7r9YkqvXb3kcwbk
    wx2Svns2MXVekPUXaArUFt6ztHFdAg3531YtpKTq64GyTyUjUvth28UGpvHqLTbx
    NYEo4KN6ziDQphFuYwvZaFH1WKy0Ib+qggJT6IPUqA/9ELx5Zx80HhnrjS6YUP3N
    e4/BLT7FqnvJ1UStD9ftAns/s2KHoZEresywnZbY2yP1nHvVhtL5iXwGoPP2NuxE
    qyM1LA/vrUp81glOnAdlX4Xhkw8HVo/Kt9/V3pvhi4r8LNAU8T7gCaO+mXC31t1R
    1mREHlLrk2NUFCjL3ZtVpn1Ed7PJ+jhV1CpYKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415705; bh=PPPMMCtCH4D/Dd4Pzz+rw5PY5x
    KQsuynEpriLlxOdmw=; b=eULYg+8K7EU/6hSySzr4PHpDYYIXZt9m4b7zHKZzKX
    7/R+OLJHzDamoGNM5TcaJnECZWCrWNVUIju4d62EtaHFJn7WE5v0oGT1G3HuWL4M
    cExDKMm67rYky4aMBETRz00fy78FNozm/R632NJX6zjFK81iA7G3J7vbO3tBdLC3
    1MahlN7RcCfAPAOH/fFmtEBgO+k8ntINJ8TXrVs+FETnLa1n9xXbC9Q+nt6RFGxh
    9Wl6apEK3h4qbX+f3DMGgbqfNEDaaGnygzLuvnDNcB8C4K79QV8hc6GOiFPnz2M2
    MqXYxSAVUnoEReN8s4o/IaXZD3fND6ng6u54TSFPLzqA==
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
        id S933060AbeBWSpG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933683AbeBWSpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nogah Frankel <nogahf@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 065/145] net_sched: red: Avoid devision by zero
Date: Fri, 23 Feb 2018 19:26:11 +0100
Message-Id: <20180223170733.083856207@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>


[ Upstream commit 5c472203421ab4f928aa1ae9e1dbcfdd80324148 ]

Do not allow delta value to be zero since it is used as a divisor.

Fixes: 8af2a218de38 ("sch_red: Adaptative RED AQM")
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/red.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/red.h
+++ b/include/net/red.h
@@ -178,7 +178,7 @@ static inline void red_set_parms(struct
 	p->qth_max	= qth_max << Wlog;
 	p->Wlog		= Wlog;
 	p->Plog		= Plog;
-	if (delta < 0)
+	if (delta <= 0)
 		delta = 1;
 	p->qth_delta	= delta;
 	if (!max_P) {
