Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C13C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07A920817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07A920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeKGNBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:01:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:52112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbeKGNBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:01:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB7B9B69E;
        Wed,  7 Nov 2018 03:32:40 +0000 (UTC)
Date:   Tue, 6 Nov 2018 19:32:34 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181107033234.djng6kas4tjkevln@linux-r8p5>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
 <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Nov 2018, Andrew Morton wrote:

>It would be interesting to know precisely which stat fields the
>database-which-shall-not-be-named is looking for.  Then we could cook
>up a very whizzy way of getting at the info.

The ctxt field, afaik. In any case they have been able to work around
the bottleneck. I'm not sure if that is the case for Waiman, however.

>
>A downside of the stat2 approach is that applications will need to be
>rebuilt.  And hopefully when people do this, they'll open
>"/etc/my-app-name/symlink-to-proc-stat" (or use per-application config)
>so they won't need a rebuild when we add /proc/stat3!
>
>A /proc/change-how-stat-works tunable would avoid the need to rebuild
>applications.  But if a system still has some applications which want
>the irq info then that doesn't work.
>
>It's all very sad, really.
>
>btw,
>
>> +The stat2 file acts as a performance alternative to /proc/stat for workloads
>> +and systems that care and are under heavy irq load. In order to to be completely
>> +compatible, /proc/stat and /proc/stat2 are identical with the exception that the
>> +later will show 0 for any (hard)irq-related fields. This refers particularly
>
>"latter"
>
>> +to the "intr" line and 'irq' column for that aggregate in the cpu line.
>
>btw2, please quantify "poor performance".  That helps us determine how
>much we care about all of this!

Up to a quarter of a second is what was reported as being spent every time
/proc/stat is used. This is with 1k cores and 4k interrupts.

Thanks,
Davidlohr
