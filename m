Return-Path: <tmricht@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZrzoZTPtz59u3yP1lneR4fuuFUwjgD6J4MwQFhpWsyWYaQjwJB0vw5Rz6ylBLqPxomHlbB0
ARC-Seal: i=1; a=rsa-sha256; t=1524816455; cv=none;
        d=google.com; s=arc-20160816;
        b=GCJz28rVaIi+Us+TxeQbmX0bH/oWIiNqc21N+c737CiLC22dyw5qqtSe3/NcLGzSFb
         XL2nwRxKX/WsavV/mPXP4SZazcF7fc4uiDhHBu7MiVg9MzOMKNpiLGseXfU0B9/a3HhD
         SvdyXEHEq592vz5fMRg84zaMeLjm2klyeZAUcGfCVgXHlMtHXp8P3YMqM2Y6HQMlpVEE
         myhPfoQxrgCpSevW73eT+xiJXvsYYC7unHpymbvz2f1dKidPLTtr4UvfCHlK4BPApESx
         Bkeq8841UHJn3HSEsEC7N60/G+TYVXNVmF2VoPPBmLdx8xJ7mZjkn+ox+vXE2We18SLn
         rgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=8GBxIlhdsR30TVwjUkXKUWhWGzQJoN5XpN7Z6imxX60=;
        b=DSEVuFARK6JoUZMsjPiorh8MoB9/iyd+uUTG/qOylBABCi3gxlDGFnuyizSeIuBAVX
         pJspr/2T7lqkUP+ohOAfaOhsIKC0LwRqbXEGrTqK/aSVV3XqWiWhgcOVG+jDbe/YXGkm
         7ACEsYE7N8JDm/7GGOveB2uIQdvxJTyGysCGYaQnueoxqokvKMm5/RP7izUY8z34T8k+
         ePH+JPwVjw1G1HMfo/hbdaQhfLDhDo/aa8MzdVbDRO4TWYhVlXHfE6+WiWN0o1yXAVhh
         5YdWEmiLL0ncBZfOyCEbD1kwTa/VLv4Sh36OQV8JgK2SaNZTaJbHxBzimgqvtI4MkfGH
         Qdpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Thomas Richter <tmricht@linux.ibm.com>
To: gregkh@linuxfoundation.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] inode: debugfs_create_dir uses mode permission from parent
Date: Fri, 27 Apr 2018 10:07:12 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18042708-0040-0000-0000-000004529F3F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042708-0041-0000-0000-000020F6AA6E
Message-Id: <20180427080712.2380-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270080
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598885939373348657?=
X-GMAIL-MSGID: =?utf-8?q?1598885939373348657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently function debugfs_create_dir() creates a new
directory in the debugfs (usually mounted /sys/kernel/debug)
with permission rwxr-xr-x. This is hard coded.

Change this to use the parent directory permission.

Fixes: edac65eaf8d5c ("debugfs: take mode-dependent parts of debugfs_get_inode() into callers")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 13b01351dd1c..80618330d86a 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -512,7 +512,10 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	if(!parent)
+		parent = debugfs_mount->mnt_root;
+	inode->i_mode = S_IFDIR | (d_inode(parent)->i_mode
+				   & (S_IRWXU | S_IRWXG));
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
-- 
2.14.3
