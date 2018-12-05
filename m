Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003622084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003622084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeLEM3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:29:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:48608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727138AbeLEM3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:29:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10752ADA9;
        Wed,  5 Dec 2018 12:29:20 +0000 (UTC)
Date:   Wed, 5 Dec 2018 13:29:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <OSalvador@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to
 be offlined
Message-ID: <20181205122918.GL1286@dhcp22.suse.cz>
References: <20181203100309.14784-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203100309.14784-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 11:03:09, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> We have received a bug report that an injected MCE about faulty memory
> prevents memory offline to succeed. The underlying reason is that the
> HWPoison page has an elevated reference count and the migration keeps
> failing. There are two problems with that. First of all it is dubious
> to migrate the poisoned page because we know that accessing that memory
> is possible to fail. Secondly it doesn't make any sense to migrate a
> potentially broken content and preserve the memory corruption over to a
> new location.
> 
> Oscar has found out that it is the elevated reference count from
> memory_failure that is confusing the offlining path. HWPoisoned pages
> are isolated from the LRU list but __offline_pages might still try to
> migrate them if there is any preceding migrateable pages in the pfn
> range. Such a migration would fail due to the reference count but
> the migration code would put it back on the LRU list. This is quite
> wrong in itself but it would also make scan_movable_pages stumble over
> it again without any way out.
> 
> This means that the hotremove with hwpoisoned pages has never really
> worked (without a luck). HWPoisoning really needs a larger surgery
> but an immediate and backportable fix is to skip over these pages during
> offlining. Even if they are still mapped for some reason then
> try_to_unmap should turn those mappings into hwpoison ptes and cause
> SIGBUS on access. Nobody should be really touching the content of the
> page so it should be safe to ignore them even when there is a pending
> reference count.

After some more thinking I am not really sure the above reasoning is
still true with the current upstream kernel. Maybe I just managed to
confuse myself so please hold off on this patch for now. Testing by
Oscar has shown this patch is helping but the changelog might need to be
updated.
-- 
Michal Hocko
SUSE Labs
