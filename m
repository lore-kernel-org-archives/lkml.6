Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E45CC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16DF218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfAYC2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:28:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbfAYC2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:28:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B70F930EF7F;
        Fri, 25 Jan 2019 02:28:32 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C24891690C;
        Fri, 25 Jan 2019 02:28:22 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, dyoung@redhat.com, x86@kernel.org,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 0/3] Add restrictions for kexec/kdump jumping between 5-level and 4-level kernel
Date:   Fri, 25 Jan 2019 10:28:14 +0800
Message-Id: <20190125022817.29506-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 25 Jan 2019 02:28:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a RESEND post.

The original v1 post can be found here:
http://lkml.kernel.org/r/20180829141624.13985-1-bhe@redhat.com

It's trying to fix several corner case issues for kexec/kdump when
dynamic switching of paging mode is enabled in x86_64. Please click 
above link to check the details.

In v1, hpa raised concern that why the paging mode checking is not done
before kexec jumping, the discussion can be found here:

http://lkml.kernel.org/r/alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de

As tglx said, it might be not doable for kdump since kdump kernel's
reserved crashkernel region only owns a portion of memory, may
be above 4G; and might be not safer to do paging mode checking and
switching thing after crash.

So resend this patchset.

Baoquan He (3):
  x86/boot: Add bit fields into xloadflags for 5-level kernel checking
  x86/kexec/64: Error out if try to jump to old 4-level kernel from
    5-level kernel
  x86/kdump/64: Change the upper limit of crashkernel reservation

 arch/x86/boot/header.S                | 12 +++++++++++-
 arch/x86/include/uapi/asm/bootparam.h |  2 ++
 arch/x86/kernel/kexec-bzimage64.c     |  5 +++++
 arch/x86/kernel/setup.c               | 18 ++++++++++++++----
 4 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.13.6

