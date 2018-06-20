Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703A6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B2220874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B2220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeFTLzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:55:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753475AbeFTLzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:55:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5992BADE3;
        Wed, 20 Jun 2018 11:55:32 +0000 (UTC)
Date:   Wed, 20 Jun 2018 13:55:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-mm@kvack.org, rientjes@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Message-ID: <20180620115531.GL13685@dhcp22.suse.cz>
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 20:20:38, Tetsuo Handa wrote:
> Sleeping with oom_lock held can cause AB-BA lockup bug because
> __alloc_pages_may_oom() does not wait for oom_lock. Since
> blocking_notifier_call_chain() in out_of_memory() might sleep, sleeping
> with oom_lock held is currently an unavoidable problem.

Could you be more specific about the potential deadlock? Sleeping while
holding oom lock is certainly not nice but I do not see how that would
result in a deadlock assuming that the sleeping context doesn't sleep on
the memory allocation obviously.

> As a preparation for not to sleep with oom_lock held, this patch brings
> OOM notifier callbacks to outside of OOM killer, with two small behavior
> changes explained below.

Can we just eliminate this ugliness and remove it altogether? We do not
have that many notifiers. Is there anything fundamental that would
prevent us from moving them to shrinkers instead?
-- 
Michal Hocko
SUSE Labs
