Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E487C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 09:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1839A2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 09:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1839A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeKDSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 13:30:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbeKDSai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 13:30:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA498kvF030537
        for <linux-kernel@vger.kernel.org>; Sun, 4 Nov 2018 04:16:21 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nhrvdgbdy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 04:16:21 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 4 Nov 2018 09:16:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 4 Nov 2018 09:16:16 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA49GFVN59834442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 4 Nov 2018 09:16:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E44EDA4051;
        Sun,  4 Nov 2018 09:16:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB1CEA404D;
        Sun,  4 Nov 2018 09:16:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.72])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  4 Nov 2018 09:16:13 +0000 (GMT)
Date:   Sun, 4 Nov 2018 11:16:12 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102160122.GH194472@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102160122.GH194472@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18110409-0008-0000-0000-0000028AFC48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110409-0009-0000-0000-000021F52C48
Message-Id: <20181104091611.GC7829@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811040088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:01:22PM -0400, Sasha Levin wrote:
> On Fri, Nov 02, 2018 at 02:45:42AM +0000, Dexuan Cui wrote:
> >>From: Roman Gushchin <guro@fb.com>
> >>Sent: Thursday, November 1, 2018 17:58
> >>
> >>On Fri, Nov 02, 2018 at 12:16:02AM +0000, Dexuan Cui wrote:
> >>Hello, Dexuan!
> >>
> >>A couple of issues has been revealed recently, here are fixes
> >>(hashes are from the next tree):
> >>
> >>5f4b04528b5f mm: don't reclaim inodes with many attached pages
> >>5a03b371ad6a mm: handle no memcg case in memcg_kmem_charge()
> >>properly
> >>
> >>These two patches should be added to the serie.
> >
> >Thanks for the new info!
> >
> >>Re stable backporting, I'd really wait for some time. Memory reclaim is a
> >>quite complex and fragile area, so even if patches are correct by themselves,
> >>they can easily cause a regression by revealing some other issues (as it was
> >>with the inode reclaim case).
> >
> >I totally agree. I'm now just wondering if there is any temporary workaround,
> >even if that means we have to run the kernel with some features disabled or
> >with a suboptimal performance?
> 
> I'm not sure what workload you're seeing it on, but if you could merge
> these 7 patches and see that it solves the problem you're seeing and
> doesn't cause any regressions it'll be a useful test for the rest of us.

AFAIK, with Roman's patches backported to Ubuntu version of 4.15, the
problem reported at [1] is solved.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1792349
 
> --
> Thanks,
> Sasha
> 

-- 
Sincerely yours,
Mike.

