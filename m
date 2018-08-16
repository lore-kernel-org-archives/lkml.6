Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97CCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FCB2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oCVgbAnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FCB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbeHPMbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:31:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46193 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbeHPMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:31:47 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180816093427epoutp02713ac4817323496242f8548d55b40d02~LU6UzFYd00538505385epoutp024;
        Thu, 16 Aug 2018 09:34:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180816093427epoutp02713ac4817323496242f8548d55b40d02~LU6UzFYd00538505385epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534412067;
        bh=TW7bJW2ZHPYQJp6BLVfJ8X5wd4TEErcn9ZkP8wrJn78=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oCVgbAnV9nyGK+RfLjbYk1S9T1nS4K1cO9dP/gmyjnQNaASw2TVl0kLdU01MTkTDI
         E4ShpU9BPaG7kIxcksD+TXUw/bvoL74RQX14eO2VdJwjHF+k4X/SjjoGVrJfetvE7U
         TvVs89jIKYuSjHSidoO/b/hNIUdJ2yToAb2T5EGY=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.197]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20180816093425epcas5p4e8867f5729109b691db2849e88a94962~LU6TNDZjg2501925019epcas5p4b;
        Thu, 16 Aug 2018 09:34:25 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.FA.04412.125457B5; Thu, 16 Aug 2018 18:34:25 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180816093424epcas2p25ede075fec715ad31108360ddca9cce8~LU6SAcb_p2671526715epcas2p2d;
        Thu, 16 Aug 2018 09:34:24 +0000 (GMT)
X-AuditID: b6c32a47-271ff7000000113c-68-5b7545217678
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B4.F3.03824.F15457B5; Thu, 16 Aug
        2018 18:34:23 +0900 (KST)
Received: from srikanthh.sa.corp.samsungelectronics.net ([107.108.218.43])
        by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PDJ00AFTRX4U110@mmp2.samsung.com>;
        Thu, 16 Aug 2018 18:34:23 +0900 (KST)
From:   Srikanth K H <srikanth.h@samsung.com>
To:     mcgrof@kernel.org, keescook@chromium.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     srikanth.h@samsung.com
Subject: [PATCH 1/1] Preventive patch in the proc file-system to handle NULL
 check.
Date:   Thu, 16 Aug 2018 15:04:13 +0530
Message-id: <1534412053-22457-1-git-send-email-srikanth.h@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZdljTQlfRtTTa4PV8QYvpjV4WZ7pzLfbs
        PclicXnXHDaLGxOeMlrsePGKyYHNY3bDRRaPnbPusntsWtXJ5tG3ZRWjx+dNcgGsUak2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUD7lRTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGQNo01srIFKgkITVj79SvTAVH2Sp2TF/I
        3MC4j7WLkZNDQsBE4sqHI0A2F4eQwA5GifOvFjNBON8ZJXqPH2GCqVqytZkRIrGBUeLmoU1Q
        Tg+TxJtfDWCz2AS0Jd7/hagSEWhglOjqPcYOkmAWkJL4c+YwkM3BISwQKvHwuDNImEVAVWL3
        /d1gG3gF3CQm/3vICLFNTuLksclgN0kIvGSV+PbuDgtEwkVi7rNjULawxKvjW9ghbGmJZ6s2
        MkI0TGaUWLZsOdTdqxkl3j3wg7DtJWYs3soMcRCfRMfhv2AHSQjwSnS0CUGUeEi8vtUJViIk
        ECtx9vZxlgmMEgsYGVYxiqUWFOempxYbFRjrFSfmFpfmpesl5+duYgSnAy33HYzbzvkcYhTg
        YFTi4X1gWBItxJpYVlyZe4hRgoNZSYT31zGgEG9KYmVValF+fFFpTmrxIUZTYBhMZJYSTc4H
        pqq8knhDUyMzMwNLMyNjC0NjJXHeKr/gaCGB9MSS1OzU1ILUIpg+Jg5OqQbG9voXL44fu2Sl
        FtclfDluFfPh8pSnq00P2+gyLni2zKBv3+RlS3t3X35i42C56e2rCYsnpUuvYMuw95C/K6qS
        uFp7Rtq9XW+V5Dmt+WrL9X5sVVI8kPD/sv5xnslOxYXFzC+17E3OnE3bKSt7JC1WZHlc4HF2
        E/GllU/5e1SbU1SbTqw8VPFRiaU4I9FQi7moOBEA/sbXYh0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJMWRmVeSWpSXmKPExsVy+t9jQV1519Jog42PrC2mN3pZnOnOtdiz
        9ySLxeVdc9gsbkx4ymix48UrJgc2j9kNF1k8ds66y+6xaVUnm0ffllWMHp83yQWwRnHZpKTm
        ZJalFunbJXBl7J36langKFvFjukLmRsY97F2MXJySAiYSCzZ2szYxcjFISSwjlHi3qRlLCAJ
        IYE+Jon+Q6UgNpuAtsT7vxBFIgINjBLdTxsZQRLMAlISf84cZu9i5OAQFgiVeHjcGSTMIqAq
        sfv+biYQm1fATWLyv4eMEMvkJE4em8w6gZFrASPDKkbJ1ILi3PTcYqMCo7zUcr3ixNzi0rx0
        veT83E2MwDDYdlirfwfj4yXxhxgFOBiVeHgfGJZEC7EmlhVX5h5ilOBgVhLh/XUMKMSbklhZ
        lVqUH19UmpNafIhRmoNFSZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoGxQHo6z2LLSJ7qV1Pm
        zq+/2vF57q0fpS+cX+RbK9Z8UzrmsO/l0bf9Qtb+dseDX2zec+JUzerIGxdbjsndjbZvXmy4
        Y+NaycJXgTNmKDk4zp+mV5L+OWHZMR1TueY9cu+Wzct8xV9yMVPeuVP3/YNQ/Vc7d2S2/jI+
        t1To5/LA+w/upLww6krbrcRSnJFoqMVcVJwIAJ2JZ0D/AQAA
X-CMS-MailID: 20180816093424epcas2p25ede075fec715ad31108360ddca9cce8
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180816093424epcas2p25ede075fec715ad31108360ddca9cce8
References: <CGME20180816093424epcas2p25ede075fec715ad31108360ddca9cce8@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the make directory for "sys" interface fail's then its
dereferenced without even checking for its validity which
will lead to crash, hence added preventive code to check
for NULL and accordingly dereference.

Signed-off-by: Srikanth K H <srikanth.h@samsung.com>
---
 fs/proc/proc_sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 89921a0..320884b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1692,6 +1692,8 @@ int __init proc_sys_init(void)
 	struct proc_dir_entry *proc_sys_root;
 
 	proc_sys_root = proc_mkdir("sys", NULL);
+	if (!proc_sys_root)
+		return -ENOMEM;
 	proc_sys_root->proc_iops = &proc_sys_dir_operations;
 	proc_sys_root->proc_fops = &proc_sys_dir_file_operations;
 	proc_sys_root->nlink = 0;
-- 
1.9.1

