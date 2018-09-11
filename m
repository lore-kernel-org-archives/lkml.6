Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B76C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE2F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TcDvfcZm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="D0B5ikda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE2F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeIKU1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:27:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46540 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbeIKU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:27:37 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BFILdf013936;
        Tue, 11 Sep 2018 08:27:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=oTWPIq65rrEIlgb5QGRpB+HdEgp8iqM3suqU2J8Uip8=;
 b=TcDvfcZmprJ6AzUlBsqgGj+m2bnw7ukkjUoR7Q5+3hwVXE9FH33ajkR0Ib7IFKK8Y5TO
 0fbiA6hXgV/VnFHZuy3sOhaRLn0hav/M9X53BcfsTNxNIAfngdENA6Fv3CxDiVcX8t83
 7bmfLubatiegNc2WgrUUaieLgEjORlB52ko= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mee9hrc1u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 08:27:44 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 11 Sep 2018 11:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTWPIq65rrEIlgb5QGRpB+HdEgp8iqM3suqU2J8Uip8=;
 b=D0B5ikdaGYdDpYwdXYqVjsQWF7/nXfbYwvAQbyd2qCGZVWsfuKB8UfHtVifruMu2qPtms1g7sIgzYgfWvfT7ec5mcDcETqPX59+9xnH7Ux8p4Uk8zzHfr/iciVvMKxFS71F0sNQNyGmddkxhoFAJb/AePRxTw8OulLUrdfR2WWw=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::7:f329) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Tue, 11 Sep
 2018 15:27:38 +0000
Date:   Tue, 11 Sep 2018 08:27:30 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180911152725.GA28828@tower.DHCP.thefacebook.com>
References: <20180910215622.4428-1-guro@fb.com>
 <20180911121141.GS10951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180911121141.GS10951@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::7:f329]
