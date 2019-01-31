Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7152C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8707C20833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MNabezNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfAaDlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:41:17 -0500
Received: from mr85p00im-hyfv06021301.me.com ([17.58.23.188]:56410 "EHLO
        mr85p00im-hyfv06021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbfAaDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:41:17 -0500
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 22:41:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=04042017; t=1548905558;
        bh=UZVy6yHJjYg8dD/2zFlO6cS9OMqluVp7UP5/vdC/txQ=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=MNabezNXbX8Dox9xtRjMUut4IJRSVksqBldcQI68UO65pg5FZQR6R7YQSZ9hjZkjQ
         plR8yFUNVH2kW7tDOlUEfsf/MVT+bn27gjBMHJYTeTbswM86OLnj32/Dg/M0neq76z
         wbX+ZQoXaQwElGV5oWmoA+M1azla15VA2fnnRR3BBobX0wyJ3dx+kigqAGmz7e4EUt
         COs8/B4P4gJxVAb1yzcoQMcSZEGClTy3L+2GcCGmfuZcFp9djV7JVC6GAWBeJyMEax
         5eS/GxwZr/aHhRQOq4biSjZEKVZOmAdNxwupyNOVNmQy8tW8mqO/L7Qiv10KAfvD7V
         1t28hk8cjrAng==
Received: from [192.168.7.24] (108-64-118-141.lightspeed.frokca.sbcglobal.net [108.64.118.141])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id F16F74010C;
        Thu, 31 Jan 2019 03:32:37 +0000 (UTC)
From:   Theodore Dubois <tblodt@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: edge case in posix file lock deadlock detection
Message-Id: <8B2B011D-6E2E-4FEA-8FEE-B69D437B8547@icloud.com>
Date:   Wed, 30 Jan 2019 19:32:37 -0800
Cc:     linux-kernel@vger.kernel.org
To:     Theodore Dubois <tblodt@icloud.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=996 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1901310026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble figuring out how the kernel handles a particular case =
in deadlock detection on posix file locks. Here's the scenario:

PID 1: locks byte 2
PID 3: locks byte 0
PID 2: locks byte 10
PID 1: locks byte 10
PID 2: locks bytes 0-2 inclusive

The last step fails with EDEADLK, but I'm not sure how that is detected. =
The specified range conflicts with two different locks, and the first =
loop in posix_lock_inode would find whichever one comes first in the =
linked list, and pass that to the deadlock detector.

If the lock on byte 2 comes first in the list, a cycle would be found =
between the lock on byte 2 and the lock on byte 10. But if the lock on =
byte 0 comes first, the deadlock detector would return NULL from =
what_owner_is_waiting_for on that lock since PID 3 has no other locks, =
and immediately succeed.

What am I missing?

Thanks,
~Theodore
