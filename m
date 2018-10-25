Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33ADC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2092083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3173EfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2092083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJZEmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbeJZEmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:42:02 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCCB20834;
        Thu, 25 Oct 2018 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540498073;
        bh=eyIobkJUoHAa2IUccYhd0jPz+nDkz8l1cih0JD7q38E=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=M3173EfA8uh0SzcTEy+Rl1X45xrv6iFgSk8ztUFXoi7A/ScFyXSyI1V3z940sVjgs
         AYCgyq59wSzEcm6AJJpHVJJo7BTIztsOVLyU0p0WVV1T613CIy8X5jmIZVmpSse/RP
         L2Zp/H0rC7PT5T1Q1ZvVP2KBv6ym/iLwH/J9P0GU=
Date:   Thu, 25 Oct 2018 16:07:51 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH AUTOSEL 4.4 08/65] btrfs: cleaner_kthread() doesn't need
 explicit freeze
Message-ID: <20181025200751.GB1693@sasha-vm>
References: <20181025141705.213937-1-sashal@kernel.org>
 <20181025141705.213937-8-sashal@kernel.org>
 <20181025150729.GD16290@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181025150729.GD16290@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 05:07:29PM +0200, David Sterba wrote:
>On Thu, Oct 25, 2018 at 10:16:08AM -0400, Sasha Levin wrote:
>> From: Jiri Kosina <jkosina@suse.cz>
>>
>> [ Upstream commit 838fe1887765f4cc679febea60d87d2a06bd300e ]
>>
>> cleaner_kthread() is not marked freezable, and therefore calling
>> try_to_freeze() in its context is a pointless no-op.
>>
>> In addition to that, as has been clearly demonstrated by 80ad623edd2d
>> ("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()"), it's perfectly
>> valid / legal for cleaner_kthread() to stay scheduled out in an arbitrary
>> place during suspend (in that particular example that was waiting for
>> reading of extent pages), so there is no need to leave any traces of
>> freezer in this kthread.
>>
>> Fixes: 80ad623edd2d ("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()")
>> Fixes: 696249132158 ("btrfs: clear PF_NOFREEZE in cleaner_kthread()")
>> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>IIRC it was some preparatory work for livepatching.  I did a quick check
>if this is safe for 4.4 and would say yes, but the patch does not fix
>anything so IMO this does not need to go to stable.

Doesn't that also affect hibernation and such?

--
Thanks,
Sasha
