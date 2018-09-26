Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5595B2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5595B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeIZMRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:17:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbeIZMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:17:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q5wcT8072711
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:06:23 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mr1d0eq4d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:06:22 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 00:06:21 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 00:06:17 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8Q66Gei25034780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 23:06:16 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8D616A054;
        Wed, 26 Sep 2018 00:06:16 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BDBA6A04F;
        Wed, 26 Sep 2018 00:06:16 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.35.106])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 Sep 2018 00:06:16 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 3B1AB2E3D69; Wed, 26 Sep 2018 11:36:13 +0530 (IST)
Date:   Wed, 26 Sep 2018 11:36:13 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     ego@linux.vnet.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/3] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Reply-To: ego@linux.vnet.ibm.com
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
 <133c7bca-5720-81de-7956-b93870a1bab8@intel.com>
 <20180922110340.GA1402@in.ibm.com>
 <f2ac8eb0-b28e-a930-0160-09720f73a297@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ac8eb0-b28e-a930-0160-09720f73a297@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18092606-0004-0000-0000-00001491E4CC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009773; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093778; UDB=6.00565348; IPR=6.00873816;
 MB=3.00023509; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-26 06:06:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092606-0005-0000-0000-000088F12FD5
Message-Id: <20180926060613.GA22139@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

On Tue, Sep 25, 2018 at 03:16:30PM -0700, Dave Hansen wrote:
> On 09/22/2018 04:03 AM, Gautham R Shenoy wrote:
> > Without this patchset, the SMT domain would be defined as the group of
> > threads that share L2 cache.
> 
> Could you try to make a more clear, concise statement about the current
> state of the art vs. what you want it to be?  Right now, the sched
> domains do something like this in terms of ordering:
> 
> 1. SMT siblings
> 2. Caches
> 3. NUMA

Yes. you are right. The state of art on POWER9 machines having SMT8
cores is as you described above with

1. SMT siblings sharing L2-cache, called the SMT domain
2. Cores on the same die, called the DIE domain
3. NUMA

> 
> It sounds like you don't want SMT siblings to be the things that we use,
> right?  Because some siblings share caches and some do not.  Right?  You
> want something like this:
> 
> 1. SMT siblings (sharing L1)
> 2. SMT siblings (sharing L2)
> 3. Other caches
> 4. NUMA
>

Yes, with the patchset the sched-domain hierarchy on POWER9 machines
having SMT8 will be:

1. SMT siblings sharing L1 cache, called the SMT domain
2. SMT siblings sharing L2 cache, called the CACHE domain (introduced in
   commit 96d91431d691 "powerpc/smp: Add Power9 scheduler topology")
3. Cores on the same die, called the DIE domain.
4. NUMA

--
Thanks and Regards
gautham.

