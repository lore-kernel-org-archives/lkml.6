Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759F8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7B220684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7B220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeGSOLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:11:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731577AbeGSOLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:11:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58B617A7E5;
        Thu, 19 Jul 2018 13:28:38 +0000 (UTC)
Received: from krava (ovpn-204-211.brq.redhat.com [10.40.204.211])
        by smtp.corp.redhat.com (Postfix) with SMTP id 52D9D1C5B9;
        Thu, 19 Jul 2018 13:28:35 +0000 (UTC)
Date:   Thu, 19 Jul 2018 15:28:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] perf/core: fix a possible deadlock scenario
Message-ID: <20180719132834.GF18667@krava>
References: <20180716215101.4713-1-xiyou.wangcong@gmail.com>
 <20180718081905.GA13520@krava>
 <CAM_iQpVX_9C42Wh+ydti=droRz_Xs_Cv4ovVcg4nqu+n1OScKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpVX_9C42Wh+ydti=droRz_Xs_Cv4ovVcg4nqu+n1OScKg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 13:28:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 13:28:38 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:21:11PM -0700, Cong Wang wrote:

SNIP

> > hum, the swevent pmu does not triger NMI, so that timer
> > will never be touched in NMI context
> 
> Good to know! So I worry too much here.
> 
> But still, given hrtimer interrupt is called with IRQ disabled, getting
> stuck in a hrtimer callback could also block IPI handler, therefore
> causing soft lockups.
> 
> Let me know if you want me to adjust the changelog for this.

yep, it's confusing, I think it should be removed from changelog

jirka
