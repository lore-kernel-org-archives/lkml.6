Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A341C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FC62173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pjaj2YHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfAHFHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:07:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfAHFHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:07:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x084xt6k176054;
        Tue, 8 Jan 2019 05:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=BOF8zLPlRfBkFXlEvYnlTN7TUDSdg9M/4VsWxklbMwk=;
 b=pjaj2YHOHrAJs9RKUbXtJbE8hycwhR3g3C66EiUZfqYq6zMuBdEYUbXPSogi2PnFU8fj
 1S1yNYncz/5ODHtTUr7GzbD0HhKKNUlp12u4+2ilHgpvilAK+BVgYT1ZGv+XgAZ6FdSG
 Bbj9HU088wITfl+pfn8y9MTWgsPx2gHzsoZzz2jg4obHZ6VExR+Z+TDgTCPipoYjm+Am
 B6PL0fSsh9amElm2CuCpk3yWsYCBl9u7vvA1WbVk8/WdTQpG5IQri5I7invXtuzF0x4+
 z1ZWvPYkO43KHjkIgEQQlTA6aUTwiyJZFoGGQW+F2NsfrN7FmUFt19DVrdDEZsR7yw7D dA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ptm0u1c0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 05:07:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0857fXi017993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 05:07:42 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0857ea1027926;
        Tue, 8 Jan 2019 05:07:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jan 2019 21:07:40 -0800
Date:   Mon, 7 Jan 2019 21:07:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, suyanjun218@gmail.com
Subject: Re: [PATCH] xfs: correct statx's result_mask value
Message-ID: <20190108050739.GQ12689@magnolia>
References: <1546854790-5233-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190107175229.GJ12689@magnolia>
 <2b27e2ec-368b-d24c-8443-e265f87e417c@sandeen.net>
 <67e03af1-6e11-4236-76e6-6127b6cfb9b9@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e03af1-6e11-4236-76e6-6127b6cfb9b9@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:58:43PM +0800, Su Yanjun <suyj.fnst@cn.fujitsu.com> wrote:
> 
> 
> On 1/8/2019 2:04 AM, Eric Sandeen wrote:
> > On 1/7/19 11:52 AM, Darrick J. Wong wrote:
> > > On Mon, Jan 07, 2019 at 04:53:10AM -0500, Su Yanjun wrote:
> > > > For statx syscall, xfs return the wrong result_mask.
> > > > 
> > > > Signed-off-by: Su Yanjun<suyj.fnst@cn.fujitsu.com>
> > > > ---
> > > >   fs/xfs/xfs_iops.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > > index f48ffd7..3811457 100644
> > > > --- a/fs/xfs/xfs_iops.c
> > > > +++ b/fs/xfs/xfs_iops.c
> > > > @@ -521,6 +521,9 @@ xfs_vn_getattr(
> > > >   			stat->btime.tv_nsec = ip->i_d.di_crtime.t_nsec;
> > > >   		}
> > > >   	}
> > > > +	
> > > > +	/* Only return mask that we care */
> > > > +	stat->result_mask &= request_mask;
> > > Why not just:
> > > 
> > > 	stat->result_mask = STATX_BASIC_STATS;
> > > 
> > > at the top of the function?
> > > 
> > > I don't see the need to mask off result_mask at all, since we could some
> > > day elect to return more than what's in request_mask...
> When we run xfstests with nfs, the generic/423 case runs failed. So i review
> the nfs'
> nfs_getattr code it does validate the request_mask.
> 
> Then i review the xfs' getattr code, it has no such check. Whatever
> request_mask
>  is set, the stat's result_mask always the 0x7ff.

Yes, statx can return more data than what userspace callers ask for:

> Maybe it has Unclear semantics about statx's result_mask.

"A filesystem may also fill in fields that the caller didn't ask for if
it has values for them available and the information is available at no
extra cost.  If this happens, the  corresponding  bits will be set in
stx_mask."

--D

> > > ...waitaminute, are you seeing garbage in the result_mask that's
> > > returned to userspace?  I also noticed the vfs stat functions declare
> > > "struct kstat stat;" without explicitly zeroing the structure fields,
> > > which means (I think) that we can leak stack information if the kernel
> > > isn't built with the stackleak plugin?
> No such problem.
> > A clear problem statement and reproducer steps would be hugely useful
> > here.
> > 
> > -Eric
> Thanks,
> Su
> 
> 
