Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AAFECDE47
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AD5206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1Ih9Krzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AD5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeJYB4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:56:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36232 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeJYB4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:56:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9OHNnjF182082;
        Wed, 24 Oct 2018 17:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=mpOyUjFNWJXyUfFsWlGyA4QuP/ThkzOTH3D9X6HcaPE=;
 b=1Ih9KrzxxctdxbgCuRWXL4S37swlnrHHRlSI+ZSczely9lMylfry9CO9z6Ni5e6K2yL4
 XJMom0MRTmVW9Z9WFGdwtHnE2wF7+UFZU/vA8M9WrQ/SsjuGxzPepVDvR4GyiyD8KeAn
 HsnhiHKWWHp9TnC1Rkrr6E7LxxQTUpYqfxK8C2RkRAXI4G2xB3az2BAags0TUmJQ3q7I
 SuZgED6hMyq8zDOYQXZ5dczfPWyopM73OgKdfaGJwjwgC+og/0d11NImgd0yIkACgZQJ
 oAM6Gm8ltFVrSzZJBXJZU6PZAHCaqhxZwdrvsB7GkOIy9BKWcgq01sv9XKEXrinQzfbO Eg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n7usud385-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 17:27:44 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9OHRiQL002524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 17:27:44 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9OHRh2n013105;
        Wed, 24 Oct 2018 17:27:43 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 10:27:43 -0700
Date:   Wed, 24 Oct 2018 10:27:49 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -V6 14/21] swap: Support to move swap account for PMD
 swap mapping
Message-ID: <20181024172749.bila5pnfsqsu7th3@ca-dmjordan1.us.oracle.com>
References: <20181010071924.18767-1-ying.huang@intel.com>
 <20181010071924.18767-15-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010071924.18767-15-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:19:17PM +0800, Huang Ying wrote:
> +static struct page *mc_handle_swap_pmd(struct vm_area_struct *vma,
> +			pmd_t pmd, swp_entry_t *entry)
> +{

Got
/home/dbbench/linux/mm/memcontrol.c:4719:21: warning: ‘mc_handle_swap_pmd’ defined but not used [-Wunused-function]
 static struct page *mc_handle_swap_pmd(struct vm_area_struct *vma,
when
# CONFIG_TRANSPARENT_HUGEPAGE is not set

