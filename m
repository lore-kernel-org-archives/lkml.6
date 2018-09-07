Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7874C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8382083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8382083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbeIHCX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:23:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeIHCX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:23:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F8A3FEA;
        Fri,  7 Sep 2018 21:41:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 32/47] osf_getdomainname(): use copy_to_user()
Date:   Fri,  7 Sep 2018 23:10:28 +0200
Message-Id: <20180907210908.055322084@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 9ba3eb5103cf56f0daaf07de4507df76e7813ed7 upstream.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/osf_sys.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -561,25 +561,20 @@ SYSCALL_DEFINE0(getdtablesize)
  */
 SYSCALL_DEFINE2(osf_getdomainname, char __user *, name, int, namelen)
 {
-	unsigned len;
-	int i;
+	int len, err = 0;
+	char *kname;
 
-	if (!access_ok(VERIFY_WRITE, name, namelen))
-		return -EFAULT;
-
-	len = namelen;
-	if (len > 32)
-		len = 32;
+	if (namelen > 32)
+		namelen = 32;
 
 	down_read(&uts_sem);
-	for (i = 0; i < len; ++i) {
-		__put_user(utsname()->domainname[i], name + i);
-		if (utsname()->domainname[i] == '\0')
-			break;
-	}
+	kname = utsname()->domainname;
+	len = strnlen(kname, namelen);
+	if (copy_to_user(name, kname, min(len + 1, namelen)))
+		err = -EFAULT;
 	up_read(&uts_sem);
 
-	return 0;
+	return err;
 }
 
 /*


