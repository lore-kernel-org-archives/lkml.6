Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD21C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F0E20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DfCmpqzE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hcsSfjE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F0E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeLCSAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:00:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9337 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbeLCSAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:00:32 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB3Hr7hw015040;
        Mon, 3 Dec 2018 10:00:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TqIWhoU+LDDptrsZ2kVM2hOsU+ChpPyzMGhgumJkNTo=;
 b=DfCmpqzEZdYyT3yPVpxXq2gzJ0fNpDhxoFnX2zUtcujbE9bQ55kKFCPcFl6sab7lcrln
 naq5eCJs7F7yXN77TSyTgVD/l2tu89keyhQzVsgjYTxBno8KfafMVmbTOAMFx0FgnaM3
 6ZXCEx/wjD8/u4gLmz9ISyNGCAsw+2FN28I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p56cmgu86-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Dec 2018 10:00:19 -0800
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 3 Dec 2018 10:00:15 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 3 Dec 2018 10:00:15 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 3 Dec 2018 10:00:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqIWhoU+LDDptrsZ2kVM2hOsU+ChpPyzMGhgumJkNTo=;
 b=hcsSfjE8jbQ+GMvgcwe2AGsifPrgY+d7YevkdQ6tBRWl9/KCbcYASLYle1zy6SENLhKKmCWpM5XkopyYDsoCtsvB2D9IXZYZv0EAfvXxpOdldLIBdVDkHBaQVgDlDUCcnbdyvJ2ZHKg1128h6XCmo7YPz0uJaQa/wXbyMmX23XE=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0854.namprd15.prod.outlook.com (10.164.171.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 18:00:12 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 18:00:12 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm/memcg: Fix min/low usage in
 propagate_protected_usage()
Thread-Topic: [PATCH 1/3] mm/memcg: Fix min/low usage in
 propagate_protected_usage()
Thread-Index: AQHUit5xdIPpMr8W9kuwgrfCUim4T6VtTlAA
Date:   Mon, 3 Dec 2018 18:00:11 +0000
Message-ID: <20181203180008.GB31090@castle.DHCP.thefacebook.com>
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
In-Reply-To: <20181203080119.18989-1-xlpang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:300:13d::18) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:1d19]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0854;20:SN6MmwU7FysHinxTa9OjfF/jRnT5wdxck2k6GLV5At+Z+Ol2liigUrLaJ4vnsUj7cu6xT/04mA4oCz5zLLqXCcg8SSoPmc4ZyKgEyMLNzNCPBdcoMuzRve3rccXznvF5w+kShR2fSaJJwVxD3TnQXqebmcqKbCYeIfv+R5I6F08=
x-ms-office365-filtering-correlation-id: 13e48c4c-6e6f-4348-4c74-08d659492b70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0854;
x-ms-traffictypediagnostic: BY2PR15MB0854:
x-microsoft-antispam-prvs: <BY2PR15MB08546FF530EAB85F11485FC0BEAE0@BY2PR15MB0854.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(11241501185)(944501493)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0854;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0854;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(366004)(376002)(189003)(199004)(86362001)(46003)(7736002)(486006)(25786009)(71190400001)(71200400001)(305945005)(4326008)(316002)(105586002)(5660300001)(476003)(478600001)(33656002)(106356001)(446003)(11346002)(97736004)(1076002)(33896004)(99286004)(52116002)(6486002)(6116002)(76176011)(6512007)(8936002)(53936002)(6436002)(6246003)(256004)(54906003)(14454004)(186003)(2906002)(6916009)(68736007)(8676002)(386003)(81166006)(81156014)(229853002)(6506007)(9686003)(102836004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0854;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vVyfFEHBpA8P+UnBTQL80eVVwc+9IMXf55dLQuPdCvRPi8FOslLbZxhyi/3qWIg8h+9mYZ9tzS/aixj0P7IqbtgECkMqQ7ThIMUpZG88zydrdHSZDp7MSqAw/Px2jS1GMWPCOaE9PEjO/0Eu/wt6bizh8YvapJQ88M5yRAAS3KJs3GO+9oQ3wr8DAWtQrMmTOYHqxuwhCtQyze+YrdcEFDPPyqIORtkGu6T5ChRLVoEsD4UPtlxtuAfNNHYkW719MpLjCGYX7eHGCfajG+NtoZapdA8pOrsjNEmuPsSdVCP+0Cp/RFRAPHgU/uVSAG/h6PlvSmM0qTKLROEzcTZYQyS/vhmnB15XiaqB0V3wkUY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93E17A46B4BEB947BD00ACE85CB7A17E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e48c4c-6e6f-4348-4c74-08d659492b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 18:00:11.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 04:01:17PM +0800, Xunlei Pang wrote:
> When usage exceeds min, min usage should be min other than 0.
> Apply the same for low.
>=20
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  mm/page_counter.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index de31470655f6..75d53f15f040 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_coun=
ter *c,
>  		return;
> =20
>  	if (c->min || atomic_long_read(&c->min_usage)) {
> -		if (usage <=3D c->min)
> -			protected =3D usage;
> -		else
> -			protected =3D 0;
> -
> +		protected =3D min(usage, c->min);

This change makes sense in the combination with the patch 3, but not as a
standlone "fix". It's not a bug, it's a required thing unless you start sca=
nning
proportionally to memory.low/min excess.

Please, reflect this in the commit message. Or, even better, merge it into
the patch 3.

Also, please, make sure that cgroup kselftests are passing after your chang=
es.

Thanks!
