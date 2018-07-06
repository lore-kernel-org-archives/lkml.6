Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7239C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4713220849
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aF7OnFwb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c6WPKXuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4713220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeGFVxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:53:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54304 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753367AbeGFVxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:53:35 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66LrAI6003668;
        Fri, 6 Jul 2018 14:53:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=S50hulBfVwX+m7ZM+FyWdvKCXySzFRTfR0k+penGjlI=;
 b=aF7OnFwbdC6atKdIzi/x1unRcVhN+a2g7fJAApAiovl10SVop03MMjY5D8u3XyxIpvwz
 yhvPU6h+sjFy9oK0UKBAtrALAkg/5ILByvuMKfSqJVEuEK0ajFs41jk+pAW/Ahyvf2X/
 4lSiSnVzUxjxtkZ3ulHmiUO/6zRwLbEFEs0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2e648b7b-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 14:53:10 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 6 Jul 2018 17:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S50hulBfVwX+m7ZM+FyWdvKCXySzFRTfR0k+penGjlI=;
 b=c6WPKXuwC8BnfCV61NUP7B70TxjOdIf51WkWOyLnbrydN2hrzWCgpsEFrZNKZVley3kQ+7XLhcD1Otm6yUYiYnUdZV0Cmaz2ZdieK//xVIA67jASHGcCapKNKqjWwakZws0GS6ZmWgx6/Ch1GJReHWk/c+g7hbWRaPynrylZPBY=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:71ff) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Fri, 6 Jul
 2018 21:52:37 +0000
Date:   Fri, 6 Jul 2018 14:52:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <kbuild-all@01.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sean Young <sean@mess.org>
Subject: Re: [PATCH v2 bpf-next 02/14] bpf: introduce cgroup storage maps
Message-ID: <20180706215229.GA27634@castle.DHCP.thefacebook.com>
References: <20180705205139.3462-3-guro@fb.com>
 <201807062214.O8pQxWve%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <201807062214.O8pQxWve%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:71ff]
