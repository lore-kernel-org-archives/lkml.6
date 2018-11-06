Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1820AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D990B2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D990B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbeKFWZY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:25:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387596AbeKFWZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:25:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14A008AE5A;
        Tue,  6 Nov 2018 13:00:18 +0000 (UTC)
Received: from ovpn-12-92.pek2.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 455C41710E;
        Tue,  6 Nov 2018 13:00:14 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] ceph: quota: fix null pointer dereference in quota check
From:   "Yan, Zheng" <zyan@redhat.com>
In-Reply-To: <20181105110052.31759-1-lhenriques@suse.com>
Date:   Tue, 6 Nov 2018 21:00:09 +0800
Cc:     Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3AD4F375-E9DE-485D-B2DA-A938AC4A3F0C@redhat.com>
References: <20181101065318.2cylxol6d444nzeu@kili.mountain>
 <20181105110052.31759-1-lhenriques@suse.com>
To:     Luis Henriques <lhenriques@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 06 Nov 2018 13:00:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 5, 2018, at 19:00, Luis Henriques <lhenriques@suse.com> wrote:
> 
> This patch fixes a possible null pointer dereference in
> check_quota_exceeded, detected by the static checker smatch, with the
> following warning:
> 
>    fs/ceph/quota.c:240 check_quota_exceeded()
>     error: we previously assumed 'realm' could be null (see line 188)
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lkml.kernel.org/n/20181101065318.2cylxol6d444nzeu@kili.mountain
> Fixes: b7a2921765cf ("ceph: quota: support for ceph.quota.max_files")
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> fs/ceph/quota.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 32d4f13784ba..03f4d24db8fe 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -237,7 +237,8 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
> 		ceph_put_snap_realm(mdsc, realm);
> 		realm = next;
> 	}
> -	ceph_put_snap_realm(mdsc, realm);
> +	if (realm)
> +		ceph_put_snap_realm(mdsc, realm);
> 	up_read(&mdsc->snap_rwsem);
> 
> 	return exceeded;

Applied, thanks.

Yan, Zheng


