Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B50C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7811A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfAVURr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVURr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:17:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 746AC13AA9;
        Tue, 22 Jan 2019 20:17:47 +0000 (UTC)
Received: from redhat.com (ovpn-124-136.rdu2.redhat.com [10.10.124.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F944504;
        Tue, 22 Jan 2019 20:17:46 +0000 (UTC)
Date:   Tue, 22 Jan 2019 15:17:44 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [LSF/MM TOPIC] Page flags, can we free up space ?
Message-ID: <20190122201744.GA3939@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 22 Jan 2019 20:17:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So lattely i have been looking at page flags and we are using 6 flags
for memory reclaim and compaction:

    PG_referenced
    PG_lru
    PG_active
    PG_workingset
    PG_reclaim
    PG_unevictable

On top of which you can add the page anonymous flag (anonymous or
share memory)
    PG_anon // does not exist, lower bit of page->mapping

And also the movable flag (which alias with KSM)
    PG_movable // does not exist, lower bit of page->mapping


So i would like to explore if there is a way to express the same amount
of information with less bits. My methodology is to exhaustively list
all the possible states (valid combination of above flags) and then to
see how we change from one state to another (what event trigger the change
like mlock(), page being referenced, ...) and under which rules (ie do we
hold the page lock, zone lock, ...).

My hope is that there might be someway to use less bits to express the
same thing. I am doing this because for my work on generic page write
protection (ie KSM for file back page) which i talk about last year and
want to talk about again ;) I will need to unalias the movable bit from
KSM bit.


Right now this is more a temptative ie i do not know if i will succeed,
in any case i can report on failure or success and discuss my finding to
get people opinions on the matter.


I think everyone interested in mm will be interested in this topic :)

Cheers,
Jérôme
