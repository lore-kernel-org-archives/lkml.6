Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeD3TBm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:01:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754409AbeD3TBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:01:40 -0400
Subject: [PATCH] ima: define a new policy condition based on the filesystem
 name
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>, "Theodore Ts'o" <tytso@mit.edu>
Date: Mon, 30 Apr 2018 15:01:34 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18043019-0040-0000-0000-00000453916C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18043019-0041-0000-0000-000020F7AA05
Message-Id: <1525114894.5669.5.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804300182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If/when file data signatures are distributed with the file data, this
patch will not be needed.  In the current environment where only some
files are signed, the ability to differentiate between file systems is
needed.  Some file systems consider the file system magic number
internal to the file system.

This patch defines a new IMA policy condition named "fsname", based on
the superblock's file_system_type (sb->s_type) name. This allows policy
rules to be expressed in terms of the filesystem name.

The following sample rules require file signatures on rootfs files
executed or mmap'ed.

appraise func=BPRM_CHECK fsname=rootfs appraise_type=imasig
appraise func=FILE_MMAP fsname=rootfs appraise_type=imasig

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_policy.c  | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index b8465e00ba5f..74c6702de74e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -21,7 +21,7 @@ Description:
 			audit | hash | dont_hash
 		condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=]]
+				[euid=] [fowner=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [permit_directio]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d89bebf85421..03cbba423e59 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -33,6 +33,7 @@
 #define IMA_INMASK	0x0040
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
+#define IMA_FSNAME	0x0200
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -74,6 +75,7 @@ struct ima_rule_entry {
 		void *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
+	char *fsname;
 };
 
 /*
@@ -273,6 +275,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_FSMAGIC)
 	    && rule->fsmagic != inode->i_sb->s_magic)
 		return false;
+	if ((rule->flags & IMA_FSNAME)
+	    && strcmp(rule->fsname, inode->i_sb->s_type->name))
+		return false;
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
@@ -540,7 +545,7 @@ enum {
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
@@ -565,6 +570,7 @@ static match_table_t policy_tokens = {
 	{Opt_func, "func=%s"},
 	{Opt_mask, "mask=%s"},
 	{Opt_fsmagic, "fsmagic=%s"},
+	{Opt_fsname, "fsname=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
@@ -776,6 +782,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			if (!result)
 				entry->flags |= IMA_FSMAGIC;
 			break;
+		case Opt_fsname:
+			ima_log_string(ab, "fsname", args[0].from);
+
+			entry->fsname = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->fsname) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_FSNAME;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1104,6 +1121,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_FSNAME) {
+		snprintf(tbuf, sizeof(tbuf), "%s", entry->fsname);
+		seq_printf(m, pt(Opt_fsname), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.7.5
