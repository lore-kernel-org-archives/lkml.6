Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D2F19C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BBB20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdGKYrwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BBB20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935130AbeFMBIP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:08:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39698 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933390AbeFMBIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:08:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D16cJW098452;
        Wed, 13 Jun 2018 01:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=O5iB7Aprjifud8uNCkKZxA7YdMfp8ogwznxDszLTQYA=;
 b=JdGKYrwdj7ypewBJIuPc+3U54JExZfCZ9Px1pOA4htOrQMsMLP9wLXrYT0nTfWGG2PEB
 RR8Td0POCifZ+uTaEVuN+F7cjho9nRO8DI0CVaTVfONt7cex344Pg9eGa6MIlnZJu2Zp
 vmbNsBvV2mM0VMNXYlqvlXfs0zafX9Hqn4EPAulU2R3yFIMOEB0uSpB+d686gqM3YFuS
 j+hOq45i716+QMT1kLvJ2wyoa5XGlTIt0TkMlOFPxLPoyxK1r0DRYHMDbB+N5pjw5ZPq
 4z2RHQ5GppKJt9h54BFSE0rC8kgisvqvqj3hmdFBVhtsKnojpJ5qeMoO+FaJOT+VzYgy mA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jjp6c8bq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 01:08:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5D1820S013927
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 01:08:02 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5D181V5005320;
        Wed, 13 Jun 2018 01:08:01 GMT
Received: from [10.154.144.7] (/10.154.144.7)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 18:08:01 -0700
Subject: Re: [PATCH v3 3/9] xen/balloon: Share common memory reservation
 routines
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-4-andr2000@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <124f3832-63b4-021d-0c6f-470229c7a056@oracle.com>
Date:   Tue, 12 Jun 2018 21:07:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612134200.17456-4-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=525
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:



One more thing: please add a comment here saying that frames array is 
array of PFNs (in Xen granularity), which is what 
XENMEM_populate_physmap requires. And remove (or update to name the 
actual call you are making) the corresponding comment in 
increase_reservation().


> +
> +int xenmem_reservation_increase(int count, xen_pfn_t *frames)
> +{
> +	struct xen_memory_reservation reservation = {
> +		.address_bits = 0,
> +		.extent_order = EXTENT_ORDER,
> +		.domid        = DOMID_SELF
> +	};
> +
> +	set_xen_guest_handle(reservation.extent_start, frames);
> +	reservation.nr_extents = count;
> +	return HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
> +}
> +EXPORT_SYMBOL_GPL(xenmem_reservation_increase);


And similarly, here we are requesting GFNs, and update 
decrease_reservation().


-boris

> +
> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames)
> +{
> +	struct xen_memory_reservation reservation = {
> +		.address_bits = 0,
> +		.extent_order = EXTENT_ORDER,
> +		.domid        = DOMID_SELF
> +	};
> +
> +	set_xen_guest_handle(reservation.extent_start, frames);
> +	reservation.nr_extents = count;
> +	return HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
