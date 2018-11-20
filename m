Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C6BC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF23D20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5cBvunJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF23D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbeKUDeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:34:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeKUDeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:34:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAKGs5ve076798;
        Tue, 20 Nov 2018 17:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ia57VBRFeuLhQV762x6Y+AEm3Mp4r9xwLH862zX3kLk=;
 b=5cBvunJIOnI0mQrwta4TdiMMHzBB0D7wZf9e2A86dIDbVn85ut7satCuZsmFWnKeCYbX
 KAWxViSM4y9LChKYWXeGmVjyCTEJ6fo9t+qFq8wDUgf5gVTcM4GiDP9ffuqfKlGfpevY
 iDmArVdMkdv/Kd+jL0QhcYxnkdYpBEwuesI3p9fCUMw8Z73fS0NYM1S7+blyBe/P98qc
 Ii39xNG7M6Mjaxb4Cav54ad2a8FfRD5mPRWhvzQTZ+cBmRNjLZ5bhMrtpDu2fdyEZrYO
 0+MWQrkz10ntoQt1TapbGHdQ7igA+5RO1hv6HOC3FtOKIronimKqwk9A9Gd8YS4cewbj Eg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ntbmqn2b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 17:03:14 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAKH3DTr032335
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 17:03:13 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAKH3CHs030437;
        Tue, 20 Nov 2018 17:03:12 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Nov 2018 09:03:12 -0800
Date:   Tue, 20 Nov 2018 09:03:21 -0800
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
        tim.c.chen@intel.com, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 05/13] workqueue, ktask: renice helper threads to
 prevent starvation
Message-ID: <20181120170320.2qvlwnpohzxow4bm@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-6-daniel.m.jordan@oracle.com>
 <20181113163400.GK2509588@devbig004.ftw2.facebook.com>
 <20181119164554.axobolrufu26kfah@ca-dmjordan1.us.oracle.com>
 <20181120163319.GW2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120163319.GW2509588@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811200150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:33:19AM -0800, Tejun Heo wrote:
> On Mon, Nov 19, 2018 at 08:45:54AM -0800, Daniel Jordan wrote:
> > So instead of flush_work_at_nice, how about this?:
> > 
> > void renice_work_sync(work_struct *work, long nice);
> 
> Wouldn't renice_or_cancel make more sense?

I guess you mean, for renicing if the work is started and canceling if it
hasn't?

Then yes, it would in this case, since if a ktask work hasn't start, there's no
point in running it--there are no more chunks for it to work on.

Was attempting to generalize for other cases when the work did need to be run,
but designing for the future can be dicey, and I'm fine either way.  So absent
other opinions, I'll do renice_or_cancel.
