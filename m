Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF9AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B32F2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f0KFHvxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B32F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeKFLtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:49:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeKFLtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:49:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA62Nil1111251;
        Tue, 6 Nov 2018 02:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OiZhdXfYMZPfN+U8MbiUuowUoap0KsRR9d2K7U4iSGM=;
 b=f0KFHvxsT0scblWlPHQ/dJKGW/9IbRqqughDHyGXzJ2RSk8LCweCJFsaS+HvPdKbwCza
 sB8UsnFljhEGvCRfiIlUvCnrTP1VLRqNiV4UvoiVrw9MH+JnvCGoE1Fx7IUnB4nN2kDs
 xlx9QPB5wihpnwk65zR9dPYgDOwvd5UudArEUGaZ5PcbGloI3YAHZZJk0HIuZpx/bcSM
 zOaOLJpE5+LKjjnFDXltx3MqLlKzkGkqhRNv3CU4QDzkNkf2KyXnZAHz0Bmp41E9X4cm
 uI38pOyavg87WVBatNQt+Ab6JuPwGBHZDYTXalOBdlK1QGToXRbDMriHo9NqKmuggsaO Ow== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4aqjffy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 02:24:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA62OkfH021361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 02:24:46 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA62OjIU031350;
        Tue, 6 Nov 2018 02:24:45 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 18:24:44 -0800
Date:   Mon, 5 Nov 2018 18:24:51 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        steven.sistare@oracle.com, tim.c.chen@intel.com, tj@kernel.org,
        vbabka@suse.cz
Subject: Re: [RFC PATCH v4 02/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181106022451.jry6nty6zsnpwq5e@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-3-daniel.m.jordan@oracle.com>
 <736b23a4-cb32-7926-101a-9b6555e59b5e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736b23a4-cb32-7926-101a-9b6555e59b5e@infradead.org>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:51:33PM -0800, Randy Dunlap wrote:
> On 11/5/18 8:55 AM, Daniel Jordan wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 41583f468cb4..ed82f76ed0b7 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -346,6 +346,17 @@ config AUDIT_TREE
> >  	depends on AUDITSYSCALL
> >  	select FSNOTIFY
> >  
> > +config KTASK
> > +	bool "Multithread CPU-intensive kernel work"
> > +	depends on SMP
> > +	default y
> > +	help
> > +	  Parallelize CPU-intensive kernel work.  This feature is designed for
> > +          big machines that can take advantage of their extra CPUs to speed up
> > +	  large kernel tasks.  When enabled, kworker threads may occupy more
> > +          CPU time during these kernel tasks, but these threads are throttled
> > +          when other tasks on the system need CPU time.
> 
> Use tab + 2 spaces consistently for help text indentation, please.

Ok, will do.  Thanks for pointing it out.
