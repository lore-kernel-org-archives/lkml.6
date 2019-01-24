Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A54C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F17A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Vp9BWMMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfAXQJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:09:38 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39586 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfAXQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:09:38 -0500
Received: by mail-yb1-f194.google.com with SMTP id s17so2574587ybp.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cGQ/TMSWGm6i6QwmVNwOtbEz6FvQrTiXlzQK44rHJwA=;
        b=Vp9BWMMNtSD8xSzhnjEWyK0/Ha4ZrmqLfO7rXLLtXOYMU6a5cu7VVhnyEe8K2lx2I1
         /rfcdNbrUq1qGtrnNo3W8bcy/7whXZ+wPvxFaBn4lNJ35C48xU8cfqmJs7PBzVTBE1PU
         VqdUExIZne/b7ck8gktsq9gjbmK6VSzEocsS8MF+941BDqwcdCht1y+Sov8y6iEyBc7L
         wVLvILvIkOQoHBQEQAD8r2B1RsPLkuHQCgTxmTknmdIuZGpUGeC24ObTfdYapJuoOBru
         EWvTKEnOvE/3v7nz9v9Lbfzu2ViuHKN1YOFWKMSUfAkfgBsV4fh89kgL/iYCAA2MDmSN
         Tv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cGQ/TMSWGm6i6QwmVNwOtbEz6FvQrTiXlzQK44rHJwA=;
        b=WtdATx21FZwvlKi+zhKSbyVmjZryGcaJgpJOqBhnk0N0asug64xHqIvy7bjfMf2tmM
         igS8KmI6luF2unX2m78q7d0XqduW0GgD9Iylj00mChxcsJAc5IB3jnjRtyNNCN8RNLIV
         jaP+b+zQg672m1A/TqmN9FgdSZWIyE8lu/sxdVuDrVaHHleyLjrD5HdtPnOIUJHtVgwo
         U4hPGcLi5/N+quWkwyaQsAOQu2oXyKd0A4RycORt9SaRxqksaSbWJlPynDrl/nrYd2TK
         oadI7YWmU2yjM0AAmLm+G1L0hVi8L98fxnWFYJQOKht4AQ/jtoopgq91KNDoJSLX4zP4
         48OQ==
X-Gm-Message-State: AJcUukeejhroZmg+ygDvGNTcs1XIBNC83OywPf1MXTkAfQHm6JzuYzHc
        1t0mxRK3oOsNF5eEUTVYp8mqD98XSIU=
X-Google-Smtp-Source: ALg8bN7AAhc+roSq4xD7zrOyYO2G3qAXC5OMDqKLkcL3ehaRbayvXhiy0r8loeIhJ734/buxb5luhg==
X-Received: by 2002:a5b:a89:: with SMTP id h9mr6466531ybq.409.1548346177229;
        Thu, 24 Jan 2019 08:09:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:9b5d])
        by smtp.gmail.com with ESMTPSA id s35sm12295052ywa.19.2019.01.24.08.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 08:09:36 -0800 (PST)
Date:   Thu, 24 Jan 2019 11:09:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: Move maxable seq_file logic into a single place
Message-ID: <20190124160935.GB12436@cmpxchg.org>
References: <20190124061718.GA15486@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124061718.GA15486@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 01:17:18AM -0500, Chris Down wrote:
> memcg has a significant number of files exposed to kernfs where their
> value is either exposed directly or is "max" in the case of
> PAGE_COUNTER_MAX.
> 
> There's a fair amount of duplicated code here, since each file involves
> turning a seq_file to a css, getting the memcg from the css, safely
> reading the counter value, and then doing the right thing depending on
> whether the value is PAGE_COUNTER_MAX or not.
> 
> This patch adds the macro DEFINE_MEMCG_MAX_OR_VAL, which defines and
> implements a generic way to do this work, avoiding fragmenting logic.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com
> ---
> mm/memcontrol.c | 78 ++++++++++++-------------------------------------
> 1 file changed, 18 insertions(+), 60 deletions(-)

I think this increases complexity more than it saves LOC,
unfortunately.

The current situation is a bit repetitive, but much more obviously
correct. And we're not planning on adding many more of those memcg
interface files, so I this doesn't seem to be an improvement re:
maintainability and future extensibility of the code.
