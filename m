Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B459BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511822084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511822084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeJEBAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:00:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEBAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:00:43 -0400
Received: from localhost (unknown [104.132.1.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3FE1727;
        Thu,  4 Oct 2018 18:06:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build,
        gmazyland@gmail.com, torvalds@linux-foundation.org, w@1wt.eu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/2] tty: erase buffers when the kernel is done with it.
Date:   Thu,  4 Oct 2018 11:06:12 -0700
Message-Id: <20181004180614.25619-1-gregkh@linuxfoundation.org>
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

v2 - addressed some review comments on the 2/2 patch.

Greg Kroah-Hartman (1):
  tty: wipe buffer if not echoing data

Linus Torvalds (1):
  tty: wipe buffer.

 drivers/tty/n_tty.c      | 20 +++++++++++++++++---
 drivers/tty/tty_buffer.c |  6 +++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.19.0

