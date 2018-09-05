Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3870BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D178A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JQsJWU1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D178A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIEVm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:42:58 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:37230 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbeIEVm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1536167512;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=HlPMdYzuRFwlmhRCbXgfEV9PEsQ+OuqBE/q9jclQhT8=;
        b=JQsJWU1kczWZDFTCLE7jG1nXe4eoI8BFZnFyW4JtMeDT32c+3FufXyhC4RRZPWFl
        5ko6B/dNTdeDkpeIoG9hA3LZk3SZd494UsAR12QnNKkIuwrCQPlej4hK6scwwAg/4jG
        ZGfszY/jAH+a5zEertxgwOaL5HWqkcTThgFz3vEs=
Date:   Wed, 5 Sep 2018 17:11:52 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        Pavel.Tatashin@microsoft.com, paulmck@linux.vnet.ibm.com,
        shady.issa@oracle.com, tariqt@mellanox.com, tglx@linutronix.de,
        tim.c.chen@intel.com, vbabka@suse.cz, longman@redhat.com,
        yang.shi@linux.alibaba.com, shy828301@gmail.com,
        Huang Ying <ying.huang@intel.com>, subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
In-Reply-To: <839e2703-1588-0873-00a7-d04810f403cf@linux.vnet.ibm.com>
Message-ID: <01000165aab80769-ad7aaedf-81ae-4bbb-a602-a2aa5d49f54e-000000@email.amazonses.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com> <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com> <839e2703-1588-0873-00a7-d04810f403cf@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.05-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Laurent Dufour wrote:

> > Large page sizes also reduce contention there.
>
> That's true for the page fault path, but for process's actions manipulating the
> memory process's layout (mmap,munmap,madvise,mprotect) the impact is minimal
> unless the code has to manipulate the page tables.

Well if you compare having to operate on 4k instead of 64k then the impact
is 16xs for larger memory ranges. For smaller operations this may not be
that significant. But then I thought we were talking about large areas of
memory.

