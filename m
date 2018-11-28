Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC17C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E2C2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E2C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeK2DVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3559 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbeK2DVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:21:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 029E37F6B2;
        Wed, 28 Nov 2018 16:19:24 +0000 (UTC)
Received: from krava (unknown [10.40.205.15])
        by smtp.corp.redhat.com (Postfix) with SMTP id ADE096838D;
        Wed, 28 Nov 2018 16:19:21 +0000 (UTC)
Date:   Wed, 28 Nov 2018 17:19:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: Re: [PATCH v3] perf symbols: Cannot disassemble some routines when
 debuginfo present
Message-ID: <20181128161920.GD13589@krava>
References: <1543422934-1228-1-git-send-email-eric.saint.etienne@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543422934-1228-1-git-send-email-eric.saint.etienne@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 28 Nov 2018 16:19:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 08:35:34AM -0800, Eric Saint-Etienne wrote:
> When the kernel is compiled with -ffunction-sections and perf uses the
> kernel debuginfo, perf fails the very first symbol lookup and ends up with
> an hex offset inside [kernel.vmlinux]. It's due to how perf loads the maps.
> 
> Indeed only .text gets loaded by map_groups__find() into al->map.
> Consequently al->map address range encompass the whole kernel image.
> But then map__load() loads many function maps by splitting al->map,
> which reduces al->map range drastically. Very likely the target address is
> then in one of those newly created function maps, so we need to lookup the
> map again to find that new map.
> 
> I'm not sure if this issue is only specific to the kernel but at least it
> occurs withe the kernel dso, and when we're not using the kernel debuginfo,
> perf will fallback to using kallsyms and then the first lookup will work.
> 
> The split of .text section happens in dso_process_kernel_symbol() where we
> call map_groups__find_by_name() to find an existing map, but with
> -ffunction-sections and a symbol belonging to a new (function) map, such
> map doesn't exist yet so we end up creating one and adjusting existing maps
> accordingly because adjust_kernel_syms is set there.
> 
> This patch makes sure that the event address we're looking-up is indeed
> within the map we've found, otherwise we lookup another map again.
> Only one extra lookup at most is required for the proper map to be found,
> if it exists.
> 
> Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
