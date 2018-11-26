Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293512086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1jGU2zkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293512086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeKZQcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:32:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbeKZQcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:32:23 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA5720865;
        Mon, 26 Nov 2018 05:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543210764;
        bh=MHJ40c/M8AjWvQ+eMGXCALPA84Vt3Wdf3OI+BRO7ELU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1jGU2zkdumOzwIiwyDi0GD/6t2pFOa6CpLvaTr3jv12UZaFxJMEs8E//mqKanULo5
         BR7f0CiMEeJf2IthpaltTr3miy1Pogauxb+6INcFYwvcBZQxpgyKvplLqdIKJjUfqe
         S0r0sRVKRWJHpWABVJ5baK7vZ4gj2UFZOf9VYp0s=
Date:   Mon, 26 Nov 2018 00:39:19 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, ohering@suse.com,
        James.Bottomley@HansenPartnership.com, hch@infradead.org,
        linux-scsi@vger.kernel.org, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, martin.petersen@oracle.com, hare@suse.de,
        Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: Fix a race in sub-channel creation that
 can cause panic
Message-ID: <20181126053919.GB34679@sasha-vm>
References: <20181126002617.7398-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181126002617.7398-1-kys@linuxonhyperv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:26:17AM +0000, kys@linuxonhyperv.com wrote:
>From: Dexuan Cui <decui@microsoft.com>
>
>We can concurrently try to open the same sub-channel from 2 paths:
>
>path #1: vmbus_onoffer() -> vmbus_process_offer() -> handle_sc_creation().
>path #2: storvsc_probe() -> storvsc_connect_to_vsp() ->
>	 -> storvsc_channel_init() -> handle_multichannel_storage() ->
>	 -> vmbus_are_subchannels_present() -> handle_sc_creation().
>
>They conflict with each other, but it was not an issue before the recent
>commit ae6935ed7d42 ("vmbus: split ring buffer allocation from open"),
>because at the beginning of vmbus_open() we checked newchannel->state so
>only one path could succeed, and the other would return with -EINVAL.
>
>After ae6935ed7d42, the failing path frees the channel's ringbuffer by
>vmbus_free_ring(), and this causes a panic later.
>
>Commit ae6935ed7d42 itself is good, and it just reveals the longstanding
>race. We can resolve the issue by removing path #2, i.e. removing the
>second vmbus_are_subchannels_present() in handle_multichannel_storage().
>
>BTW, the comment "Check to see if sub-channels have already been created"
>in handle_multichannel_storage() is incorrect: when we unload the driver,
>we first close the sub-channel(s) and then close the primary channel, next
>the host sends rescind-offer message(s) so primary->sc_list will become
>empty. This means the first vmbus_are_subchannels_present() in
>handle_multichannel_storage() is never useful.
>
>Fixes: ae6935ed7d42 ("vmbus: split ring buffer allocation from open")
>Cc: stable@vger.kernel.org
>Cc: Long Li <longli@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: K. Y. Srinivasan <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

Just a heads-up: ae6935ed7d42 ("vmbus: split ring buffer allocation from
open") was merged in the 4.20 merge window, so this fix won't actually
apply to any of the current stable trees.

However, it's good to have tags (fixes + cc: stable) here since this fix
might end up (for whatever reason) getting merged only for 4.21, which
will then make these tags relevant.

--
Thanks,
Sasha
