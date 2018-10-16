Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E16C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5012083E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5012083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJPM1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:27:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeJPM1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:27:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F376514513042;
        Mon, 15 Oct 2018 21:39:18 -0700 (PDT)
Date:   Mon, 15 Oct 2018 21:39:18 -0700 (PDT)
Message-Id: <20181015.213918.1656394276439267836.davem@davemloft.net>
To:     wang6495@umn.edu
Cc:     kjlu@umn.edu, f.fainelli@gmail.com, keescook@chromium.org,
        andrew@lunn.ch, ecree@solarflare.com, ilyal@mellanox.com,
        ynorov@caviumnetworks.com, alan.brady@intel.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool: fix a privilege escalation bug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1539013777-1625-1-git-send-email-wang6495@umn.edu>
References: <1539013777-1625-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 21:39:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>
Date: Mon,  8 Oct 2018 10:49:35 -0500

> In dev_ethtool(), the eth command 'ethcmd' is firstly copied from the
> use-space buffer 'useraddr' and checked to see whether it is
> ETHTOOL_PERQUEUE. If yes, the sub-command 'sub_cmd' is further copied from
> the user space. Otherwise, 'sub_cmd' is the same as 'ethcmd'. Next,
> according to 'sub_cmd', a permission check is enforced through the function
> ns_capable(). For example, the permission check is required if 'sub_cmd' is
> ETHTOOL_SCOALESCE, but it is not necessary if 'sub_cmd' is
> ETHTOOL_GCOALESCE, as suggested in the comment "Allow some commands to be
> done by anyone". The following execution invokes different handlers
> according to 'ethcmd'. Specifically, if 'ethcmd' is ETHTOOL_PERQUEUE,
> ethtool_set_per_queue() is called. In ethtool_set_per_queue(), the kernel
> object 'per_queue_opt' is copied again from the user-space buffer
> 'useraddr' and 'per_queue_opt.sub_command' is used to determine which
> operation should be performed. Given that the buffer 'useraddr' is in the
> user space, a malicious user can race to change the sub-command between the
> two copies. In particular, the attacker can supply ETHTOOL_PERQUEUE and
> ETHTOOL_GCOALESCE to bypass the permission check in dev_ethtool(). Then
> before ethtool_set_per_queue() is called, the attacker changes
> ETHTOOL_GCOALESCE to ETHTOOL_SCOALESCE. In this way, the attacker can
> bypass the permission check and execute ETHTOOL_SCOALESCE.
> 
> This patch enforces a check in ethtool_set_per_queue() after the second
> copy from 'useraddr'. If the sub-command is different from the one obtained
> in the first copy in dev_ethtool(), an error code EINVAL will be returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Applied and queued up for -stable.
