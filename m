Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6107FC37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1160E21736
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QRSZoB3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfAUXwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:52:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfAUXwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:52:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0LNnb2A071205;
        Mon, 21 Jan 2019 23:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Hq/Qg44AYB/6GNSa3cN/OGotgUeaTw+/CCmEkkQ+xEE=;
 b=QRSZoB3mfSv/raXbmjg6saS+6yUsqBrl9sAznhz2E10gZ/B5Iljab9FpSxSKcIC9MlFy
 BXNXl2cbiaAcsBayKKFwAiDAb1KZ1ut5V/2QE/6QiyAPwV2U6Sm7LupN9D2V3swyJ53z
 uK6lqS0NyZVJmWm0EF93nO4NEE1TOtYi7v50XwQMAznfK9kYyiZ11y2ie5OqXwj5EEIA
 G1iLePpFdkgfG6YMEyRm6aPCWsLcMh4PSZQasIJ3GoDa1VsEi/9VSbISPNtgnSJzl7+J
 rP3kGO27USRPgoW0SfTUFEjy6muFstGfjWLpHeteq0NGPbaf6bX4PLG07wZw5Br+1YKy cA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q3vhrgn55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jan 2019 23:52:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0LNq2hP011220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jan 2019 23:52:02 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0LNq0mW005756;
        Mon, 21 Jan 2019 23:52:00 GMT
Received: from localhost (/10.159.159.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jan 2019 15:51:59 -0800
Date:   Mon, 21 Jan 2019 15:51:58 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jann Horn <jannh@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Pavel Machek <pavel@ucw.cz>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
Message-ID: <20190121235158.GA4363@magnolia>
References: <20190118161440.220134-1-jannh@google.com>
 <20190121215454.GA12996@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121215454.GA12996@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9143 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901210186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:54:54PM -0500, Theodore Y. Ts'o wrote:
> On Fri, Jan 18, 2019 at 05:14:38PM +0100, Jann Horn wrote:
> > Multiple filesystems can already return EFSCORRUPTED errors to userspace;
> > however, so far, definitions of EFSCORRUPTED were in filesystem-private
> > headers.
> > 
> > I wanted to use EUCLEAN to indicate data corruption in the VFS layer;
> > Dave Chinner says that I should instead hoist the definitions of
> > EFSCORRUPTED into the UAPI header and then use EFSCORRUPTED.
> > 
> > This patch is marked for stable backport because it is a prerequisite for
> > the following patch.
> > 
> > Cc: stable@vger.kernel.org
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Jann Horn <jannh@google.com>
> 
> Before we enshrine the overloading of EUCLEAN and EFSCORRUPTED, I
> wonder if we should at least consider the option of assigning a new
> error code number for EFSCORRUPTED.  The downside of doing this is
> that for a while, older versions glibc won't have strerror/perror
> translation for the new error code.  On the other hand, I'm not sure
> it will be that much more confusing to the average user than
> "Structure needs cleaning".  :-)
> 
> The upside of assigning a new error code is that in a year or two,
> we'll actually have an intelligible error message showing up in log
> files and in user's terminals.

Uh... Ted?  Back in ~2009 we had a discussion on the ext4 conference
call about what error codes to return for "metadata is garbage" and
"metadata crc doesn't validate".  Back then you said that it would have
been great if someone had thought of defining error codes for that so
that by the time we got around to merging metadata checksums for ext4,
we'd have some error codes ready to go.

I pointed out that "the XFS people" already returned EUCLEAN /
EFSCORRUPTED and EILSEQ / EBADFSCRC for those cases and that upstream
had been doing that for a couple of years already, so we decided that
we'd just make ext4 behave like XFS because they'd already started
training everyone and their pet search engines that these oddly phrased
error messages in the context of a filesystem means they need to run
some sort of fsck/repair tool.  We also decided that while the messaging
was weird, it would be less work for both of us than to try to push
disruptive changes through Linux uapi, glibc, man pages, strerror
localization catalogs, etc.

Now it's a *decade* later, and ext4 / XFS have both converged on more or
less the same behavioral patterns w.r.t. when they return EFSCORRUPTED
and EFSBADCRC.  btrfs, hpfs, jffs2, and ubifs seem to use EUCLEAN to
signal bad metadata just like XFS and ext4 do.

I disagree with upending 13 years of established precedent for user
visible behavior.  We possibly could've pulled this off ten years ago,
but it's waaaay too late now.  Too much work, too little gain.

--D

> 					- Ted
