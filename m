Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5067F21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5PMC30nF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAWSDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:03:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfAWSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:03:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NHx8pb080932;
        Wed, 23 Jan 2019 18:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=L7KNFaLuoeWXZt5Kqc8T1Znp4vIQhaEABJbxHmrMl9E=;
 b=5PMC30nFSC5R8FSaQxRT2DauyDLSuw1QGYMVhG25F3EhnFQKjDdVBcoML7a1RLJzHHBD
 WFvSmEQyppOh4qovuovG33IhWFnLc2yATGkXyz/P4iBZYsVvtW2rQNtNGn8YRbCWKVgA
 dsg6fdQML4bQReZtaJwT2ikPEYntVHNkmZVc2cZeH0UzPSVa/R0G5zGgvIJ+UTcOSERA
 69H/KdmieUy+Y+Bwccq/SeBU+rLl2is3zTyI01S7GnXs4P9v/ygvU1hcOqrQqfWP88jm
 GhHwH4b6Y7QQtbQoDk0mzlJf4jwqUK63EctONYr1KHg9yeIcdf4MxJTCpDDty4VHIJmN pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q3vhrud4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:03:34 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NI3X9r004197
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:03:33 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NI3XoL011836;
        Wed, 23 Jan 2019 18:03:33 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 10:03:32 -0800
Date:   Wed, 23 Jan 2019 13:03:17 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 08/13] KVM/nVMX: Use kvm_vcpu_map when mapping the
 posted interrupt descriptor table
Message-ID: <20190123180314.GM19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-9-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-9-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=736
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:08AM +0100, KarimAllah Ahmed wrote:
> Use kvm_vcpu_map when mapping the posted interrupt descriptor table since
> using kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory
> that has a "struct page".
> 
> One additional semantic change is that the virtual host mapping lifecycle
> has changed a bit. It now has the same lifetime of the pinning of the
> interrupt descriptor table page on the host side.

Is the description stale? I am not seeing how you are changing the
semantics here. You follow the same path - map/unmap.

Could you expand please?

> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v4 -> v5:
> - unmap with dirty flag
> 
> v1 -> v2:
> - Do not change the lifecycle of the mapping (pbonzini)
