Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8825BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C00208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UaLp0yqm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dZ57iVrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C00208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeH1DIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:08:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34590 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727230AbeH1DIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:08:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RNICCU009561;
        Mon, 27 Aug 2018 16:19:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=pkdkG+m+A8vIavr6fMPnpLoPByP3osZJ/PC6JaB1i3I=;
 b=UaLp0yqmPPL4LqNmno8QO3ntkRAD1xR7U26uiRXPi50g2mcLftUhogNxa3JD6yJRhGQO
 C4P2JBJ4RF9YVHtGR5G+ra9++EX7Yrvx87L2DQomov1JdDUvaTa10rK6x9NZooZRplx9
 nHfwHueoiELtIKQRkk6jU0TZ80U6cJktzS8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m4rysr9m2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 Aug 2018 16:19:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 27 Aug 2018 19:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkdkG+m+A8vIavr6fMPnpLoPByP3osZJ/PC6JaB1i3I=;
 b=dZ57iVrV3r6G/bBxBoOELSRbHfKs6H71/gP9ndiBgRnVtyqfPJiQ6q0X7CEQ2UGj2FZv18Nt9Si09LK1GlkuXxLvkUf4hijKw6Xnj+Fup1Kk33DaYUH7puRnUXkIbvOrvGBXoF53tmWuC8Uj64FsntqEh2Q9ponjv52lgPhVXd0=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::6:20cf) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Mon, 27 Aug
 2018 23:19:17 +0000
Date:   Mon, 27 Aug 2018 16:19:12 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] mm: rework memcg kernel stack accounting
Message-ID: <20180827231909.GA19820@tower.DHCP.thefacebook.com>
References: <20180827162621.30187-1-guro@fb.com>
 <20180827140143.98b65bc7cb32f50245eb9114@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180827140143.98b65bc7cb32f50245eb9114@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::6:20cf]
