Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478D3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE93218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbfBFMxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:53:32 -0500
Received: from mail.pantelija.rs ([3.17.35.93]:44290 "EHLO mail.pantelija.rs"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfBFMx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:53:29 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 07:53:28 EST
Received: from [192.168.7.11] (cable-178-148-85-173.dynamic.sbb.rs [178.148.85.173])
        by mail.pantelija.rs (Postfix) with ESMTPS id 0D4F360324
        for <linux-kernel@vger.kernel.org>; Wed,  6 Feb 2019 13:45:32 +0100 (CET)
To:     linux-kernel@vger.kernel.org
From:   Dragan Milenkovic <dragan.milenkovic@pantelija.rs>
Subject: [BUG] Deadlock in block/blk-flush.c, with resolution
Message-ID: <8a90744a-8e2d-21b9-c88a-818991b3b753@pantelija.rs>
Date:   Wed, 6 Feb 2019 13:45:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bug manifests by mdX_raid1 and other related tasks being blocked.

It is triggered by LVM RAID, but is not caused by it. I have also 
triggered it by LVM + mdraid, but only once. It is more frequent by
LVM RAID.

It does not occur in the master branch, but it does in 4.20.y, 4.19.y, 
4.18.y. Here is a Debian bug report:
     https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=913119

I have tracked it to this commit:

 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=344e9ffcbd1898e1dc04085564a6e05c30ea8199

Specifically to this line:

 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/block/blk-flush.c?id=344e9ffcbd1898e1dc04085564a6e05c30ea8199

The commit log message makes it appear as if this is a refactoring 
change, but the check for q->elevator was inverted.

The line has not been changed between that commit and the current master 
branch. Since I applied this change to my distribution's kernel (4.19), 
my system has been completely stable.

Let me know if you need me to do anything else, but this seems as a 
straight-forward cherry-pick.

Dragan

