Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51DFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3857B208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I+zj6Rxr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Gr1yKXnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3857B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934202AbeGJPHJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:07:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40624 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933952AbeGJPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:05:56 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AF3Fg3012378;
        Tue, 10 Jul 2018 08:05:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=Iu/fV8Gp+X6WmM9OVWFo3Pv/ik+AwZ15B36A2dj9aYI=;
 b=I+zj6RxrKFQtR51kcKpebxOgykJUl2Bm6GpPFcfuEfKgY93H/SVT8npSj3sfhzzlS1RL
 WhYP4MHUAJ3ocNAS6U/rH8UbSDmF5ldrhz9svqYqHtTGWojW/2xidyOnLnMJ2N1xSIYG
 lX8T/fbM21Di63wCIlRYH1xrExLhlUawT2w= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k4xm083aj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 10 Jul 2018 08:05:31 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 10 Jul 2018 08:05:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu/fV8Gp+X6WmM9OVWFo3Pv/ik+AwZ15B36A2dj9aYI=;
 b=Gr1yKXnGP7m7LPbGpYzhTNMur2ukTBIgVKpAzL2ueA5tKiSQuQbBb668njJ2Tmv/iBjmKK5qyMyFfuHZIy0H77eOBlkxX08a3Gu9CJSc/rRa399ziPVmxubBhhw4TXEfaniuqpo6rO8cT8Um6VbQPAt9LzPaa/wiun8I49xawpc=
Received: from w1t1fb (2620:10d:c090:200::6:a2f2) by
 DM6PR15MB2507.namprd15.prod.outlook.com (2603:10b6:5:8e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Tue, 10 Jul 2018 15:05:24 +0000
Date:   Tue, 10 Jul 2018 16:05:14 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: btf: add btf print functionality
Message-ID: <20180710150513.GA1621@w1t1fb>
References: <20180708203002.543403467@fb.com>
 <20180708203336.433372958@fb.com>
 <20180709205612.5041acc9@cakuba.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180709205612.5041acc9@cakuba.lan>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:200::6:a2f2]
