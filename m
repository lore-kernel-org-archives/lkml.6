Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0D9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F5A21904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l5Ns9i+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbfBNBrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:47:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34470 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732989AbfBNBrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:47:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E1iCen164153;
        Thu, 14 Feb 2019 01:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Mv4loqm46Z/QYiGEHUXmuNKDhUS254UKT2WUxryVk2A=;
 b=l5Ns9i+utIL6ouIO9ODcBGb2oeY93cHhqOnXNv/2L29/pPR6gQtogJBiAgwh9JhEDnjk
 wLlOschNbcSVtu+yXoUJxhfVmiT3SZtitv+c1TY9bBFbmXPPifAIQ26UFWXPYn2VeyOA
 t1sCPrQF35sCdHoaNM0IkQRSGsnGhj+uuzNbBnADT5NFt+6SaiaIhmk8/H2f/SjqB3ux
 VAtut17mZKE7D1xJYhg4MYAamNzc/xnS19gNPYqcuh4xK/EcbwSrYHfeV3KQxxbpZGcF
 gHNPfmILcXaqPIqICyTc+1tpU59yPJviu5ZqCH/DVUKgA33dg0idbbLEBXSe7gnGISOW Qg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qhreknc7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 01:46:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E1kI9Z027465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 01:46:18 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E1kEMH002971;
        Thu, 14 Feb 2019 01:46:14 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 01:46:14 +0000
Date:   Wed, 13 Feb 2019 20:46:34 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org,
        dave@stgolabs.net, jack@suse.cz, cl@linux.com, linux-mm@kvack.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com,
        atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru,
        peterz@infradead.org
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190214014634.kxjiwzelczlskeo6@ca-dmjordan1.us.oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
 <20190211225620.GO24692@ziepe.ca>
 <20190211231152.qflff6g2asmkb6hr@ca-dmjordan1.us.oracle.com>
 <20190212114110.17bc8a14@w520.home>
 <20190213002650.kav7xc4r2xs5f3ef@ca-dmjordan1.us.oracle.com>
 <20190213130330.76ef1987@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213130330.76ef1987@w520.home>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:03:30PM -0700, Alex Williamson wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > On Tue, Feb 12, 2019 at 11:41:10AM -0700, Alex Williamson wrote:
> > > This still makes me nervous because we have userspace dependencies on
> > > setting process locked memory.  
> > 
> > Could you please expand on this?  Trying to get more context.
> 
> VFIO is a userspace driver interface and the pinned/locked page
> accounting we're doing here is trying to prevent a user from exceeding
> their locked memory limits.  Thus a VM management tool or unprivileged
> userspace driver needs to have appropriate locked memory limits
> configured for their use case.  Currently we do not have a unified
> accounting scheme, so if a page is mlock'd by the user and also mapped
> through VFIO for DMA, it's accounted twice, these both increment
> locked_vm and userspace needs to manage that.  If pinned memory
> and locked memory are now two separate buckets and we're only comparing
> one of them against the locked memory limit, then it seems we have
> effectively doubled the user's locked memory for this use case, as
> Jason questioned.  The user could mlock one page and DMA map another,
> they're both "locked", but now they only take one slot in each bucket.

Right, yes.  Should have been more specific.  I was after a concrete use case
where this would happen (sounded like you may have had a specific tool in
mind).

But it doesn't matter.  I understand your concern and agree that, given the
possibility that accounting in _some_ tool can be affected, we should fix
accounting before changing user visible behavior.  I can start a separate
discussion, having opened the can of worms again :)

> If we continue forward with using a separate bucket here, userspace
> could infer that accounting is unified and lower the user's locked
> memory limit, or exploit the gap that their effective limit might
> actually exceed system memory.  In the former case, if we do eventually
> correct to compare the total of the combined buckets against the user's
> locked memory limits, we'll break users that have adapted their locked
> memory limits to meet the apparent needs.  In the latter case, the
> inconsistent accounting is potentially an attack vector.

Makes sense.

> > > There's a user visible difference if we
> > > account for them in the same bucket vs separate.  Perhaps we're
> > > counting in the wrong bucket now, but if we "fix" that and userspace
> > > adapts, how do we ever go back to accounting both mlocked and pinned
> > > memory combined against rlimit?  Thanks,  
> > 
> > PeterZ posted an RFC that addresses this point[1].  It kept pinned_vm and
> > locked_vm accounting separate, but allowed the two to be added safely to be
> > compared against RLIMIT_MEMLOCK.
> 
> Unless I'm incorrect in the concerns above, I don't see how we can
> convert vfio before this occurs.
>  
> > Anyway, until some solution is agreed on, are there objections to converting
> > locked_vm to an atomic, to avoid user-visible changes, instead of switching
> > locked_vm users to pinned_vm?
> 
> Seems that as long as we have separate buckets that are compared
> individually to rlimit that we've got problems, it's just a matter of
> where they're exposed based on which bucket is used for which
> interface.  Thanks,

Indeed.  But for now, any concern with simply changing the type of the
currently used counter to an atomic, to reduce mmap_sem usage?  This is just an
implementation detail, invisible to userspace.
