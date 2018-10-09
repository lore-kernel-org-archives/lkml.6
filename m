Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5B6C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF512087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF512087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJIXWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:22:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbeJIXWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:22:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A030B06E;
        Tue,  9 Oct 2018 16:04:23 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id C7368A1041; Tue,  9 Oct 2018 18:04:21 +0200 (CEST)
Date:   Tue, 9 Oct 2018 18:04:21 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Edward Cree <ecree@solarflare.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Alan Brady <alan.brady@intel.com>,
        Eugenia Emantayev <eugenia@mellanox.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ethtool: fix a missing-check bug
Message-ID: <20181009160421.GC9504@unicorn.suse.cz>
References: <1539090940-5323-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539090940-5323-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 08:15:38AM -0500, Wenwen Wang wrote:
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

Do you have an example how userspace could abuse the race to make kernel
do something bad which it couldn't with the patch? I could think of only
two or three potentially problematic scenarios:

1. Userspace changes cmd to a value which would not have been dispatched
into ethtool_get_rxnfc() otherwise. While this is unfortunate, existing
in-tree ethtool::get_rxnfc() handlers would only return -EOPNOTSUPP or
-EINVAL in such case so no harm done.

2. Userspace uses ETHTOOL_GRXFH with FLOW_RSS not set in flow_type but
then switches cmd to other subcommand so that ethtool_ops::get_rxnfc()
handler is called with only partially initialized info and some garbage
in the rest. However, unless this new cmd is completely wrong (case 1
above), userspace could have sent exactly the same garbage directly.

3. The "garbage" might be leftover data which could leak into userspace
on return. However, as ethtool_get_rxnfc() would still use "short" value
of info_size, it would have to leak indirectly by affecting the value of
info.flow_type or info.data which seems rather theoretical.

Did I miss something?

I don't want to say that the check shouldn't be added, I'm just not
convinced that the reasoning in commit message is correct.

Michal Kubecek

> 
> This patch adds a necessary check on 'info.cmd' and 'cmd' to confirm that
> they are still same after the two copies in ethtool_get_rxnfc(). Otherwise,
> an error code EINVAL will be returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  net/core/ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> index c9993c6..0136625 100644
> --- a/net/core/ethtool.c
> +++ b/net/core/ethtool.c
> @@ -1015,6 +1015,9 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
>  			return -EINVAL;
>  	}
>  
> +	if (info.cmd != cmd)
> +		return -EINVAL;
> +
>  	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
>  		if (info.rule_cnt > 0) {
>  			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
> -- 
> 2.7.4
> 
