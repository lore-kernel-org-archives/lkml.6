Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE8EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786BE206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfAGOJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:09:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727008AbfAGOJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:09:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07E98EY003303
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 09:09:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pv6f5nkb9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:09:37 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 7 Jan 2019 14:09:35 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 14:09:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07E9Tbq45940774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 14:09:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68D374C050;
        Mon,  7 Jan 2019 14:09:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CBAC4C04A;
        Mon,  7 Jan 2019 14:09:23 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.42.180])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jan 2019 14:09:21 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 10/21] mm: build separate zonelist for PMEM and DRAM node
In-Reply-To: <20190107095753.7feee5fxjja5lt75@wfg-t540p.sh.intel.com>
References: <20181226131446.330864849@intel.com> <20181226133351.644607371@intel.com> <87sgyc7n9a.fsf@linux.ibm.com> <20190107095753.7feee5fxjja5lt75@wfg-t540p.sh.intel.com>
Date:   Mon, 07 Jan 2019 19:39:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19010714-0008-0000-0000-000002AC5190
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010714-0009-0000-0000-000022185B95
Message-Id: <87h8ekk19s.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fengguang Wu <fengguang.wu@intel.com> writes:

> On Tue, Jan 01, 2019 at 02:44:41PM +0530, Aneesh Kumar K.V wrote:
>>Fengguang Wu <fengguang.wu@intel.com> writes:
>>
>>> From: Fan Du <fan.du@intel.com>
>>>
>>> When allocate page, DRAM and PMEM node should better not fall back to
>>> each other. This allows migration code to explicitly control which type
>>> of node to allocate pages from.
>>>
>>> With this patch, PMEM NUMA node can only be used in 2 ways:
>>> - migrate in and out
>>> - numactl
>>
>>Can we achieve this using nodemask? That way we don't tag nodes with
>>different properties such as DRAM/PMEM. We can then give the
>>flexibilility to the device init code to add the new memory nodes to
>>the right nodemask
>
> Aneesh, in patch 2 we did create nodemask numa_nodes_pmem and
> numa_nodes_dram. What's your supposed way of "using nodemask"?
>

IIUC the patch is to avoid allocation from PMEM nodes and the way you
achieve it is by checking if (is_node_pmem(n)). We already have
abstractness to avoid allocation from a node using node mask. I was
wondering whether we can do the equivalent of above using that.

ie, __next_zone_zonelist can do zref_in_nodemask(z,
default_exclude_nodemask)) and decide whether to use the specific zone
or not.

That way we don't add special code like 

+	PGDAT_DRAM,			/* Volatile DRAM memory node */
+	PGDAT_PMEM,			/* Persistent memory node */

The reason is that there could be other device memory that would want to
get excluded from that default allocation like you are doing for PMEM

-aneesh

