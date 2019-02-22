Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57361206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfBVTok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:44:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57082 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfBVToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:44:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BE2E414A86563;
        Fri, 22 Feb 2019 11:44:38 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:44:38 -0800 (PST)
Message-Id: <20190222.114438.657594655581302475.davem@davemloft.net>
To:     vlomovtsev@marvell.com
Cc:     sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com
Subject: Re: [PATCH v3 0/8] nic: thunderx: fix communication races between
 VF & PF
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
        <20190220110225.9497-1-vlomovtsev@marvell.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Feb 2019 11:44:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <vlomovtsev@marvell.com>
Date: Wed, 20 Feb 2019 11:02:42 +0000

> The ThunderX CN88XX NIC Virtual Function driver uses mailbox interface
> to communicate to physical function driver. Each of VF has it's own pair
> of mailbox registers to read from and write to. The mailbox registers
> has no protection from possible races, so it has to be implemented
> at software side.
> 
> After long term testing by loop of 'ip link set <ifname> up/down'
> command it was found that there are two possible scenarios when
> race condition appears:
>  1. VF receives link change message from PF and VF send RX mode
> configuration message to PF in the same time from separate thread.
>  2. PF receives RX mode configuration from VF and in the same time,
> in separate thread PF detects link status change and sends appropriate
> message to particular VF.
> 
> Both cases leads to mailbox data to be rewritten, NIC VF messaging control
> data to be updated incorrectly and communication sequence gets broken.
> 
> This patch series is to address race condition with VF & PF communication.
> 
> Changes:
> v1 -> v2
>  - 0000: correct typo in cover letter subject: 'betwen' -> 'between';
>  - move link state polling request task from pf to vf 
>    instead of cheking status of mailbox irq;
> v2 -> v3
>  - 0003: change return type of nicvf_send_cfg_done() function
>    from int to void;
>  - 0007: update subject and remove unused variable 'netdev'
>    from nicvf_link_status_check_task() function;

Series applied, thanks.
