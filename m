Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D51C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04A217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfAVP5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:57:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbfAVP5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:57:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E837A87622;
        Tue, 22 Jan 2019 15:57:31 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 932381019637;
        Tue, 22 Jan 2019 15:57:30 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org
Cc:     Balbir Singh <bsingharora@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: [PATCH 0/4] powerpc/livepatch: reliable stack unwinder fixes
Date:   Tue, 22 Jan 2019 10:57:20 -0500
Message-Id: <20190122155724.27557-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 22 Jan 2019 15:57:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a false negative report (ie, unreliable) from the
ppc64 reliable stack unwinder, discussed here [1] when it may
inadvertently trip over a stale exception marker left on the stack.

The first two patches fix this bug.  Nicolai's change clears the marker
from the stack when an exception is finished.  The next patch modifies
the unwinder to only look for such on stack elements when the ABI
guarantees that they will actually be initialized.

The final two patches consist of code cleanups that Nicolai and I
spotted during the development of the fixes.

Testing included re-running the original test scenario (loading a
livepatch module on ppc64le) on a 5.0.0-rc2 kernel as well as a RHEL-7
backport.  I ran internal tests on the RHEL-7 backport and no new test
failures were introduced.  I believe that Nicolai has done the same
with respect to the first patch.

[1] https://lore.kernel.org/lkml/7f468285-b149-37e2-e782-c9e538b997a9@redhat.com/

Joe Lawrence (3):
  powerpc/livepatch: relax reliable stack tracer checks for first-frame
  powerpc/livepatch: small cleanups in save_stack_trace_tsk_reliable()
  powerpc/livepatch: return -ERRNO values in
    save_stack_trace_tsk_reliable()

Nicolai Stange (1):
  powerpc/64s: Clear on-stack exception marker upon exception return

 arch/powerpc/Kconfig             |  2 +-
 arch/powerpc/kernel/entry_64.S   |  7 +++
 arch/powerpc/kernel/stacktrace.c | 74 +++++++++++++++++---------------
 3 files changed, 47 insertions(+), 36 deletions(-)

-- 
2.20.1

