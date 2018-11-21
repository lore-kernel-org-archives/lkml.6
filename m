Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E704C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5CC21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KYUv/rCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5CC21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeKUPYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:24:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34580 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKUPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:24:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAL4nMqs032244;
        Wed, 21 Nov 2018 04:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ObcDvYuCvCRY854lGNth8zzfyqEUvVBRMF/Qt74EXuE=;
 b=KYUv/rCE/lT+oc+6eV3gucNcZHOeI3d0yFGKUrSOtHxcLZGq+9ibWqZ19it0q2hXyPkD
 qd0fA2rAKTW2dDpijvMP3FEq5JiZA81qH+niJCYoY+DONuchuL3K8rZ5YM1eXtaWgS9X
 p8ACNP4Q+GghzoQgRIwtQyaZ5FkNvsRtUXMdL5VYqL2P7JZl7qP3xsCsqCcj/U3fPZrE
 fhgDzaEKCnxzwJkEcUJjEZQR5LCHQx2mwMnCRy4aIfkggDwbcZTkm0hg/o6r+ubeKtEb
 luHD6oacE2q10FNMFfg6QkbF4LdOr9tsi8tyKEGVkmg8qvSZgbxliFq5omN0Ek+RRjUP VA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ntadtydgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 04:51:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAL4pg56026719
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 04:51:43 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAL4pf8x018611;
        Wed, 21 Nov 2018 04:51:41 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Nov 2018 20:51:40 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181120141207.GK22247@dhcp22.suse.cz>
Date:   Tue, 20 Nov 2018 21:51:39 -0700
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <29F15A96-D6EB-450E-B54B-A4CB460ED9B3@oracle.com>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-4-mhocko@kernel.org>
 <20181120140715.mouc7okin3ht5krr@kshutemo-mobl1>
 <20181120141207.GK22247@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9083 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=663
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811210044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 20, 2018, at 7:12 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> +		/*
> +		 * Check the locked pages before taking a reference to not
> +		 * go in the way of migration.
> +		 */

Could you make this a tiny bit more explanative, something like:

+		/*
+		 * Check for a locked page first, as a speculative
+		 * reference may adversely influence page migration.
+		 */

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
