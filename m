Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B1C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4598F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeILSiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:38:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILSiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:38:51 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g05Ha-0001Ap-RZ; Wed, 12 Sep 2018 15:34:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: [RFC PATCH] x86: load FPU registers on return to userland
Date:   Wed, 12 Sep 2018 15:33:43 +0200
Message-Id: <20180912133353.20595-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a refurbished series originally started by by Rik van Riel. The
goal is load the FPU registers on return to userland and not on every
context switch. By this optimisation we can:
- avoid loading the registers if the task stays in kernel and does
  not return to userland
- make kernel_fpu_begin() cheaper: it only saves the registers on the
  first invocation. The second invocation does not need save them again.

To access the FPU registers in kernel we need:
- disable preemption to avoid that the scheduler switches tasks. By
  doing so it would set TIF_LOAD_FPU and the FPU registers would be not
  valid.
- disable BH because the softirq might use kernel_fpu_begin() and then
  set TIF_LOAD_FPU instead loading the FPU registers on completion.

This seems to work with userland & xmm registers. Haven't tested the
pkeys feature and KVM yet.

Sebastian


