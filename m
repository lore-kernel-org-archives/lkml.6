Return-Path: <tmricht@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZpvRpfIhbsngA6gHYHfVE2g9GN4sOwekghW+fffw8A8nOm5H9zRUAczQqPh0387MI5iXsmO
ARC-Seal: i=1; a=rsa-sha256; t=1524832560; cv=none;
        d=google.com; s=arc-20160816;
        b=ZDtIygTAPzven7qJkJprnHHt8NYMri7/ppUhCn3I/9VS1v3e/a3/NIT1V7yVR1HGzv
         T74eGfbfAQlqzKMWjz2wPJThRDK08/BxEv5WciMhT2MKsNnQ1ENShLwA9p2zSvaVV5bQ
         V3mjeWfWBWTHM8sd9nXnNCKR46Nc3INmG/Pa4dJfXinop4FZMSWIC976ZX3n07Ep5yMe
         1AAuDwCDZ+xtIhl+J7TlykpfoOFaWxhWTKlIglutPQd+XPOwSaNYMbNlcRd/7eQRd1pi
         evuksyEpL28hm3NF4WBB/+Pc4epdMlUDuliSoQZyyBy3hwJBlZ4ZZO4/xU1FtmVaYrPM
         PSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:date:subject:cc
         :to:from:arc-authentication-results;
        bh=C0RMs7oEBa6yYHbjGjgWFhqwIkcYzzPIfgW24ruZFe8=;
        b=m16CfeTL6U3p4hiel3fFYCENgRY4hTjm07MbOqsEJFFPz2n6NqTY0pISQKExfPoygk
         q6VcgqQKnX5hkGOqKgPaasJK7SMtMONwKYWTNR6x+ifLjEPIgKGZklaidQlnvMO/SvcM
         BBceR1CfROyr/ZJNqcRJ7q72KYGvMX7nqFhT8Jxg3CiGXBT3ZBbdM1uZ397D6M7eMczo
         gfzyVH+YkVWyG5M9vZi8T4RqfqEL2+2tUwfXRjhKWD3YT2YGxb2BcB6eUz3FgTgpaN1V
         oiDY3udyT+3WIbxtPLL8ijjm8Vf5vUR4fu/G3/ZoKf8bkl0D6Qe4bG6zLS+YbDmcZ+Ng
         dpmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Thomas Richter <tmricht@linux.ibm.com>
To: gregkh@linuxfoundation.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] debugfs: inode: debugfs_create_dir uses mode permission from parent
Date: Fri, 27 Apr 2018 14:35:47 +0200
X-Mailer: git-send-email 2.13.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042712-0040-0000-0000-00000433B864
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042712-0041-0000-0000-00002637C584
Message-Id: <20180427123547.15727-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270121
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598885939373348657?=
X-GMAIL-MSGID: =?utf-8?q?1598902827130524624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently function debugfs_create_dir() creates a new
directory in the debugfs (usually mounted /sys/kernel/debug)
with permission rwxr-xr-x. This is hard coded.

Change this to use the parent directory permission.

Output before the patch:
root@s8360047 ~]# tree -dp -L 1 /sys/kernel/debug/
/sys/kernel/debug/
├── [drwxr-xr-x]  bdi
├── [drwxr-xr-x]  block
├── [drwxr-xr-x]  dasd
├── [drwxr-xr-x]  device_component
├── [drwxr-xr-x]  extfrag
├── [drwxr-xr-x]  hid
├── [drwxr-xr-x]  kprobes
├── [drwxr-xr-x]  kvm
├── [drwxr-xr-x]  memblock
├── [drwxr-xr-x]  pm_qos
├── [drwxr-xr-x]  qdio
├── [drwxr-xr-x]  s390
├── [drwxr-xr-x]  s390dbf
└── [drwx------]  tracing

14 directories
[root@s8360047 linux]#

Output after the patch:
[root@s8360047 ~]# tree -dp -L 1 /sys/kernel/debug/
sys/kernel/debug/
├── [drwx------]  bdi
├── [drwx------]  block
├── [drwx------]  dasd
├── [drwx------]  device_component
├── [drwx------]  extfrag
├── [drwx------]  hid
├── [drwx------]  kprobes
├── [drwx------]  kvm
├── [drwx------]  memblock
├── [drwx------]  pm_qos
├── [drwx------]  qdio
├── [drwx------]  s390
├── [drwx------]  s390dbf
└── [drwx------]  tracing

14 directories
[root@s8360047 linux]#

