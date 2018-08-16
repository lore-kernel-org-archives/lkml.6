Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081692147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nM+1E1Q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081692147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeHPVW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:22:27 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:57072
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbeHPVW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUVnslCv3BuCak19cOppJJFBa2ALR44ZvtxZmm+xefw=;
 b=nM+1E1Q5HPf0pLBHnE3kXNvBYbK70Xz022cuONWT7ILBrvxcrBSvdH49zv6gOUshfbaHk5rj9YpVCkYhvpbeak7J2gk2bl99ak4X9SuxnDS5Od9I+01nRVt42pzOvGpYWnzUciaIrnRzpyGpn+KC8rUWxZRpXEiAdxAKa4qQpbI=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0843.namprd21.prod.outlook.com (10.173.172.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.7; Thu, 16 Aug 2018 18:22:21 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Thu, 16 Aug 2018
 18:22:21 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 3/4] mm/memory_hotplug: Refactor
 unregister_mem_sect_under_nodes
Thread-Topic: [PATCH v3 3/4] mm/memory_hotplug: Refactor
 unregister_mem_sect_under_nodes
Thread-Index: AQHUNKY0SEMNBRldw0KDglUlvnp8kKTBXbOAgACj+ICAALEsAA==
Date:   Thu, 16 Aug 2018 18:22:21 +0000
Message-ID: <20180816182220.dmlun5edcbf4lspj@xakep.localdomain>
References: <20180815144219.6014-1-osalvador@techadventures.net>
 <20180815144219.6014-4-osalvador@techadventures.net>
 <20180815150121.7ec35ddabf18aea88d84437f@linux-foundation.org>
 <20180816074813.GA16221@techadventures.net>
In-Reply-To: <20180816074813.GA16221@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.69.118.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0843;6:xDVs9ntyBLIlt98/cuhM2wUeAUxN0mV3fNKD6qZ+YBZ4CUhEnYbvl/ToiXz3+PG92DVVDfp+hF7qgyE4WdWJ8rRMYggYS8U89FfrGuAjvOqh/CkDOAO74RuObADRKy0EGwOa3sZLVLAksm80MYJYX6Ne/wAhtvR+Q94JKOJY+042jrngbhlYS0CKk/dhvF/xavsmAHLm8H7FYFWqxrpFMWcjg4HliqKmiKxPT74tGCTXmp2UaeRbsgP6gc7qeVNYOKKKRHPSHIGL6IdpL+W/xm5YY+HAayaDK+U+gMSoylExZW87TA95H5zLgBMwxfffzlb6+Uc+49nbW6YOXWIMaCC50PyFw5g0an0G0gtaxuP5bFdZ+vHWTxCYzmwX+frdoX6pW7G9vZiYRBpLM0Xmrz0/f8ulVUDqulDyw9u18fkB730XJy8BjC4fDrZC4BtXE1k7RRuAtKfEVvg6IBo4Sw==;5:9FV+yij0a3J0nbZ2l90JaAJqP/zhyBJIxkJ/WL0caOWU/p1bBZZsSH2AJ75rITDWRgLcQfg37heSGdp3Ik9EG11oBtSPlI/e3M5GJhhNoRMeOx61LFksW9WskVSVkvws4szoK5vLwjLPb/+o3hHfm/XPb8u2Aq/FGg3AkfZwbNg=;7:bnUhBSkauOyaDndv/p6G5H2N7NPlSIY9DAbq6manFKM/C0BoLQ6orA2ZUtAOtPEFt8Wk8nMBeJrVNBKY8Q1+dAPsxyI1hoPjMoKBzBElUiMtdz7uxLydfWLTj4ZYVJWYVWP3kMYurfJzM2wPL1woKAZHzOpJQvxOchzA3yGlxoIKAhZ47+WLUhBW6Y2mpyR37TDHiITt2hbEaYRoRUfr8P7WhxuvDkPISBjymaSUmS++Ck6IQZtfLzXTdwtm7Trw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c0ee592c-4dd6-43bd-6fa6-08d603a5354f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0843;
x-ms-traffictypediagnostic: DM5PR21MB0843:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB08436A197971F910754CE96E9D3E0@DM5PR21MB0843.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231336)(8210008)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:DM5PR21MB0843;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0843;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(346002)(366004)(376002)(199004)(189003)(54094003)(66066001)(256004)(53936002)(11346002)(305945005)(5660300001)(105586002)(81166006)(22452003)(446003)(106356001)(81156014)(486006)(476003)(316002)(10090500001)(8936002)(68736007)(186003)(39060400002)(6436002)(99286004)(7736002)(6506007)(4326008)(26005)(3846002)(14454004)(6116002)(102836004)(93886005)(8676002)(7416002)(2906002)(10290500003)(86362001)(25786009)(229853002)(2900100001)(72206003)(478600001)(76176011)(6512007)(1076002)(6486002)(9686003)(6916009)(6246003)(5250100002)(33896004)(86612001)(54906003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0843;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 62Q1lQh0oJ29dRPj82KLmt+nIkMyHi+mruUYBfylGFnf9uNHNvFp4x+i+qXiJVC5FsWlb3Iq08aaDj2pU3ID2CuZY0hCIYdbduBk+n1H2mfwEDe1YVW13Wowzofu29HpUoiExeFJip2SceDB+2d8WACBcw7PvsfwnmUM7vSoA5LbghMQg0iMAd/eYl1DXemGth3kVfMJPfSb9+goPpcAy1Vr8uCujjH/4drmC3wYRU/o/1rf84mQKL4zK+0TihZErNtFY94GHq9F4AhQnfMyXxTEqY/TXLQfrQyibU7YOTTrS5fJ2gUFEfe/P6mltpobdoaqfWQ8hU3ptoOTqx2kGNC67BPU9Qo4JgV3C4SHcGo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D33BD405BF53E24FB8DD25B72AF4ABD6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ee592c-4dd6-43bd-6fa6-08d603a5354f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 18:22:21.6407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0843
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > d) What's the maximum number of nodes, ever?  Perhaps we can always
> >    fit a nodemask_t onto the stack, dunno.
>=20
> Right now, we define the maximum as NODES_SHIFT =3D 10, so:
>=20
> 1 << 10 =3D 1024 Maximum nodes.
>=20
> Since this makes only 128 bytes, I wonder if we can just go ahead and def=
ine a nodemask_t
> whithin the stack.
> 128 bytes is not that much, is it?

Yeah, sue stack here, 128b is tiny. This also will solve Andrew's point of =
having an untested path when alloc fails, and simplify the patch overall.

Thank you,
Pavel=
