Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeEBVvq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:51:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41644 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeEBVvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:51:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <james.l.morris@oracle.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 02 May 2018 16:49:16 -0500
Message-ID: <87r2mtybhf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDzeC-0007yJ-Vx;;;mid=<87r2mtybhf.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/1k2r2I5uA4PLbvCpZ1pQUyRunfTd9bHU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 210 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (1.4%), b_tie_ro: 2.0 (1.0%), parse: 0.93 (0.4%),
        extract_message_metadata: 22 (10.6%), get_uri_detail_list: 2.2 (1.0%),
        tests_pri_-1000: 10 (4.8%), tests_pri_-950: 1.24 (0.6%), tests_pri_-900: 1.00
        (0.5%), tests_pri_-400: 23 (10.9%), check_bayes: 22 (10.4%), b_tokenize: 7
        (3.2%), b_tok_get_all: 7 (3.4%), b_comp_prob: 2.1 (1.0%), b_tok_touch_all:
        3.0 (1.4%), b_finish: 0.66 (0.3%), tests_pri_0: 141 (67.2%),
        check_dkim_signature: 0.61 (0.3%), check_dkim_adsp: 2.5 (1.2%),
        tests_pri_500: 4.8 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] evm: Don't update hmacs in user ns mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seth Forshee <seth.forshee@canonical.com>
Date: Fri, 22 Dec 2017 15:32:35 +0100

The kernel should not calculate new hmacs for mounts done by
non-root users. Update evm_calc_hmac_or_hash() to refuse to
calculate new hmacs for mounts for non-init user namespaces.

Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: James Morris <james.l.morris@oracle.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

Mimi this patch has been floating around for a while and it appears to
be the only piece missing from the vfs to make unprivileged mounts safe
(at least semantically).  Do you want to merge this through your integrity
tree or should merge this through my userns tree?

 security/integrity/evm/evm_crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a46fba322340..facf9cdd577d 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -200,7 +200,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	int size;
 	bool ima_present = false;
 
-	if (!(inode->i_opflags & IOP_XATTR))
+	if (!(inode->i_opflags & IOP_XATTR) ||
+	    inode->i_sb->s_user_ns != &init_user_ns)
 		return -EOPNOTSUPP;
 
 	desc = init_desc(type);
-- 
2.14.1
