Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE33C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C320645
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6C320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeHaO3q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:29:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727191AbeHaO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:29:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7VAEnSZ090502
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:22:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m73dh98rj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:22:55 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 31 Aug 2018 11:22:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Aug 2018 11:22:51 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7VAMoVi26345670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Aug 2018 10:22:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE88AE056;
        Fri, 31 Aug 2018 13:22:18 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14B26AE045;
        Fri, 31 Aug 2018 13:22:17 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 31 Aug 2018 13:22:16 +0100 (BST)
Date:   Fri, 31 Aug 2018 03:22:48 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180829084348.GO24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18083110-0028-0000-0000-000002F24068
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083110-0029-0000-0000-000023ABA642
Message-Id: <20180831102248.GA8437@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=862 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808310109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2018-08-29 10:43:48]:

> On Fri, Aug 10, 2018 at 09:45:33AM -0700, Srikar Dronamraju wrote:
> 
> > ....
> > CPU302 attaching NULL sched-domain.
> > CPU303 attaching NULL sched-domain.
> > BUG: arch topology borken
> >      the DIE domain not a subset of the NODE domain
> 
> ^^^^^ CLUE!!
> 
> but nowhere did you show what it thinks the DIE mask is.
> 
> >  CPU0 attaching sched-domain(s):
> >    domain-2: sdA, span=0-303 level=NODE
> >     groups: sg=sgL 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, sgM 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, sdN 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, sgO 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> > CPU1  attaching sched-domain(s):
> >    domain-2: sdB, span=0-303 level=NODE
> > [  367.739387]     groups: sg=sgL 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, sgM 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, sdN 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, sgO 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
> 
> You forgot to provide the rest of it... what's domain-[01] look like?

At boot: Before topology update.

For  CPU 0 
domain-0: span=0-7 level=SMT
 groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }
 domain-1: span=0-303 level=DIE
  groups: 0:{ span=0-7 cap=8192 }, 8:{ span=8-15 cap=8192 }, 16:{ span=16-23 cap=8192 }, 24:{ span=24-31 cap=8192 }, 32:{ span=32-39 cap=8192 }, 40:{ span=40-47 cap=8192 }, 48:{ span=48-55 cap=8192 }, 56:{ span=56-63 cap=8192 }, 64:{ span=64-71 cap=8192 }, 72:{ span=72-79 cap=8192 }, 80:{ span=80-87 cap=8192 }, 88:{ span=88-95 cap=8192 }, 96:{ span=96-103 cap=8192 }, 104:{ span=104-111 cap=8192 }, 112:{ span=112-119 cap=8192 }, 120:{ span=120-127 cap=8192 }, 128:{ span=128-135 cap=8192 }, 136:{ span=136-143 cap=8192 }, 144:{ span=144-151 cap=8192 }, 152:{ span=152-159 cap=8192 }, 160:{ span=160-167 cap=8192 }, 168:{ span=168-175 cap=8192 }, 176:{ span=176-183 cap=8192 }, 184:{ span=184-191 cap=8192 }, 192:{ span=192-199 cap=8192 }, 200:{ span=200-207 cap=8192 }, 208:{ span=208-215 cap=8192 }, 216:{ span=216-223 cap=8192 }, 224:{ span=224-231 cap=8192 }, 232:{ span=232-239 cap=8192 }, 240:{ span=240-247 cap=8192 }, 248:{ span=248-255 cap=8192 }, 256:{ span=256-263 cap=8192 }, 264:{ sp
 an=264-271 cap=8192 }, 272:{ span=272-279 cap=8192 }, 280:{ span=280-287 cap=8192 }, 288:{ span=288-295 cap=8192 }, 296:{ span=296-303 cap=8192 }

