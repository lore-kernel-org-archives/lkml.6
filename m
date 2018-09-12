Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8473E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8473E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeILSoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:44:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726836AbeILSoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:44:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDB59AF53;
        Wed, 12 Sep 2018 13:39:33 +0000 (UTC)
Date:   Wed, 12 Sep 2018 15:39:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com, osalvador@suse.de
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Message-ID: <20180912133933.GI10951@dhcp22.suse.cz>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
 <20180912150356.642c1dab@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912150356.642c1dab@thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-09-18 15:03:56, Gerald Schaefer wrote:
[...]
> BTW, those sysfs attributes are world-readable, so anyone can trigger
> the panic by simply reading them, or just run lsmem (also available for
> x86 since util-linux 2.32). OK, you need a special not-memory-block-aligned
> mem= parameter and DEBUG_VM for poison check, but w/o DEBUG_VM you would
> still access uninitialized struct pages. This sounds very wrong, and I
> think it really should be fixed.

Ohh, absolutely. Nobody is questioning that. The thing is that the
code has been likely always broken. We just haven't noticed because
those unitialized parts where zeroed previously. Now that the implicit
zeroying is gone it is just visible.

All that I am arguing is that there are many places which assume
pageblocks to be fully initialized and plugging one place that blows up
at the time is just whack a mole. We need to address this much earlier.
E.g. by allowing only full pageblocks when adding a memory range.
-- 
Michal Hocko
SUSE Labs
