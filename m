Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2852FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBB221726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167772;
	bh=cn7LNfa3uzNUcxcOIVUvfue+JbDet6t+ypTWBrUUU08=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zfo1/pejCaGcWybpnMceIMka4eLf1A4/fcrYYpgMDiF65ZAlOVqlgVq3/a5f4ZhpE
	 x44uxM6wbf6pBs6wOS7brOIhmGr27qjfxDkCPbQa6//XFmnCDaT6lgnL25U5YGO+Qy
	 AmvDwhQpz8viZ2Y4xYzyfSJ1vzM5GzVXnqpTzzEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfAVOgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbfAVOgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:36:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B86320854;
        Tue, 22 Jan 2019 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167769;
        bh=cn7LNfa3uzNUcxcOIVUvfue+JbDet6t+ypTWBrUUU08=;
        h=From:To:Cc:Subject:Date:From;
        b=ZdFlLYl2XZsRGYyWmFrP2RPIhJoLYN+h6AZJj4Y+mM8fnGw/vAjvdNZ61Usd8zM5f
         hqFB+82bkB1kY4natNGi17lfZkxkkm4qf2j55ghBDtQVuBZe8U5+Wldh/SKlRSpAMn
         mN1nJlEV2incfXM5e3LE2tJYskJUgRX9KCyVnkQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/6] x86: cleanup debugfs usage
Date:   Tue, 22 Jan 2019 15:35:36 +0100
Message-Id: <20190122143542.8816-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs code, there is no need to ever check the return
value of the call, as no logic should ever change if a call works
properly or not.  Fix up a bunch of x86-specific code to not care about
the results of debugfs.

Greg Kroah-Hartman (6):
  x86: mce: no need to check return value of debugfs_create functions
  x86: kdebugfs: no need to check return value of debugfs_create
    functions
  x86: kvm: no need to check return value of debugfs_create functions
  x86: mm: no need to check return value of debugfs_create functions
  x86: platform: no need to check return value of debugfs_create
    functions
  x86: xen: no need to check return value of debugfs_create functions

 arch/x86/kernel/cpu/mce/core.c            | 15 ++----
 arch/x86/kernel/cpu/mce/inject.c          | 34 ++-----------
 arch/x86/kernel/cpu/mce/severity.c        | 14 ++----
 arch/x86/kernel/kdebugfs.c                | 60 +++++------------------
 arch/x86/kvm/debugfs.c                    | 26 +++-------
 arch/x86/mm/debug_pagetables.c            | 35 +++----------
 arch/x86/platform/atom/punit_atom_debug.c | 22 ++-------
 arch/x86/platform/intel-quark/imr.c       | 14 ++----
 arch/x86/platform/intel/iosf_mbi.c        | 21 ++------
 arch/x86/platform/uv/tlb_uv.c             | 15 +-----
 arch/x86/xen/debugfs.c                    |  7 +--
 arch/x86/xen/p2m.c                        |  3 --
 12 files changed, 52 insertions(+), 214 deletions(-)

-- 
2.20.1

