Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9234BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB0620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfA1Ru7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:50:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfA1Ru4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:50:56 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D08CF2541;
        Mon, 28 Jan 2019 17:50:55 +0000 (UTC)
Date:   Mon, 28 Jan 2019 09:50:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm, memory_hotplug: fix uninitialized pages
 fallouts.
Message-Id: <20190128095054.4103093dec81f1c904df7929@linux-foundation.org>
In-Reply-To: <20190128144506.15603-1-mhocko@kernel.org>
References: <20190128144506.15603-1-mhocko@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 15:45:04 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> Mikhail has posted fixes for the two bugs quite some time ago [1]. I
> have pushed back on those fixes because I believed that it is much
> better to plug the problem at the initialization time rather than play
> whack-a-mole all over the hotplug code and find all the places which
> expect the full memory section to be initialized. We have ended up with
> 2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full
> memory section") merged and cause a regression [2][3]. The reason is
> that there might be memory layouts when two NUMA nodes share the same
> memory section so the merged fix is simply incorrect.
> 
> In order to plug this hole we really have to be zone range aware in
> those handlers. I have split up the original patch into two. One is
> unchanged (patch 2) and I took a different approach for `removable'
> crash. It would be great if Mikhail could test it still works for his
> memory layout.
> 
> [1] http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1666948
> [3] http://lkml.kernel.org/r/20190125163938.GA20411@dhcp22.suse.cz

Any thoughts on which kernel version(s) need these patches?