X-ClientProxiedBy: MWHPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:301:3b::24) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b4513a-556a-4057-cca8-08d5e38acd26
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:DEzrkkfgObNwaw57gmS+v+9fPjvv9T8P1NoV1DQrdvZy7g2+WKvSMmx7nyyyiq/bB8fxH+u4WGflMRB7edWykTmwjyUm6YtCMBgvx+/8t2XeovSP3cCMgoiZaSW91SQPpas/GXPxoYrmrbE28patS9jW4TiK2fZRfWdvtbBzQuPPm6iYO2fdXhOVKagqYMcqJvqEcU8tesiNbjqTh+czjSQ0/hRQxvVUx0/ZRUheXTdaNmbQD1YUSOr02TUOSZzT;25:IhzMRHK3m/IMCSstm/vVFmkXTnrCzo4f4tMGaDWw2zt22n/EPMjAS+UezTMQhqmZs3O9um3kpqcaphYOGGQdpA3QdC60Yy35B2FsMSZ4UCO8CdjRWw6/3xTCXRL4Kw5HYuA97lP6vNDqyzwR5kAoVIfsSGwOuDtqBCzBIN8UrpojviahDAcMOMtsqxVkxCSZJjLsC3/fG/LYJK1M+EPtKAEO+Pnk8oc4ja38V+/sh90PH3r2/ON+PyJxUYjLla0ijhE4H1IZq+C0to8oYoTjUC1ZV6uP4mEcJyX2IMN1xj1fCmXuMBjL82xmv3wGSmzJ68Fj38b1a5tVK/dExamROQ==;31:GU650SkgXyWNKgxQX95STlzPa3UHEmpx0N1/V0bMcixfMD9GdddUGLHvzokR+IGZ7FCKlF5Wf4yD2j3ysxo6/Lpjz7ECh7rxKJnvU4T1D0ewSliFmXLq16EE6FNEOIT+b92CD//3EbI6jtoGAlJvI/1yiY7grnICbsWq74Nv7lLVKcQZ/w1Swc91ml+n8oeE69A/gqssF1VJwjqpuC55ku68YH1E0t7m6Ro88a3MGWA=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:g1IYflwkvM29PD3jV5svqAZhlc4FmkuGhI7zgX7zeMFLAr+IlXt8evcJTzqtWmOLJ8XOb4QiXEbXOMOsL0q+TKoyMgWC/iUt3HM9aHYD0beQGA5cxAh+SJ4qAFsH2oofk9N941ewSgff5BXKgo4l7s07SDZbQUYxM46lk1vaCIEAXJpltv0DWR81ay7Ni77+SRMegFZ6BeVA1XttWKyhu+LNkAyo6hZFqY2ktxXY/Wt/ZVrsTPfTOYNsCrFQWf1zrAWcLl2MIdWxAw3e25AkYsE2W5I4X0VAOUcRtEEQZMzHWSeLg1Xn1NmVa4S1YVm3jczAvEc0iP/D0uee09eTeCR2W0Ske2+woYe0G6k1DfKBnar5/ImAQbtattwrKDHMvOM/Vzhuo0nl4f1SsFk4c3wS4xvBl3+a82FngjN+jCa0XOKF3cbZmTLBLARoAW4mbXJB1NqxtZkjpe9I0PfnFm5HniEK9RIRI9lHU6ExaHYlaR/cfIQpDSBJWIouUXym;4:Kz+2yKYEQ+vam1+MyzUSbFhQfNSquEmT6ysgMOoKMY2DnOyV6J+S/NfALHKDMErqV3NobBN/prBMVSnJc5p15+LnF7++KkNROtQFKk2yc1Fd03cKybb+/FUgEuKMmmQ7mfP7UvbAJK6f2x7wy6cNHhDdTA/ZOoNtcCEn93yCmKe5GzvvmlIBaQanNytDgX+3FeXh7TpAP1KHoyodsR2uM/w83ohiD4BXaNi77LG6j5TdzNcv6JKdgqbMPj7zdd2PtqBAQ4aWszfbS31C/170Y/aC2WIvOHQSq+ABWzfCV4YDnst5OLXugHr/IOKxpelAAhT0G9iylS0zY5EU5Ac7nOrntPRDo8h2oNANIPbt0Fq1mgO9wvqwETH//W6xnnzGcICrjQdUTTksZWMO4N10i2lZm96wkUFuKbS9gZBLmm8=
X-Microsoft-Antispam-PRVS: <BY2PR15MB01679D3B23F45557ED220E0BBE470@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162)(166708455590820)(67672495146484)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(105586002)(345774005)(446003)(86362001)(575784001)(11346002)(486006)(476003)(2906002)(8936002)(7736002)(305945005)(81156014)(81166006)(2361001)(8676002)(58126008)(316002)(16586007)(68736007)(54906003)(106356001)(33656002)(6666003)(5660300001)(6916009)(52396003)(7696005)(52116002)(6506007)(386003)(229853002)(53546011)(76176011)(4001150100001)(46003)(14444005)(5024004)(186003)(97736004)(16526019)(47776003)(6306002)(50466002)(9686003)(6116002)(55016002)(966005)(25786009)(23726003)(4326008)(6246003)(53936002)(1076002)(2351001)(478600001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:J88p0ueS7GW/v1kzXgRpl87VA3/SyR0qbuCyau1jb?=
 =?us-ascii?Q?tq2Hs2QMEeo0kgjW6TNFChH8cH3Utj95Gj5wMSBFE/NQFDFvD2ac7AGtLEtf?=
 =?us-ascii?Q?CHdQx5nxqtCTd306DVcj1R/jAFbwPs46BLAS4Wm9moM0tTr00czeQ3H2meO5?=
 =?us-ascii?Q?Q2REPNehApWAda3y5quVkDe7odNEc2z9m5MW1PvYOjFUu1xLI01TZYp4GIJ7?=
 =?us-ascii?Q?c7iwjFFB09LqrT8/kjmedbAqxVDxdASLwm5CJ5Lo5WFopaUWsN7SYd7wkRNF?=
 =?us-ascii?Q?HzWno3C4RIcoB2DflFsPZUu3mK2L86TgpehpeZoR6TSpP8K5kLRLeq5Gt+CL?=
 =?us-ascii?Q?u+ydifGe2QxAK0HD6wMlWixQO92OzI3oZN4ik/O6xgJ1Ib4xuU+EvGn8GltX?=
 =?us-ascii?Q?vymWn65ahRHXcCdWmiqrAtQIelV2mJuD5NBcyff3wB9t46MuLcYdTgQoCG3U?=
 =?us-ascii?Q?y+IGDzq455qb7R7dzg0LZMslxcwfg1Tf83jj8tlHad9DJ5ymD9eKGSdBT1F/?=
 =?us-ascii?Q?cHLDyvtkavQdiDyEkslr6vrbn6ixPvcFqoRWgLnXTnDyiDJBwGRX0Xnqwqf2?=
 =?us-ascii?Q?raKp2sbX9u7h7yzj4M00rRw6mws94Vk8ufWPmpSc5SW4OEfol04GM8pCocAc?=
 =?us-ascii?Q?k7vOUo4xJhI+ID1PHo2J7lDBKpW/yiJwkaHzPgYRGdvuDhU/A57lv4++D0FK?=
 =?us-ascii?Q?QDX/udmDx4SV8ZGk/HbxUJnovsW27buGxc4cmE0+wkReUOkyXYNprc3MpGdW?=
 =?us-ascii?Q?unXZUwI8n4vGn/dxDC+XEaSk0EgWjs4SkWKAve2YV7ID2oZzwTaAXTpbyqZh?=
 =?us-ascii?Q?Z4u6sNADx6NuEy007ZsMYlI89pfwwoCAN3sXmF9h60umHnGvUqQ4/ktM+xIv?=
 =?us-ascii?Q?IglyXxNNhy9oW7yg0kL1blPJKia1wSviJESXPHSmiwfnO/Wmt3/zQKIoNaKc?=
 =?us-ascii?Q?BTjY/a97n/dh5Ptj3e0u9YzDz1u3EBc4IUFpO07AJ43ZQvzoXQz6HYJTzZiZ?=
 =?us-ascii?Q?NfLPcpm22Be81kikFAB5geIrrhO7iEtD7CjFYxqUIWHdrqIxRPLudyIG9sLV?=
 =?us-ascii?Q?Oc+UzZldXEifJZesCZuCfQ6sX4BE/NInZ5P3VR4RklQ++1f3qR0BKO0+u67+?=
 =?us-ascii?Q?3uyXuxhhRVo/sbYrsAMXjfotaN4qTy+OwiyytUAQHcvhIEi4A1zR12MnJTUg?=
 =?us-ascii?Q?kBajKr4TiEDrx3MvO74LBLPXcinNoWTcerxamB7Ed94rj+TlJG9mR1/v5bsU?=
 =?us-ascii?Q?vz92Hrm5KnfLXL8zyxN+GmdFWTtZD2uydjCdHlPoH1W3B0axTEgVge64Q1Js?=
 =?us-ascii?Q?9BrmRq05qCiPI9dJdoSuqAMpqAKmQ0fL/wukoC9Qja2hwdseS8tTGcvep6mq?=
 =?us-ascii?Q?PnH1BtWL9sjYD/PP2Cn4pLhaLz0Xn+CtEm27o2WFP/MHgPcuxqghg8VozYCu?=
 =?us-ascii?Q?2wNOBBR+hwQgqOxRuYKXs1tbISCjEjS1OatOa9Jbmj1h+pBwpH2?=
X-Microsoft-Antispam-Message-Info: 60oUNmm1bEDTmRTBdl9Oc0zzQ7FvufwsbqH8Ek8kliOUT1VHEl1qEKevYUXXcCda/EzcHnX3p/YTYW1gyWH6dkGHsk5QO6pIr/S9NQuWXSC9VYWRrDpxD4LxxnglCbViGnBl1KrlzxauIuSHK/30GNBJ/i0haLQT/4lkdRFB6oohBOMYc8Ufkx6m2xzEfBugDMbchTOOpWoy3MMozkaM/aBh5Rm5VUUEq2b4moRZdfOz7w5VD6QHkJSMYMLvkAJneyxCZ9TGYL6+KT+tLAiSKcfcz3qKEkNeubVlzKmSX5nBBDmmgL4nMK30IX+bpgsr5M5L1o5SePC7H9QcP+YPotHN4nVqye896J04Qxuc1vc=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:aUpB5E9IQ+ImmyOCndaG8TiB38Z0q7Qn86u2QIMkH031kahMfAAaTQfKPeFbIOOkMQ/ARurb7yMNDbhOmDpMX0CuBPKSgOebzadcDudxMA0JYlDt6qw/Rja6CQcuqosMUyt+2pPZY1uPElfnThxPW5kUkRVYNVMqqAqbK8d9tDBYKAI0RLArK1TlJ+MLP0hOXOV71e45Hs91mGfMIyG7KWAJgAHItlMhcL+7HnYteaXkreN7+qis7nsxT9t0nv4pIDdXcoCh+YUi8WPSTvFNOW2ghmLLl79ak6RBQTigrLkrMdog/Ko1xksEA/Rj9fmgozehaE3A4aRLrUhCrHwlx9ENXgKPyn6P5G42T9tnL/fBka1qFbQbybG3HQYS12DNWCLkU5Te22PPgNQAw3UTWuBaP/BIitcxTco2YcVtqmRXUL4VqUkmIC+iYZMs73gZ5CRfIXiGc6UFqgBEr3c59w==;5:3u9F72atY/I5upMCp51LVE3EX9fB3gitRG/upl29Aui4B+RBV5LqQN1yhSC5e4dy1sPq5O55eQUtgkUO7V0rRcY13UFhqVNVF4M1I+NiDayTLHQiGQ2ExLApj1xlQpofcfZSZQefRFT2KvXm5X4NA/6X+Haiyh6Z/9c8v/f9ez4=;24:Inri7CedGRJAgS264Hnw7QeQv40+ffKgPi7rRkV59hTbLQFz4IZOYVKEeBRTlqKSbEHGOD4nG0l4icJaojHxct8Q/aO1r3a6jf0WXanCqm8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;7:Zn2pFW5GURLRtVGEoL+cEge/E/EBRvoeLfo7WTUzQcAzy/XyaPr4+q0WIGlhGwzQZpJnkGnz+yQuFJ5YnrXVryor9JygpDGPN5PmKnArSblipS3+x7y0KBLayNNnqvIf9QIRsjJNRGhM0eVdEpmIIPVDRfVOvHWXLack4/IP+4yffm3ZMeIP7CxdnWWiqrUtN9QBOg6fyseUza5YJXBjpCQjNddp5sQQNnbUlheirZ2sWFuhGKyPyB2qv2MP7gJB;20:wG0evV2pv4TZqZwnEN/fZuzrZQG3QAc511QkgAq82N4MzaN9Z4A0PNm1wyUMCB9bDvdBiw7S22YyOfAygXXH54vkOuIcWTdt8/cfaZB5NzFYacUv7DD7e3rw+ylxhy1+vgsnjylxN3O4MLSlXJYUMy7j/NfgwBaUXYk8pVxcP+U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 21:52:37.0894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b4513a-556a-4057-cca8-08d5e38acd26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:42:39PM +0800, kbuild test robot wrote:
> Hi Roman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Roman-Gushchin/bpf-cgroup-local-storage/20180706-055938
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: s390-performance_defconfig (attached as .config)
> compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://urldefense.proofpoint.com/v2/url?u=https-3A__raw.githubusercontent.com_intel_lkp-2Dtests_master_sbin_make.cross&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=ImwiAAR6DVyf5JEcIc5VLF9xY4lfFxVuk8_4BN6I03g&s=r0S7gFQPOZVZagshsK0pL3eU8_GRpD1ywrvYfXJ4yBQ&e= -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=s390 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel//bpf/local_storage.c:2:0:
>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_attach':
> >> include/linux/bpf-cgroup.h:237:10: error: 'EINVAL' undeclared (first use in this function)
>      return -EINVAL;
>              ^~~~~~
>    include/linux/bpf-cgroup.h:237:10: note: each undeclared identifier is reported only once for each function it appears in
>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_detach':
>    include/linux/bpf-cgroup.h:243:10: error: 'EINVAL' undeclared (first use in this function)
>      return -EINVAL;
>              ^~~~~~
>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_query':
>    include/linux/bpf-cgroup.h:249:10: error: 'EINVAL' undeclared (first use in this function)
>      return -EINVAL;
>              ^~~~~~
> 
> vim +/EINVAL +237 include/linux/bpf-cgroup.h
> 
> 30070984 Daniel Mack 2016-11-23  232  
> fdb5c453 Sean Young  2018-06-19  233  static inline int cgroup_bpf_prog_attach(const union bpf_attr *attr,
> fdb5c453 Sean Young  2018-06-19  234  					 enum bpf_prog_type ptype,
> fdb5c453 Sean Young  2018-06-19  235  					 struct bpf_prog *prog)
> fdb5c453 Sean Young  2018-06-19  236  {
> fdb5c453 Sean Young  2018-06-19 @237  	return -EINVAL;
> fdb5c453 Sean Young  2018-06-19  238  }
> fdb5c453 Sean Young  2018-06-19  239  
> 
> :::::: The code at line 237 was first introduced by commit
> :::::: fdb5c4531c1e0e50e609df83f736b6f3a02896e2 bpf: fix attach type BPF_LIRC_MODE2 dependency wrt CONFIG_CGROUP_BPF
> 
> :::::: TO: Sean Young <sean@mess.org>
> :::::: CC: Daniel Borkmann <daniel@iogearbox.net>

These errors have nothing to do with the cgroup local storage patchset.
They do exist in the current bpf-next tree.
Here is the fix.

Thanks!

--

From c0cd59b969e060765514224e31595763213e40f9 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Fri, 6 Jul 2018 14:34:29 -0700
Subject: [PATCH bpf-next] bpf: include errno.h from bpf-cgroup.h

Commit fdb5c4531c1e ("bpf: fix attach type BPF_LIRC_MODE2 dependency
wrt CONFIG_CGROUP_BPF") caused some build issues, detected by 0-DAY
kernel test infrastructure.

The problem is that cgroup_bpf_prog_attach/detach/query() functions
can return -EINVAL error code, which is not defined. Fix this adding
errno.h to includes.

Fixes: fdb5c4531c1e ("bpf: fix attach type BPF_LIRC_MODE2 dependency
wrt CONFIG_CGROUP_BPF")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Sean Young <sean@mess.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 79795c5fa7c3..d50c2f0a655a 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -2,6 +2,7 @@
 #ifndef _BPF_CGROUP_H
 #define _BPF_CGROUP_H
 
+#include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <uapi/linux/bpf.h>
 
-- 
2.14.4