Here is the full diff output done with:
[root@s8360047 ~]# diff -u treefull.before treefull.after |
	sed 's-^- # -' > treefull.diff
 # --- treefull.before	2018-04-27 13:22:04.532824564 +0200
 # +++ treefull.after	2018-04-27 13:24:12.106182062 +0200
 # @@ -1,55 +1,55 @@
 #  /sys/kernel/debug/
 # -├── [drwxr-xr-x]  bdi
 # -│   ├── [drwxr-xr-x]  1:0
 # -│   ├── [drwxr-xr-x]  1:1
 # -│   ├── [drwxr-xr-x]  1:10
 # -│   ├── [drwxr-xr-x]  1:11
 # -│   ├── [drwxr-xr-x]  1:12
 # -│   ├── [drwxr-xr-x]  1:13
 # -│   ├── [drwxr-xr-x]  1:14
 # -│   ├── [drwxr-xr-x]  1:15
 # -│   ├── [drwxr-xr-x]  1:2
 # -│   ├── [drwxr-xr-x]  1:3
 # -│   ├── [drwxr-xr-x]  1:4
 # -│   ├── [drwxr-xr-x]  1:5
 # -│   ├── [drwxr-xr-x]  1:6
 # -│   ├── [drwxr-xr-x]  1:7
 # -│   ├── [drwxr-xr-x]  1:8
 # -│   ├── [drwxr-xr-x]  1:9
 # -│   └── [drwxr-xr-x]  94:0
 # -├── [drwxr-xr-x]  block
 # -├── [drwxr-xr-x]  dasd
 # -│   ├── [drwxr-xr-x]  0.0.e18a
 # -│   ├── [drwxr-xr-x]  dasda
 # -│   └── [drwxr-xr-x]  global
 # -├── [drwxr-xr-x]  device_component
 # -├── [drwxr-xr-x]  extfrag
 # -├── [drwxr-xr-x]  hid
 # -├── [drwxr-xr-x]  kprobes
 # -├── [drwxr-xr-x]  kvm
 # -├── [drwxr-xr-x]  memblock
 # -├── [drwxr-xr-x]  pm_qos
 # -├── [drwxr-xr-x]  qdio
 # -│   └── [drwxr-xr-x]  0.0.f5f2
 # -├── [drwxr-xr-x]  s390
 # -│   └── [drwxr-xr-x]  stsi
 # -├── [drwxr-xr-x]  s390dbf
 # -│   ├── [drwxr-xr-x]  0.0.e18a
 # -│   ├── [drwxr-xr-x]  cio_crw
 # -│   ├── [drwxr-xr-x]  cio_msg
 # -│   ├── [drwxr-xr-x]  cio_trace
 # -│   ├── [drwxr-xr-x]  dasd
 # -│   ├── [drwxr-xr-x]  kvm-trace
 # -│   ├── [drwxr-xr-x]  lgr
 # -│   ├── [drwxr-xr-x]  qdio_0.0.f5f2
 # -│   ├── [drwxr-xr-x]  qdio_error
 # -│   ├── [drwxr-xr-x]  qdio_setup
 # -│   ├── [drwxr-xr-x]  qeth_card_0.0.f5f0
 # -│   ├── [drwxr-xr-x]  qeth_control
 # -│   ├── [drwxr-xr-x]  qeth_msg
 # -│   ├── [drwxr-xr-x]  qeth_setup
 # -│   ├── [drwxr-xr-x]  vmcp
 # -│   └── [drwxr-xr-x]  vmur
 # +├── [drwx------]  bdi
 # +│   ├── [drwx------]  1:0
 # +│   ├── [drwx------]  1:1
 # +│   ├── [drwx------]  1:10
 # +│   ├── [drwx------]  1:11
 # +│   ├── [drwx------]  1:12
 # +│   ├── [drwx------]  1:13
 # +│   ├── [drwx------]  1:14
 # +│   ├── [drwx------]  1:15
 # +│   ├── [drwx------]  1:2
 # +│   ├── [drwx------]  1:3
 # +│   ├── [drwx------]  1:4
 # +│   ├── [drwx------]  1:5
 # +│   ├── [drwx------]  1:6
 # +│   ├── [drwx------]  1:7
 # +│   ├── [drwx------]  1:8
 # +│   ├── [drwx------]  1:9
 # +│   └── [drwx------]  94:0
 # +├── [drwx------]  block
 # +├── [drwx------]  dasd
 # +│   ├── [drwx------]  0.0.e18a
 # +│   ├── [drwx------]  dasda
 # +│   └── [drwx------]  global
 # +├── [drwx------]  device_component
 # +├── [drwx------]  extfrag
 # +├── [drwx------]  hid
 # +├── [drwx------]  kprobes
 # +├── [drwx------]  kvm
 # +├── [drwx------]  memblock
 # +├── [drwx------]  pm_qos
 # +├── [drwx------]  qdio
 # +│   └── [drwx------]  0.0.f5f2
 # +├── [drwx------]  s390
 # +│   └── [drwx------]  stsi
 # +├── [drwx------]  s390dbf
 # +│   ├── [drwx------]  0.0.e18a
 # +│   ├── [drwx------]  cio_crw
 # +│   ├── [drwx------]  cio_msg
 # +│   ├── [drwx------]  cio_trace
 # +│   ├── [drwx------]  dasd
 # +│   ├── [drwx------]  kvm-trace
 # +│   ├── [drwx------]  lgr
 # +│   ├── [drwx------]  qdio_0.0.f5f2
 # +│   ├── [drwx------]  qdio_error
 # +│   ├── [drwx------]  qdio_setup
 # +│   ├── [drwx------]  qeth_card_0.0.f5f0
 # +│   ├── [drwx------]  qeth_control
 # +│   ├── [drwx------]  qeth_msg
 # +│   ├── [drwx------]  qeth_setup
 # +│   ├── [drwx------]  vmcp
 # +│   └── [drwx------]  vmur
 #  └── [drwx------]  tracing
 #      ├── [drwxr-xr-x]  events
 #      │   ├── [drwxr-xr-x]  alarmtimer

Fixes: edac65eaf8d5c ("debugfs: take mode-dependent parts of debugfs_get_inode() into callers")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/debugfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 13b0135..a913b12 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -512,7 +512,9 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	if (!parent)
+		parent = debugfs_mount->mnt_root;
+	inode->i_mode = S_IFDIR | ((d_inode(parent)->i_mode & 0770));
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
-- 
2.9.3
