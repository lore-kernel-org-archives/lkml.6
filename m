Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18534C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED573218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfAaGt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:49:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbfAaGt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:49:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V6nhe0048340
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:49:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbtbyvbbw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:49:56 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 31 Jan 2019 06:49:55 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 06:49:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V6npjr1835270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 06:49:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09A811C050;
        Thu, 31 Jan 2019 06:49:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69D6A11C04C;
        Thu, 31 Jan 2019 06:49:49 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.38.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 06:49:49 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>, lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [LSF/MM ATTEND ] memory reclaim with NUMA rebalancing
In-Reply-To: <20190130174847.GD18811@dhcp22.suse.cz>
References: <20190130174847.GD18811@dhcp22.suse.cz>
Date:   Thu, 31 Jan 2019 12:19:47 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19013106-0008-0000-0000-000002B9278F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013106-0009-0000-0000-0000222528B6
Message-Id: <87h8dpnwxg.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=822 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> Hi,
> I would like to propose the following topic for the MM track. Different
> group of people would like to use NVIDMMs as a low cost & slower memory
> which is presented to the system as a NUMA node. We do have a NUMA API
> but it doesn't really fit to "balance the memory between nodes" needs.
> People would like to have hot pages in the regular RAM while cold pages
> might be at lower speed NUMA nodes. We do have NUMA balancing for
> promotion path but there is notIhing for the other direction. Can we
> start considering memory reclaim to move pages to more distant and idle
> NUMA nodes rather than reclaim them? There are certainly details that
> will get quite complicated but I guess it is time to start discussing
> this at least.

I would be interested in this topic too. I would like to
understand the API and how it can help exploit the different type of
devices we have on OpenCAPI.

IMHO there are few proposals related to this which we could discuss together

1. HMAT series which want to expose these devices as Numa nodes
2. The patch series from Dave Hansen which just uses Pmem as Numa node.
3. The patch series from Fengguang Wu which does prevent default
allocation from these numa nodes by excluding them from zone list.
4. The patch series from Jerome Glisse which doesn't expose these as
numa nodes.

IMHO (3) is suggesting that we really don't want them as numa nodes. But
since Numa is the only interface we currently have to present them as
memory and control the allocation and migration we are forcing
ourselves to Numa nodes and then excluding them from default allocation.

-aneesh

