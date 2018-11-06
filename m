Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9DEC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6BE2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5bSWIBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6BE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeKFKxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:53:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44578 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeKFKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:53:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA61TFwP074569;
        Tue, 6 Nov 2018 01:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8nfYdVa5jWpYK80znAydvS4IVis1w3ImQRBB2skTJIk=;
 b=R5bSWIBUzAVzAnCzC4gwKnYOu74y2ymzbZ/qcxLmPmYUNNP9EOxAuJwhtRj8ecFFEVME
 Nk6cCxTbE5azdp/5g0W56B566jP/Zs83Qy2jJsCRutoMfXkTX8P+vmSP2RJty2jjFino
 8Oj2nn/BLdMP9SsDeULVzf0ZUs6LOddWTOqH1OvcMnQfz5EwT6PN69simLAO/tKzw4NL
 Cd/p81EP/lWKcxZYSfCD8uKzQO070Fosb8DUFPh8ThXnUQlg/ts/eGVzQ/b+p9D4GlGW
 EtopRWIwrd0mluFP9GWJ5fTRkEhszKiHSUTBicC1xBCxIyFD3jlzqJhhcYdnK1xc8nun mQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nh4aqjb7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 01:29:56 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA61Tn8A021976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 01:29:50 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA61Tmia001738;
        Tue, 6 Nov 2018 01:29:48 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 17:29:48 -0800
Date:   Mon, 5 Nov 2018 17:29:55 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mike.kravetz@oracle.com, Pavel.Tatashin@microsoft.com,
        prasad.singamsetty@oracle.com, rdunlap@infradead.org,
        steven.sistare@oracle.com, tim.c.chen@intel.com, tj@kernel.org,
        vbabka@suse.cz
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181106012955.br5swua3ykvolyjq@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105172931.GP4361@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105172931.GP4361@dhcp22.suse.cz>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=717
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 06:29:31PM +0100, Michal Hocko wrote:
> On Mon 05-11-18 11:55:45, Daniel Jordan wrote:
> > Michal, you mentioned that ktask should be sensitive to CPU utilization[1].
> > ktask threads now run at the lowest priority on the system to avoid disturbing
> > busy CPUs (more details in patches 4 and 5).  Does this address your concern?
> > The plan to address your other comments is explained below.
> 
> I have only glanced through the documentation patch and it looks like it
> will be much less disruptive than the previous attempts. Now the obvious
> question is how does this behave on a moderately or even busy system
> when you compare that to a single threaded execution. Some numbers about
> best/worst case execution would be really helpful.

Patches 4 and 5 have some numbers where a ktask and non-ktask workload compete
against each other.  Those show either 8 ktask threads on 8 CPUs (worst case) or no ktask threads (best case).

By single threaded execution, I guess you mean 1 ktask thread.  I'll run the
experiments that way too and post the numbers.

> I will look closer later.

Great!  Thanks for your comment.

Daniel
