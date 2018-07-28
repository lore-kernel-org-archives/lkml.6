Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B21C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5B12088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GT+2BM8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5B12088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeG1JMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 05:12:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeG1JMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 05:12:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6S7jCWX183578;
        Sat, 28 Jul 2018 07:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vLjAWrjn6u0HLgoERA4VMT/XajitL0etOiR6AbG2qr0=;
 b=GT+2BM8V4B0P10E5bwWSG70Ti5tGU9SLZF5bSEkb+OanFxe1IloxS/8HQHGtFE05+YeY
 2578V0EYDBLQvI1fTlECBgiXeTLtJwNYC9WEoeaBjo2gU64+FsvEhW5bKiz+K64tZvdu
 YUwPF4TH1N0KcXU4LMSsb/4UBId9FsVrjeYFqut4ZVGijVv55N2fiQHvi3ij40OzbNoi
 O2BoV8qCtGm3WQ3yDwnMJjBzxUoQBx7/GCrvKajbtHDrY8Paa22aA2SLzbt4/LwDJTEp
 dTrjfB5oJxNfwvkty0WAahQE2i9w+0EzbdB8KIX/6FMRoNdJdXYCWdDIaocoYzfI6hCV hg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kgh4pr5by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jul 2018 07:47:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6S7l97P022268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jul 2018 07:47:09 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6S7l6IC027444;
        Sat, 28 Jul 2018 07:47:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 28 Jul 2018 00:47:06 -0700
Date:   Sat, 28 Jul 2018 00:47:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sodagudi Prasad <psodagud@codeaurora.org>,
        adilger.kernel@dilger.ca, wen.xu@gatech.edu,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Remounting filesystem read-only
Message-ID: <20180728074704.GA4203@magnolia>
References: <366cf3ac534bbadaaa61714a43006ac7@codeaurora.org>
 <e9869d6cd358e9de395d730ab7b3aa60@codeaurora.org>
 <20180727195213.GE13922@thunk.org>
 <c121825198eba667c09fc53fa9b4fd3a@codeaurora.org>
 <20180728001823.GA28432@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180728001823.GA28432@thunk.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8967 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807280083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 08:18:23PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Jul 27, 2018 at 01:34:31PM -0700, Sodagudi Prasad wrote:
> > > The error should be pretty clear: "Inode table for bg 0 marked as
> > > needing zeroing".  That should never happen.
> > 
> > Can you provide any debug patch to detect when this corruption is happening?
> > Source of this corruption and how this is partition getting corrupted?
> > Or which file system operation lead to this corruption?
> 
> Do you have a reliable repro?  If it's a one-off, it can be caused by
> *anything*.  Crappy hardware, a bug in some proprietary, binary-only
> GPU driver dereferencing some wild pointer that corrupts kernel
> memory, etc.
> 
> Asking for a debug patch is like asking for "can you create technology
> that can detect when a cockroach enter my house?"

Well, ext4 *could* add metadata read and write verifiers to complain
loudly in dmesg about stuff that shouldn't be there, so at least we'd
know when we're writing cockroaches into the house... :)

--D

> So if you have a reliable repro, then we know what operations might be
> triggering the corruption, and then you work on creating a minimal
> repro, and only *then* when we have a restricted set of possibilities
> that might be the cause (for example, if removing a GPU call makes the
> problem go away, then the patch would need to be in the proprietary
> GPU driver....)
> 
> > I am digging code a bit around this warning to understand more.
> 
> The warning means that a flag in block group descriptor #0 is set
> that should never be set.  How did the flag get set?  There is any
> number of things that could cause that.
> 
> You might want to look at the block group descriptor via dumpe2fs or
> debugfs, to see if it's just a single bit getting flipped, or if the
> entire block group descriptor is garbage.  Note that under normal code
> paths, the flag *never* gets set by ext4 kernel code.  The flag will
> get set on non-block group 0 block group descriptors by ext4, and the
> ext4 kernel code will only clear the flag.
> 
> Of course, if there is a bug in some driver that dereferences a
> pointer widely, all bets are off.
> 
> 					- Ted
