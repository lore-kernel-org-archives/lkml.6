Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B74C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37D32098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37D32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeJCSHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:07:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbeJCSHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:07:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93BAnJJ100223
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 07:19:22 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mvvnvr9y7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:19:22 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 3 Oct 2018 05:19:22 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Oct 2018 05:19:18 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w93BJHDD66322522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Oct 2018 04:19:17 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 463D213604F;
        Wed,  3 Oct 2018 05:19:17 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC75C136059;
        Wed,  3 Oct 2018 05:19:16 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.35.51])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  3 Oct 2018 05:19:16 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 5C3BB2E4C72; Wed,  3 Oct 2018 16:49:13 +0530 (IST)
Date:   Wed, 3 Oct 2018 16:49:13 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
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
Subject: Re: [PATCH v9 0/3] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Reply-To: ego@linux.vnet.ibm.com
References: <1538399802-23582-1-git-send-email-ego@linux.vnet.ibm.com>
 <994106db-7f79-7d22-0d4e-f458bd85bb64@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994106db-7f79-7d22-0d4e-f458bd85bb64@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18100311-0016-0000-0000-0000093A538C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009814; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097236; UDB=6.00567426; IPR=6.00877278;
 MB=3.00023598; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-03 11:19:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100311-0017-0000-0000-00004091F6F9
Message-Id: <20181003111913.GA9055@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810030112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

On Mon, Oct 01, 2018 at 07:05:11AM -0700, Dave Hansen wrote:
> On 10/01/2018 06:16 AM, Gautham R. Shenoy wrote:
> > 
> > Patch 3: Creates a pair of sysfs attributes named
> > 	  /sys/devices/system/cpu/cpuN/topology/smallcore_thread_siblings
> > 	  and
> > 	  /sys/devices/system/cpu/cpuN/topology/smallcore_thread_siblings_list
> > 	  exposing the small-core siblings that share the L1 cache
> > 	  to the userspace.
> 
> I really don't think you've justified the existence of a new user/kernel
> interface here.  We already have information about threads share L1
> caches in here:
> 
> 	/sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_list


Hmmm. My bad, I wasn't aware of this sysfs interface. We can use this
to share information about L1 cache. And currently on the upstream
kernel we report incorrect value on POWER9 SMT8 core. I will fix
this. Thanks for calling this out.

> 
> The only question would be if anything would break because it assumes
> that all SMT siblings share all caches.  But, it breaks if your new
> interface is there or not; it's old software that we care about.
>

Up until POWER9 SMT8 cores, this assumption was true that all SMT
siblings share all caches. POWER9 SMT8 cores are the only exception. 

--
Thanks and Regards
gautham.

