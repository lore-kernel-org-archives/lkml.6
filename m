Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8548C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB8020894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q96o81I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB8020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeGaUxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:53:06 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39843 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbeGaUxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:53:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 1a2a1dc0;
        Tue, 31 Jul 2018 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id; s=mail; bh=9O+iO6j8xxV5xtWJ1AvpuoElz/M
        =; b=Q96o81I7pNzRz82ESzvsZ2fut5KWi/1hxjfxRRHBRPZmeIS/UbilhRo9ovm
        PghpwQaLquZ8l2ThmcLsG2iApY07w1ig8qDjJb+ZPfASY8UZlb7F5b5+SRlRHhdI
        W9vlmkT2pKnBpxWEx7xWxBIbY9GOvCu8EingFdglePvhJx1hBCBuzHfHncNi6Xzw
        HNRUgoFmGXNqlWyjymyr/lsgk4j6DW90+YQaCuDoPoXwQXe7f4DcAXWOauPl0TmZ
        pZBPJiPMII5hYhrWHPmr2QmAIiF1+UKmyqGVJ0vjOhMbnx7Hl23jtLhxlEzDnHaG
        iufFBtiV5FkbOzzGPLae5wm66uA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a901ad57 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 31 Jul 2018 19:00:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v1 0/3] WireGuard: Secure Network Tunnel
Date:   Tue, 31 Jul 2018 21:10:59 +0200
Message-Id: <20180731191102.2434-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is available on git.kernel.org in this branch:

  * https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log/?h=jd/wireguard

The two primary patches in it may be viewed using these temporary tags:

  * https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/commit/?h=zinc
  * https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/commit/?h=wireguard

WireGuard is a secure network tunnel written especially for Linux, which
has faced around three years of serious development, deployment, and
scrutiny. It delivers excellent performance and is extremely easy to
use and configure. It has been designed with the primary goal of being
both easy to audit by virtue of being small and highly secure from a
cryptography and systems security perspective. WireGuard is used by some
massive companies pushing enormous amounts of traffic, and likely
already today you've consumed bytes that at some point transited through
a WireGuard tunnel. Even as an out-of-tree module, WireGuard has been
integrated into various userspace tools, Linux distributions, mobile
phones, and data centers. There are ports in several languages to
several operating systems, and even commercial hardware and services
sold integrating WireGuard. It is time, therefore, for WireGuard to be
properly integrated into Linux.

Ample information, including documentation, installation instructions,
and project details, is available at:

  * https://www.wireguard.com/
  * https://www.wireguard.com/papers/wireguard.pdf

As it is currently an out-of-tree module, it lives in its own git repo
and has its own mailing list, and every commit for the module is tested
against every stable kernel since 3.10 on a variety of architectures
using an extensive test suite:

  * https://git.zx2c4.com/WireGuard
    https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/WireGuard.git/
  * https://lists.zx2c4.com/mailman/listinfo/wireguard
  * https://www.wireguard.com/build-status/

The project has been broadly discussed at conferences, and was presented
to the Netdev developers in Seoul last November, where a paper was
released detailing some interesting aspects of the project. Dave asked
me after the talk if I would consider sending in a v1 "sooner rather
than later", hence this patchset. A decision is still waiting from the
LPC network track committee, but an update on these topics may be
presented in Vancouver in a few months. Presentations:

  * https://www.wireguard.com/presentations/
  * https://www.wireguard.com/papers/wireguard-netdev22.pdf

The cryptography in the protocol itself has been formally verified by
several independent academic teams with positive results, and I know of
two additional efforts on their way to further corroborate those
findings. The version 1 protocol is "complete", and so the purpose of
this review is to assess the implementation of the protocol. However, it
still may be of interest to know that the thing you're reviewing uses a
protocol with various nice security properties:

  * https://www.wireguard.com/formal-verification/

This patchset is divided into three parts. The first is a boring commit
to random.c, which Ted approved a while back but asked me to submit it
together with WireGuard and have it enter the kernel through the net
tree. The second is a small collection of cryptographic primitives. The
third is WireGuard itself, presented as a unintrusive and self-contained
virtual network driver.

The primary pathology of this patchset is the very long lines; I have
3840 horizontal pixels on my laptop, and I enjoy using all of them.
However, if this is a problem for parent tree maintainers, I'll dutifully
wrap at 80 chars per the norm. Beyond that, the focus of WireGuard has been
on keeping things fairly simple, so I hope that this will be an enjoyable
review.

Enjoy,
Jason

-- 
2.18.0

