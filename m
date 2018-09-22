Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F2BC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128DF21523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128DF21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeIVQ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:57:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbeIVQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:57:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8MB3lYk089625
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 07:03:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mnk64t8nt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 07:03:50 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Sat, 22 Sep 2018 05:03:50 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Sep 2018 05:03:47 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8MB3km122675618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Sep 2018 04:03:46 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2165B7805C;
        Sat, 22 Sep 2018 05:03:46 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D3A07805E;
        Sat, 22 Sep 2018 05:03:45 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.219.46])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 22 Sep 2018 05:03:45 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 278C82E2D04; Sat, 22 Sep 2018 16:33:40 +0530 (IST)
Date:   Sat, 22 Sep 2018 16:33:40 +0530
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
Subject: Re: [PATCH v8 0/3] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
Reply-To: ego@linux.vnet.ibm.com
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
 <133c7bca-5720-81de-7956-b93870a1bab8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133c7bca-5720-81de-7956-b93870a1bab8@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18092211-0036-0000-0000-00000A3C8859
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009751; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091974; UDB=6.00564258; IPR=6.00871999;
 MB=3.00023449; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-22 11:03:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092211-0037-0000-0000-0000490757AE
Message-Id: <20180922110340.GA1402@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809220117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Thu, Sep 20, 2018 at 11:04:54AM -0700, Dave Hansen wrote:
> On 09/20/2018 10:22 AM, Gautham R. Shenoy wrote:
> >  	   -------------------------
> > 	   |  	    L1 Cache       |
> >        ----------------------------------
> >        |L2|     |     |     |      |
> >        |  |  0  |  2  |  4  |  6   |Small Core0
> >        |C |     |     |     |      |
> > Big    |a --------------------------
> > Core   |c |     |     |     |      |
> >        |h |  1  |  3  |  5  |  7   | Small Core1
> >        |e |     |     |     |      |
> >        -----------------------------
> > 	  |  	    L1 Cache       |
> > 	  --------------------------
> 
> The scheduler already knows about shared caches.  Could you elaborate on
> how this is different from the situation today where we have multiple
> cores sharing an L2/L3?

The issue is not so much about the threads in the core sharing L2
cache. But the two group of threads in the core, each of which has its
own L1-cache. This patchset (the second patch in the series) informs
the scheduler of this distinction by defining the SMT sched-domain
have groups correspond to the threads that share L1 cache. With this
the scheduler will treat a pair of threads {1,2} differently from
{1,3} when threads 1 and 3 share the L1 cache, while 1 and 2 don't.

The next sched-domain (CACHE domain) is defined as the group of
threads that share the L2 cache, which happens to be the entire big
core.

Without this patchset, the SMT domain would be defined as the group of
threads that share L2 cache. Thus, the scheduler would treat any two
threads in the big-core in the same way, resulting in run-to-run
variance when the software threads are placed on pair of threads
within the same L1-cache group or on separate ones.

> 
> Adding the new sysfs stuff seems like overkill if that's all that you
> are trying to do.
>

The sysfs attributes are to inform the users that we have a big-core
configuration comprising of two small cores, thereby allowing them to
make informed choices should they want to pin the tasks to the CPUs.

--
Thanks and Regards
gautham.

