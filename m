Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD95C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A841320852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dU4pLrpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A841320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeGYPoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:44:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeGYPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:44:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6PETSNf123498;
        Wed, 25 Jul 2018 14:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ROkCH+V4/ZdcmBUDbKLUHlUvEC8hwH7DPOfvR1ybh2Y=;
 b=dU4pLrpCSa/vDAUgDo3K+Ljhet3+0BNuUj9jeeFejkEtl3Sfcsxe9rx73vs75kgxdT64
 v5OfGMD/00UnvIBIOa6ngaAmYOhKg+MijoBHcyhpcejYWkzSiAzAg43Rnq0J3wJt19jq
 v9oU8yYqM754sjOZ9XLEQxMcqzI/pIpUu1VJZWIOcgk5NRb7LXCHwhG/RCZqFXFD9Qwg
 xMWfBl+FgFV5F/Snd+PANT5X33+295l7J8+Dc+9Q6LwxFLjINZHwq74SERv5F5dvJqs3
 NhwJzD7eVZYbex5/bEvEEHFFdemJoLZ/sMoEi6TlGAaCj+FqMKX9VqCnCDZePoO5d5/e UA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kbv8t5pjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 14:32:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6PEW1Af001198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 14:32:01 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6PEVvOW015686;
        Wed, 25 Jul 2018 14:31:57 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Jul 2018 07:31:57 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [BUG BISECT] NFSv4 client fails on Flush Journal to Persistent
 Storage
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAJKOXPfMiaGP9xqPcOQMs+a4RKvhK03v51e5r3GaUiFs0G=61Q@mail.gmail.com>
Date:   Wed, 25 Jul 2018 10:31:54 -0400
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
Message-Id: <9B9E1627-AC2E-4A0C-AB6E-5815876A59AB@oracle.com>
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
To:     Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=847
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 25, 2018, at 9:27 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> On 18 June 2018 at 18:20, Chuck Lever <chuck.lever@oracle.com> wrote:
>> 
>> The extra serialization appears to have a reproducible performance
>> impact on RDMA, which no longer takes the reserve_lock when allocating
>> a slot.
>> 
>> I could put an xprt_alloc_xid call in xprt_alloc_slot, but that would
>> only work for socket-based transports. Would it be OK if RDMA had its
>> own XID allocation mechanism?
> 
> Hi,
> 
> On recent next the issue appeared again. My boards with NFSv4 root
> timeout on 80% of boots. This time my NFS server is faster - Pi3 B+
> :).
> 
> Is this know? Should I start long bisect or maybe you can point me to
> possible causes?

Hi Krzysztof, I don't know of any recent changes. Bisecting would be
a good place to start.


--
Chuck Lever



