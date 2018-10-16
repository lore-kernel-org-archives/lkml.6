Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DD1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2502E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2502E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJPM16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:27:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42976 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeJPM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:27:58 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B8DC014513042;
        Mon, 15 Oct 2018 21:39:28 -0700 (PDT)
Date:   Mon, 15 Oct 2018 21:39:28 -0700 (PDT)
Message-Id: <20181015.213928.1979135633281436819.davem@davemloft.net>
To:     wang6495@umn.edu
Cc:     kjlu@umn.edu, f.fainelli@gmail.com, keescook@chromium.org,
        ilyal@mellanox.com, ecree@solarflare.com,
        ynorov@caviumnetworks.com, alan.brady@intel.com,
        eugenia@mellanox.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool: fix a missing-check bug
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1539090940-5323-1-git-send-email-wang6495@umn.edu>
References: <1539090940-5323-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 21:39:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>
Date: Tue,  9 Oct 2018 08:15:38 -0500

> In ethtool_get_rxnfc(), the eth command 'cmd' is compared against
> 'ETHTOOL_GRXFH' to see whether it is necessary to adjust the variable
> 'info_size'. Then the whole structure of 'info' is copied from the
> user-space buffer 'useraddr' with 'info_size' bytes. In the following
> execution, 'info' may be copied again from the buffer 'useraddr' depending
> on the 'cmd' and the 'info.flow_type'. However, after these two copies,
> there is no check between 'cmd' and 'info.cmd'. In fact, 'cmd' is also
> copied from the buffer 'useraddr' in dev_ethtool(), which is the caller
> function of ethtool_get_rxnfc(). Given that 'useraddr' is in the user
> space, a malicious user can race to change the eth command in the buffer
> between these copies. By doing so, the attacker can supply inconsistent
> data and cause undefined behavior because in the following execution 'info'
> will be passed to ops->get_rxnfc().
> 
> This patch adds a necessary check on 'info.cmd' and 'cmd' to confirm that
> they are still same after the two copies in ethtool_get_rxnfc(). Otherwise,
> an error code EINVAL will be returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Applied.