X-ClientProxiedBy: MWHPR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:300:ed::23) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 039df7a8-5bdf-47a4-c94a-08d60c738303
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:JPEmtgRX+lg/dlHI3Q9zJZ2GJiNfT+jbVPUEqkyJQWVVruSls8jda3ZZTJ3f0WkD3OafCEwVbzfx9Igdt/YsW44zA1I0vdvOnNpA8eYXPlXUjKWndXNgioMXT1W/96TbIc4Mim+BZW6p8bn9PthjHvFb9n+DWJFG8EzlrpDg1UGVO2CoxWPf5yabssS19JePLCoo6b6opbeSZ3i3qO3Jq1O426fANMzJCCuRA/Si7T1tOh2Sqm58bsaAopVvYQaC;25:Y82DhMsYiXJ5bRWwo/3DrxqLqNQiPk9rOKMkNdK1zOS8CtX5P5H6eCJacm3bzCaZhiMIxbMTMUtnIdyWunyq2b433oKdiYz3S1jRqHfUakE2Mk83+44hJ+LC0S8ctBoBFBS8xbNW0zA/hjkHRxi6DQyN/6AieAdP7X7ydVc5J/wcDaKg5kLKmcAlX6+PdfGWJv4CyVFKZWhPXBo6HpILdRYRuA53fwz0tMpAv4U40g9Z8CutuOMNuCeCH+CL5PV32Tgu9AxOVk/A/ovZEs3t3E/1gxymsGCpa9+6LYRrsyjfl8olqHWyU7Jh5/m2HGGz5j980104y5kfPAOFr1oGQNz2/MHnfiglbz6ElsiJN+g=;31:6wHObYca2Mdi1azg70lWTqlDfLHUDDAzYv7X8c5pxpU8301dJZIK8bmoHXYHbSrNXMNbiHtALsFmsRfHSdAsWy/MFp1xhw/AQ1GWZ+Tqku8VeLncQ/5mb8XZsCQrv2MEBZxSdKvc8HUayKQAvcs/TSF6jE8Ef+/wBMangW+t0IsHxRTmWddilpvm8K7kaxifzgxXoOe5wgrxOHVuosr8p80ZkGfsAUTyw3QTlFzo1eo=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:hoEHofd6uMialtHCiRC+6Fa+PnhD6vGzodmhZ3quPf4xts3CgEEa3iaSl564G+coVGwyxnnoAuEV62Ol3sj5whQJuvmqCtAz0QysikWLOTtsbVa2MHVPyidJx0fom8Imr393UBh315SY0bL8IKMT+ZH01QLqWBv4Le9sUaKVhp2PmIkGvm7wy6VD9y9N2yjS4JX9F5qCNebhi4h15IN99ttydIoVmf5PcSIlecUUGZtfkIA90R27HRDVL+AElPM9gNLeIK4wgA40fCyoWxYLUSbi/uqT9TCj/9wZePQFTSik4OXIMbms4xIzdcgROUkUBAqWiVziUx2/r213hsWbVnNfD7PjdQgt92rPYOceIbmSLm763HMtbq9Jwjs1Ks+dw+AGzoCRBs88KTt4hdxvb+5BA5rfuf+xsqTHhwQnb8yD94eBaHz6ahSb+FrUe1KxE7LNUD1nvuhGBnwZpL2Xc755XYgM+YkF7Jmdso1AZZVsMpwBRicpAyUjAau3uEer;4:4Vr1ALiXzENo+0e+0rtqr2q/a0iXCNfmrtNgFhrMEdyHx1hmEcNbeFv1MCLoSLvWTjXpgUt4rIeBlzC9JxF5GkM+RiQYfuNX+Kid9UZ2I/VzsL8Zn3zNoF+Eb7zHPmw8kG9iW74nHr3jjmv8Y5Fum34qLrXeL9ogfoLlPClYtNhBbHXh3z8TfkrQfzXC7xcd1NZd7xUFfyStzim3MJBsX4PAhYvBhDXH3Nmb+a/uBrSCOm3UFujlWY8WzVawCsG1q82NH7OVWa26+Le/M3pRvUx9hupZymA8wLdHbVbpDQiLOmrcvN9M1zbwgtTWqxgN0t5r22OyFqLzKWSjjpIER4hibd8G2QYSe2dHs1Ut0PL5OO1bovRrCfUpF38VOQLVi3PJzOrY6iPyTsqbsxbkkUs4j4wzndLtjpgah05v9SE=
X-Microsoft-Antispam-PRVS: <BY2PR15MB016796D8F9E579ADF7766916BE0B0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(106356001)(446003)(47776003)(11346002)(105586002)(5660300001)(23726003)(55016002)(1076002)(39060400002)(9686003)(68736007)(476003)(6666003)(46003)(6916009)(229853002)(305945005)(6116002)(86362001)(575784001)(6246003)(2906002)(4326008)(81166006)(486006)(7736002)(81156014)(97736004)(8676002)(15650500001)(6506007)(53546011)(386003)(50466002)(316002)(58126008)(478600001)(16586007)(52116002)(7696005)(33656002)(25786009)(8936002)(52396003)(14444005)(53936002)(54906003)(16526019)(76176011)(186003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:pilb3cDzPYMdkdG4BUQe6KvCmvw9IT5qmT4tUrF2l?=
 =?us-ascii?Q?tZWmZpVdBCNQ8Kpe2aa1hawD2x5b8xsng1JOxdszQZ83Syy2WW1X4WwKmkkh?=
 =?us-ascii?Q?wZpi/wHG4ydmsPTyhk+d7Z0S8TW1sE05r5FPe7VifxMn+d4o46S6UkepLjzT?=
 =?us-ascii?Q?CpLsnezrsf7H5AQpSs7/23z7N1SlAIraND6XVo6qMX2KOPOt5w4lNWRGxrSt?=
 =?us-ascii?Q?I1ocaNsEn7Ynev7iS5bUY/67YPVhT4mz7gi3oOOIb7leIGyKw5/ScQNClhuS?=
 =?us-ascii?Q?pHdIhaoTP90N5hvbLfIwUmj79PvK9rEu2Ddm2vqMsNpq+g1PcEOz3guuU0ym?=
 =?us-ascii?Q?l/7TYO6yAAVttxYolYMEkQe72+0H9tYjFavyP1O1sGfKhN86N6iwy3eEcwOM?=
 =?us-ascii?Q?2CJ2t1sWUPj8gCacDURpMdKbC2r6IEepzLAvVR/0k+Xx+KkaLFznshmrVdGB?=
 =?us-ascii?Q?vInA+1Lb5GE0KdGYCC28Rh/URSsDEK4w06oJPHVCOj/81eATJbytBxyLBQaV?=
 =?us-ascii?Q?Y//VeslgIUxhSU/M9CTRhoqny1Jzxzl3IW4J7SjF/bsueBqqmXiCwhF0xVnd?=
 =?us-ascii?Q?k01d19nr3+amSlF2ZNZyPGfMP6joilCBZYF2EkiJbdagvTFwZwWFBOFed3Vq?=
 =?us-ascii?Q?9yHacuz7Hw0Ev6h4DaHrGWnjCYCaGnH4GIpR+ADrviA+9NSxdZBCU3BUsYgq?=
 =?us-ascii?Q?B2S2eO6Y6nPrgU+LKhxTwhezpN7Ur7uQz4T6c+sGAb7eEiBq0IyYLTrvSfdv?=
 =?us-ascii?Q?EfWStMOUVuC1XNgaZPhzeDoZdqoPKAOKe+SdCgh57w1UtFlNgrfUv8sFoXPt?=
 =?us-ascii?Q?7frzlvFtdgmeQ9Zq9k3tQOXa7FaspobcUooz+FZqx0qTtHpUDqpm9XHbRKIv?=
 =?us-ascii?Q?rTh63uHxuVvtcSyZFU1TSZbZ5RyTd3WfI/tnz5y5skFQGv7QhM7yDapHZRdd?=
 =?us-ascii?Q?r85k/1ILvI38Ov8vyxAYluoHnx2P1VjDHss0c81M/cuFesg/6/mHeVvC13tM?=
 =?us-ascii?Q?m77uID2pUVpttXRZp+V3l4A1UT7m5Fry+FP8KDZ+G/jIEnsHihLZTvmNAW0T?=
 =?us-ascii?Q?vJmOKvqtXJ7bKOcKO6dzS2gHkV8fvZ4hkfsou4Q9dO8+6rkKAkcKXzO3KzeC?=
 =?us-ascii?Q?37buwHVdod2wdaiWG5hF7cXiUvrEvXaIBTcPsXkrIAxiPkIJat58N36DaIEh?=
 =?us-ascii?Q?1vZauu/dOh7bTxnOjdzAxW+ltz3GkoACR4EOtRESWXSSNmnlJVls8gWjicfo?=
 =?us-ascii?Q?o5OywMfoEZqkfscfnWn97rlOwgtSbYTc4VhB2Gq9hrIAwMql4vBQLu4w6E8o?=
 =?us-ascii?Q?dvHNyw8YxV9QUdsv3+DbE4L1xsYYiJodSL1ZHP6MD6J1oJ11wRl7Br61UBgJ?=
 =?us-ascii?Q?IBz8Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: 890ZLpw1Vc5tiAjCskvyPAX+A3qS+YfwpXEMthonjpwEnxR8Mpfz2OdG3qRJGOveFDkrPVhC4W3YyTXLPuedL/xKkbE3yuRGqMp0+nbBZRmZlkd/D6Q6PPFgOUWDX+ewEPMdMWxjtAioxANPJGjiYy3EbAplKxkxGr4cjqN6WtYdB/m/UktJpgwibFSLZLNx2V9eoqhcp1YhEeNDY98zeVH8yKMztrqLl4oPD92w6ZBSEvDV89FbwupiIt+9PdiHIWeeTXIBN3wBkpFu+dZDzJU6Rj8unZlmH4dGSgjhCq+nr7nQvoUV32z7zBBBk+vVDdBgVFik2rLalUM9t7b7zOzgJGfFX1jBGoAFC0WpCEY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:bnqisvVENIqhmymOcSR9sI43Wy6tRo0sWZIfVoOZIu0/TmA/vQg2sxf/epETzKe287ANQqK97I7nW+1MOHo+INJlXFSGavAFxaDHtNsls7P3u5+0ZYRHItmRF492TCXMpyptn+CBk5B4qwQp1eVcsNoznvTmuCyWeaH56all1j/F+jxGqojnL9awz4nlKOW/hG7ddyM89PYWKebCGxQCW83450yR5QbbFA4FXI0kZzVe/iCmSwDJllB5L5eNTlVv1u73r3FIfRVd+mtF+ry8TtUZweXRe+cbcZPMbkxQJ4g28UWc708PBJ5el878nXQfarAUCd7r1yHGpXbifhnaCOW1EGOwMn0gMRM4fn3r7crxLOm8WqcCdp+qbaWWbH4E5u3riN2+qvRi16UE5TrO9lIIUuPSxb4eQ0H2zQzLHoBh55jCJx+2N1nmHEMXWgiZChwe/kLnae369E6wc4n5Mg==;5:ko2UHdyT/n0gKCpofo7XHiWIPqCMOMrPVASgZJ1kLEbM/ZIT17KyiDOHr9aFuogjPkN3tayeHKjy2L9OeCsZ6/h/pAOpZvcHej/+8gqbjiKBg0zUiDLfCLAZiQwHQQqyvkSuCQCfOeSn+FZ8HKGMiiUJ99xMI9xUTaYJB4bhbbs=;7:5EQAXvcHAr/RrGtYspUH8tDypYqsJKN4HS0LgY2ctj+3hoR2ZCDeNW0UVgyqNEZpuup3zJVgnzYgyw+CW9FzPWqC9fKtqoEXzAdg6IksI7SnJi30INNgdZGv+Hsmp2SSrgttmFQ8nrM66eKwbyRfQCq37lHTtcGdapiph/EhyJaac3qulDddjUj5M3FTa+iwP3Q9rfwdxSLeiKHVcUKdTYos/6idXB9wyI+hkpPre3+MUaEBfAGBhnpqlNGCn5Bd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:Lb+AjgbJ40Zombr26iIt3BassBeIvvsdSuv5DzHIuXy1O0EAfr2N2r9HYm+Xii9xDvumzVoLM6BMGqL/hQZjvzqy7ftUn4E7dtHotuJkV71WIENpzj4m4myA0fGHSFrbbJTXpzMpJjINjB4JfsIs9iYd4iLNW0Ubxi7IJuCbfs8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 23:19:17.1643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039df7a8-5bdf-47a4-c94a-08d60c738303
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:01:43PM -0700, Andrew Morton wrote:
> On Mon, 27 Aug 2018 09:26:19 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > If CONFIG_VMAP_STACK is set, kernel stacks are allocated
> > using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
> > stack pages are charged against corresponding memory cgroups
> > on allocation and uncharged on releasing them.
> > 
> > The problem is that we do cache kernel stacks in small
> > per-cpu caches and do reuse them for new tasks, which can
> > belong to different memory cgroups.
> > 
> > Each stack page still holds a reference to the original cgroup,
> > so the cgroup can't be released until the vmap area is released.
> > 
> > To make this happen we need more than two subsequent exits
> > without forks in between on the current cpu, which makes it
> > very unlikely to happen. As a result, I saw a significant number
> > of dying cgroups (in theory, up to 2 * number_of_cpu +
> > number_of_tasks), which can't be released even by significant
> > memory pressure.
> > 
> > As a cgroup structure can take a significant amount of memory
> > (first of all, per-cpu data like memcg statistics), it leads
> > to a noticeable waste of memory.
> 
> OK, but this doesn't describe how the patch addresses this issue?

Sorry, missed this part. Let's add the following paragraph to the
commit message (the full updated patch is below):

To address the issue, let's charge thread stacks on assigning
them to tasks, and uncharge on releasing them and putting into
the per-cpu cache. So, cached stacks will not be assigned to
any memcg and will not hold any memcg reference.


> 
> >
> > ...
> >
> > @@ -371,6 +382,35 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
> >  	}
> >  }
> >  
> > +static int memcg_charge_kernel_stack(struct task_struct *tsk)
> > +{
> > +#ifdef CONFIG_VMAP_STACK
> > +	struct vm_struct *vm = task_stack_vm_area(tsk);
> > +	int ret;
> > +
> > +	if (vm) {
> > +		int i;
> > +
> > +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> 
> Can we ever have THREAD_SIZE < PAGE_SIZE?  64k pages?

Hm, good question!
We can, but I doubt that anyone using 64k pages AND CONFIG_VMAP_STACK,
and I *suspect* that it will trigger the BUG_ON() in account_kernel_stack():

static void account_kernel_stack(struct task_struct *tsk, int account) {
	...

	if (vm) {
		...

		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);

But I don't see anything that makes such a config illegitimate.
Does it makes any sense to use vmap if THREAD_SIZE < PAGE_SIZE?

> 
> > +			/*
> > +			 * If memcg_kmem_charge() fails, page->mem_cgroup
> > +			 * pointer is NULL, and both memcg_kmem_uncharge()
> > +			 * and mod_memcg_page_state() in free_thread_stack()
> > +			 * will ignore this page. So it's safe.
> > +			 */
> > +			ret = memcg_kmem_charge(vm->pages[i], GFP_KERNEL, 0);
> > +			if (ret)
> > +				return ret;
> > +
> > +			mod_memcg_page_state(vm->pages[i],
> > +					     MEMCG_KERNEL_STACK_KB,
> > +					     PAGE_SIZE / 1024);
> > +		}
> > +	}
> > +#endif
> > +	return 0;
> > +}
> >
> > ...
> >

