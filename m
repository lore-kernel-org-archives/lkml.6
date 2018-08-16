Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7FE20673
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SsCWsD0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7FE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeHPV7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:59:50 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:48064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725749AbeHPV7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izJtUjMI6nUfqnPdrIL+aJBy/ZjKPjvJ7iXjqm5jrqs=;
 b=SsCWsD0zAAlPrjbJ+QbMEtRgRWTDeC3aKF0kzMHbqjnn+D0UnpeW1OHOd+qAFO/pSbFUefkREIMPd2ERzEq4VM4T3oCD7kTMtAdpACScDLSq74/LFT4RwKofp7B+Wx+gA090wxGps/Yiu/KATE+OojWtqOhLnfDWhlICPtPJf9o=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.5; Thu, 16 Aug 2018 18:59:31 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Thu, 16 Aug 2018
 18:59:31 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 4/4] mm/memory_hotplug: Drop node_online check in
 unregister_mem_sect_under_nodes
Thread-Topic: [PATCH v3 4/4] mm/memory_hotplug: Drop node_online check in
 unregister_mem_sect_under_nodes
Thread-Index: AQHUNKY0L/M1Chtix0yg3O5Mw7071qTCvTkA
Date:   Thu, 16 Aug 2018 18:59:31 +0000
Message-ID: <20180816185930.tfg2rzjnh34lmuxa@xakep.localdomain>
References: <20180815144219.6014-1-osalvador@techadventures.net>
 <20180815144219.6014-5-osalvador@techadventures.net>
In-Reply-To: <20180815144219.6014-5-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.69.118.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0780;6:KwasRoKHEBWqdtdR14KODzu8Shdj9HDV0NrYpeqc6y2NXtgMOfYfRIuMk/yRGWpAbfDFWdBFOfHRD+Od7zYXp5iAF/VgJbDg0QqOUNkXmGtnxoS2W+nX6/eIDL2dliyh4aNQpDxjxShB5SIDP7CFf8kpmro8QX+ZKu6IBIHBAFr2COuxJ6oOYmGwyZ5bIsbqIpxazYEzCGAZeOdqFcfSUOSuQTQhTNhVhPgroqBJvCjp64vpppTvWSke4I4+duCrBGeDfrDZsT9KuZYV9mJ1+6mphXfXmfpOdfW6pEsOt90y2CZuapEcldf6RcjPaTSIvBCzbVGEK2j76EVCz91UvGKDwV6CSAvg/GOHcWTNmy/BUKdFHLqDr8XGUFJCNx6sYQSoxKX0VY29zRPMyNLxfsrU49L3Z+esFCqx5de4ONANEMpnBdudMTp+gl6bzNyLHEQw6l8eqjxAJFBt3IXGuA==;5:OPai/aWTbVFl115gn9pHF2GHVsBj7Jawn37V+MY9wxiQUL9/Ts/pvHgpouAPwXNXD7FLAd8uvw+xGSAQKEYHfwPWQqzxXo6McCJOu2x5ekeNM9X7K5SryW5vZfLMuYA89E7Cu9htYNjTT6T76rkkuk8ds042e4f3Rhb6aPDuOPw=;7:QbO1uAIoHraR3k7tn/Bpmw76HhM1QFw8JldJWqQuSc6JTepcO9hvjxf+yFfvGzH2RbgWXck6V0fm8TmlDGwEmBpyvGra3SjfSHXMxtUyrUhxi4ygnJwxTk6MgYP2/Y4SaoqyRvC+SG0YVg7BmkR6t4xpvjOjPN7FLxF38clLm6UY0hZl/MMl/7EGxMIN0FC1riFCV05WgGBIPi/EZALKwstxMBilADrJehS5MauXB6eccuFUPrJhPRztHNZvBeIY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8ce9db1-eb09-4913-4607-08d603aa667a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0780;
x-ms-traffictypediagnostic: DM5PR21MB0780:
x-microsoft-antispam-prvs: <DM5PR21MB07807AB34422D39FC64B1B9A9D3E0@DM5PR21MB0780.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(8214008)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR21MB0780;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0780;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(102836004)(106356001)(6486002)(9686003)(6512007)(76176011)(186003)(22452003)(6246003)(54906003)(486006)(8676002)(86612001)(6436002)(53936002)(66066001)(316002)(25786009)(105586002)(39060400002)(6506007)(99286004)(2900100001)(53546011)(7736002)(4326008)(305945005)(476003)(68736007)(1076002)(229853002)(26005)(33896004)(3846002)(6116002)(14454004)(97736004)(6916009)(5250100002)(6346003)(8936002)(10090500001)(446003)(10290500003)(11346002)(2906002)(72206003)(478600001)(5660300001)(81156014)(86362001)(256004)(7416002)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0780;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: nYen15FnUEzByqhzASOQetrafowILgCfHxMkvNVe9vkyenVcFtgKTNikACGiXC4X4SNlqBCbthyF2MeYtHMjjXO1f3e7XtmTMlu3nBrHHeI8E+oS48BUvauqYL/zkLJ/T9pmz7rhGSWaQ2yjFYmfjF4aSDsmdu0rRUhgJmrmBoefXiqNZ3/1h0zAxjvEU9XUIzOeEfaYFVzftD64H6XIFqPU8T9/TD8PWKEmq+joZAtY0r5HxYSeAnGcnOjfoc/MhnhqCOMK/tZHE6p1clJQvk5w5oegzVe96UYqtefYw/1FcZf8npJe9cz/iIcClzavf536JUWNsYx1+ObG4Emi3DxK7wv+HXWBqmZidQ0p5IM+PtsVPf1TCQwgDITuCEQXsc7dlRiFqQru9/c0ci5EQWqrcJoZGtPyNFkjShdaQW5FpexmZ8mWTNqWUpvNe12s3GgOl4nlP42E2e1spkmNCY6+lvCcD3YmVSkpJDgKHvk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E026F4C5C651CE45ABA9F717F027A8C3@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ce9db1-eb09-4913-4607-08d603aa667a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 18:59:31.6835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-15 16:42:19, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
>=20
> We are getting the nid from the pages that are not yet removed,
> but a node can only be offline when its memory/cpu's have been removed.
> Therefore, we know that the node is still online.

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>

>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  drivers/base/node.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 81b27b5b1f15..b23769e4fcbb 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -465,8 +465,6 @@ void unregister_mem_sect_under_nodes(struct memory_bl=
ock *mem_blk,
> =20
>  		if (nid < 0)
>  			continue;
> -		if (!node_online(nid))
> -			continue;
>  		/*
>  		 * It is possible that NODEMASK_ALLOC fails due to memory
>  		 * pressure.
> --=20
> 2.13.6
> =
