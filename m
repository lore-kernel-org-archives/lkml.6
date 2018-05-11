Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeEKA4U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:56:20 -0400
Received: from sonic311-29.consmr.mail.ne1.yahoo.com ([66.163.188.210]:43517
        "EHLO sonic311-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752167AbeEKA4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:56:17 -0400
X-YMail-OSG: VuK0DXUVM1n_IzsaqRR1H.u.8WvEEMcV8nF0wYSMBDd2Ohxvlgb27tcIN4l4j_n
 eXCFkIdzB8rTYftb01GfmkcASSuSJN1VnVfP.YZIrGDjPvm5Lf.GBVPrpfjl846FtA3PWU0KmHKy
 EZhDEHBkCRAc3jgRk3u0Lgv1v0pAuSycJ2q1PScpACMDCglZVZWz9lqhu46V_4zf.haQveMMQsAp
 gMbFi8HwBw1XHAy2EG6f1QFCNF0H54cOlFqKD2cSKQnaLhBjGHCfn6Bstt8NXW1z2Dy.ChBuhsnG
 zdfLrD3l8TvYWjROE68EWLXckdZHw8TMeeTSOQnnEc79W3kL2IP5MnKhb05e5YSJreXJm7viRRS.
 .Vpz_aUv_NZDuU4d.l.ItloAvIB8i.VFqRNaIxMNG.Z6JyI8XZbv7mqAhZdQz2eytM_fECkchjhk
 ab0j8NvEeLZv9bB0uAyu0FO2uDqHD12N3t7t5GuMqyP5s2Dv9DDhr.tcc8E4v1dchenPsjp53JJb
 x5g9PZ7qlkcHXnp0cRF9K7e5AwFnR_UNt3QJ3.hlxWJs2pr__VvJ93gv8ZaFBp8NRkIk15tYSZ8Q
 jZ_s6hhFm1NNQAypXk4kn_5oZKYXAZi83m9dE72A5Qqjurqm83miRs8IqPFR8c5AgmsgOz5KetqF
 Gtjo-
Subject: [PATCH 22/23] LSM: Fix setting of the IMA data in inode init
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
Message-ID: <e5fb34e1-43ee-bee1-2751-065e8b2b083a@schaufler-ca.com>
Date: Thu, 10 May 2018 17:56:10 -0700
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
Date: Thu, 10 May 2018 16:23:47 -0700
Subject: [PATCH 22/23] LSM: Fix setting of the IMA data in inode init

Fix a missing assignment in the inode security initialization.
The EVM entry was not being set correctly.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index ef51783e967e..571643cc7256 100644
--- a/security/security.c
+++ b/security/security.c
@@ -941,6 +941,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 							&lsm_xattr->value_len);
 		if (rc == 0) {
 			lsm_xattr++;
+			evm_xattr = lsm_xattr;
 			if (ret == -EOPNOTSUPP)
 				ret = 0;
 		} else if (rc != -EOPNOTSUPP) {
@@ -950,7 +951,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	if (ret == 0) {
-		rc = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+		rc = evm_inode_init_security(inode, new_xattrs, evm_xattr);
 		if (rc == 0)
 			rc = initxattrs(inode, new_xattrs, fs_data);
 	}
-- 
2.14.3
