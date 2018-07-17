Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2444ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88156206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88156206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGQU6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:58:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:58:46 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LkEpj-1gCOcX0BxL-00cNsc; Tue, 17 Jul 2018 22:23:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: export security_kernel_load_data function
Date:   Tue, 17 Jul 2018 22:23:37 +0200
Message-Id: <20180717202355.2119407-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:kiy1i74IFDaVb4GxjRdW0LvWuai9XJxE6mUN0j2vHAFufVUsRwg
 aXPMy+eUHPPlrmY0+hbFdPKNofz53Ev/yCNIjp9+JccJrUU2EMY6UpX7p2Zh5EBz9LAupCp
 J13uv1dt2/bbYDY+p6j72JCzgyk+x00/bgisaCFdq037+D/9r2DWkQHZ6bu3mQVPSUD3vba
 Mcv9kXI+LNkOAs/70fJFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ITWu7OOS1Ts=:UfLAHqMlmrX1x/gF+z50VZ
 dYE5pRYZPXJxtag9J0YKDXrvwv/bQKcKuOhiHHSDbVct0ZZuMEIlqP/PvJ9iLHdtH2PJijH8b
 C3fX1XVdYBxdxA05VVkqUkbzBctmQ3IvNsRJm7EbqWKK3XcqbIoS7Ko8ey/R/EAzLKJEQqBJZ
 IGE8LJg1RA3wPh8spF6dZVBKbhLWXQeoNBmiII2NhDqkcHG2D/EHsT6C1rP59216bEQOomCRJ
 F/K/qXSe4uHfCo4WDc9s3WRnA5weqcpPk7fL1DAQy3sIZSopAua4xfFeFEYmrPkuVj6r2++pp
 f6rKwAN9Xr3rT91oni+dP7kxbi31ZUSUTHLZRB05DLj0DGIwTLyQPBMbaetKCS7b3tRw+Rv3u
 KyUAyTbiEdgn7zuBMusftcrx3zeKUQ4s3ThNIbudqg3z5yuJSsRQ0ERhK2LvLqZxPNaxL13z+
 lnrs4jXgQ4tN4mr6daioCUcFpovnx+2XY/TTYXz8QKwKYuFljuG8KC1UqzuB01eMCeaKWVRU3
 bdVoWN6QybSG5xe6r7fvOSu9CexfmQQ+YsOmsEqc8aa6bx/+edDmRe84MkbrgPq5GHShcZ4Fr
 w/DwmKsV2nQUlhRJ7HplyVsGYkNbPV9ctwh6uKls3jlcpBSf1cVoOpNjrfz5WCczfM/RFpHAL
 RTnKCsaiwt2Eomx+praL/6RWcI3tfbzVdRpZhdrEKX4sqca2VQws/F0fbBEvFHh+JT+g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware_loader can be built as a loadable module, which now
fails when CONFIG_SECURITY is enabled, because a call to the
security_kernel_load_data() function got added, and this is
not exported to modules:

ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!

Add an EXPORT_SYMBOL_GPL() to make it available here.

Fixes: 6e852651f28e ("firmware: add call to LSM hook before firmware sysfs fallback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index 03e98be76d58..7f9618eaba10 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1121,6 +1121,7 @@ int security_kernel_load_data(enum kernel_load_data_id id)
 		return ret;
 	return ima_load_data(id);
 }
+EXPORT_SYMBOL_GPL(security_kernel_load_data);
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
-- 
2.9.0

