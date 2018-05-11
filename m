Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeEKAzP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:55:15 -0400
Received: from sonic311-29.consmr.mail.ne1.yahoo.com ([66.163.188.210]:39160
        "EHLO sonic311-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752033AbeEKAzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:55:11 -0400
X-YMail-OSG: u3wPdm0VM1lWm1fciywA9LCIHdzZ5HiDr7gwmiZ1HI5t3hDhCjcX48ZDQqaadCR
 E531Aah4QdGbZ5w64sE8hIuWhHBbNa8nmZbjqKIaBadRfjOhsiI9WMPwBe1G9qIF2fDLybmC2FCX
 uBjSVU0jsR2ZKpxJ18Mb92KoVzCkRG6ygcFjbNiV_GK4TafHStmaEBD0pmKhmNWcLBXCMPeTD_dq
 rt4qaZ9gcIz7kaA8bs0o855bEu5aqvy5jIQm0coYoDGmIe1I7CpqS0fpkYhgWaweqKUoYU7dDVx4
 n7POL8g.k2iNDcbhbQN15nKIWJNLTvH9t4YooIFmdQJbxzImDB2iR7yVlpiWI0au04w0RfZETX_0
 SRiVGPRRXXlKyvpmi_ffHZh4f1.LznvS1XHytv8N8kZ4YJYFTjcAh1148lSL9ktX7yWiyoBCBprT
 NCFTuCgLS9L46zVKTEENCW_WDNhaIY8m3E6LvgupMR2rE5Z7l4sMcNOGVDOX6e1ntpZsefiRHfQ9
 EvuVXjavR6MU03_weDHqWjGJiSPpGTEbXskDDOFH_WtLHqdOZ_P9ZSMv2Q4MlJHOpUDiBizofj2T
 SjFhwCJSBuXu7C6bhOEUMFXA5ken9zpN9HFlhcYh7NiHk1ATrfEpGSpxQtZ6So597dVQ33GL44tb
 TWbs-
Subject: [PATCH 15/23] LSM: Mark security blob allocation failures as unlikely
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2e03ca7d-35b7-4af0-a328-ad280a59f001@schaufler-ca.com>
Date: Thu, 10 May 2018 17:55:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 14:33:57 -0700
Subject: [PATCH 15/23] LSM: Mark security blob allocation failures as unlikely

The allocation of security blobs is unlikely to fail.
Mark the checks thus for performance reasons.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index 359ed1137c00..412dba75da65 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1245,7 +1245,7 @@ int security_file_alloc(struct file *file)
 {
 	int rc = lsm_file_alloc(file);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(file_alloc_security, 0, file);
 	if (unlikely(rc))
@@ -1368,7 +1368,7 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
 	if (unlikely(rc))
@@ -1388,7 +1388,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(cred, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
@@ -1409,7 +1409,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(new, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
-- 
2.14.3
