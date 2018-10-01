Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEAAC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702BC208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QZzhtv+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702BC208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeJAWXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:23:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53182 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJAWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:23:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w91Fi2QW079501;
        Mon, 1 Oct 2018 15:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=aq+D6ORcfHk6oLIDzrTRVxOZ2WHwD/PzPMrrS53WfkQ=;
 b=QZzhtv+bAmYzOv4t8JgvOWl027jHoUcevEx/2fq9KB89/Ql5dvyxRH4zN7ysE99OfreU
 KMftI/px76UA3Ov5OgJS5ipqY8yNQL/9ia4upXP2HCjdPx2sehMACtlc1RnaA3qCsKnV
 Lx126zCGZ3EqdmSiDWId9W6SyuErK8qcPl3oRswgg4BR842wVMP3tVI22xbhqYdl8L1b
 7n29v1ZghQeWAotyBePihQaD/oVjUAEAWzOZyFqbwRfyP1ieQVfDJZAjqbpZoWPMT3Jh
 5tTsMWK1dNXxbuJeXfMSys4McnaL4yUFFK3CpQIgnznsPSZUI0rpRfN+U1h/wkykKz5U xw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mt21qr49k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Oct 2018 15:45:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w91Fj1s4001159
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Oct 2018 15:45:01 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w91Fj0dZ000585;
        Mon, 1 Oct 2018 15:45:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Oct 2018 08:45:00 -0700
Date:   Mon, 1 Oct 2018 08:44:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>, TongZhang <ztong@vt.edu>,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <20181001154459.GB5872@magnolia>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
 <20180926013329.GD31060@dastard>
 <20180926192426.472360ea@alans-desktop>
 <20180927013812.GF31060@dastard>
 <20180930151652.6975610c@alans-desktop>
 <20181001002521.GM31060@dastard>
 <20181001160442.47c798bc@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001160442.47c798bc@alans-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9033 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:04:42PM +0100, Alan Cox wrote:
> >         /* only root can play with this */
> >         if (!capable(CAP_SYS_ADMIN))
> >                 return -EACCES;
> > 
> > Think about it - if DM control ioctls only require CAP_SYS_ADMIN,
> > then if have that cap you can use DM to remap any block in a block
> > device to any other block. You don't need to the filesystem to move
> > stuff around, it can be moved around without the filesystem knowing
> > anything about it.
> 
> Yes - I am not surprised the XFS is not the only problem area. The fact
> XFS also isn't going via the security hooks so security hooks can fix it
> just makes it worse.
> 
> > > That's what people said about setuid shell scripts.  
> > 
> > Completely different. setuid shell scripts got abused as a hack for
> > the lazy to avoid setting up permissions properly and hence were
> > easily exploited.
> 
> Sounds to me like an accurate description of the current capabilities
> mess in the kernel (and not just XFS and not just file systems)
> 
> > Systems restricted by LSMs to the point where CAP_SYS_ADMIN is not
> > trusted have exactly the same issues. i.e. there's nobody trusted by
> > the kernel to administer the storage stack, and nobody has defined a
> > workable security model that can prevent untrusted users from
> > violating the existing storage trust model....
> 
> With a proper set of LSM checks you can lock the filesystem management
> and enforcement to a particular set of objects.

What would a proper set look like?  I /thought/ CAP_SYS_ADMIN was an
(admittedly overly general) way to do that, but evidently that view is
not considered correct.

Looking at include/linux/security.h, I don't see any hooks that seem
like an obvious fit for a lot of the XFS ioctls.  Do we need to add
some?  How do we do that?

Just looking at XFS, we let CAP_SYS_ADMIN processes do things like...

- Change the size of the filesystem
- Discard all post-EOF speculative preallocations
- Manage reserved block pools (which help us avoid ENOSPC)
- Query the filesystem for detailed space usage information
- Issue DISCARDs on unused space

- Set a new volume label
- Check and repair metadata

- Inject errors for testing
- Emergency shutdowns of the FS

- Bulk stat() of inodes
- Deal with files (open, read xattrs, read link targets) via file handles
- Read system xattrs

Can we create the necessary LSM hooks to check all of those things?  I
could see the following new hooks:

* Query filesystem space information
* Manage filesystem space information
* Set new filesystem label/uuid
* Run metadata integrity operations
* Access testing / debugging hooks
* Reading filesystem internal metadata
* Picking files by handle instead of path

I imagine block devices probably need a few explicit hooks too:

* Raw reads
* Raw writes
* Reconfigure block device

If we /did/ replace CAP_SYS_ADMIN checking with a pile of LSM hooks, how
do we make sure that we (XFS) avoid breaking existing XFS tools?  I
guess the default compatibility handler for all of those new hooks would
be "return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;" and then other LSMs
could restrict that further if so configured.

Seriously, I don't know that much about how LSMs actually perform
security checks -- it looks like a number of them can be active
simultaneously, and we just call each of them in a chain until one of
them denies permission or we run out of LSMs and allow it?

FWIW I didn't have a particular security or threat model in mind when I
made the above list; all I did was break up the existing CAP_SYS_ADMIN
into rough functional areas.  Maybe it makes sense, but maybe I'm
rambling. :)

--D

> You can build that model where for example only an administrative
> login from a trusted console may launch processes to do that
> management.
> 
> Or you could - if things were not going around the LSM hooks.
> 
> Alan
