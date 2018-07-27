Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA7BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B81206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zmjtdbZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B81206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbeG0DH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:07:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57192 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731933AbeG0DH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:07:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6R1isRI002296;
        Fri, 27 Jul 2018 01:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=YDCkVhoQCpxQGWOoUO47x24j7lPQYTUsk4goWUre4H8=;
 b=zmjtdbZqJNwQCyijsifQdbtVYlkN6OZx52+rr0WMuLCuYaKyd2O1rpcE4kLh4RNnhRV7
 AV4Va6zO2bEgxliS9/cA6vHBKuZ6wvdCpwwXWOIlWp2GEl2uUPWHyLPEE96L8smCEYi9
 HtRX+CIg2I6ZQsTc9fWvVEnwbShvJV5+Pqj8WoOatu+Bks2ckEc9DuWb44NQlMhzhqGt
 N7Y/5MWEMgrsckWnWfeqi/3WW9pWtPUyB2PNuWHJs56sLOBPkKvd4sTZVKSqQx0pGvrZ
 j17wtbeMPdG5N5wcScJ5ayCTQUXebrQZKenpoya1kH2Gt1Tme58N96ftKvmp0eOVhw39 GQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kbtbd5eqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jul 2018 01:48:14 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6R1mDt1002481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jul 2018 01:48:13 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6R1m9dw000381;
        Fri, 27 Jul 2018 01:48:09 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 18:48:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [BUG BISECT] NFSv4 client fails on Flush Journal to Persistent
 Storage
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAJKOXPejStfaQdtUwh33v+aC7KpamoLkix3nitbHrDRx4QAR6g@mail.gmail.com>
Date:   Thu, 26 Jul 2018 21:48:06 -0400
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <63E567B6-ACC6-449F-95F6-1F17102221F1@oracle.com>
References: <CAJKOXPd2rntNOpU1quR9Zm_J22+=pEaj4ZTC_tdZ0zcRYUciFg@mail.gmail.com>
 <CAPKp9uZ79ybkv7dMpcy2GQ9L+rWk+vdExQ48diWWQPOUdDQtSQ@mail.gmail.com>
 <CAJKOXPfX0CytKcYDaDAYYuCQjk-mcGjFRHfZco-wPQsc4G1agA@mail.gmail.com>
 <BCD39D7E-EEEC-4EB9-824E-63323C333C88@oracle.com>
 <CAJKOXPcw-i99_U-Ltuuf6w-WRK7V4gNqVSYkCMGFEXQG2DL2XQ@mail.gmail.com>
 <CAJKOXPf7V1z4pNZ2RsjkJmaVAgk34_rPOtQOc7J5KRMSRemrdg@mail.gmail.com>
 <082848F5-6360-4523-BA95-601777E17CF2@oracle.com>
 <CAJKOXPe4uqOZGd_zb_Mqq4Fspu63LHZky86O4tPaD3BZNCBS6w@mail.gmail.com>
 <6AAC5897-8762-4209-8718-67291B87AA00@oracle.com>
 <d617f8a85c3414230cd755fe0e4470c0f8bd17ff.camel@hammerspace.com>
 <26995E49-E8DD-421D-BABF-9E672B9383BD@oracle.com>
 <30a1455b6817361f8228c022628aef5cdee70c3e.camel@hammerspace.com>
 <784782B0-A387-4D3B-A517-E85D851162B8@oracle.com>
 <CAJKOXPfMiaGP9xqPcOQMs+a4RKvhK03v51e5r3GaUiFs0G=61Q@mail.gmail.com>
 <9B9E1627-AC2E-4A0C-AB6E-5815876A59AB@oracle.com>
 <CAJKOXPejStfaQdtUwh33v+aC7KpamoLkix3nitbHrDRx4QAR6g@mail.gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8966 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=886
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807270014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 26, 2018, at 4:46 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> On 25 July 2018 at 16:31, Chuck Lever <chuck.lever@oracle.com> wrote:
>> 
>> 
>>> On Jul 25, 2018, at 9:27 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> 
>>> On 18 June 2018 at 18:20, Chuck Lever <chuck.lever@oracle.com> wrote:
>>>> 
>>>> The extra serialization appears to have a reproducible performance
>>>> impact on RDMA, which no longer takes the reserve_lock when allocating
>>>> a slot.
>>>> 
>>>> I could put an xprt_alloc_xid call in xprt_alloc_slot, but that would
>>>> only work for socket-based transports. Would it be OK if RDMA had its
>>>> own XID allocation mechanism?
>>> 
>>> Hi,
>>> 
>>> On recent next the issue appeared again. My boards with NFSv4 root
>>> timeout on 80% of boots. This time my NFS server is faster - Pi3 B+
>>> :).
>>> 
>>> Is this know? Should I start long bisect or maybe you can point me to
>>> possible causes?
>> 
>> Hi Krzysztof, I don't know of any recent changes. Bisecting would be
>> a good place to start.
> 
> Hi,
> 
> That was my mistake because of missing part of NFS server
> configuration on new board. I tested again recent releases and current
> linux-next and everything works fine.
> 
> Sorry for the noise.

Thanks for the update.


--
Chuck Lever



