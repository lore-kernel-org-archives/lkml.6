Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB63C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C4D2147D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C4D2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbeHIQ6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:58:54 -0400
Received: from [195.159.176.226] ([195.159.176.226]:36235 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbeHIQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:58:54 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1fnlyM-00044c-Ap
        for linux-kernel@vger.kernel.org; Thu, 09 Aug 2018 16:31:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Subject: Re: [PATCH] netfilter: nf_queue: Replace conntrack entry
Date:   Thu, 9 Aug 2018 17:09:37 +0300
Message-ID: <vhut3f-tel.ln1@banana.localnet>
References: <20180503140745.26588-1-kristian.evensen@gmail.com>
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.2.1-20140504 ("Tober an Righ") (UNIX) (Linux/4.3.3-bananian (armv7l))
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.comp.security.firewalls.netfilter.devel Kristian Evensen <kristian.evensen@gmail.com> wrote:
> SKBs are assigned a conntrack entry before being passed to any NFQUEUEs,
> and if no entry is found then a new one is created. This behavior causes
> problems for some traffic patterns. For example, if two UDP packets
> to/from the same host (using the same ports) arrive at the "same" time,
> both are assigned a new conntrack entry. After the first packet have
> traversed all chains, the conntrack entry will be inserted into the
> global table. The second packet will then be dropped during the
> insertion step, as an entry for the same flow already exists. One type
> of application that frequently generates this traffic pattern, is DNS
> resolvers.

> This commit introduces a new function that checks, and potentially
> replaces, the conntrack entry for any additional "new" SKBs mapping to
> an existing flow. While not a perfect solution, there are still
> situations where to-be-dropped SKBs can slip through, the situations is
> improved considerably. On the routers I have used for testing, packets
> belonging to the same UDP flow are let through (when generating the
> traffic pattern described above). Without the change in this commit, all
> packets except the first one was dropped.

> With the change in this commit, a user can implement "perfect" solutions
> in user-space. An application can for example keep track of seen UDP
> flows, and then only release packets belonging to one flow when the
> entry has been created. Without the change, and SKB is stuck with the
> original conntrack entry.

PING
Any progress on this patch?

> Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
> ---
>  net/netfilter/nfnetlink_queue.c | 68 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

[...]

