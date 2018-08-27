Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CBAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFB4208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nlWIMCrw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VbQ9tW/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFB4208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeH1DOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:14:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35798 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbeH1DOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:14:31 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RNNFIo013750;
        Mon, 27 Aug 2018 16:25:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=HRcl5lAIC8MUgYOLwxKgPpXIYT3/XK1t1UNLTquISDk=;
 b=nlWIMCrwz9hnKJ9Utekw6yORWHMm3Wtcrdu7IkeML1pXVFzlV12VNtpz9usjI0g9T+er
 /+4y5XQXdgwWbiKd31g/sNIrwpTG8VxfDlZkLCDbNpKswmUgyRXycW8MSb89gkRDsyBr
 a5QM8jVp8ojSzBMa8/QTRVurYjza8XaunLA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m4rysra0y-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 Aug 2018 16:25:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 27 Aug 2018 16:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRcl5lAIC8MUgYOLwxKgPpXIYT3/XK1t1UNLTquISDk=;
 b=VbQ9tW/NA8tcv9f8Mw71+YSID6TYN15WK89FDaJdfIfJKFcvQW8fiGVpA1Ici0FgUP/HxVRZ+aSEKSSp7A4qkZj8WVBwabAU5L/ikmfxEgUGweWizleb0Q35yCZXRZ3X+/tgLml3H/vKbtVyEVST7hb2tcEXfT0VHUwRNfdjo3o=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::6:20cf) by
 BLUPR15MB0161.namprd15.prod.outlook.com (2a01:111:e400:5248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Mon, 27 Aug
 2018 23:25:04 +0000
Date:   Mon, 27 Aug 2018 16:24:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/3] mm: don't miss the last page because of round-off
 error
Message-ID: <20180827232456.GA20631@tower.DHCP.thefacebook.com>
References: <20180827162621.30187-1-guro@fb.com>
 <20180827162621.30187-3-guro@fb.com>
 <20180827140432.b3c792f60235a13739038808@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180827140432.b3c792f60235a13739038808@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::6:20cf]
