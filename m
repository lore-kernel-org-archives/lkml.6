Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF80FC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EA921479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EA921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeKUWjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:39:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729128AbeKUWjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:39:31 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALBx6kw056071
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 07:05:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nw5p847fp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 07:05:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Wed, 21 Nov 2018 12:05:20 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Nov 2018 12:05:17 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wALC5GXF60817580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 12:05:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EB1CA4060;
        Wed, 21 Nov 2018 12:05:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C844A405F;
        Wed, 21 Nov 2018 12:05:16 +0000 (GMT)
Received: from localhost (unknown [9.152.212.229])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Nov 2018 12:05:15 +0000 (GMT)
Date:   Wed, 21 Nov 2018 13:05:10 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH next-lockdown 1/1] debugfs: avoid EPERM when no open file
 operation defined
References: <4136.1522452584@warthog.procyon.org.uk>
 <cover.thread-bfac1b.your-ad-here.call-01542799656-ext-6093@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-bfac1b.your-ad-here.call-01542799656-ext-6093@work.hours>
X-TM-AS-GCONF: 00
x-cbid: 18112112-0008-0000-0000-000002963F3F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112112-0009-0000-0000-000022006F52
Message-Id: <patch-1.thread-bfac1b.git-bfac1b60354c.your-ad-here.call-01542799656-ext-6093@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With "debugfs: Restrict debugfs when the kernel is locked down"
return code "r" is unconditionally set to -EPERM, which stays like that
until function return if no "open" file operation defined, effectivelly
resulting in "Operation not permitted" for all such files despite kernel
lock down status or CONFIG_LOCK_DOWN_KERNEL being enabled.

In particular this breaks 2 debugfs files on s390:
/sys/kernel/debug/s390_hypfs/diag_304
/sys/kernel/debug/s390_hypfs/diag_204

To address that set EPERM return code only when debugfs_is_locked_down
returns true.

Fixes: 3fc322605158 ("debugfs: Restrict debugfs when the kernel is locked down")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 fs/debugfs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 51cb894c21f2..89c86faaa02a 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -167,9 +167,10 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 
 	real_fops = debugfs_real_fops(filp);
 
-	r = -EPERM;
-	if (debugfs_is_locked_down(inode, filp, real_fops))
+	if (debugfs_is_locked_down(inode, filp, real_fops)) {
+		r = -EPERM;
 		goto out;
+	}
 
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
@@ -296,9 +297,10 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
-	r = -EPERM;
-	if (debugfs_is_locked_down(inode, filp, real_fops))
+	if (debugfs_is_locked_down(inode, filp, real_fops)) {
+		r = -EPERM;
 		goto out;
+	}
 
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
-- 
2.18.0.13.gd42ae10