For  CPU 1 
domain-0: span=0-7 level=SMT
 groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }, 0:{ span=0 }
 domain-1: span=0-303 level=DIE
  groups: 0:{ span=0-7 cap=8192 }, 8:{ span=8-15 cap=8192 }, 16:{ span=16-23 cap=8192 }, 24:{ span=24-31 cap=8192 }, 32:{ span=32-39 cap=8192 }, 40:{ span=40-47 cap=8192 }, 48:{ span=48-55 cap=8192 }, 56:{ span=56-63 cap=8192 }, 64:{ span=64-71 cap=8192 }, 72:{ span=72-79 cap=8192 }, 80:{ span=80-87 cap=8192 }, 88:{ span=88-95 cap=8192 }, 96:{ span=96-103 cap=8192 }, 104:{ span=104-111 cap=8192 }, 112:{ span=112-119 cap=8192 }, 120:{ span=120-127 cap=8192 }, 128:{ span=128-135 cap=8192 }, 136:{ span=136-143 cap=8192 }, 144:{ span=144-151 cap=8192 }, 152:{ span=152-159 cap=8192 }, 160:{ span=160-167 cap=8192 }, 168:{ span=168-175 cap=8192 }, 176:{ span=176-183 cap=8192 }, 184:{ span=184-191 cap=8192 }, 192:{ span=192-199 cap=8192 }, 200:{ span=200-207 cap=8192 }, 208:{ span=208-215 cap=8192}, 216:{ span=216-223 cap=8192 }, 224:{ span=224-231 cap=8192 }, 232:{ span=232-239 cap=8192 }, 240:{ span=240-247 cap=8192 }, 248:{ span=248-255 cap=8192 }, 256:{ span=256-263 cap=8192 }, 264:{ spa
 n=264-271 cap=8192 }, 272:{ span=272-279 cap=8192 }, 280:{ span=280-287 cap=8192 }, 288:{ span=288-295 cap=8192 }, 296:{ span=296-303 cap=8192 }


For  CPU 8
domain-0: span=8-15 level=SMT
 groups: 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }
 domain-1: span=0-303 level=DIE
  groups: 8:{ span=8-15 cap=8192 }, 16:{ span=16-23 cap=8192 }, 24:{ span=24-31 cap=8192 }, 32:{ span=32-39 cap=8192 }, 40:{ span=40-47 cap=8192 }, 48:{ span=48-55 cap=8192 }, 56:{ span=56-63 cap=8192 }, 64:{ span=64-71 cap=8192 }, 72:{ span=72-79 cap=8192 }, 80:{ span=80-87 cap=8192 }, 88:{ span=88-95 cap=8192 }, 96:{ span=96-103 cap=8192 }, 104:{ span=104-111 cap=8192 }, 112:{ span=112-119 cap=8192 }, 120:{ span=120-127 cap=8192 }, 128:{ span=128-135 cap=8192 }, 136:{ span=136-143 cap=8192 }, 144:{ span=144-151 cap=8192 }, 152:{ span=152-159 cap=8192 }, 160:{ span=160-167 cap=8192 }, 168:{ span=168-175 cap=8192 }, 176:{ span=176-183 cap=8192 }, 184:{ span=184-191 cap=8192 }, 192:{ span=192-199 cap=8192 }, 200:{ span=200-207 cap=8192 }, 208:{ span=208-215 cap=8192 }, 216:{ span=216-223 cap=8192 }, 224:{ span=224-231 cap=8192 }, 232:{ span=232-239 cap=8192 }, 240:{ span=240-247 cap=8192 }, 248:{ span=248-255 cap=8192 }, 256:{ span=256-263 cap=8192 }, 264:{ span=264-271 cap=8192 }, 27
 2:{ span=272-279 cap=8192 }, 280:{ span=280-287 cap=8192 }, 288:{ span=288-295 cap=8192 }, 296:{ span=296-303 cap=8192 }, 0:{ span=0-7 cap=8192 }