X-ClientProxiedBy: MWHPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:300:c0::31) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dca0e7db-f37f-4457-d228-08d617fb1c40
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:59AI/9IyzFrtGqHUFEZk6xR/zgmDtRwS6pi4ycTg0kL6O10/ppazyhw3eyEjzrZDJB8JpoTeLz2WTHNskKvb3FbB+Vvxo2+185b9HTcVQzJt4Hih1XpMeDtvALc9p4P8Z8c8nH+8Gw+zLu6WTEd1Imu//GJuAJrmGfgwFkuLs8XrH845omnv3IEMP11U8TTnXNAaQgFvD6CkxxxVoaKTORf0lC8IuN39vFOCKoGdOF0sBB4xFmdZqW/0eKpvFvUk;25:X+XD+fqAzU8ufFbnGnPjnymJ/GCD0SVsjMZ07R+pA1Yq8vrpoiuhL2YAv72vd/gAkC4G5ticg0EOifNLkkGnzVCkDkIkFEhcjlf2XQBu2LNVNZFFTvZAm1TeWAxTxdzu9wcLd2pNiz7fBILo2Gf0TMosHDsG0WH+Lto9SdxKk/0IAo7GMb0IrFv4otLdROKja1M7ZATJQkIy2wHoK24x/aZnbLUUrbRZ8bekwXFWQsFmXQcRMPGWzNab6zTkNfxUsMkgOJ5UvXYOjyN5zv+ntC0MMn9yzt/3TgfGccgAvDiGM9gfjNq2GgVaS1QZTbk94QfQdzRGBrlhyLy04pG+Lg==;31:Dt59BP0sapKN1WIEGsUGdgvYAOFREVF8vFVIVMOrb9bZQQZwu4k8ssGG6bQVgd/ZKOOnG7wOmzfddwlrLDzpejOWC0WWNPmFyBN4iKhN3uX2C+Q3L5fAkGKxhVPjKEsQmtGVm76sLoqjoetlQJWP6CpuKrTapOMOrzpmLCEQW/DAno4MJPxIm0ddNE5PrZKQGBlMytDfQhowRN6wsvRI4vx9+nO5uaNNC8yRMqgxbgk=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:nTTr8q3SLhE1SZAD4+XfhSpIS9/j0xLIiP21dNXUke5CWfjIdT5jxWFDK3hTXyXVJ+b2lrB0rgDfkaZeWMuBIS6SG1p49yNorGhm9lHH/a7rSoPo3PlMXlpDxm31kV5sqqHMvM6xyRl44417uAzVDTpALrPMToqXkKNl4lhCcg6G93itE40i8nrdRhlwkfPT83dowViEjYSQ6MaOxNR7vXg55XZkAJs2BzVKiX1vsrdpw57F/XOUhp7BBOUmfoG0pZjauNtoVUXtMCYUhMDBw0jyMjyR92T2/EDgT/qwZjs8WSGOmsvqHKp8UQSJK/9ai7nyJP+awM0u/BF3aC8y7rKhg1EDTCGXwiCc8ZuhdFz8TINNRSq6R2Ho5zRwAoVBmWPVCl9w2+K5jVx56Tj3V3WelnseCWQxUK3kgivIyKci7IK7xX5jCecjNeFkorgh2hZO3y02nG/lCde5SsmDs5hyIg+3V1xN0q/thrioTGTBLDR/W9ig7pztXo60gIjU;4:PuzTE+eBS4SX2aYzQiVchpg3N064hHKZIMk26dWwI6h1TgwXXO2mNTm+C5QJeziBZDBtBMglMiUbsvvmLiw6BXIJF6yxC/gk0CHHGoQfha+A9scTnU/+z0kPtJmpqtHr7RTZ/v/XvczEXgxWBQNTgaU/xWGnoWkec8buGKL4jB+VoVwr6UcEvmB/wt6Cb91i+0CqLzJIPl9nxuKZqLCn6Wz/dJlp8Sw3u3txTjelPIOOEWR5+5jN0fszNPbjvpLAwtXytdxLPNLGpR0RaeMIlA==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162F52039CB37382617992CBE040@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231344)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(52314003)(199004)(189003)(25786009)(52116002)(7696005)(52396003)(39060400002)(76176011)(4326008)(6916009)(8936002)(6116002)(478600001)(46003)(5660300001)(305945005)(16526019)(86362001)(229853002)(186003)(6246003)(68736007)(6666003)(14444005)(16586007)(316002)(53936002)(9686003)(106356001)(386003)(105586002)(55016002)(2906002)(58126008)(47776003)(6506007)(33656002)(476003)(8676002)(486006)(54906003)(446003)(97736004)(7736002)(81166006)(11346002)(1076002)(81156014)(23726003)(50466002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:71q98dcbGyaW9fnLPjYnOfOeSYa4wSMdrnQ7NipYD?=
 =?us-ascii?Q?uAFc9ohoIOqkWjDnVnbbHdfUu4NeJqc9WK1zAbHbV98y1B8HTs8qrWMUtKsP?=
 =?us-ascii?Q?n+dpf+UydZV7URgsMq/SA8Kwm0Z4PPShaDXeQCPFpfDV4P3XhYbh6bR/kzoW?=
 =?us-ascii?Q?GC3XQpTBV2nbB1ZNDHXTMYTslzkfpPN0pAi1Go0S8yM2Cncr3uyTucygk51D?=
 =?us-ascii?Q?A30ek2cmBhDhY+ty7ipKU4wIqHFiY02iMxYQgQbncIRU7/6fDZuXDQ0FpDfZ?=
 =?us-ascii?Q?6t/o/exQYRL0m+M48wbN9gNi9syIYR5aRxaUCtkBsa7Pd1OfGpVkyTo3Vi+Q?=
 =?us-ascii?Q?3gAlNVfSWQwFD8dAEHBq8QYKPcmWsZ9bYBMd/MTYwbDfRTI0wmJY7xrmSSp0?=
 =?us-ascii?Q?SyYlxPXYh5I54klD++XeE6/qrkxQmZpIfhtJWg4Th6E+aA1NHujovsRYZAW5?=
 =?us-ascii?Q?i/5vRYG3tEtxQd/AE8kWpk+vZFJ37b+0FuFPlXEGTQHosxCyNXI5HIKiewLi?=
 =?us-ascii?Q?ZUjqYeDoArummFLlnFJkQsYGVJ1pyJriASehK5l9+xNbDKSYJeN/zK938PY1?=
 =?us-ascii?Q?VtV9luK84+QY7fpGJb4GxrWMPVekob1TrPfTm3KXMf+7Q3v16A1MBVOLptyi?=
 =?us-ascii?Q?xHe4gqVt76gutIsxh0OYSudyvAfmUIK9N5JJkeo7FoYl92iSsqTbTq9uyaL7?=
 =?us-ascii?Q?CEdg2mKY5QxGEGovHn2dwaeZ+BOiyTIIvC4J+bIUCX7xQXr9wsZ2lF3A6LIf?=
 =?us-ascii?Q?B2YJKHYG5NF1BwVfkgM/DEP2Uha7WixRz/6iHU5Gcx5CpVlp/pdi1ZESojJI?=
 =?us-ascii?Q?zGh+xmxszq0r7T1tWi2kptNuscSSfRJXHXnqW31sZJqaQPKGxX6+bhf79Fqm?=
 =?us-ascii?Q?JE30/QWS5ju0dBDo4KLNQ1mrbjmuT2QumtxM1AcX7oZNt/vUqJQ6vTZLn85n?=
 =?us-ascii?Q?puc/WEconLb3PD4Y1FXzLtzHOFMDD/pjVU6Ahh9DDt22nT/X+rcaJbEcHODm?=
 =?us-ascii?Q?EZUu0rmpuKPkdntHoGjEgjW0TAGD3qeEiVl+wE6Apnrw7laCnVv1karhF0Hg?=
 =?us-ascii?Q?GsaDy4keVG9DIv7O9UP94m+kq1aMllRBbUD/PgdfKZsU3RFTh14L003SWFbr?=
 =?us-ascii?Q?GNH5hBYZeyblQL8iorWK2EKnrnvey2+2rXUY3jfFkW32boTkpQsNjTDjfP1+?=
 =?us-ascii?Q?phBOTCTnEuyVDZJKA+NaaPNke65wvaFjmuSWL5v9BIKqQmYoJ+9/w/DJ1hOI?=
 =?us-ascii?Q?a6jA0wQQU0Or8hGZ796POca6Ww2ebPIfG6v4OCvPlLK2vc4xo6MCksHK02NV?=
 =?us-ascii?Q?/o1wd9FQ4lN6LmTPWxALgg=3D?=
