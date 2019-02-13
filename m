Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E3EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F892175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XC31dfEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393087AbfBMRdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:33:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57554 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393063AbfBMRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:33:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DHTJ1E170354;
        Wed, 13 Feb 2019 17:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yF1vCib8Wg9S4HalqsC6LxQUOgk4ubp6E1FmYHDuLck=;
 b=XC31dfEtwiMut3n3VSmiGY3+oQEEaOads4E8f4KuieqGvrzDrvSjRLbWXoDmYjjbX++z
 jw6UKA1VozrD+wWa5BGKiIXhctrgRVDgKIY/XOQNe27cZxcgc7km/A2oFyzR1f7Al5mV
 /5kqGA7u/8XsEiJXP29RN2aRZupDj7oxvCJz8SwZobqdfMOnwPcANjEfk2iziumuTJua
 uufMBj+SArGPxt447awCQrAV6+77x9quxBOW5+VvUls5h1PR37w+OzkPI9W9mkJiEG3Y
 zoRtWr15MrO481KRKSBTbNcdzKlisvTACqqk85NQnTWGsOLE3BejsWTEPnkKrV5iyTeG dg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhrekkewu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 17:33:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1DHX7Af009656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 17:33:07 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1DHX6pq024489;
        Wed, 13 Feb 2019 17:33:06 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 17:33:06 +0000
Date:   Wed, 13 Feb 2019 12:33:27 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: Move recent_rotated pages calculation to
 shrink_inactive_list()
Message-ID: <20190213173327.uhexilxmmztx7fbt@ca-dmjordan1.us.oracle.com>
References: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
 <154998444053.18704.14821278988281142015.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154998444053.18704.14821278988281142015.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:14:00PM +0300, Kirill Tkhai wrote:
> Currently, struct reclaim_stat::nr_activate is a local variable,
> used only in shrink_page_list(). This patch introduces another
> local variable pgactivate to use instead of it, and reuses
> nr_activate to account number of active pages.
> 
> Note, that we need nr_activate to be an array, since type of page
> may change during shrink_page_list() (see ClearPageSwapBacked()).
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/vmstat.h |    2 +-
>  mm/vmscan.c            |   15 +++++++--------

include/trace/events/vmscan.h needs to account for the array-ification of
nr_activate too.