For  CPU 9 
domain-0: span=8-15 level=SMT
 groups: 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }, 8:{ span=8 }
 domain-1: span=0-303 level=DIE
  groups: 8:{ span=8-15 cap=8192 }, 16:{ span=16-23 cap=8192 }, 24:{ span=24-31 cap=8192 }, 32:{ span=32-39 cap=8192 }, 40:{ span=40-47 cap=8192 }, 48:{ span=48-55 cap=8192 }, 56:{ span=56-63 cap=8192 }, 64:{ span=64-71 cap=8192 }, 72:{ span=72-79 cap=8192 }, 80:{ span=80-87 cap=8192 }, 88:{ span=88-95 cap=8192 }, 96:{ span=96-103 cap=8192 }, 104:{ span=104-111 cap=8192 }, 112:{ span=112-119 cap=8192 }, 120:{ span=120-127 cap=8192 }, 128:{ span=128-135 cap=8192 }, 136:{ span=136-143 cap=8192 }, 144:{ span=144-151 cap=8192 }, 152:{ span=152-159 cap=8192 }, 160:{ span=160-167 cap=8192 }, 168:{ span=168-175 cap=8192 }, 176:{ span=176-183 cap=8192 }, 184:{ span=184-191 cap=8192 }, 192:{ span=192-199 cap=8192 }, 200:{ span=200-207 cap=8192 }, 208:{ span=208-215 cap=8192 }, 216:{ span=216-223 cap=8192 }, 224:{ span=224-231 cap=8192 }, 232:{ span=232-239 cap=8192 }, 240:{ span=240-247 cap=8192 }, 248:{ span=248-255 cap=8192 }, 256:{ span=256-263 cap=8192 }, 264:{ span=264-271 cap=8192 }, 27
 2:{ span=272-279 cap=8192 }, 280:{ span=280-287 cap=8192 }, 288:{ span=288-295 cap=8192 }, 296:{ span=296-303 cap=8192 }, 0:{ span=0-7 cap=8192 }


After topology update.

For CPU 0
domain-0: span=0-7 level=SMT
 groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }
 domain-1: span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 level=DIE
  groups: 0:{ span=0-7 cap=8192 }, 32:{ span=32-39 cap=8192 }, 64:{ span=64-71 cap=8192 }, 96:{ span=96-103 cap=8192 }, 128:{ span=128-135 cap=8192 }, 160:{ span=160-167 cap=8192 }, 192:{ span=192-199 cap=8192 }, 224:{ span=224-231 cap=8192 }, 256:{ span=256-263 cap=8192 }, 288:{ span=288-295 cap=8192 }
  domain-2: span=0-303 level=NODE
   groups: 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }

For CPU 1
domain-0: span=0-7 level=SMT
 groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }, 0:{ span=0 }
 domain-1: span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 level=DIE
  groups: 0:{ span=0-7 cap=8192 }, 32:{ span=32-39 cap=8192 }, 64:{ span=64-71 cap=8192 }, 96:{ span=96-103 cap=8192 }, 128:{ span=128-135 cap=8192 }, 160:{ span=160-167 cap=8192 }, 192:{ span=192-199 cap=8192 }, 224:{ span=224-231 cap=8192 }, 256:{ span=256-263 cap=8192 }, 288:{ span=288-295 cap=8192 }
  domain-2: span=0-303 level=NODE
   groups: 0:{ span=0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,256-263,288-295 cap=81920 }, 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }


For CPU 8
 domain-0: span=8-15 level=SMT
  groups: 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }
  domain-1: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=DIE
   groups: 8:{ span=8-15 cap=8192 }, 40:{ span=40-47 cap=8192 }, 72:{ span=72-79 cap=8192 }, 104:{ span=104-111 cap=8192 }, 136:{ span=136-143 cap=8192 }, 168:{ span=168-175 cap=8192 }, 200:{ span=200-207 cap=8192 }, 232:{ span=232-239 cap=8192 }, 264:{ span=264-271 cap=8192 }, 296:{ span=296-303 cap=8192 }
   domain-2: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=NODE
    groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }
    domain-3: span=0-303 level=NUMA
     groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
ERROR: groups don't span domain->span

For CPU 9
 domain-0: span=8-15 level=SMT
  groups: 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }, 8:{ span=8 }
  domain-1: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=DIE
   groups: 8:{ span=8-15 cap=8192 }, 40:{ span=40-47 cap=8192 }, 72:{ span=72-79 cap=8192 }, 104:{ span=104-111 cap=8192 }, 136:{ span=136-143 cap=8192 }, 168:{ span=168-175 cap=8192 }, 200:{ span=200-207 cap=8192 }, 232:{ span=232-239 cap=8192 }, 264:{ span=264-271 cap=8192 }, 296:{ span=296-303 cap=8192 }
   domain-2: span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 level=NODE
    groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }
    domain-3: span=0-303 level=NUMA
     groups: 8:{ span=8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=81920 }, 16:{ span=16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=73728 }, 24:{ span=24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=73728 }
ERROR: groups don't span domain->span

-- 
Thanks and Regards
Srikar Dronamraju

