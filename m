Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70152086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70152086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIKRkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:40:16 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:7541 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbeIKRkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:40:15 -0400
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
To:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20180910215622.4428-1-guro@fb.com>
 <20180911121141.GS10951@dhcp22.suse.cz>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <0ea4cdbd-dc3f-1b66-8a5f-8d67ab0e2bc9@sony.com>
Date:   Tue, 11 Sep 2018 14:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911121141.GS10951@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 02:11 PM, Michal Hocko wrote:
> Why is this a problem though? IIRC this event was deliberately placed
> outside of the oom path because we wanted to count allocation failures
> and this is also documented that way
>
>           oom
>                 The number of time the cgroup's memory usage was
>                 reached the limit and allocation was about to fail.
>
>                 Depending on context result could be invocation of OOM
>                 killer and retrying allocation or failing a
>
> One could argue that we do not apply the same logic to GFP_NOWAIT
> requests but in general I would like to see a good reason to change
> the behavior and if it is really the right thing to do then we need to
> update the documentation as well.
>

Why not introduce a MEMCG_ALLOC_FAIL in to memcg_memory_event?
