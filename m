Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF07C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11632064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gROHLtKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11632064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbeGZQfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:35:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:35:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QFEQRi154598;
        Thu, 26 Jul 2018 15:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=4YFGOA0nl7N0g75UyL47SNH+cYmr21W3NWhzHssOtfk=;
 b=gROHLtKrIQaFkF9Q4S2xK9lIOVFxpg3WECRmTrRPHD2KB42jhSsSZT8XXV+1UNvXUZpy
 VTwQoKQmUfJbybk8mAT/2WvdafhdYXAupuQwY+kh+yW9aMILPElQMMIs+m1P0atj7wYd
 aS5dJhMJ48VRz3MJ0lLPcLEi/AXyGCiOz1KTKnF8eJPCZejdd+AlmWeyOt9EYUnfcvYF
 gi/rPx1QsciI1Cvt8NKCH2ieEOz3yimV6JwA2XtPG8Xe4HSewcNnVYHTMgH0g13zlDL0
 TM4qMMd6Yz3yHDuLB+KYiK6JmotiTjMNA0txGk/8WtIXTs3zkPhbK/P7DCVwG5xC31hi Xw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kbvsp3j9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 15:17:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QFHkf6004195
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 15:17:46 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6QFHiCa023673;
        Thu, 26 Jul 2018 15:17:44 GMT
Received: from xakep.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 08:17:44 -0700
Date:   Thu, 26 Jul 2018 11:17:42 -0400
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 3/5] mm/page_alloc: Inline function to handle
 CONFIG_DEFERRED_STRUCT_PAGE_INIT
Message-ID: <20180726151742.ebjghfe27n7eoxq6@xakep.localdomain>
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-4-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725220144.11531-4-osalvador@techadventures.net>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=968
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-26 00:01:42, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> Let us move the code between CONFIG_DEFERRED_STRUCT_PAGE_INIT
> to an inline function.
> Not having an ifdef in the function makes the code more readable.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