X-ClientProxiedBy: MWHPR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:301:14::17) To DM6PR15MB2507.namprd15.prod.outlook.com
 (2603:10b6:5:8e::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad2bd41-4c4f-4619-b82b-08d5e67690ed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2507;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;3:iUQNz07rnTdTA7mq/3oNN9x42eh5etaz9Wd0s2ia4lpmlDlvPC/YEpHJ8Y6YvdRMVubT3m6yTT2lITtWrbpBW0r2AN9n531nl4qbwz50aLPuV64M+0mZtHVEh3UJwor2QaZ0gxX6DratbuF6BusS5M1ZiXy6TMTyDI0Byoftl/lSf+UaYJxM3IMus+wtNcsMM4rrRX6HtOltXXsNiDK7+mmLT1KoHrE6MOi245NP5hy+R3AkzME71alzvklViO57;25:Vp2Bf2vzxXdGZzzn/VUhPQD/B/WUwiNefL9SUWMihIkUnQbBuTcN2ryNDdCoMFKQcAuTaVfqii8695WjHQJHJ8SJI67Kza4OLOMoskHKd29V6ljTtF7ohzTZ/oRuHgT+2nrRB3gTl6D8tbWW6Cm0WD2A+0p+28kkJfQ0XxeeajAH+F3Xf5VcIoY1Tj8FZ1ETo9zZGr7dQbuFYCvQKX3XFKK1U88U93qfRGILCuH34b+b6YYUVD85yWFNi/djGGUkExFHGUROo7AB9uOdCjUY7YwS9H2OPJrp51ciWD30umnvpWm1URW8nPSnYIvxgx5NBG8bDYb8WWL3sMNFvSIaOw==;31:8UhVRMeaSpz4EqbvDNAiSi9lyba1PpAcSfdRXSSHPjNYft4xfYtDg7nKIXfKmhZncGIjfzd0lL6bUBIoYwSqFmVlHvJN9qob9yFi3NRDccpVhWZi+QFPyRN45hCkIoat6eXpGQiGuQCeWBEFV3GXKHWtOEal3WsLk6Zw6cIrPl2vbdfFW4xUHBPTrV50YCF7NXVd313zXsgX6UdQ/c6Z0kJ/x92ORfCs9CJTSK2yE54=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2507:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;20:f+a3iXKjxIDqiBDyHHo3n/3dr4Pv+7+SnYUR5+fKLR4h/bZVEGQHY2eX+S30IgP5RVuSHJlajzu9uWKxT3k/NpycjZCEm8kkjbNRGb/5ghJILd4p0WMaF+zW4gEyDH2OPYR0GgsjJYFKgoNOzg8SXNVhuJz/7ZhomfeYQdNf0CddlV/QWQaX9N1DaSv6w3pf05picLZrIj1vf37/5w3dYG5tTQySPYVG+nZqLlhWup6wFMu4uBUAslXCohAi6Wb6++4jQCbmQg8E1WQT3YqOR8CHQtCqxkcsHwNZanaHRT4+2wxzg7hDpYl090QfaQprBSl1Ttz65fyamQPflLfPD0yZM369XyvqCTMvIj/ieZVviKg0yRnzlNLoi6b9kqgS5uV+rwlRpe+SGrJDMqih7iyuTCXeOl/Dtze3rBNc8xndRBySVK8CMOxqipkcO05rqCSIz8y4kStf/G3iVV3rLSb29A2PqsZiT++Vr8rWsrRuCctoSSqMcOwMZokR8+5B;4:ArX6US72tDZCIyYCjOM6Wyu3kDVtjEPpruAiAI/vnrfUFu0UbKdZUDbPWlMWaBxX2M9waEEWBkgwzMP2rIgexXmZKHwuTYrH7nD7dJwQoQTZsm6PsP/9yUjaI67eUXYA6043BNRvqqea+HL7QB9GvWkl0l3GNvh5APiF2nMXkLhKB8S3DrCsLf4mAF8Xnd3KONfwMQA0RHEURRedColTMShA4VoJTXmJsIjFeHL9JN7vn8riMP/zIDqDdRK6mIvCKy3uzRupDdcLtoGWJyC+TOM3M2SwJ43PgXozgROKZHoU36wweYF7vx/29acWiM6tNoanBJ61p0Xy1SJPSH/jAS4/TWNLTddGRFRUbAoeTLs=
X-Microsoft-Antispam-PRVS: <DM6PR15MB2507CA1090259655D53EE838C65B0@DM6PR15MB2507.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR15MB2507;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2507;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(366004)(39860400002)(189003)(199004)(69224002)(33896004)(86362001)(33716001)(23726003)(7736002)(386003)(6116002)(25786009)(1076002)(305945005)(76176011)(6916009)(46003)(6666003)(52396003)(6496006)(186003)(16526019)(8676002)(478600001)(52116002)(14444005)(9686003)(58126008)(55016002)(54906003)(16586007)(316002)(68736007)(5660300001)(2906002)(4326008)(39060400002)(81166006)(81156014)(97736004)(8936002)(106356001)(6246003)(50466002)(53936002)(33656002)(229853002)(47776003)(476003)(486006)(446003)(105586002)(11346002)(18370500001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2507;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR15MB2507;23:yQUIagspp+oRKSd/qFWC5HyF2fCoxl0znHlZRsAMG?=
 =?us-ascii?Q?7QiBaHlVKMzVAoek/GfybOFrh8FwV17vWFpi4wWnb5jRayuXDJSEFHbFldtu?=
 =?us-ascii?Q?XH/u0LepO/+zBKbQSZImkfcdF++En9zzTzZdOOV90zx0pnHErnp73SNPeAAy?=
 =?us-ascii?Q?eDHlajl/nsj7tTpjbo78QMVzgl/eiox6Bdc0pUt1cV5ZPxgkShSR+k53Caqq?=
 =?us-ascii?Q?z6+x9Z5Hgh6MoIdWyZSH5VcmLuEvTLkDAu1oMmFnk8qMTniZ2LHFqhy2nWIN?=
 =?us-ascii?Q?bhrPUy/O7H8Xlu8KtxU2PDyFA5eCH9S6So2VSp7bgutP6SWKVrPI19EoME/t?=
 =?us-ascii?Q?k2hvbvL6ji46YvrF0//3JvfirNiYlpo6kmIKKQEZXoGEsqOqsqVQqRGyuYAB?=
 =?us-ascii?Q?5Qt+2jh/DBVJhRAKfKnab/Igz7gDITdFQLaBNvXZ8UmS9fqf2MjeRIXotSH1?=
 =?us-ascii?Q?k3ZqBqWZx3kGWZuEkvs31vLZZVzYax7dbtKtUDwM/capU/q2ypHjfyM6qkRQ?=
 =?us-ascii?Q?oUM5Uo95uR3Jc0XoxS8LR8BEsWIIdQPojVlUwtnzmzReazJskkPTrwIX09p1?=
 =?us-ascii?Q?UdQlWyRgEu3djUZ8T6IvL+ZlDIp13GJQpJx5osFMpTBQoesXDfskvTz+HJhz?=
 =?us-ascii?Q?oUclEIDyRDptJRV/8IhvaQmiSUQXR41UAEnbTXE7PlbvwTXgmtvq971L4VvZ?=
 =?us-ascii?Q?wKLzM7GkOhpRG29Gs23YsDdc+x+a5yINLXvU04I3hmWFG1FV6n+B2VTRi3mU?=
 =?us-ascii?Q?bmeML7EYVo9z0wwigyWlgEGP6P/gYyExWDlxj5pWZwoBssyGVmt92vw/Hy1O?=
 =?us-ascii?Q?PuHx2nEG6O7EYcjLLrKRVw9ZN3xAIswWZs8Oy1vGn6gR7u7cWTDNJunx+sH0?=
 =?us-ascii?Q?4qOovQTmoNlHajJOlHAKKkkAfmkPOT0yrOzDcq5WvozYHbK3xgiiFDws7isN?=
 =?us-ascii?Q?7MyoQjFd/4Bhu6zMpvOWXEvR0Y/RRqsLUg9IQ3geQlmLnr+K/Bjmwt8yVQ5v?=
 =?us-ascii?Q?PzSqJHJgZVRZS6MSjvalKnud7dtxH1pjEGr6TxSo/flJ0Rf2coll5ZhvQpQv?=
 =?us-ascii?Q?JmNV7PMLMdhfiLwQEy+8ycFYNWTHEfxTm5863nrXzom+Z+FdhiCbrKoeNY5S?=
 =?us-ascii?Q?oqgD5ZJTJ2KfkTRQDVQEHQbULJB7VD6COr9BLc5F0+v96LPLJyuTbNCBJ9Sn?=
 =?us-ascii?Q?4gqLAvJ4jVpXl/I/xWn66VXnjMBhTiL0kFjNPdzH+iB1DEPvQACx2oL37uSX?=
 =?us-ascii?Q?72rfBr237TlO8ec8Sw/KBF3+RcbQ4oAPZORotB3A5F7Y3iprXFc62olrHI4v?=
 =?us-ascii?Q?H77Hn5RHRifaV3tikk0XNbvxzYIMO4hOnEB4hO0iJKepelUHluD60NPCegRD?=
 =?us-ascii?Q?CzZWQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: syU7x9DCzYwI1NkCCq9EpMCqvBYmbug5jsSImkv/nCjWXvw+eT1CD1t4Fy+QdFJW7qfxnly5ZYFrPVZW6gwvHxWZAi2R5EYQRAwIDvBuPPT0Yh2cOcgoWIqnEjdw93Ti+cr3TzIi3eCgwOdUkwkz3ouL+vEe+R2eKLhf4NtF+KacSHrS/zFZID3krq5iM49J9ZCV8OPK+S/GdtXzb9VmCXYD277f2HOBdEh1U1WJPvZyn5WIdufdt1wXgidDy7o8CJk16zESkjWC0QE2qIQ0qON/bn+BVHNmj0BwWrm3dt++qjSsU72LNsXi0dN7aErI0yUwio/C+s+zIteWtBCOFUujN9RkwrVRAZ1y3jjEK1I=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;6:bQnkmYScUoScP0AeSvBH4SkUZTPYexfl2CvuNWzRqbRABLOOFARLZuiFIsqc/59bHZtUCSEoV3f5z7jWX+2Wx75trcYEuJfVzuC1Kpsmiyo7U0rQ3RI4dxsmwz8pgcjgXrvDZtvmTwpcyTPg32/xyOT3ywnToB8sGB0pbddjLLgc88GuP95oz86nThdAC1OArMdJd0wnrvgBS83QW+ytXxpKhWBs2q7o0J4N9VJTDG9fT64kb81/ggVyH3uUsmSDyo5zhIhcUare25faOj08ppAzPXinZmOT666PrzVB9xWILQc4KPLOnvZ5WWjmhcFxnvbQ5+/Kw7HH5P/dVVo60aaSomDNcwju/nZaqCvSVtSTCFSNVYp04wFtVnK77j7QBj5+pQxCu7fSM/pRDjoOa4cFjubj/gwAh80cY7sfSKP2CPtzuhImy+4H5g3Y/ac3evf+lxPu/8ARD093zywtmg==;5:PsQHQqm6p+rLQndT7ULbsbpMpDFme19O4EzjejRtU8WQvr3yyjqzqT057/N2uuR/71MAzNmgRHNwvwsI8Nj6/F7SqyLORC7JxV4HlBJ/LexGoW8sc/ADvj7u0EKLYaqjsJN5tOvChrXYcqUu0iUFXbJxw77FFJC27dVQKqa5Biw=;24:b9FfpCtsV96kfSnzgb3OhVfrqFeD26NxSgsgCEYktkR7d8tHsShEg0HAFqcTX+v3J0+SRtYn3nVyQff015cxCifEAaMDNBcVg8B1OC4u/lo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;7:C/doXa9UPuD4QTKnuxH1uTJM3A62QZhjyRlMDPbdS5nieNeqjs+zufY3cAkeSLRSzTxNADdzCsXSv8E9y0phKfwwvTy35aTG4jAYDfLRp/EayAHrvbqJJKMhoGmzQNCpnVjdUPIHuGr86WfK8sgKdNRnWl39cnUBD4YrhgvylPCOZYXBLAid8lv9axCwur5HKM6i/SwcyZalgktaAGFLTYdgDsR6RTZjpHW4x2hlFxcF6BB0Y4m5MF6t81VSXYke;20:FaYdUif0Cwv/R+6JbQqucd8bZyjRKcPTSQ6vdfNQJlQ5G8jLja5VpxohKaflay4/tBWXtwlHwkdr9/kSUD7NqDbGcBDuhtZRKBZT4/CaaLbO5bTD/jjgGJ5xEv/JHDnzcmQsu1HU2SBwZfikKD2uKrrP6AAP70vFDHrIdUAqnwY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 15:05:24.4633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad2bd41-4c4f-4619-b82b-08d5e67690ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2507
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 08:56:12PM -0700, Jakub Kicinski wrote:
> On Sun, 8 Jul 2018 13:30:04 -0700, Okash Khawaja wrote:
> > This consumes functionality exported in the previous patch. It does the
> > main job of printing with BTF data. This is used in the following patch
> > to provide a more readable output of a map's dump. It relies on
> > json_writer to do json printing. Below is sample output where map keys
> > are ints and values are of type struct A:
> > 
> > typedef int int_type;
> > enum E {
> >         E0,
> >         E1,
> > };
> > 
> > struct B {
> >         int x;
> >         int y;
> > };
> > 
> > struct A {
> >         int m;
> >         unsigned long long n;
> >         char o;
> >         int p[8];
> >         int q[4][8];
> >         enum E r;
> >         void *s;
> >         struct B t;
> >         const int u;
> >         int_type v;
> >         unsigned int w1: 3;
> >         unsigned int w2: 3;
> > };
> > 
> > $ sudo bpftool map dump id 14
> > [{
> >         "key": 0,
> >         "value": {
> >             "m": 1,
> >             "n": 2,
> >             "o": "c",
> >             "p": [15,16,17,18,15,16,17,18
> >             ],
> >             "q": [[25,26,27,28,25,26,27,28
> >                 ],[35,36,37,38,35,36,37,38
> >                 ],[45,46,47,48,45,46,47,48
> >                 ],[55,56,57,58,55,56,57,58
> >                 ]
> >             ],
> >             "r": 1,
> >             "s": 0x7ffd80531cf8,
> >             "t": {
> >                 "x": 5,
> >                 "y": 10
> >             },
> >             "u": 100,
> >             "v": 20,
> >             "w1": 0x7,
> >             "w2": 0x3
> >         }
> >     }
> > ]
> > 
> > This patch uses json's {} and [] to imply struct/union and array. More
> > explicit information can be added later. For example, a command line
> > option can be introduced to print whether a key or value is struct
> > or union, name of a struct etc. This will however come at the expense
> > of duplicating info when, for example, printing an array of structs.
> > enums are printed as ints without their names.
> > 
> > Signed-off-by: Okash Khawaja <osk@fb.com>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > 
> > ---
> >  tools/bpf/bpftool/btf_dumper.c |  253 +++++++++++++++++++++++++++++++++++++++++
> >  tools/bpf/bpftool/main.h       |   15 ++
> >  2 files changed, 268 insertions(+)
> > 
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf_dumper.c
> > @@ -0,0 +1,253 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2018 Facebook */
> > +
> > +#include <linux/btf.h>
> > +#include <linux/err.h>
> > +#include <stdio.h> /* for (FILE *) used by json_writer */
> > +#include <linux/bitops.h>
> > +#include <string.h>
> > +#include <ctype.h>
> 
> fwiw: the preferred ordering would have been:
> 
> #include <ctype.h>
> #include <stdio.h> /* for (FILE *) used by json_writer */
> #include <string.h>
> #include <linux/bitops.h>
> #include <linux/btf.h>
> #include <linux/err.h>
> 
> > +#include "btf.h"
> > +#include "json_writer.h"
> > +#include "main.h"
> > +
> > +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> > +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> > +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> > +#define BITS_ROUNDUP_BYTES(bits) \
> > +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> > +const int one = 1;
> > +#define is_big_endian() ((*(char *)&one) == 0)
> 
> Could we try to do this at compilation time?  Without the variable? :(
> 
> #include <asm/byteorder.h>
> 
> #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
> 	return true;
> #else
> 	return false;
> #endif
> 
> We could also just include endian.h, but since it's a non-standard
> extension perhaps using kernel header is a safer bet.
> 
> > +static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
> > +			      __u8 bit_offset, const void *data);
> > +
> > +static void btf_dumper_ptr(const void *data, json_writer_t *jw,
> > +			   bool is_plain_text)
> > +{
> > +	if (is_plain_text)
> > +		jsonw_printf(jw, "%p", *((unsigned long *)data));
> > +	else
> > +		jsonw_printf(jw, "%u", *((unsigned long *)data));
> 
> nit: I think you missed these parenthesis
> 
> > +}
> > +
> 
> > +static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
> > +				const void *data, json_writer_t *jw,
> > +				bool is_plain_text)
> > +{
> > +	int left_shift_bits, right_shift_bits;
> > +	int nr_bits = BTF_INT_BITS(int_type);
> > +	int total_bits_offset;
> > +	int bytes_to_copy;
> > +	int bits_to_copy;
> > +	__u64 print_num;
> > +
> > +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> > +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> > +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> > +	bits_to_copy = bit_offset + nr_bits;
> > +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> > +
> > +	print_num = 0;
> > +	memcpy(&print_num, data, bytes_to_copy);
> > +	if (is_big_endian()) {
> > +		left_shift_bits = bit_offset;
> > +		right_shift_bits = 64 - nr_bits;
> > +	} else {
> > +		left_shift_bits = 64 - bits_to_copy;
> > +		right_shift_bits = 64 - nr_bits;
> > +	}
> 
> Or you can just put the #if here, since it's the only use.
> 
> > +	print_num <<= left_shift_bits;
> > +	print_num >>= right_shift_bits;
> > +	if (is_plain_text)
> > +		jsonw_printf(jw, "0x%llx", print_num);
> > +	else
> > +		jsonw_printf(jw, "%llu", print_num);
> > +}
> > +
> > +static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
> > +			  const void *data, json_writer_t *jw,
> > +			  bool is_plain_text)
> > +{
> > +	__u32 *int_type;
> > +	__u32 nr_bits;
> > +
> > +	int_type = (__u32 *)(t + 1);
> > +	nr_bits = BTF_INT_BITS(*int_type);
> > +	/* if this is bit field */
> > +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> > +	    BITS_PER_BYTE_MASKED(nr_bits)) {
> > +		btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > +				    is_plain_text);
> > +		return 0;
> > +	}
> > +
> > +	switch (BTF_INT_ENCODING(*int_type)) {
> > +	case 0:
> > +		if (BTF_INT_BITS(*int_type) == 64)
> > +			jsonw_printf(jw, "%lu", *((__u64 *)data));
> 
> nit: more parenthesis here
> 
> > +		else if (BTF_INT_BITS(*int_type) == 32)
> > +			jsonw_printf(jw, "%u", *((__u32 *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 16)
> > +			jsonw_printf(jw, "%hu", *((__u16 *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 8)
> > +			jsonw_printf(jw, "%hhu", *((__u8 *)data));
> > +		else
> > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > +					    is_plain_text);
> > +		break;
> > +	case BTF_INT_SIGNED:
> > +		if (BTF_INT_BITS(*int_type) == 64)
> > +			jsonw_printf(jw, "%ld", *((long long *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 32)
> > +			jsonw_printf(jw, "%d", *((int *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 16)
> > +			jsonw_printf(jw, "%hd", *((short *)data));
> > +		else if (BTF_INT_BITS(*int_type) == 8)
> > +			jsonw_printf(jw, "%hhd", *((char *)data));
> > +		else
> > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > +					    is_plain_text);
> > +		break;
> > +	case BTF_INT_CHAR:
> > +		if (*((char *)data) == '\0')
> 
> nit: here too, etc..
> 
> > +			jsonw_null(jw);
> 
> I don't think the null is good.  I thought I mentioned that?
yes! i intended but missed doing that amongst the several other changes :)

> Look for
> example at Python:
> 
> >>> import json
> >>> thing = json.loads('{"a": [97, 98, 99, 100]}')
> >>> bytearray(thing["str"]).decode('utf-8')
> 'abcd'
> >>> "".join(map(chr, thing["str"]))
> 'abcd'
> >>> thing = json.loads('{"str": [97, 98, 99, 100, null]}')
> >>> bytearray(thing["str"]).decode('utf-8')
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> TypeError: an integer is required
> >>> "".join(map(chr, thing["str"]))
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> TypeError: an integer is required (got type NoneType)
> 
> If you start putting nulls into the array the conversion to a string
> will become more difficult, won't it?  Do you have a use case where
> this helps?  Maybe my Python-foo is not strong enough?
> 
> > +		else if (isprint(*((char *)data)))
> > +			jsonw_printf(jw, "\"%c\"", *((char *)data));
> > +		else
> > +			if (is_plain_text)
> > +				jsonw_printf(jw, "0x%hhx", *((char *)data));
> > +			else
> > +				jsonw_printf(jw, "\"\\u00%02hhx\"",
> > +					     *((char *)data));
> > +		break;
> > +	case BTF_INT_BOOL:
> > +		jsonw_bool(jw, *((int *)data));
> > +		break;
> > +	default:
> > +		/* shouldn't happen */
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int btf_dumper_struct(const struct btf_dumper *d, __u32 type_id,
> > +			     const void *data)
> > +{
> > +	const struct btf_type *t;
> > +	struct btf_member *m;
> > +	int ret = 0;
> > +	int i, vlen;
> > +
> > +	t = btf__type_by_id(d->btf, type_id);
> > +	if (!t)
> > +		return -EINVAL;
> > +
> > +	vlen = BTF_INFO_VLEN(t->info);
> > +	jsonw_start_object(d->jw);
> > +	m = (struct btf_member *)(t + 1);
> > +
> > +	for (i = 0; i < vlen; i++) {
> > +		const void *data_off = data +
> > +				       BITS_ROUNDDOWN_BYTES(m[i].offset);
> 
> nit: empty line between variable declaration and code, perhaps also
> don't init inline since it doesn't fit that way?
> 
> > +		jsonw_name(d->jw, btf__name_by_offset(d->btf, m[i].name_off));
> > +		ret = btf_dumper_do_type(d, m[i].type,
> > +					 BITS_PER_BYTE_MASKED(m[i].offset),
> > +					 data_off);
> > +		if (ret)
> > +			break;
> > +	}
> > +
> > +	jsonw_end_object(d->jw);
> > +
> > +	return ret;
> > +}
> 
> Thanks for all the changes you've made so far!
