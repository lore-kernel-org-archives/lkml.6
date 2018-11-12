Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374C8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CC3223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BGcLKp8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CC3223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbeKMCW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:22:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48236 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbeKMCW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:22:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wACGNo3v039290;
        Mon, 12 Nov 2018 16:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=aOginBTIqKJ4xnjjgVQbNF366wYkv3X0l8j+RoUjAzQ=;
 b=BGcLKp8pOhj3NT63Q4KCUVwQg5DX2eZQzZ12kbISr/4eIOxVB9xXH3Ohqr4B9ncGR0IW
 +//6DwQEL4a8BvaV/XK8dr2w6G8A0IWeshQbpVi1IQ5scRj4HDD7KsaHeWFmHIoJR51L
 paQjjXmSRelpjRXzp8cGmeNLfiYaq+xpVtdLB5Rf4EFojg/XmOah2Ra/fIJk7RmWQTAM
 l7R1Sv0HEp7ykqzWV77io3wHVrmm/z35+TZdr/5KUSalh7hGDXDL9fUe1OiJceHu6bFD
 oAcRGERx6rQjBn2/hRICuifPVRuDnomss8eNCxyf6E9QkDYJHaNqD7Y5HW4KrzVnNutt pQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nnw6ee9nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 16:25:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wACGPlnJ031522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 16:25:47 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wACGPiWr015385;
        Mon, 12 Nov 2018 16:25:44 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 08:25:44 -0800
Date:   Mon, 12 Nov 2018 08:25:52 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        daniel.m.jordan@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        davem@davemloft.net, pavel.tatashin@microsoft.com, mhocko@suse.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz,
        khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-ID: <20181112162551.ot6q7r56unovlaon@ca-dmjordan1.us.oracle.com>
References: <20181109211521.5ospn33pp552k2xv@xakep.localdomain>
 <18b6634b912af7b4ec01396a2b0f3b31737c9ea2.camel@linux.intel.com>
 <20181110000006.tmcfnzynelaznn7u@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110000006.tmcfnzynelaznn7u@xakep.localdomain>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9075 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811120143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 07:00:06PM -0500, Pavel Tatashin wrote:
> On 18-11-09 15:14:35, Alexander Duyck wrote:
> > On Fri, 2018-11-09 at 16:15 -0500, Pavel Tatashin wrote:
> > > On 18-11-05 13:19:25, Alexander Duyck wrote:
> > > > This patchset is essentially a refactor of the page initialization logic
> > > > that is meant to provide for better code reuse while providing a
> > > > significant improvement in deferred page initialization performance.
> > > > 
> > > > In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
> > > > memory per node I have seen the following. In the case of regular memory
> > > > initialization the deferred init time was decreased from 3.75s to 1.06s on
> > > > average. For the persistent memory the initialization time dropped from
> > > > 24.17s to 19.12s on average. This amounts to a 253% improvement for the
> > > > deferred memory initialization performance, and a 26% improvement in the
> > > > persistent memory initialization performance.
> > > 
> > > Hi Alex,
> > > 
> > > Please try to run your persistent memory init experiment with Daniel's
> > > patches:
> > > 
> > > https://lore.kernel.org/lkml/20181105165558.11698-1-daniel.m.jordan@oracle.com/
> > 
> > I've taken a quick look at it. It seems like a bit of a brute force way
> > to try and speed things up. I would be worried about it potentially
> 
> There is a limit to max number of threads that ktasks start. The memory
> throughput is *much* higher than what one CPU can maxout in a node, so
> there is no reason to leave the other CPUs sit idle during boot when
> they can help to initialize.
> 
> > introducing performance issues if the number of CPUs thrown at it end
> > up exceeding the maximum throughput of the memory.
> > 
> > The data provided with patch 11 seems to point to issues such as that.
> > In the case of the E7-8895 example cited it is increasing the numbers
> > of CPUs used from memory initialization from 8 to 72, a 9x increase in
> > the number of CPUs but it is yeilding only a 3.88x speedup.
> 
> Yes, but in both cases we are far from maxing out the memory throughput.
> The 3.88x is indeed low, and I do not know what slows it down.
> 
> Daniel,
> 
> Could you please check why multi-threading efficiency is so low here?

I'll hop on the machine after Plumbers.

> I bet, there is some atomic operation introduces a contention within a
> node. It should be possible to resolve.

We'll see, in any case I'm curious to see what the multithreading does with
Alex's patches, especially since we won't do two passes through the memory
anymore.

Not seeing anything in Alex's work right off that would preclude
multithreading.
