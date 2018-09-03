Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C35C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822432086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DmJG+m9F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="foheQTHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822432086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIDAui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:50:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727510AbeIDAui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:50:38 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w83KSKp6029550;
        Mon, 3 Sep 2018 13:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=6dygtqcvd00lGS8uy3jtIVfxCe8tLNC1ILwcYL1QZS0=;
 b=DmJG+m9FF6iblSb/ji3URqVoXOlmEUIEiGMYB3J9N3EnRPwF1fGpotVlm7Im2rbg3x2A
 FdNnOovl2zB7AA/Y5ueuqZ2oCc3GY978zLPghIZpoTKvw3IMNo1/Jm2zBie7cJkB41eB
 INXdvEGolt3cfBYQp/2hfNe4emtLYIqYJss= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m9b5kg35m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Sep 2018 13:28:38 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 3 Sep 2018 16:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dygtqcvd00lGS8uy3jtIVfxCe8tLNC1ILwcYL1QZS0=;
 b=foheQTHcc8fBDB3rKtD81Lo+yixHCBKFFJhUDg6QTnUCmurE3tArBiziSfnm0mrB6vgLhWkWXgpDzHP9vgyzJ5dWs5M5XLg1XDvrhqYifTctwdjb4zB7UUUgrMeCe3XEJ7jkM2m80k33Lao/tlmQYAPwK0xo2x0YgRpWiSh52rY=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:180::1:3759) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.18; Mon, 3 Sep
 2018 20:28:12 +0000
Date:   Mon, 3 Sep 2018 13:28:06 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Rik van Riel <riel@surriel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
Message-ID: <20180903202803.GA6227@castle.DHCP.thefacebook.com>
References: <20180831203450.2536-1-guro@fb.com>
 <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
 <20180831213138.GA9159@tower.DHCP.thefacebook.com>
 <20180903182956.GE15074@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180903182956.GE15074@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:180::1:3759]
