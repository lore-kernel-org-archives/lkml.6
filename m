Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A08C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353482077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dnhTst20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353482077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeJKSjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:39:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeJKSjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:39:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9BB93lW167277;
        Thu, 11 Oct 2018 11:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XmHQgPj/uqOkCi9oawpSOKtBKOLUPcNleSM9yEqb0os=;
 b=dnhTst203vzkLwR2X3jNg8uiG0vz8XDLogzcFPmIDs5uHYNTCCHfuqP+dpK8l8RN9B0P
 hVNydnlCza4UHLf32Wdft//Kgti9q/019smlAR9ZdD7STdGykUdX2hmUA8ugey0EfXA/
 2l91P3CGIEKr//V3eY78oM/yuCjHIlBZuDjrqWqGC6iExLuCfXtHLWlU2hfXNU8+5OCH
 D7TuMvmm/1pEmRTDaKoE2D9D3CU85tFzlFBGsSODlHT+6DorXYdsX9rMtq0GcubUO5f2
 PbH2VJkjbnwxAc+KA/r9fp0HCmArsfHPJla3Ihb+o7EZDCiZJaeLiOgs/ik54T90ozTr xQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mxnprbax6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 11:12:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9BBCC8Q010720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 11:12:12 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9BBCCD0009273;
        Thu, 11 Oct 2018 11:12:12 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 11:12:11 +0000
Date:   Thu, 11 Oct 2018 14:12:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH] staging: erofs: harden inode lookup for 32-bit platforms
Message-ID: <20181011111204.zhxh5tw66pdxb3zh@mwanda>
References: <20181009140713.29629-1-gaoxiang25@huawei.com>
 <20181011084413.3sovzgsj6pzyrml7@mwanda>
 <b6baf932-64e5-c902-7e7f-02094b96a8d6@huawei.com>
 <20181011101807.hydncp6nhzjlzznr@mwanda>
 <6318156d-4a3d-e5d0-93c1-90be2345565b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6318156d-4a3d-e5d0-93c1-90be2345565b@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 06:49:57PM +0800, Gao Xiang wrote:
> Hi Dan,
> 
> On 2018/10/11 18:18, Dan Carpenter wrote:
> > On Thu, Oct 11, 2018 at 05:46:26PM +0800, Gao Xiang wrote:
> >>
> >>
> >> On 2018/10/11 16:44, Dan Carpenter wrote:
> >>> On Tue, Oct 09, 2018 at 10:07:13PM +0800, Gao Xiang wrote:
> >>>> This patch introduces inode hash function, test and set callbacks,
> >>>> and iget5_locked to find the right inode for 32-bit platforms.
> >>>>
> >>>
> >>> The way I read this changelog, we're trying to deal with corrupt file
> >>> systems?  Is that correct?  Presumably in the current code it could lead
> >>> to a Oops or something?
> >>
> >> No, this commit isn't trying to deal with corrupt file systems.
> >> In EROFS, the nid is not continuous and it represents the inode offset
> >> inode offset = nid * 32.
> >> Therefore the nid is 64-bit both for 32-bit and 64-bit platforms. However,
> >> i_ino is 'unsigned long', which means for 32-bit platforms, i_ino is not enough
> >> to contain the nid.
> >>
> >> Therefore, we should use iget5_locked for this case.
> > 
> > I guess what I'm saying is, what are the user visible effects of this
> > patch?  It's hard for me to tell from the patch description.  Could you
> > please re-write the description and send a v2?
> 
> Sorry for my just hurry reply. It seems I really misunderstood your point :-(
> 
> If all nids are less than 32-bit, the user will see the correct inode/nid number
> for all 32-bit platforms, but if some nids are greater than 32-bit, it could be
> collisions without this patch for 32-bit platforms.
> 
> This patch switch the inode number by XOR the high 32-bit and the low 32-bit,
> use customized tester to avoid collisions for 32-bit platforms.
> 
> I will send v2 to fix the commit message...but it seems Greg is already merged in
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=2abd7814138774eb56319e9dcc0abd08ece45424
> 

Oh.  Then that's fine then.  If Greg already merged it, then it's too
late to change.  Thanks for the explanation, though.

regards,
dan carpenter

