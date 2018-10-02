Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900A3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAF42064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAF42064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJCABg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:01:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJCABg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:01:36 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A414EB8;
        Tue,  2 Oct 2018 17:17:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build,
        gmazyland@gmail.com, torvalds@linux-foundation.org, w@1wt.eu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] tty: erase buffers when the kernel is done with it.
Date:   Tue,  2 Oct 2018 10:17:06 -0700
Message-Id: <20181002171708.1311-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

azlig and Milan Broz reported that when the tty layer is done with a
buffer, the data can hang around in it for a very long time.  That
sometimes can "leak" to userspace under some conditions.

Because of this, just zero out the data after the tty layer is finished
with it, for buffers that we "think" should be zeroed out.

Greg Kroah-Hartman (1):
  tty: wipe buffer if not echoing data

Linus Torvalds (1):
  tty: wipe buffer.

 drivers/tty/n_tty.c      | 20 +++++++++++++++++---
 drivers/tty/tty_buffer.c |  6 +++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.19.0

