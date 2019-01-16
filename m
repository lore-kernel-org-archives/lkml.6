Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B339C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8B320651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYS5WVgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393084AbfAPNR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:17:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53484 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbfAPNR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:17:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0GD8kpP141506;
        Wed, 16 Jan 2019 13:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=KMd8EyktuLIUPDx0Y0EsmN54mJ0yuOAxXT2sMJgaI9M=;
 b=CYS5WVgwKpDC4AJHf/JWq0ZhXCau1wqtrlHgPUvGgB2kGMk7lvDXOod3A2cu8zEynmpl
 2QZKPL5fHF8hxHlDtYv1A23s9obNLODa2srSb15BB9/XvIFoQi9wgUxBKqz56QetcQVK
 bhxucJR5/wIvsCjNceTaepC/RM8voWrMW7REbYr7szLtTjKlWvsRCB3HSZv17iMdgmxc
 NHLetqkkM6m+krZbtSe862IvT7kqIv0cNUt52WKXloj4WAOpV6ZzJbQUK5GnUeVbt2oB
 lNl/kQjxeiIQUL27JdPLN57UUzXgzDU56Nh2YWjXsCvOQaefkuxsoVGRpUPprX58aj80 Ug== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pybjs9ug6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 13:17:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0GDH0vR007324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 13:17:00 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0GDGwVY002608;
        Wed, 16 Jan 2019 13:16:59 GMT
Received: from localhost.localdomain (/173.48.71.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 05:16:58 -0800
Date:   Wed, 16 Jan 2019 08:17:03 -0500
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] xen: Fix x86 sched_clock() interface for xen
Message-ID: <20190116131703.GB2793@localhost.localdomain>
References: <20190114124413.3742-1-jgross@suse.com>
 <ebfc24e3-21a0-6cc6-ae68-5c13c1e66b9a@knorrie.org>
 <4808225b-e413-2ec1-77a1-15999c18583f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4808225b-e413-2ec1-77a1-15999c18583f@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901160110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:50:13AM +0100, Juergen Gross wrote:

> @@ -1650,13 +1650,14 @@ void xen_callback_vector(void)
>                         xen_have_vector_callback = 0;
>                         return;
>                 }
> -               pr_info("Xen HVM callback vector for event delivery is
> enabled\n");
> +               if (!silent)
> +                       pr_info("Xen HVM callback vector for event
> delivery is enabled\n");

How about replacing pr_info() with pr_info_once()?

-boris

