Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BAEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1968820851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mwZxTHDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeLMVSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:18:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50924 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLMVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:18:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBDLEHSq184585;
        Thu, 13 Dec 2018 21:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=MyiyEqpIp9y1UDoyMMg4GLoeCVRl3XddOrZgHH+DbBA=;
 b=mwZxTHDgDpFDy3VodFXB5MZyVTe2UAWlMePQBHZDymCRjkAQopa5JacA1xb+Cu3AYWfK
 Fm9jaixOrHzIjG1azqQxXQUp32WyVHmpWRdR90exp+szrcByurNcmYLe80RiDr0cvL5D
 aQP6QoJD8KxfkrRMIDvsFroh+M0wkXDhGyhRlyrtRorhJR4tlBmRaZdNnYOxL8uruL2o
 hXn38LAXZIdt6XtpCr7yEND4UwGWgVeTZbHr7ZK8R6Ed6lqkWEKjdc9cfzMne6VkXfRt
 +l1xcaCZrGZ+3cK35w5f7DjLDaRhj5EHskt5gf/xwQdtQLZQGv7rNTBFnmxVN5zsMfQe lA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pb7tf6hne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 21:18:48 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBDLIgV2024076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 21:18:42 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBDLIfOC009664;
        Thu, 13 Dec 2018 21:18:42 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 13:18:41 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id A71AD6A0109; Thu, 13 Dec 2018 16:18:40 -0500 (EST)
Date:   Thu, 13 Dec 2018 16:18:40 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20181213211840.GC18692@char.us.oracle.com>
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213101022.12475-4-jasowang@redhat.com>
 <20181213102713-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213102713-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9106 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812130182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.giant snip..
> > +	npinned = get_user_pages_fast(uaddr, npages, write, pages);
> > +	if (npinned != npages)
> > +		goto err;
> > +
> 
> As I said I have doubts about the whole approach, but this
> implementation in particular isn't a good idea
> as it keeps the page around forever.
> So no THP, no NUMA rebalancing, userspace-controlled
> amount of memory locked up and not accounted for.
> 
> Don't get me wrong it's a great patch in an ideal world.
> But then in an ideal world no barriers smap etc are necessary at all.

So .. suggestions on how this could be accepted? As in other ways
where we still get vmap and the issues you mentioned are not troubling you?

Thanks!
