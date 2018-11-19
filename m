Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C36C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A40C2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e13SM20p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A40C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbeKTDJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387653AbeKTDJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:09:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 182A92148E;
        Mon, 19 Nov 2018 16:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645907;
        bh=NRiG90B1tNiYuIGoo1kOkQKEUu6z6kMfoUbVA602Plc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e13SM20psMhb361zcTI1WQkItSGe+qZcKfzdoolYMZt4jd9ghwcCCv4OnUdNaAnG9
         q5tn+pkLZkLt+ImbpT1nqdhYkdt/uIk1GmJRnVAzZlAMw6QIyuXNGvHiWRWZM+ZKXb
         aOT+rkcUwozxIWGTWA2n5Ez/PQtLmsq12czc+kq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@gmx.us>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.18 134/171] selinux: check length properly in SCTP bind hook
Date:   Mon, 19 Nov 2018 17:28:50 +0100
Message-Id: <20181119162638.259081463@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

commit c138325fb8713472d5a0c3c7258b9131bab40725 upstream.

selinux_sctp_bind_connect() must verify if the address buffer has
sufficient length before accessing the 'sa_family' field. See
__sctp_connect() for a similar check.

The length of the whole address ('len') is already checked in the
callees.

Reported-by: Qian Cai <cai@gmx.us>
Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Cc: <stable@vger.kernel.org> # 4.17+
Cc: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Tested-by: Qian Cai <cai@gmx.us>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/hooks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5306,6 +5306,9 @@ static int selinux_sctp_bind_connect(str
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
+		if (walk_size + sizeof(sa_family_t) > addrlen)
+			return -EINVAL;
+
 		addr = addr_buf;
 		switch (addr->sa_family) {
 		case AF_UNSPEC:


