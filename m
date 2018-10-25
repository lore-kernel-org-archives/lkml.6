Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61303C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2821D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2821D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJYXkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:40:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727502AbeJYXkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:40:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 542E6AD72;
        Thu, 25 Oct 2018 15:07:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11253DABAA; Thu, 25 Oct 2018 17:07:30 +0200 (CEST)
Date:   Thu, 25 Oct 2018 17:07:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH AUTOSEL 4.4 08/65] btrfs: cleaner_kthread() doesn't need
 explicit freeze
Message-ID: <20181025150729.GD16290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>
References: <20181025141705.213937-1-sashal@kernel.org>
 <20181025141705.213937-8-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025141705.213937-8-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:16:08AM -0400, Sasha Levin wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> [ Upstream commit 838fe1887765f4cc679febea60d87d2a06bd300e ]
> 
> cleaner_kthread() is not marked freezable, and therefore calling
> try_to_freeze() in its context is a pointless no-op.
> 
> In addition to that, as has been clearly demonstrated by 80ad623edd2d
> ("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()"), it's perfectly
> valid / legal for cleaner_kthread() to stay scheduled out in an arbitrary
> place during suspend (in that particular example that was waiting for
> reading of extent pages), so there is no need to leave any traces of
> freezer in this kthread.
> 
> Fixes: 80ad623edd2d ("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()")
> Fixes: 696249132158 ("btrfs: clear PF_NOFREEZE in cleaner_kthread()")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

IIRC it was some preparatory work for livepatching.  I did a quick check
if this is safe for 4.4 and would say yes, but the patch does not fix
anything so IMO this does not need to go to stable.
