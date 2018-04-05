Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeDERnE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:43:04 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:47326 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750786AbeDERnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:43:03 -0400
From: Debabrata Banerjee <dbanerje@akamai.com>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc: dbanerje@akamai.com, Daniel Lezcano <daniel.lezcano@free.fr>
Subject: [PATCH] Fix /proc/[pid]/ns permissions
Date: Thu,  5 Apr 2018 13:15:02 -0400
Message-Id: <20180405171502.14347-1-dbanerje@akamai.com>
X-Mailer: git-send-email 2.16.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=972
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804050177
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=939 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804050177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems like a bug since the original commit 6b4e306aa3dc. Having ns
directory be executable but not readable does not make sense. Further,
it breaks userspace when it needs to know which namespace it belongs
to. For example, setting a process to prctl(PR_SET_DUMPABLE, 0)
immediately hides the namespace from that user, breaking the latest
pgrep with namespace support.

The main problem here is that unlike other namespaces, pid namespaces
appear flat as you follow the parents upwards in the heirarchy. It is
important to be able to tell that a process is in your namespace, a
child namespace, or an entirely different namespace. In the latter
case, the pid is already hidden from you, thus these permission don't
matter.

CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Daniel Lezcano <daniel.lezcano@free.fr>

Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d53246863cfb..2295ac0d8e1c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2922,7 +2922,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
 	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
 	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
-	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
+	DIR("ns",	  S_IRUGO|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
 #endif
-- 
2.16.2