X-Microsoft-Antispam-Message-Info: Ryv0tgo/kkSqKMXB3Ll7niU63bHpwj/es2JAD8hK0lI53zzPnb3VHeRgxTLQlkn0oCMmSzpYDHHyaThSvMESYOrpsqFeQbX+81KtpVlsALx6zesUMZ1TWMuTG1lccIjudpPWc0sNPtik8VplNXjpTsrr2kUvlqhzwxJ9zSKzFiFMuPfrxZM6V4pC/vJT4Y/gk3PbIZ6uUXx2ByK8O2TOvkQ1o4wxUEyr8tCszvbOOKIsoiZkvpP1y0kufucj5zrYrIKvfx/v2pgGV3n2+l0bZ0nr1yP5X5u1tRyQWaVqioZUZkGV4SYItOaW5eo+anpCMuPRUsMU76wF8K/VMkdtizTeE87RMY+t2RtymFwX18w=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:qiC6CmhpqIUhZTCRI2ldQu3KsETyoigrGbKDdKXLbuZR6N4GiBDaQo6NrZBo+8paDV0pwk6ShDWhTEoOaenLQST6+FOGj/QeQKwNw0bzzrR9oNsCT/lw2jpxQBFNNiS5iGZrjbkxSybC1fcy/f4SY3tMtSKEqsYFmabR8u0xf3hasQL+V1ODpEzVqUGqnmvtEVbKtbzH4wSDkppEx0yKmHzG8OnOnhGNAcLyJixuw7sdrutcDZE0+GeFUjL01X4Tocy193rcwiBy3rFY8Imh+rfHPLh2sjPWpDlhVeSTrqvk2+RC/k3c6r2L4YhjzERdef1G9FWkrA7GLu6vl17Ths6MzB9dGbgzfBkwqthQEu8j5R/OsMDSToB57kC/7G81KKqI1yjrpDuw0ShH+8E0lFX/cDLNtIvROXb9LfkEvqbXMNtRykqoTkuUDbqdXv2NPRByP/laBlxxq6V0nuMLyg==;5:SvhiqW1uAqxCj5b0aRdsO9C+K4AcC1vTgk//p4c6ObdDp14lmZIgq8NFRIiKd5R4q8y+5yPF5nwQ1vvQraLIMfwa+KHk+RKcSLLYdWCnqu96vM5dtkhfGp3FihNLdL3wZLJbrrO2VKQPZeNjPU5jVT0STspBw1ZykFrNLwg+jv4=;7:q+wWhTyeZF/Vjet6w+5x92khVKhDTU9LY+/wby9M1bDiaqJ33gzxcZdM8gjljrODBchl8U2HOm2D48mSjsoSxwWKbQ27Hj2jc6iOp2Ts8CInuCJaNxYHkTyKSf91LOkiPk38deFXrhOADmA+C1cCToAfbHSjfEMDgd1db+UDypCJqrydeIlAb7dmwRXNbpvBlu5V/jjDz/8rsh/RkL+1M5Wj2B5+7C4xmEhTxpm1u95nPpxudrG9+NEI9gRaxzxd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:iqmZzsZ4mnlEExopFxijiHB/NJ1kWiWi7g5vrgbzWCO51RmnJplvXGI168FxYcFDkL9P5+FGrP+apqOg76aQV49zBVBx/hsPVrefItDM2XKwTEiS0FwoO53XbpVE46SUyh5PJRoL/pPbv9XFFl46riRexOEyLinnjdJB7GteNV0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 15:27:38.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca0e7db-f37f-4457-d228-08d617fb1c40
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:11:41PM +0200, Michal Hocko wrote:
> On Mon 10-09-18 14:56:22, Roman Gushchin wrote:
> > The memcg OOM killer is never invoked due to a failed high-order
> > allocation, however the MEMCG_OOM event can be easily raised.
> > 
> > Under some memory pressure it can happen easily because of a
> > concurrent allocation. Let's look at try_charge(). Even if we were
> > able to reclaim enough memory, this check can fail due to a race
> > with another allocation:
> > 
> >     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> >         goto retry;
> > 
> > For regular pages the following condition will save us from triggering
> > the OOM:
> > 
> >    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
> >        goto retry;
> > 
> > But for high-order allocation this condition will intentionally fail.
> > The reason behind is that we'll likely fall to regular pages anyway,
> > so it's ok and even preferred to return ENOMEM.
> > 
> > In this case the idea of raising the MEMCG_OOM event looks dubious.
> 
> Why is this a problem though? IIRC this event was deliberately placed
> outside of the oom path because we wanted to count allocation failures
> and this is also documented that way
> 
>           oom
>                 The number of time the cgroup's memory usage was
>                 reached the limit and allocation was about to fail.
> 
>                 Depending on context result could be invocation of OOM
>                 killer and retrying allocation or failing a
> 
> One could argue that we do not apply the same logic to GFP_NOWAIT
> requests but in general I would like to see a good reason to change
> the behavior and if it is really the right thing to do then we need to
> update the documentation as well.

Right, the current behavior matches the documentation, because the description
of the event is broad enough. My point is that the current behavior is not
useful in my corner case.

Let me explain my case in details: I've got a report about sporadic memcg oom
kills on some hosts with plenty of pagecache and low memory pressure.
You'll probably agree, that raising OOM signal in this case looks strange.

It's natural for cgroup memory usage to be around memory.max border, and
I've explained in the commit message how an attempt to charge a high-order
allocation can fail in this case, even if there no real memory pressure
in the cgroup.

Thanks!
