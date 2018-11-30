Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BD6C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6353C2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lIpZ2++v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6353C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLAHqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:46:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeLAHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:46:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAUKY8UI085112;
        Fri, 30 Nov 2018 20:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jmp3J+x7nYWDXCr5pEJPaI0Z5oLSjbxos2adqsGHl0U=;
 b=lIpZ2++vvDtZ50ZlVrGlKDtdxU/1wiZc2stmfQdIhkqZWx4UCuV+ooe+K3+i35XPHdsz
 z3I0WcE58CHhga+mPyWuS0iK2wXkcniGF2Qkih0wrzeovhXCL77N1dYutb0RYJCQ7tvr
 0fvFeezDunr4JmC5/gCWG44ylS7BorRma2kG1lUFYt/5qq0bLniynAMA9IwIThksCXVV
 N9DkECiVz7T15VJhwO5ULnGGVCI9JGt1/kGszbVXWkLPo8lRlJdfp47mHr0EAIz8pejp
 fcnV60otVsXRdh3BTlC58x8YK5DJ4jjtDpTt1S2QMdD0uNTjxY4XhxSOQPvaHCkkuj7Y QQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nxxkr09rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 20:35:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAUKZTBs030525
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 20:35:29 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAUKZTsI002629;
        Fri, 30 Nov 2018 20:35:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Nov 2018 12:35:28 -0800
Date:   Fri, 30 Nov 2018 12:35:27 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181130203527.GP8125@magnolia>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130101441.GA213156@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9093 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811300175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 05:14:41AM -0500, Sasha Levin wrote:
> On Fri, Nov 30, 2018 at 09:22:03AM +0100, Greg KH wrote:
> > On Fri, Nov 30, 2018 at 09:40:19AM +1100, Dave Chinner wrote:
> > > I stopped my tests at 5 billion ops yesterday (i.e. 20 billion ops
> > > aggregate) to focus on testing the copy_file_range() changes, but
> > > Darrick's tests are still ongoing and have passed 40 billion ops in
> > > aggregate over the past few days.
> > > 
> > > The reason we are running these so long is that we've seen fsx data
> > > corruption failures after 12+ hours of runtime and hundreds of
> > > millions of ops. Hence the testing for backported fixes will need to
> > > replicate these test runs across multiple configurations for
> > > multiple days before we have any confidence that we've actually
> > > fixed the data corruptions and not introduced any new ones.
> > > 
> > > If you pull only a small subset of the fixes, the fsx will still
> > > fail and we have no real way of actually verifying that there have
> > > been no regression introduced by the backport.  IOWs, there's a
> > > /massive/ amount of QA needed for ensuring that these backports work
> > > correctly.
> > > 
> > > Right now the XFS developers don't have the time or resources
> > > available to validate stable backports are correct and regression
> > > fre because we are focussed on ensuring the upstream fixes we've
> > > already made (and are still writing) are solid and reliable.

I feel the need to contribute my own interpretation of what's been going
on the last four months:

What you're seeing is not the usual level of reluctance to backport
fixes to LTS kernels, it's our own frustrations at the kernel
community's systemic inability to QA new fs features properly.

Four months ago (prior to 4.19) Zorro started digging into periodic test
failures with shared/010, which resulted in some fixes to the btrfs
dedupe and clone range ioctl implementations.  He then saw the same
failures on XFS.

Dave and I stared at the btrfs patches for a while, then started looking
at the xfs counterparts, and realized that nobody had ever added those
commands to the fstests stressor programs, nor had anyone ever encoded
into a test the side effects of a file remap (mtime update, removal of
suid).  Nor were there any tests to ensure that these ioctls couldn't be
abused to violate system security and stability constraints.

That's why I refactored a whole ton of vfs file remap code for 4.20, and
(with the help of Dave and Brian and others) worked on fixing all the
problems where fsx and fsstress demonstrate file corruption problems.

Then we started asking the same questions of the copy_file_range system
call, and discovered that yes, we have all of the same problems.  We
also discovered several failure cases that aren't mentioned in any
documentation, which has complicated the generation of automatable
tests.  Worse yet, the stressor programs fell over even sooner with the
fallback splice implementation.

TLDR: New features show up in the vfs without a lot of design
documentation, incomplete userspace interface manuals, and not much
beyond trivial testing.

So the problem I'm facing here is that the XFS team are singlehandedly
trying to pay off years of accumulated technical debt in the vfs.  We
definitely had a role in adding to that debt, so we're fixing it.

Dave is now refactoring the copy_file_range backend to implement all the
necessary security and stability checks, and I'm still QAing all the
stuff we've added to 4.20.

We're not finished, where "finished" means that we can get /one/ kernel
tree to go ~100 billion fsxops without burping up failures, and we've
written fstests to check that said kernel can handle correctly all the
weird side cases.

Until all those fstests go upstream, I don't want to spread out into
backporting and testing LTS kernels, even with test automation.  By the
time we're done with all our upstream work you ought to be able to
autosel backport the whole mess into the LTS kernels /and/ fstests will
be able to tell you if the autosel has succeeded without causing any
obvious regressions.

> > Ok, that's fine, so users of XFS should wait until the 4.20 release
> > before relying on it?  :)

At the rate we're going, we're not going to finish until 4.21, but yes,
let's wait until 4.20 is closer to release to start in on porting all of
its fixes to 4.14/4.19.

> It's getting to the point that with the amount of known issues with XFS
> on LTS kernels it makes sense to mark it as CONFIG_BROKEN.

These aren't all issues specific to XFS; some plague every fs in subtle
weird ways that only show up with extreme testing.  We need the extreme
testing to flush out as many bugs as we can before enabling the feature
by default.  XFS reflink is not enabled by default and due to all this
is not likely to get it any time soon.

(That copy_file_range syscall should have been rigorously tested before
it was turned on in the kernel...)

> > I understand your reluctance to want to backport anything, but it really
> > feels like you are not even allowing for fixes that are "obviously
> > right" to be backported either, even after they pass testing.  Which
> > isn't ok for your users.
> 
> Do the XFS maintainers expect users to always use the latest upstream
> kernel?

For features that are EXPERIMENTAL or aren't enabled by default, yes,
they should be.

--D

> 
> --
> Thanks,
> Sasha
