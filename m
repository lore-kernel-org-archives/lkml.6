Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542DDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241BD2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241BD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbeK3BXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbeK3BXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:23 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gSN8V-0006xt-BU; Thu, 29 Nov 2018 15:17:47 +0100
Date:   Thu, 29 Nov 2018 15:17:47 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Subject: MPX is broken for 32bit programs on a 64bit host
Message-ID: <20181129141746.5p5ed7c6rip5qswp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so I've been testing my FPU patches and noticed that the test
mpx-mini-test_32 [0] fails on 64bit host.
I went back to v4.4 and it didn't pass there fully, it ended with:
| starting mpx bounds table test
| ERROR: siginfo bounds do not match shadow bounds for register 0

But it did way more than it does today. Since commit 1b028f784e8c3
("x86/mm: Introduce mmap_compat_base() for 32-bit mmap()") it is broken
and ends very early with

| mpx dig (  1) complete, SUCCESS (       0 /    0)
| #BR status == 2, missing bounds table,kernel should have handled!!

The 64bit cases passes. Didn't try the 32bit test case on a 32bit host.
Maybe the test case is fishy (I can't tell).

This is broken since v4.12-rc1. This is known [1] since April this year.
Should I send a removal patch for MPX or is someone actually going to
fix this? Or do we wait for gcc-9 to be released?

[0] tools/testing/selftests/x86/mpx-mini-test_32
[1] https://lkml.kernel.org/r/20180428175043.y35czmhcursyrzsy@gmail.com

Sebastian
