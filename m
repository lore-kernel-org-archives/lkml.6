Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34994C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2CD2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2CD2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeJDAX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:23:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4827 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbeJDAXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:23:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93HP7qJ141307
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 13:34:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mw00366h0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 13:34:03 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 3 Oct 2018 18:34:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Oct 2018 18:33:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w93HXvdf62914690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Oct 2018 17:33:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88470A4055;
        Wed,  3 Oct 2018 20:33:34 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DE62A4040;
        Wed,  3 Oct 2018 20:33:33 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.204.62])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  3 Oct 2018 20:33:33 +0100 (BST)
Date:   Wed, 3 Oct 2018 20:33:54 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
References: <20180924195603.GJ18685@dhcp22.suse.cz>
 <20180924200258.GK18685@dhcp22.suse.cz>
 <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
 <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
 <20180925202959.GY18685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com>
 <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org>
 <20180926060624.GA18685@dhcp22.suse.cz>
 <20181002112851.GP18290@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18100317-0016-0000-0000-0000020E16E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100317-0017-0000-0000-000032655C2E
Message-Id: <20181003173354.GA17328@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=474 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810030164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 01:29:42PM -0700, David Rientjes wrote:
> On Tue, 2 Oct 2018, Michal Hocko wrote:
> 
> > On Wed 26-09-18 08:06:24, Michal Hocko wrote:
> > > On Tue 25-09-18 15:04:06, Andrew Morton wrote:
> > > > On Tue, 25 Sep 2018 14:45:19 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> > > > 
> > > > > > > It is also used in 
> > > > > > > automated testing to ensure that vmas get disabled for thp appropriately 
> > > > > > > and we used "nh" since that is how PR_SET_THP_DISABLE previously enforced 
> > > > > > > this, and those tests now break.
> > > > > > 
> > > > > > This sounds like a bit of an abuse to me. It shows how an internal
> > > > > > implementation detail leaks out to the userspace which is something we
> > > > > > should try to avoid.
> > > > > > 
> > > > > 
> > > > > Well, it's already how this has worked for years before commit 
> > > > > 1860033237d4 broke it.  Changing the implementation in the kernel is fine 
> > > > > as long as you don't break userspace who relies on what is exported to it 
> > > > > and is the only way to determine if MADV_NOHUGEPAGE is preventing it from 
> > > > > being backed by hugepages.
> > > > 
> > > > 1860033237d4 was over a year ago so perhaps we don't need to be
> > > > too worried about restoring the old interface.  In which case
> > > > we have an opportunity to make improvements such as that suggested
> > > > by Michal?
> > > 
> > > Yeah, can we add a way to export PR_SET_THP_DISABLE to userspace
> > > somehow? E.g. /proc/<pid>/status. It is a process wide thing so
> > > reporting it per VMA sounds strange at best.
> > 
> > So how about this? (not tested yet but it should be pretty
> > straightforward)
> 
> Umm, prctl(PR_GET_THP_DISABLE)?
> 

~/git/linux$ git grep PR_GET_THP_DISABLE
include/uapi/linux/prctl.h:#define PR_GET_THP_DISABLE   42
kernel/sys.c:   case PR_GET_THP_DISABLE:
tools/include/uapi/linux/prctl.h:#define PR_GET_THP_DISABLE     42

-- 
Sincerely yours,
Mike.

