Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A4AECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494A520856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVf6srx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494A520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeJZTdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeJZTdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:33:50 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607F02085B;
        Fri, 26 Oct 2018 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540551432;
        bh=PiPQm0YofBWdO7bNuXW32BYcKZKaGyRLyYzjcYKiD8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVf6srx/1StTIDJa8va/O6Yjw8RyRK2/MQOR5aPdnoJuH+YeiLdTNyWmYowuoFfZ8
         ZiN588tfkIrU1sXhzgDAAu1g5nQSGiW0GjXycnqsoXnSxugkgtALBy8gMnogKUHLJW
         0cVp1dB1SvpfE8StMtuuxqaRMVBM7X+NKv3zU8/Y=
Date:   Fri, 26 Oct 2018 06:57:10 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.4 08/65] btrfs: cleaner_kthread() doesn't need
 explicit freeze
Message-ID: <20181026105710.GD2015@sasha-vm>
References: <20181025141705.213937-1-sashal@kernel.org>
 <20181025141705.213937-8-sashal@kernel.org>
 <20181025150729.GD16290@suse.cz>
 <20181025200751.GB1693@sasha-vm>
 <nycvar.YFH.7.76.1810260857260.23511@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1810260857260.23511@cbobk.fhfr.pm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:58:57AM +0200, Jiri Kosina wrote:
>On Thu, 25 Oct 2018, Sasha Levin wrote:
>
>> >> cleaner_kthread() is not marked freezable, and therefore calling
>> >> try_to_freeze() in its context is a pointless no-op.
>> >>
>> >> In addition to that, as has been clearly demonstrated by 80ad623edd2d
>> >> ("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()"), it's perfectly
>> >> valid / legal for cleaner_kthread() to stay scheduled out in an arbitrary
>> >> place during suspend (in that particular example that was waiting for
>> >> reading of extent pages), so there is no need to leave any traces of
>> >> freezer in this kthread.
>> >>
>> >> Fixes: 80ad623edd2d ("Revert "btrfs: clear PF_NOFREEZE in
>> >> Fixes: cleaner_kthread()")
>> >> Fixes: 696249132158 ("btrfs: clear PF_NOFREEZE in cleaner_kthread()")
>> >> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>> >> Signed-off-by: David Sterba <dsterba@suse.com>
>> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> >
>> >IIRC it was some preparatory work for livepatching.  I did a quick check
>> >if this is safe for 4.4 and would say yes, but the patch does not fix
>> >anything so IMO this does not need to go to stable.
>>
>> Doesn't that also affect hibernation and such?
>
>This patch just removes pointless try_to_freeze(), that's guaranteed not
>to do anything and return immediately, as the btrfs kthread is not
>freezable.
>So I don't think it's needed in stable; the semantics is equivalent before
>and after.

Gotcha. I'll drop it. Thank you!

--
Thanks,
Sasha