X-ClientProxiedBy: MWHPR10CA0057.namprd10.prod.outlook.com
 (2603:10b6:300:2c::19) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c0b0a0-fa7b-426d-b625-08d611dbc596
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:++673PcgOTxi4rz7+nqemNpB8EnpPFJxGqcAWFYkN6+GuKiHSRmLPRnVJr7t3MPNfw93Bv5MMcfGBawyj22F7rKnchomoxiMTkj8MFPzClityDOzfpb/qQtGO4dNiNHQCSduZzwT6mSPZtCLS5am3aeos4HZUB7wHO51e8B6h/feTjRfVJb6k4ppJbu2HxX9iAlxX/YV2eVPvGtVqZFkJFH/J5ERFPtsGWGFRTf0PTafHNhmQDWxGxpiEaieJT31;25:x0p0r63gvEaWck1J/5c25cvdXfqTy8ScEPoJFwbcDlohtPN1twZ3wgY2SMuIkirjKG/oMAKyJC87nUmuOsyesYSSrlxZ97uaZZNVGDClwqB6NkOTgSEJONVlCOxTkBvAHUv3Aj7CEFdAZOXQ23+z1xvAN/FKF21gAds1lqfCjr80qwhks/8kesE1suvZ90uRnU8H8roypW5m123CjjcqWah2y5DB6SYxRGouBTX7dcScCKh+RfhhCQ8H/UMsWOELGlrloVLk6kbcBruOzZper1fe0CRrS2lmArLWSXLwQzJiZZhPQd5AGa++fcTxy0/3vrq1fi03/YwQpwCd3A+m9g==;31:6r9iiWuHrXKSbdH0fEbP6VOx2UGMHCdsugdTRw3J+URUUWJtVw2IfCWh6uZe5pMOUtKG/VLuFxawghN9Bx4AnExTiOK6cjAXILzq8CWO3hviaQSJTYiCIgE/kXTB/UIgip6jv11EBAMajNmq7dUerszSVIOFY8eRAa11Z5OlQXHPs8MYI2nJCoTWV/z9LS0nHfa8zQEEJKUbqAim/uk6PpHZlkwMFB8wVzCD6L3r/Lw=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:QfcnYt0TCucx3eD8cDbmPRYjdoXUr83mmrlDHLF60CAcDXmc7PI/i3Xety5fla8NpS4Gk+WygwHCtt2lJQWvtkYpJ1haV9eYKiH0GcMMLxHpY53lq4+T2rGoD97I+7GvTx2LpEPD/qhbJDN0+YgFm24fwP1UIKayoWrk9aBQ3el2/scuR9n+8Dvi/DZxWcMf+CFlK+gWQHL6OQiDuUcBORnf7NtjAlli2b455kf3Wo4/S69gNwdLikHUWB79NjVTYdULda+3dFeQsq7cFIYZ90BMt0T+ml+QGYbKVhvTBd925eZ5JvJL6YI5leieIcbS6dvWoBZ8eChYFP9cmw/OZO8YOMBGuz7uoHc90TBGmbTzVecyhceX2PAkMW/wxc9XColgesO8dnoK9FrKg2wvhaSBM/ZdbV0S7ybE7tA9HwNYUjQ5dODWfC+xBLus0tSHNfStMdJ3nwbAO24jTeBImyCtxTnCsz83WADeoYD2Eb89Ftp5y2FNdJ/TfFvwO+MX;4:Lct31SU8LwCefJUq95izhypkazUrtMs8tuRDJ44Pq3oGEQD1wLkp4f7TDbtJ1i3g/zekzuua1YMp+heVfDRhOHFXJ7ij6JmwdY7vxrM5Axpo69j5i8oCqD04846kvfxvoge1f6zanOfPWBOEe7+LEBjk79NoupM98dMAsvm8wrODKn0lwnO89Zm0H7jeMRDU+pJq781idO5BvYUwKSSwRzRuA8KfM/tswYm51UJqxrvzoagc4rmwM8u+1NYSTb2w8rUEEGVmw/gM0wzLIPHYDA==
X-Microsoft-Antispam-PRVS: <CY1PR15MB01719E130EE3D9007A539F11BE0C0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 0784C803FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(54906003)(6916009)(6666003)(86362001)(5660300001)(47776003)(76176011)(7696005)(52396003)(52116002)(16586007)(478600001)(58126008)(316002)(50466002)(25786009)(97736004)(4326008)(6246003)(6116002)(23726003)(1076002)(16526019)(186003)(46003)(486006)(446003)(6506007)(11346002)(476003)(386003)(2906002)(106356001)(105586002)(93886005)(55016002)(8936002)(229853002)(8676002)(9686003)(33656002)(68736007)(305945005)(14444005)(81166006)(81156014)(7736002)(53936002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:dJmXcZU+MmkcIW8/uFkFNijcE4lLvhC7/yTxcl++P?=
 =?us-ascii?Q?4LfYzGk5n3l7eYN12enOrXLJl0TIE+6Df40A/G6iSBcj8wT/DI+ldQDphpzh?=
 =?us-ascii?Q?Z7AJDNStv2Mb/+jEumkUPi2eXMVcYxpIM6a1zOkkAMrDYhxxvt3AIbNnuYyY?=
 =?us-ascii?Q?Iqy0HRmaSrei6NudeqkcwO+1ZnJEy23FdbpwXH9V/QHWG9jvwbPwFNrmy6Vv?=
 =?us-ascii?Q?XzAsDLZxnOTY7erU3tDW7Xr2lFLsJIMGfsqOukD0gOFUYvJbTSF+9gyVvND4?=
 =?us-ascii?Q?baB0/CON05mWgXqy+rMNh5Bw9757URQsQ9GG9KhP5jBPTE24YqNUVXVaLR9T?=
 =?us-ascii?Q?XhlV17p1KWdK8Xy5MUVhtDuEruPGUqHqdzgBImwLWLsO+X+VfT3Jm7FfDfd4?=
 =?us-ascii?Q?26IGUbbiVbiEhJ2WnggldKREFZeZHLBw0z71oC3ubLxR8cxblN5M6ONmsefl?=
 =?us-ascii?Q?oviSt8sZIODCDm61BLFa+CBQV5Cc5rOfgz/5bex2wDEhRAp9jdY/ZO5nZP4B?=
 =?us-ascii?Q?bxx+sUEDxR4NZaymJwAFkPbFBQSqe/oLGYbl4ZCkN719LmfMiFuCBy5m8qZU?=
 =?us-ascii?Q?WFn+jvxRBqjdNl8RhQs+lXg6CLirm/xvfUGe2xq4fmUKUZTCh75O23iXmeZQ?=
 =?us-ascii?Q?EUCm+2q6trkgpTsfmGizwqrbjAM3tvbaVX/2SBB+RU7dUdMeYY1ZHZS63oT5?=
 =?us-ascii?Q?bxVh9hxyQUZbKYuxMtdObp7pPw1Dc4ORm920gpbpLDiJmUTnmutIFgSePBri?=
 =?us-ascii?Q?kNTfVzGeZbjWR1XV1VwlOsLSnwoyL2lleLnM0gQXt1EX5xr6vjrGqrt76Wpa?=
 =?us-ascii?Q?9a2i9hTgm1gSsaGxjc2dD4gogxJTUcPakyO2WPN0oHGivzMNq9JVVPJ9EP/q?=
 =?us-ascii?Q?xQ37xyS9CV4SwoHKrII/CZnUi8M1WgxWmk4J4dC8NYaHopO2GFXkvZDUi1u8?=
 =?us-ascii?Q?AXMCNoXRAsSTHzLo6fwxvPlpS+uqxTKRGE2/XiXN54s7pMsZRcrOmVA5OoOq?=
 =?us-ascii?Q?6vOgqweKduF/Dj9whqXAR0/SS0XZI0yMqKp0zkM9/4yqHT+sSV/6JXst48z5?=
 =?us-ascii?Q?hpDfpYW9z285LcO/TLGCt9QIL32TNxFSSBx1vvt+0AM5Dsa1GpZDTz08Jiqx?=
 =?us-ascii?Q?e+BTopg1jWObSx7Znt8fAHkltE1jeQFOZw402oKTSIWO90j8K58DSll187wR?=
 =?us-ascii?Q?iI8IRyEFlElFqwU0eu2VFDxBO+CbuXgB33J2OTc4F5ROZ+K3sGggLRO6PZXI?=
 =?us-ascii?Q?upr5X6so1ZR3P8+YAxAH2RLowiKnHdx1VylZj+/F2r5FAOMYL/2sTcBlBjB8?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: r7VkgU/Nkt0qSyu8EX3NfJ0etKgSc5Hgmgr+NX1tzoKljXzXbu74a8O8ylO8NwQoK9gvq/eSA+ISPLUMEXoC8hQPgA2Jl+xYKFm/Vv80ddcpHGwn/4cm4JAxCxiWdw6rJRo3vrhe1Vcq6xjk0p+aYU2YX/n6zFvesBurxTZDornQXQ4RYfH4MztRgCVPMwGDplvRvF9+uh0fr/ThBoEMNgmIr71zVSIg8DJnlt+OTcC7gqQOFEa/v6OmGSJMp6ayD4CCSTgQtHgbg2S9wcKZnePRCegor9IFh0gYfomHvEIa/qSatuMkkF4pex+KU/uk6cWqbcjUhoEaqXi/yzpR4UDL/NNjCm0TScYvkuyMyz0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:0Uv52re4Ywsb25IjYwaS+dZZm+qVwuC8nxIDol6Ur//O5+lH+KxnlXEBA5DK+wJ/yOV+DGJ6ep8OEPSQzczWyjf8xP/S1AyqbHLcX7CAjvHy66KlOEMwA0CEHJjjGueLI5kh4fQHKPQO8SG9yyWf4FsYmjAW5pI6vobvLdCxn8k2mv7eCworjn9JOPkxKP8enS/M3OGeGrZ7KUD7ZUpjIFw9wNf3kGNYUsM3IUKrK2nLTXha02HjgYVFMllYt+sOZwfE1R7MEi1r9iU49+O79XOARGd8JKyzaspfoEYw755BZHxK2sywCOZV8Pkziuzs9qKhKVoRDhHYOkETRrsgsOOuQCuyprP1CMItiDNc5T/bpajgSLqgXtdmnZwjr/nvSfEbtRs0nmkzmqq+ij48Oz5ACCigBwnTklG53pwJmW4sWupYso2EdxnZOU+njt1M0XKD4koNriP3v9u0h/VQbQ==;5:gvFYbeavccBAuBZrv8VPjO0N7UpExYh88ev/lu6srMXsV3qMBbjRyHjRlwbq8Ti1AcUyJ45dt5VM/RL9vVfKb8kTDNon3rYe0loZQmzq70sKyVZgqbXKl011r3YH9OTPhHuZR101G8sNNlLfHVkTt5tHjerP8kTsL5wE5SEpReM=;7:TNhVnjLnLYmCaGD0HZQmYlPjWVu0Mi/TZ/e5mCKtvlaDGZqvcsqSj7UHRcYA2fUi7USNMxM4oI1Y16233+ZQqQC+Yg/3c4EsdsG4/OewzNFItF0V6TvnaI5ud/MHobVntVSA4Eq8XfWd9kYRnEGyPhYZO9uD/G1etfXh484lRS0y8ASHjdpQxKGHokTMwAF/yEM2CSy45IJnn4TIN4kwVZAgunhVZL1fTmDspnkzKsa6bFeREFJzVw73IYS6Lfef
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:eM6c3MvgpB8F8ACgVdDUXvj4/B0UeR8uQG3u8kauCekHesIZKuX5pIx1ytWg9E5OEVrIKw+fxVeFMPuKSS255tC+XCFdGk32V/Yw0sVfksVFVK8LRKU6AWUEZrtaR9cNjNiT5q6k3cvNxk0wL67Acf99Q0vZRuN9QbHDOdh/61A=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 20:28:12.2556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c0b0a0-fa7b-426d-b625-08d611dbc596
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-03_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 08:29:56PM +0200, Michal Hocko wrote:
> On Fri 31-08-18 14:31:41, Roman Gushchin wrote:
> > On Fri, Aug 31, 2018 at 05:15:39PM -0400, Rik van Riel wrote:
> > > On Fri, 2018-08-31 at 13:34 -0700, Roman Gushchin wrote:
> > > 
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index fa2c150ab7b9..c910cf6bf606 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -476,6 +476,10 @@ static unsigned long do_shrink_slab(struct
> > > > shrink_control *shrinkctl,
> > > >  	delta = freeable >> priority;
> > > >  	delta *= 4;
> > > >  	do_div(delta, shrinker->seeks);
> > > > +
> > > > +	if (delta == 0 && freeable > 0)
> > > > +		delta = min(freeable, batch_size);
> > > > +
> > > >  	total_scan += delta;
> > > >  	if (total_scan < 0) {
> > > >  		pr_err("shrink_slab: %pF negative objects to delete
> > > > nr=%ld\n",
> > > 
> > > I agree that we need to shrink slabs with fewer than
> > > 4096 objects, but do we want to put more pressure on
> > > a slab the moment it drops below 4096 than we applied
> > > when it had just over 4096 objects on it?
> > > 
> > > With this patch, a slab with 5000 objects on it will
> > > get 1 item scanned, while a slab with 4000 objects on
> > > it will see shrinker->batch or SHRINK_BATCH objects
> > > scanned every time.
> > > 
> > > I don't know if this would cause any issues, just
> > > something to ponder.
> > 
> > Hm, fair enough. So, basically we can always do
> > 
> >     delta = max(delta, min(freeable, batch_size));
> > 
> > Does it look better?
> 
> Why don't you use the same heuristic we use for the normal LRU raclaim?

Because we do reparent kmem lru lists on offlining.
Take a look at memcg_offline_kmem().

Thanks!
