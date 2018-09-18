Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA81ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8910520693
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8910520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeIRITM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbeIRITM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:19:12 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B058356D4;
        Tue, 18 Sep 2018 02:48:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E71030912F4;
        Tue, 18 Sep 2018 02:48:41 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org, dyoung@redhat.com
Subject: [PATCH 0/2] x86/kexec_file: add reserved e820 ranges to the kdump kernel e820 table
Date:   Tue, 18 Sep 2018 10:48:35 +0800
Message-Id: <20180918024837.17710-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 18 Sep 2018 02:48:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E820 reserved ranges is useful in kdump kernel, we have added this in
kexec-tools code.

One reason is PCI mmconf (extended mode) requires reserved region otherwise
it falls back to legacy mode.

Furthermore, when AMD SME kdump support, it needs to map dmi table area as
unencrypted. For normal boot these ranges sit in e820 reserved ranges thus
the early ioremap code naturally map them as unencrypted. So if we have same
e820 reserve setup in kdump kernel then it will just work like normal kernel.

Kdump use walk_iomem_res_desc to iterate resources then add matched desc to
e820 table for the kdump kernel.

But IORES_DESC_NONE resource type includes several different e820 types, we
need add exact e820 type to the kdump kernel e820 table thus need an extra
checking in memmap_entry_callback to match the e820 type and resource name.

NOTE:
Before verifying this patches, you need to merge the following patch, which
uses to fix an upstream bug. For more information, you can refer to the link
below.
https://lore.kernel.org/patchwork/patch/986979/

Lianbo Jiang (2):
  x86/kexec_file: add e820 entry in case e820 type string matches to io
    resource name
  x86/kexec_file: add reserved e820 ranges to 2nd kernel e820 table

 arch/x86/include/asm/e820/api.h |  2 ++
 arch/x86/kernel/crash.c         | 12 +++++++++++-
 arch/x86/kernel/e820.c          |  2 +-
 kernel/resource.c               |  1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.17.1