Thanks!


--

From 91b373bb03715dcd2393302ab1816c929ee980ae Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Tue, 14 Aug 2018 16:01:02 -0700
Subject: [PATCH v3 1/3] mm: rework memcg kernel stack accounting

If CONFIG_VMAP_STACK is set, kernel stacks are allocated
using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
stack pages are charged against corresponding memory cgroups
on allocation and uncharged on releasing them.

The problem is that we do cache kernel stacks in small
per-cpu caches and do reuse them for new tasks, which can
belong to different memory cgroups.

Each stack page still holds a reference to the original cgroup,
so the cgroup can't be released until the vmap area is released.

To make this happen we need more than two subsequent exits
without forks in between on the current cpu, which makes it
very unlikely to happen. As a result, I saw a significant number
of dying cgroups (in theory, up to 2 * number_of_cpu +
number_of_tasks), which can't be released even by significant
memory pressure.

As a cgroup structure can take a significant amount of memory
(first of all, per-cpu data like memcg statistics), it leads
to a noticeable waste of memory.

To address the issue, let's charge thread stacks on assigning
them to tasks, and uncharge on releasing them and putting into
the per-cpu cache. So, cached stacks will not be assigned to
any memcg and will not hold any memcg reference.

Fixes: ac496bf48d97 ("fork: Optimize task creation by caching
two thread stacks per CPU if CONFIG_VMAP_STACK=y")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/memcontrol.h | 13 ++++++++-
 kernel/fork.c              | 55 +++++++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 652f602167df..4399cc3f00e4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1268,10 +1268,11 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);
 int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 			    struct mem_cgroup *memcg);
