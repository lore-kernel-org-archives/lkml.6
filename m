Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9549FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFB420661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFB420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeHaPdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:33:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbeHaPdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:33:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7VBOGea119719
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:26:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m741v9uvm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:26:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 31 Aug 2018 12:26:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Aug 2018 12:26:22 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7VBQLXi34144348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Aug 2018 11:26:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E899A52050;
        Fri, 31 Aug 2018 14:26:16 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.122.211.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id C8CC85204E;
        Fri, 31 Aug 2018 14:26:14 +0100 (BST)
Date:   Fri, 31 Aug 2018 16:56:18 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andre Wild <wild@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
 <20180810164533.GB42350@linux.vnet.ibm.com>
 <20180829084348.GO24124@hirez.programming.kicks-ass.net>
 <20180831102248.GA8437@linux.vnet.ibm.com>
 <20180831104115.GH24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180831104115.GH24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18083111-0008-0000-0000-0000026A4175
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083111-0009-0000-0000-000021D2452B
Message-Id: <20180831112618.GA10911@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808310120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-08-31 12:41:15]:

> On Fri, Aug 31, 2018 at 03:22:48AM -0700, Srikar Dronamraju wrote:
> 
> > At boot: Before topology update.
> 
> How does that work; you do SMP bringup _before_ you know the topology !?
> 

If you look at the other mail that I sent, the system boots to its regular
state with a certain topology. The hypervisor might detect and push topology
updates after the system has been booted and initialized.  This topology
update can happen much much later after boot. We boot with a particular
topology and a later point of time, the topology update event occurs.


> > After topology update.
> > 
> > For CPU 0
> > domain-0: span=0-7 level=SMT
> >  groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }
> >  domain-1: span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 level=DIE
> >   groups: 0:{ span=0-7 cap=8192 }, 32:{ span=32-39 cap=8192 }, 64:{ span=64-71 cap=8192 }, 96:{ span=96-103 cap=8192 }, 128:{ span=128-135 cap=8192 }, 160:{ span=160-167 cap=8192 }, 192:{ span=192-199 cap=8192 }, 224:{ span=224-231 cap=8192 }, 256:{ span=256-263 cap=8192 }, 288:{ span=288-295 cap=8192 }
> >   domain-2: span=0-303 level=NODE
> >    groups: 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> > 

> > For CPU 9
> >  domain-0: span=8-15 level=SMT
> >   groups: 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }, 8:{ span=8 }
> >   domain-1: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=DIE
> >    groups: 8:{ span=8-15 cap=8192 }, 40:{ span=40-47 cap=8192 }, 72:{ span=72-79 cap=8192 }, 104:{ span=104-111 cap=8192 }, 136:{ span=136-143 cap=8192 }, 168:{ span=168-175 cap=8192 }, 200:{ span=200-207 cap=8192 }, 232:{ span=232-239 cap=8192 }, 264:{ span=264-271 cap=8192 }, 296:{ span=296-303 cap=8192 }
> >    domain-2: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=NODE
> >     groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }
> >     domain-3: span=0-303 level=NUMA
> >      groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> > ERROR: groups don't span domain->span
> 
> This is all very confused... and does not include the error we saw
> earlier.

> 
> CPU 0 has: SMT, DIE, NODE
> CPU 8 has: SMT, DIE, NODE, NUMA
> 

This was the same in my previous posting too. Before the topology update
happened, all the cpus would be in SMT, DIE. The topology updates can be
disabled using a kernel parameter topology_updates=off. Its documented under
https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html as

      topology_updates= [KNL, PPC, NUMA] Format: {off} Specify if the kernel
      should ignore (off) topology updates sent by the hypervisor to this
      LPAR.

and is not something new in powerpc.

> Something is completely buggered in your topology setup.
> 

