Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416AEC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0269F20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zsD3j7eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0269F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeLALYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:24:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50874 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLALYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:24:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB104TtH066643;
        Sat, 1 Dec 2018 00:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=nbdo/fXZkibVsOR084DEFbIDags7Vz6zkSVNnPWV6Ic=;
 b=zsD3j7eIth0TbPEJuQiFIUHKNZMr/5JsfeAp18+YvTzLDZatWmzpGbiWgrhgbaRpgKYk
 sXJ3Hum9ZJ8pT2sDSNimIdlAgLnKWCsbo2tzC2U8cM06YSG4pMZpfg8wq+7fepM8zuce
 7OB4uu5xdBm1MkmMC6tZVWgdu8tPIDY6s2EcwF1R4fvTVLeYpwTepNK6mhTtoDSztiUR
 KEK0C/tAkvSzaXLZuff3MyDkyrydzhAmZ56r77+8ymd8I4jgVuwxJlrphyKqcBw+jaqM
 HL0sQP3a4zt55HM4xnviNeM6kaykfGdBKbWfFeJQplXjnhAUKwgluRzIohuiWcuA3mW8 Nw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p2jf0r6hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Dec 2018 00:13:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB10D05x011989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Dec 2018 00:13:00 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB10Cvg3017901;
        Sat, 1 Dec 2018 00:12:57 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Nov 2018 16:12:57 -0800
Date:   Fri, 30 Nov 2018 16:13:07 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vbabka@suse.cz, peterz@infradead.org,
        dhaval.giani@oracle.com
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181201001307.wmb6o4fuysnl7vcz@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181130191819.GJ2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130191819.GJ2509588@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9093 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811300205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:18:19AM -0800, Tejun Heo wrote:
> Hello,
> 
> On Mon, Nov 05, 2018 at 11:55:45AM -0500, Daniel Jordan wrote:
> > Michal, you mentioned that ktask should be sensitive to CPU utilization[1].
> > ktask threads now run at the lowest priority on the system to avoid disturbing
> > busy CPUs (more details in patches 4 and 5).  Does this address your concern?
> > The plan to address your other comments is explained below.
> 
> Have you tested what kind of impact this has on bandwidth of a system
> in addition to latency?  The thing is while this would make a better
> use of a system which has idle capacity, it does so by doing more
> total work.  It'd be really interesting to see how this affects
> bandwidth of a system too.

I guess you mean something like comparing aggregate CPU time across threads to
the base single thread time for some job or set of jobs?  Then no, I haven't
measured that, but I can for next time.
