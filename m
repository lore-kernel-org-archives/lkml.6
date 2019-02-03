Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB8C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4792084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfBCOXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:23:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55886 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730566AbfBCOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:39 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeP-0006Sl-G8; Sun, 03 Feb 2019 14:21:37 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006rg-Ju; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hangbin Liu" <liuhangbin@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adit Ranadive" <aditr@vmware.com>,
        "Vishnu Dasa" <vdasa@vmware.com>,
        "Jorgen Hansen" <jhansen@vmware.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.374962470@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 056/305] VMCI: Resource wildcard match fixed
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jorgen Hansen <jhansen@vmware.com>

commit 11924ba5e671d6caef1516923e2bd8c72929a3fe upstream.

When adding a VMCI resource, the check for an existing entry
would ignore that the new entry could be a wildcard. This could
result in multiple resource entries that would match a given
handle. One disastrous outcome of this is that the
refcounting used to ensure that delayed callbacks for VMCI
datagrams have run before the datagram is destroyed can be
wrong, since the refcount could be increased on the duplicate
entry. This in turn leads to a use after free bug. This issue
was discovered by Hangbin Liu using KASAN and syzkaller.

Fixes: bc63dedb7d46 ("VMCI: resource object implementation")
Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: Drop the version change.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -56,7 +56,8 @@ static struct vmci_resource *vmci_resour
 
 		if (r->type == type &&
 		    rid == handle.resource &&
-		    (cid == handle.context || cid == VMCI_INVALID_ID)) {
+		    (cid == handle.context || cid == VMCI_INVALID_ID ||
+		     handle.context == VMCI_INVALID_ID)) {
 			resource = r;
 			break;
 		}

