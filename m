Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37623C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC26214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfAJX5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:57:52 -0500
Received: from mail.us.es ([193.147.175.20]:40306 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbfAJX5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:57:51 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A06D461EA7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:57:49 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 902BFDA85D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:57:49 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 77175DA863; Fri, 11 Jan 2019 00:57:49 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 786ADDA84C;
        Fri, 11 Jan 2019 00:57:47 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 11 Jan 2019 00:57:47 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 44F674265A4E;
        Fri, 11 Jan 2019 00:57:47 +0100 (CET)
Date:   Fri, 11 Jan 2019 00:57:46 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Westphal <fw@strlen.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2] netfilter: account ebt_table_info to kmemcg
Message-ID: <20190110235746.65mp4kgyscgjhktl@salvia>
References: <20190103031431.247970-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103031431.247970-1-shakeelb@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 07:14:31PM -0800, Shakeel Butt wrote:
> The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
> memory is already accounted to kmemcg. Do the same for ebtables. The
> syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
> whole system from a restricted memcg, a potential DoS.
> 
> By accounting the ebt_table_info, the memory used for ebt_table_info can
> be contained within the memcg of the allocating process. However the
> lifetime of ebt_table_info is independent of the allocating process and
> is tied to the network namespace. So, the oom-killer will not be able to
> relieve the memory pressure due to ebt_table_info memory. The memory for
> ebt_table_info is allocated through vmalloc. Currently vmalloc does not
> handle the oom-killed allocating process correctly and one large
> allocation can bypass memcg limit enforcement. So, with this patch,
> at least the small allocations will be contained. For large allocations,
> we need to fix vmalloc.

OK, patch is applied, thanks.
