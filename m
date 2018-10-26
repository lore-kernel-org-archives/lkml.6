Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CD520824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CD520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeJZPiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:38:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbeJZPiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:38:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E9B0AE58;
        Fri, 26 Oct 2018 07:02:25 +0000 (UTC)
Date:   Fri, 26 Oct 2018 08:58:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
cc:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.4 08/65] btrfs: cleaner_kthread() doesn't need
 explicit freeze
In-Reply-To: <20181025200751.GB1693@sasha-vm>
Message-ID: <nycvar.YFH.7.76.1810260857260.23511@cbobk.fhfr.pm>
References: <20181025141705.213937-1-sashal@kernel.org> <20181025141705.213937-8-sashal@kernel.org> <20181025150729.GD16290@suse.cz> <20181025200751.GB1693@sasha-vm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018, Sasha Levin wrote:

> >> cleaner_kthread() is not marked freezable, and therefore calling
> >> try_to_freeze() in its context is a pointless no-op.
> >>
> >> In addition to that, as has been clearly demonstrated by 80ad623edd2d
> >> ("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()"), it's perfectly
> >> valid / legal for cleaner_kthread() to stay scheduled out in an arbitrary
> >> place during suspend (in that particular example that was waiting for
> >> reading of extent pages), so there is no need to leave any traces of
> >> freezer in this kthread.
> >>
> >> Fixes: 80ad623edd2d ("Revert "btrfs: clear PF_NOFREEZE in
> >> Fixes: cleaner_kthread()")
> >> Fixes: 696249132158 ("btrfs: clear PF_NOFREEZE in cleaner_kthread()")
> >> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> >> Signed-off-by: David Sterba <dsterba@suse.com>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >IIRC it was some preparatory work for livepatching.  I did a quick check
> >if this is safe for 4.4 and would say yes, but the patch does not fix
> >anything so IMO this does not need to go to stable.
> 
> Doesn't that also affect hibernation and such?

This patch just removes pointless try_to_freeze(), that's guaranteed not 
to do anything and return immediately, as the btrfs kthread is not 
freezable.
So I don't think it's needed in stable; the semantics is equivalent before 
and after.

Thanks,

-- 
Jiri Kosina
SUSE Labs

