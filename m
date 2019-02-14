Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8856222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390827AbfBNKTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:19:38 -0500
Received: from relay.sw.ru ([185.231.240.75]:42436 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfBNKTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:19:37 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1guE79-0004zP-Jo; Thu, 14 Feb 2019 13:19:31 +0300
Subject: Re: [PATCH 1/4] mm: Move recent_rotated pages calculation to
 shrink_inactive_list()
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
 <154998444053.18704.14821278988281142015.stgit@localhost.localdomain>
 <20190213173327.uhexilxmmztx7fbt@ca-dmjordan1.us.oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <057454bf-5f49-2043-9197-68f99a0501a4@virtuozzo.com>
Date:   Thu, 14 Feb 2019 13:19:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213173327.uhexilxmmztx7fbt@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2019 20:33, Daniel Jordan wrote:
> On Tue, Feb 12, 2019 at 06:14:00PM +0300, Kirill Tkhai wrote:
>> Currently, struct reclaim_stat::nr_activate is a local variable,
>> used only in shrink_page_list(). This patch introduces another
>> local variable pgactivate to use instead of it, and reuses
>> nr_activate to account number of active pages.
>>
>> Note, that we need nr_activate to be an array, since type of page
>> may change during shrink_page_list() (see ClearPageSwapBacked()).
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/vmstat.h |    2 +-
>>  mm/vmscan.c            |   15 +++++++--------
> 
> include/trace/events/vmscan.h needs to account for the array-ification of
> nr_activate too.

Yeah, thanks.
