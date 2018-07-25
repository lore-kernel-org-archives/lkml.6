Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59CBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987A6205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987A6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeGYJ1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:27:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeGYJ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:27:38 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8B52B78;
        Wed, 25 Jul 2018 08:17:03 +0000 (UTC)
Date:   Wed, 25 Jul 2018 10:17:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] thunderbolt: Add support for runtime PM
Message-ID: <20180725081701.GA16930@kroah.com>
References: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
 <20180725080321.35746-7-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725080321.35746-7-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:03:20AM +0300, Mika Westerberg wrote:
> When Thunderbolt host controller is set to RTD3 mode (Runtime D3) it is
> present all the time. Because of this it is important to runtime suspend
> the controller whenever possible. In case of ICM we have following rules
> which all needs to be true before the host controller can be put to D3:
> 
>   - The controller firmware reports to support RTD3
>   - All the connected devices announce support for RTD3
>   - There is no active XDomain connection
> 
> Implement this using standard Linux runtime PM APIs so that when all the
> children devices are runtime suspended, the Thunderbolt host controller
> PCI device is runtime suspended as well. The ICM firmware then starts
> powering down power domains towards RTD3 but it can prevent this if it
> detects that there is an active Display Port stream (this is not visible
> to the software, though).
> 
> The Thunderbolt host controller will be runtime resumed either when
> there is a remote wake event (device is connected or disconnected), or
> when there is access from userspace that requires hardware access.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/domain.c  |  42 +++++++++++-
>  drivers/thunderbolt/icm.c     | 119 ++++++++++++++++++++++++++++++----
>  drivers/thunderbolt/nhi.c     |  38 ++++++++++-
>  drivers/thunderbolt/switch.c  |  65 +++++++++++++++++--
>  drivers/thunderbolt/tb.h      |  10 +++
>  drivers/thunderbolt/tb_msgs.h |   4 ++
>  drivers/thunderbolt/xdomain.c |  18 +++++
>  7 files changed, 276 insertions(+), 20 deletions(-)


This patch did not apply to my tree at all, what branch did you make it
against?

I've applied the others here, thanks.

greg k-h
