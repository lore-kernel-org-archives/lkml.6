Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E78C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E49206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xd3cu6ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E49206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeK2NjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:39:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58982 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2NjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:39:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAT2Y66Z084550;
        Thu, 29 Nov 2018 02:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=RRYOjySoQRUJYlwueEMVI3P/yQguc9IzJUD2fgOuECs=;
 b=Xd3cu6evgM+mS6VcjJPxkeljOO5WnOXPsXj6BvP7y1ddWnqTpkyHL7NbPZ3xtXyNb9wZ
 A26L60QrnrXpHK+JPFQKf6ck6hrYi/osz48L8KgCGK9GEn9zMCoNanUrtplfv+Fk8gt7
 jVtloo7kHmhdeEjV0jnyfgZWOBTeVlsXvWtIENGUWAYncaHmNzpPoj1MB26++1JCR104
 PV5W25FaJ72f5Ude7XbkViZPYPYA5t9b4D+tRdh+S0FNbyPe+eaLDW6NCbgqZ7FzdgMP
 QTkgSav5yrieWrd7T/5xGmWSrPH+moDicaByI3u/ILcFjCQ0ue3jmgE1rDRUTB01hP53 aw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqnn88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:34:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2YEZp027037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:34:14 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAT2YCMk016493;
        Thu, 29 Nov 2018 02:34:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 18:34:11 -0800
To:     kys@linuxonhyperv.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, ohering@suse.com,
        James.Bottomley@HansenPartnership.com, hch@infradead.org,
        linux-scsi@vger.kernel.org, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, martin.petersen@oracle.com, hare@suse.de,
        kys@microsoft.com, Dexuan Cui <decui@microsoft.com>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: Fix a race in sub-channel creation that can cause panic
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181126002617.7398-1-kys@linuxonhyperv.com>
Date:   Wed, 28 Nov 2018 21:34:03 -0500
In-Reply-To: <20181126002617.7398-1-kys@linuxonhyperv.com>
        (kys@linuxonhyperv.com's message of "Mon, 26 Nov 2018 00:26:17 +0000")
Message-ID: <yq1a7ls1ujo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=797
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


KY,

> From: Dexuan Cui <decui@microsoft.com>
>
> We can concurrently try to open the same sub-channel from 2 paths:
>
> path #1: vmbus_onoffer() -> vmbus_process_offer() -> handle_sc_creation().
> path #2: storvsc_probe() -> storvsc_connect_to_vsp() ->
> 	 -> storvsc_channel_init() -> handle_multichannel_storage() ->
> 	 -> vmbus_are_subchannels_present() -> handle_sc_creation().
>
> They conflict with each other, but it was not an issue before the recent
> commit ae6935ed7d42 ("vmbus: split ring buffer allocation from open"),
> because at the beginning of vmbus_open() we checked newchannel->state so
> only one path could succeed, and the other would return with -EINVAL.

Applied to 4.20/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