X-ClientProxiedBy: MWHPR1201CA0009.namprd12.prod.outlook.com
 (2603:10b6:301:4a::19) To BLUPR15MB0161.namprd15.prod.outlook.com
 (2a01:111:e400:5248::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c0ec66c-8f98-4acf-5869-08d60c745249
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0161;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;3:MRBaNLbTpvuETb3h9DlTK94gQRWqx1PuPhqh5N+2welJqdhNLSq2uMTLuOFuLGhDHQWwVfwLA35t+H/g+HhyyFfbxqsTvHAn0wTn90kp7+3GQdtj/ZH1o/PnD3DJKQm18D0G3ojzC1s5uvxqJmvNw/K13+YtAThIMUmWj23PVRG2ZtgK/lnBrB7MzyajdniSWo9YWWnYy2MN5d7GTq8UDv8PRlCG2/tV9uduqC20kcpqY7I/dpp91tS15iPJzOrm;25:iG8GpEvRI22jHPuCSGRwDWPfocaNN83orZIEQ6EJO5yOcfxb9Zqod1j0Epyyoj+oF/i3RCxts4CB5R6LOp37WO8OjaLe+v/pQuKTw90W3apjXL43WAcGkyzIGPsKrlIf0ca2izNoFcR5eWF3XeqEV0nSXIISltBLBa1BbCwe44BnMUG4Psi9wiklV2J2YpkXEkH1ald+eBxSslNXA3WQBqExUFACjbANLrVIoHPPwMdfuuBSyIETbLwmdDIvPlhqxHs4+5kKpkL4/gxilL+NJR4Y2h1sLQPkM+tl2GJYXsfju6J0B8j6xgUllKFi9NJenfit/31PTKNwC8yO1aIWBL9rxkilIn7yOLjqjGIld2g=;31:XyqsB5IUwI2NQNrXkVgsQRZt2mD8Ge87B/UxeH6Buxg4WiDrS2KlOKlr171cPjWSoVtvA7Qnxcy9TuZT6gDdpBRpwsdsI0Mu+vjI14QmTDpaX4Zb+8YPFbJ8wIMAakqXH6Zu5aK2UyFZm6SEBpr+UkZ/p6ldG495Kc1YG/k2gN62ZEGzsEZR10hgKRl8Q0byRvwcUrzvSZkgKKVBbrxWEy6mP934Lzbk3fMFeCvT66o=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0161:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:wrPyfev9O83avUV8aQNa0sYtbs5q+in5HCxbstRTy/HEfY0c7JyHy+g4uq2NhHZ4GuXwQXFzQYQnOTbbfrAfuxExcMdxcHfxR7lPOPrpjDtP5H7wgEKNgZlShLdRPeyr0T99y5l/M0Q0aLE9i7I0tbkfGHQ9Rm8HR5bNBCsxbOEKG/hynHKSSGhi7WH/ZKP8ja/zxoUWP33+FZNddH/TfYZ1QBZe9EPGlmSil8YC22aLCCvfFt1+gJvQ21f3aY7brDqBPaD5zU5iMLNYAEBgv9ZeLo/98NwYnY9ABJy+XPFVcIXoCBEUp2tabdhfpEAgjWsT3vcq7fXB6ivTS82vZXE4EP2JEyGEa5BmX9Zeok8Tah6ayDPG1TiQbgFFtC6eScjgROFjtYrp/TnZH04uuNGELFuv9kpiN/859ctKoCbHHBmczNziSuP9IQa7Vn9jp6CP6lBb7bes6aIhxSd0P2W+MatQWQvNKQmIr4JX9dWPE0Eznw6kmUSMx3LIqKz8;4:KOVbfNcES3OSnS5mIO2iqtSUbzK1aYWPtBqwK1Btkwi2tYfehMxoaeUnBj0uthqhDPgyQQ8XVSiNKZTaOkU5pzHV/bYROLVNvRs5mT9KtQZ7Jc87BLXnzHSOBy9rLKJvLvLDFniZ99bcj/Q06orqA7Fo1hwhYjtCo9kaMp8/iFenSXsesG/zeTRBP66YpeY4vV2VGPOaC4dszakctisq+2KMOa2GJVB8mlVbO474Eb1Yjz802/UfMO9UmTgCayy+Ygr1uA3vBaH6FV2U3ybe1L9X0idfwXUOMLjuN8Rgx02Fzl1HOzepeIanI6UbuBVu
X-Microsoft-Antispam-PRVS: <BLUPR15MB016146C4FF26890F1BBF0709BE0B0@BLUPR15MB0161.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:BLUPR15MB0161;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0161;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(55016002)(305945005)(6916009)(14444005)(486006)(105586002)(106356001)(5660300001)(7416002)(6666003)(7736002)(478600001)(97736004)(476003)(446003)(9686003)(11346002)(47776003)(229853002)(46003)(7696005)(76176011)(58126008)(52116002)(316002)(52396003)(54906003)(6506007)(386003)(16586007)(68736007)(8676002)(6116002)(39060400002)(81166006)(81156014)(50466002)(6246003)(25786009)(23726003)(86362001)(4326008)(1076002)(186003)(16526019)(2906002)(8936002)(33656002)(53936002)(18370500001)(32033001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0161;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0161;23:Rfhj4n88I1B9Zs77xAvk0SZK3c1vlZhA3c5fBlZHO?=
 =?us-ascii?Q?51OEcy+l59L68Lq40pcb+a3FRsFksXTuqHQrPk1lHjMBHjP3TLhVhEfaNt9m?=
 =?us-ascii?Q?bVcjESYpXoKhvE6qoBg3MJf5KO9B32hCU9MYcVkIjR64lbwi0MI7q/I/qKS7?=
 =?us-ascii?Q?GP7aDAbrKmcTXevRgyO4lGiJYK5kJKlHiLyts9837++pl45t2pGJG6+sErrg?=
 =?us-ascii?Q?nuyaDqeZvmFOeTj7rgYKqxsl0N0quruMH8F7r83FTS166501ZSafOp3cLEPb?=
 =?us-ascii?Q?Vmfkmw34Ab4JIPkIiPxTLs79KjYxkSkz0BDrYKUtVH3/YC5NvyKo3s4wpDzF?=
 =?us-ascii?Q?XpSSkR2FSIJ/hVn0Oj2t4y/Flba3mGmsNP5DmwON667pIeKBQ7E9chRQUO6m?=
 =?us-ascii?Q?ph3HlA1PczD2foDHBmyur1r6Repy0Ur41y+oE85FXX1hd8gPXiqZbBqotV7U?=
 =?us-ascii?Q?+1s1kZBNuSfiSVNWf5KNHYXN5DWyxZYd9ipa5OV2fCCU1Ng71rddHw2V29sU?=
 =?us-ascii?Q?Balt2RJoO0EE/igaeP6QK+KCI/WrgwiTkeOuKjr8QxYNAshameAhHb/PWgly?=
 =?us-ascii?Q?eco/zebYHgj08Zu3m3LfWjGx9DqOLXb33nugnfavbDJ7rXOgKK/zYZ7y+4qy?=
 =?us-ascii?Q?Km5j9wyLJF0Dk/COEL387U3wIdsIurUZ5JyWPMskZf8w3bg4Uq77xCaXHBGO?=
 =?us-ascii?Q?8rTKb/NtAELAEFXYTPTn8N+FL7GuHmPrlTivgbX7mQTFG2OHX2Dk91hKZWPI?=
 =?us-ascii?Q?1e5vzn5UfDQxHp7DvhLUiUmydGWlzGdeR3nCdxVpGXneC9KjxLPQBt7D5xpp?=
 =?us-ascii?Q?/hPhc3QEYHl/Dhz+9oUSoFtLcnjZSX0IIU1tfR1J39Z29/yZ1eubX8aluTE3?=
 =?us-ascii?Q?iD7c/dJFAWADdVZ64HKytA4lshzMIm21yQ7Po1FCjaPsUoCYMptAIKo+DVTU?=
 =?us-ascii?Q?eGKjurgnaxt4hNCpeOhY9zwFHCZgZHQ2aMhDm+M+6UR8N9MchagJwbqpURRP?=
 =?us-ascii?Q?TgN1KEUe6OzisaZywxNHQAXpL/bDjVPGFFQrBxSwdEpJuj+S5NSRymvkv1rY?=
 =?us-ascii?Q?DJpqxXysUJGYYWkrYKexkVpr8MV38AhNXObLGmncpGNzDjfa4GHO6S6D37Lg?=
 =?us-ascii?Q?tdKRNysRj3preC3PpmSGTkyvu0JQAmQ52XMnbPFZupWf8c7zcZoRmN2B/yLm?=
 =?us-ascii?Q?Eu85Mq4PYzdhxHQjjuniDEcB1mlV1T9cgOHmkeE4a2NQ7PYe1JHtynv3YlS+?=
 =?us-ascii?Q?DwjgXv0ohdAj9OC0MHRwzQ+maYacs4W8q6yzX8LjSBpm7YEmP/C8HLzdAswR?=
 =?us-ascii?Q?NKOq28+lVXZS8OgFmKE8Dk8SL3RjgEpZXuputAHUye5?=
X-Microsoft-Antispam-Message-Info: cteHZW6H8NQ1etBRSxcJ4tfFAK0vWgTWMitO5U9segNTbCJ59Lp2uGBF0OPtsPVaPRbgBtOpR0U12YYUAn5SN7InTle5bYdOt8ngqRyR5xXLuzbkkk32m6qlRHCZpcFjA1LxDWCC2E5riYFqpFOfa7hZtZ3jKMgbs8H2Vl8FtTnSLchG7iVungrHcZpKXBzf+u3+tK/eOv+5N3ll0BLmTC2khr5YgUkZHU9O3A9u89xCuAzdqcsrKz8wc+mXa2oT1mFKNVpLlBF1XEGG54Ki6Zbqo1Pf6utnSETFJWdKHDVQyXopjH/zQwwQglW/5Wmwm6GYghuKDsLZ9kJGKJ1LOn3ZztadXjukfYWlVJf1zYU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;6:jvEDkS+hOdKlj+kGaY6D4mI77MrYc/naX0tb8Eq7cgTpemZTQ2nYevAHWdMrmd59RYeOf0nDwAg44TEX1MZGE2SbDvP8vSf/KUifE2W9xsxj+CEK9Ktxmw9sILYSc8fgHX2lW/aPO4uBOVfoeXb8cSs0enCD8otKkGP2jZh7irjo0WXJLFSaJpwWqrJB+raImc4KTvinGBewAf5AimxmM4Ma0z035DvS4+OoE7Y1bgDSy0Wld0Kxnzb02YtcNASNGlS79mPjYLe8Vauh7pUVfWkwxV8d8KfD+OgHAgGOVTUt4Y3SfsEnxQRXNHKlR42mcdCxli6EJkFGVAKvXSUrwUo25gnZbKYapR3w61D4XxvsfDU9M17uLhRLDvTmzNsPVPHvphbftSO7Lrx+FIpVjN4/IDGF+YtePL8UXyvFaaPCir2hVS7Mq6IUk+B+uRnAYEKnmyq/TRY8BkBqTL3buw==;5:Zsc0OzcGxJZ1bDeOVNGt2FG+x7hjljjP2uwLIJxzROy+cYLhWS20GuMdPrEU01jQK6U79dUXkOjuCgZoeWYSv5ZHdngYFLjJJvbQul3aAhoQPeMFfbtio7vj/PtjVzKds3prweqKj5Vzm3I/hq6ifsD7FlMXHu/IYJ0Ht0whl6g=;7:ubKJztPdAKGVlfN3R6riul+FDoXBzk9HSEJk1PpWBE4klxyM1gkyzw62DHKZipOVidAULt9r2/ermfVjdpDWGwHppfCsBoE5o35W+CKdcLflWUl/+9bjb00fpe8yhqHbth/rfHRevmZJ/FcyMNHXPmRe4YPEyoR/eetz2fNhMULz7F3PkEYWLv1C8yZ3f+2Q3nRjOsFP0+g+xDSeHaq4qh38hcx8gzU1HUkwn01qEM1COwDdDxnD8OHnAUb1R5rF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:t/DmKfdf3K7zmmHB2gvSUv8W9KVi1jJvuXCD830/eIyucCuipVxpsNShfBGv1DV/7jR2By/bjxmqi3eyGC6B/z4YelY9adVXVR4dyRhG9lEkEc5/9FjxXRjWhpppQzFiQmw77hDqKpoxe3Nopvag2rCl2RUEJkv3cteEQhuTGAM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 23:25:04.2656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0ec66c-8f98-4acf-5869-08d60c745249
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0161
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:04:32PM -0700, Andrew Morton wrote:
> On Mon, 27 Aug 2018 09:26:21 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > I've noticed, that dying memory cgroups are  often pinned
> > in memory by a single pagecache page. Even under moderate
> > memory pressure they sometimes stayed in such state
> > for a long time. That looked strange.
> > 
> > My investigation showed that the problem is caused by
> > applying the LRU pressure balancing math:
> > 
> >   scan = div64_u64(scan * fraction[lru], denominator),
> > 
> > where
> > 
> >   denominator = fraction[anon] + fraction[file] + 1.
> > 
> > Because fraction[lru] is always less than denominator,
> > if the initial scan size is 1, the result is always 0.
> > 
> > This means the last page is not scanned and has
> > no chances to be reclaimed.
> > 
> > Fix this by rounding up the result of the division.
> > 
> > In practice this change significantly improves the speed
> > of dying cgroups reclaim.
> > 
> > ...
> >
> > --- a/include/linux/math64.h
> > +++ b/include/linux/math64.h
> > @@ -281,4 +281,6 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
> >  }
> >  #endif /* mul_u64_u32_div */
> >  
> > +#define DIV64_U64_ROUND_UP(ll, d)	div64_u64((ll) + (d) - 1, (d))
> 
> This macro references arg `d' more than once.  That can cause problems
> if the passed expression has side-effects and is poor practice.  Can
> we please redo this with a temporary?

Sure. This was copy-pasted to match the existing DIV_ROUND_UP
(probably, not the best idea).

So let me fix them both in a separate patch.

Thanks!