+
+#ifdef CONFIG_MEMCG_KMEM
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void memcg_kmem_uncharge(struct page *page, int order);
 
-#ifdef CONFIG_MEMCG_KMEM
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
 
@@ -1307,6 +1308,16 @@ extern int memcg_expand_shrinker_maps(int new_id);
 extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 				   int nid, int shrinker_id);
 #else
+
+static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
+{
+	return 0;
+}
+
+static inline void memcg_kmem_uncharge(struct page *page, int order)
+{
+}
+
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 6ad26f6ef456..c0fb8d00f3cb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		return s->addr;
 	}
 
+	/*
+	 * Allocated stacks are cached and later reused by new threads,
+	 * so memcg accounting is performed manually on assigning/releasing
+	 * stacks to tasks. Drop __GFP_ACCOUNT.
+	 */
 	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
 				     VMALLOC_START, VMALLOC_END,
-				     THREADINFO_GFP,
+				     THREADINFO_GFP & ~__GFP_ACCOUNT,
 				     PAGE_KERNEL,
 				     0, node, __builtin_return_address(0));
 
@@ -249,9 +254,19 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 static inline void free_thread_stack(struct task_struct *tsk)
 {
 #ifdef CONFIG_VMAP_STACK
-	if (task_stack_vm_area(tsk)) {
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+
+	if (vm) {
 		int i;
 
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+			mod_memcg_page_state(vm->pages[i],
+					     MEMCG_KERNEL_STACK_KB,
+					     -(int)(PAGE_SIZE / 1024));
+
+			memcg_kmem_uncharge(vm->pages[i], 0);
+		}
+
 		for (i = 0; i < NR_CACHED_STACKS; i++) {
 			if (this_cpu_cmpxchg(cached_stacks[i],
 					NULL, tsk->stack_vm_area) != NULL)
@@ -352,10 +367,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 					    NR_KERNEL_STACK_KB,
 					    PAGE_SIZE / 1024 * account);
 		}
-
-		/* All stack pages belong to the same memcg. */
-		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
-				     account * (THREAD_SIZE / 1024));
 	} else {
 		/*
 		 * All stack pages are in the same zone and belong to the
@@ -371,6 +382,35 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	}
 }
 
+static int memcg_charge_kernel_stack(struct task_struct *tsk)
+{
+#ifdef CONFIG_VMAP_STACK
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+	int ret;
+
+	if (vm) {
+		int i;
+
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+			/*
+			 * If memcg_kmem_charge() fails, page->mem_cgroup
+			 * pointer is NULL, and both memcg_kmem_uncharge()
+			 * and mod_memcg_page_state() in free_thread_stack()
+			 * will ignore this page. So it's safe.
+			 */
+			ret = memcg_kmem_charge(vm->pages[i], GFP_KERNEL, 0);
+			if (ret)
+				return ret;
+
+			mod_memcg_page_state(vm->pages[i],
+					     MEMCG_KERNEL_STACK_KB,
+					     PAGE_SIZE / 1024);
+		}
+	}
+#endif
+	return 0;
+}
+
 static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(tsk->state != TASK_DEAD))
@@ -808,6 +848,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (!stack)
 		goto free_tsk;
 
+	if (memcg_charge_kernel_stack(tsk))
+		goto free_stack;
+
 	stack_vm_area = task_stack_vm_area(tsk);
 
 	err = arch_dup_task_struct(tsk, orig);
-- 
2.17.1

