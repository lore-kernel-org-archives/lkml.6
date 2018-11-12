Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B87C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF0E2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF0E2241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeKMAzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:55:48 -0500
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:44135 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726385AbeKMAzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:55:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 094B718227D91;
        Mon, 12 Nov 2018 15:02:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: moon00_8728da11fe052
X-Filterd-Recvd-Size: 2014
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Nov 2018 15:02:08 +0000 (UTC)
Message-ID: <6cc250180e2cea8726a08c35f1020b200cc2bd5e.camel@perches.com>
Subject: Re: [PATCH RFC] locking/lockdep: replace simple printk by pr_info
From:   Joe Perches <joe@perches.com>
To:     Corentin Labbe <clabbe@baylibre.com>, mingo@redhat.com,
        peterz@infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 12 Nov 2018 07:02:07 -0800
In-Reply-To: <1542027794-2255-1-git-send-email-clabbe@baylibre.com>
References: <1542027794-2255-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 13:03 +0000, Corentin Labbe wrote:
> While working on detector of new warn/err/crit/... messages, I found that the
> following messages was printed with the warn loglevel:
> [    0.001607] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.001625] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.001641] ... MAX_LOCK_DEPTH:          48
> [    0.001658] ... MAX_LOCKDEP_KEYS:        8191
> [    0.001673] ... CLASSHASH_SIZE:          4096
> [    0.001689] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.001704] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.001719] ... CHAINHASH_SIZE:          32768
> [    0.001735]  memory used by lock dependency info: 4623 kB
> 
> While the cause is still unknown to me, converting printk to pr_info fixed the issue.

because in lib/Kconfig.debug

config MESSAGE_LOGLEVEL_DEFAULT
	int "Default message log level (1-7)"
	range 1 7
	default "4"
	help
	  Default log level for printk statements with no specified priority.

	  This was hard-coded to KERN_WARNING since at least 2.6.10 but folks
	  that are auditing their logs closely may want to set it to a lower
	  priority.


