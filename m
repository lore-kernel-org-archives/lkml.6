Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Zx3hOOR1HVvzPgAAmS7hNA
	; Sun, 10 Jun 2018 19:35:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E113560791; Sun, 10 Jun 2018 19:35:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6BA72606FA;
	Sun, 10 Jun 2018 19:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BA72606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753732AbeFJTfy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 15:35:54 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41470 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbeFJTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 15:35:52 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 04CE0136AA24D;
        Sun, 10 Jun 2018 12:35:51 -0700 (PDT)
Date: Sun, 10 Jun 2018 12:35:51 -0700 (PDT)
Message-Id: <20180610.123551.885190586229525170.davem@davemloft.net>
To: Vadim.Lomovtsev@caviumnetworks.com
Cc: rric@kernel.org, sgoutham@cavium.com,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com,
        Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH] net: thunderx: prevent concurrent data re-writing by
 nicvf_set_rx_mode
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Jun 2018 12:35:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Fri,  8 Jun 2018 02:27:59 -0700

> +	/* Save message data locally to prevent them from
> +	 * being overwritten by next ndo_set_rx_mode call().
> +	 */
> +	spin_lock(&nic->rx_mode_wq_lock);
> +	mode = vf_work->mode;
> +	mc = vf_work->mc;
> +	vf_work->mc = NULL;
> +	spin_unlock(&nic->rx_mode_wq_lock);

At the moment you drop this lock, the memory behind 'mc' can be
freed up by:

> +	spin_lock(&nic->rx_mode_wq_lock);
> +	kfree(nic->rx_mode_work.mc);

And you'll crash when you dereference it above via
__nicvf_set_rx_mode_task().
