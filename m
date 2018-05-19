Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeESDPg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 23:15:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751700AbeESDPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 23:15:30 -0400
Date: Sat, 19 May 2018 05:15:23 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] procfs: fix mmap() for /proc/vmcore
References: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
X-TM-AS-GCONF: 00
x-cbid: 18051903-0040-0000-0000-0000043B7C27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051903-0041-0000-0000-00002640A332
Message-Id: <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805190035
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Procfs does not set max file size (s_maxbytes) and ends up with default
value of
MAX_NON_LFS	 ((1UL<<31) - 1)
Commit be83bbf80682 ("mmap: introduce sane default mmap limits")
introduced "pgoff" limits checks for mmap, considering fs max file size
as upper limit, which made it impossible to mmap /proc/vmcore file
contents above 2Gb (/proc/vmcore appears to be the only procfs file
supporting mmap).

Reuse MAX_LFS_FILESIZE as procfs s_maxbytes value.

Fixes: be83bbf80682 ("mmap: introduce sane default mmap limits")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 fs/proc/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 2cf3b74391ca..de1b3b1da883 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -502,6 +502,7 @@ int proc_fill_super(struct super_block *s, void *data, int silent)
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
 	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
+	s->s_maxbytes = MAX_LFS_FILESIZE;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = PROC_SUPER_MAGIC;
-- 
⢀⡵⣤⡴⣅  2.17.0
⠏⢟⡛⣛⠏⠇ space invaders edition
