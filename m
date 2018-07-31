Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C5F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pMLf9cj0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hMbBLqUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C5F208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbeHABet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:34:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35222 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732819AbeHABet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:34:49 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6VNguko017482;
        Tue, 31 Jul 2018 16:51:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=1AbK3YyLoJmAy3LgKlyDFAlGSkQJKWZ3lECXQDEgqUY=;
 b=pMLf9cj0vIP8IhGVyaH18/AtIkk/GdD6WHhmIfpJSpB0mu2Wjey3H6/ZY3zW2XVHDOwQ
 xyJDM4DYkF8jZU4QfkQx3Zx9qE00CZKChpMv+KKyoJ0nY0dO4okjkmar1mQX7eJaJv6a
 iUCMxbWU0cmFenCC0Oi7DAMM/E3sC4cmH5E= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kjxvb0fb3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Jul 2018 16:51:53 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 31 Jul 2018 16:51:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AbK3YyLoJmAy3LgKlyDFAlGSkQJKWZ3lECXQDEgqUY=;
 b=hMbBLqUV/30SkhlXKznijwmCDWRTq4HbGe51lK48nDyNnsYsS7rCKzWqfkI8whPxfRGT80ocQbN1xnuodMcrKsZrvqJ1j4+5q7JHWiiSHzZJe8eGlBDObmKPu7bk8+avL0GNvEg7O3o5QKXDRcL1AXSdf2syzdhHXK+9X8gOEKU=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::6:ec7a) by
 BLUPR15MB0164.namprd15.prod.outlook.com (2a01:111:e400:5249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Tue, 31 Jul
 2018 23:51:45 +0000
Date:   Tue, 31 Jul 2018 16:51:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     David Rientjes <rientjes@google.com>
CC:     <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] introduce memory.oom.group
Message-ID: <20180731235135.GA23436@castle.DHCP.thefacebook.com>
References: <20180730180100.25079-1-guro@fb.com>
 <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:ec7a]
X-ClientProxiedBy: MWHPR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:301:1::11) To BLUPR15MB0164.namprd15.prod.outlook.com
 (2a01:111:e400:5249::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d88bab-ab67-405f-fe14-08d5f740938f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;3:YIteWHaERzPEa5i/rmSEFvpmGWqf9CZi1ukFQSXoACOdtUU4qVq4MQVWbcwgTyDcq9MWSpbsnoMuoRJtDtc7OJDNaZPaOSg2Eln9DdHHbEzJziUJNnqybbg91G1mWGsD32t7Owq/88EYIi3NkF+TRz3h39UDC24vEF2IsL3AgUFsQzf1x7H/XGRDKC7mr6z8fGkMJAiodpu1JQtoETSx8EQlzha7v7dTYo5I/LmUhlutvp4zqj1+TPfwK2zVYPDX;25:4n4wP/NNTiYtGMpR9AtY/BWkY678z43EYiBZltralvluwX414tmNqjKZSoO65xEUcRyjuWX8DHtU0344dISi2DuZb72AF4MuIRnG+snUN2XHYiFAPyffJaZr9wj5IEb0nTNtsVUg8NMLro+jSjp/BzZCtoEPLwEzou1eD5kOt8IrxpP0h4LBRL8tXwszb1y3jYWEe75Gkv8UQgGaOPymM3ay8ifTib0VGQKvjT1D96zZHqtZhEt4Deis0+Bdl69rn2HMqexZa9DzDEwPbzFfaHkpSDPOFM/+0XNGmzgs+5OZvjpG8MCmIn/ZcFAE+env5m1U9i3iXVfOk6q+Y7cqrI6JmHLIRazIbmxrK/h0zx8=;31:OLPZhzEjWMNdNm5xLhPAcmJQ1WZr0oPL5ccBUufFtMFmst49zBPjUCI/d5uowdgFxBYpIaMvS29WNf5vFUvVeb9oTYC4x75K/ZV3PMA+gBEfJDUYDsmsKJkgUmmwyxsAoszIHvlF0gkG9e8Y6e2pJEP4x5i1LdGnZ0FpTMPIkiLGBJHnSwRrAHKu8ssnoqT3hb4W2zSsdypeZDjVrRsXrTRh8ZB9zX4H+BG6NcxFYyU=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0164:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:M8cfmqWmqJXrwJREjOCxk0GKwJfTc+gg2xPca0yt+klIVDdrXibo+NDHvHh8HWnZ0u3mmwnvF7o2sFB9sL2ecbh6lNNAtPcpG5SqLXfjbGLpCCRBvJJOAl5hBKypw+iL6zRKa8wWHsCRuKG5fN/jX3VsyRT55Nu1aBHQ6sbuQIIrd366zecj5BQMyG12bIOiH59cF6PwNEkVZtDPJwrvdyWVG5Fw/giSQM5CClyFPj/ss/R23Mq+AJhMrR2hByPxeIGdwJTgTDsvaRtqEhZD9qdXvgWzjhnou0bUyXZHYPSlS0Mm/mM4FRnR4fP71jEz3xj1y0yrv6DysXGpxBfnmm0cTIVO56salwZn1JCksv/6qd5x3qs22AsSOZ8hKVllIWsafUPed6Sbp/qqZUcEZRYRrazoJzYSXA3rmqmBFcdZz9K+SN/HC9DpkjTeB1oSt2AMmq8Yo6+hu2Bo0OHU5jrPjOjuyrowjsQcZX9eIwx/sqV9wIPFlvtf5kgj5au2;4:o20L+coTy+8OsKOiu64seLYApF34gRdrCv8iQl2JJmJ3Om1EsIKMfH1fQl8myTsHUgDtoIVPRpWRkftyVlE0vyiGLmMM9o3LrTCjt3Sz63zNlNUdcoANxeMEkVFf18AGtVBvR0Kx7/OpmmBpYCisow8QtU6PhCJTTy4cXabJ8OUHV7OgNnsYYreYHUtk/X22Ofsha+t9qoQoaGEG5cfty0vmuhIJWmaTcgVC+xxwYZItIH2rzrygPRNM7vvn9mHFSc7g3TMC2NtvOQBHBnHjeyTA4bMqAII1kak9fbyaRowHKHTIlI5yZHSj2E1g7eP6
X-Microsoft-Antispam-PRVS: <BLUPR15MB01646784A7A36922848E4A39BE2E0@BLUPR15MB0164.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0164;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0164;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39850400004)(189003)(199004)(52314003)(53936002)(58126008)(105586002)(106356001)(16586007)(316002)(2906002)(97736004)(33656002)(52396003)(229853002)(86362001)(68736007)(478600001)(50466002)(54906003)(76176011)(6506007)(6246003)(966005)(25786009)(55016002)(6916009)(9686003)(5660300001)(4326008)(47776003)(446003)(46003)(7736002)(186003)(6666003)(81166006)(305945005)(16526019)(81156014)(8936002)(11346002)(7696005)(386003)(8676002)(6116002)(23726003)(52116002)(1076002)(486006)(476003)(6306002)(18370500001)(42262002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0164;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0164;23:tzxGem18iIeBUyJxPzVohmXK35GmE9vKWwjCi/fAL?=
 =?us-ascii?Q?/7m3B2cMfxhPfKOddeq1j4wEM9hKyiLjR90POS/7yX5eLhyqk0rmlMrkE7rm?=
 =?us-ascii?Q?AK6EP6+8fVoKc3TE+vRNid7ylByqq4aluDhVW5OFUd8b2eRMisqCJslqVXOh?=
 =?us-ascii?Q?dhPwLpenlmesYDkXeEp5Gy5yYVXKIcvQ/TJtJcHOVDM3ozUFFbVwgyYkNpwV?=
 =?us-ascii?Q?X/Jgh4F5DF9ZadFSX14NyHgXaO29iiSIxohBRFy4+m1BKA76iRa744KZVfs9?=
 =?us-ascii?Q?vi4B3Uy1Tqj3hU+4FShqOlql6TV9FGX99823Aj+RKpsSNHapYIYySDui/EXd?=
 =?us-ascii?Q?q1VI0OD646OjK/weum0K+QWm3t0wZqcHhF48wReDsbVjngK9zc7VKrQ/88nT?=
 =?us-ascii?Q?2BcgWd/42jA4q+ml6V7kQGDxTdRDOUGfCLqM+sXc5lEj+U0MAkWGSzXS6fgH?=
 =?us-ascii?Q?5v5ykU0RpXmpCOnK60gJrXvFSJdo/yxq36NRTwdTPniDt3ujqVTklyD1GHBq?=
 =?us-ascii?Q?EAs+M8XqpGFpil3+Jh8A45tUikcOTtSCEMVpQ58iiKfumFRmAq3G/KWiVMXc?=
 =?us-ascii?Q?GmOGMNTsHvlIlhwb4+wVSLLPMgFceo71f+/hn2POVz+7dvOPP54mrCPVF0NX?=
 =?us-ascii?Q?F6FFioUhAXsCoNfLVxxbpaHdzCVAEtS5QxBIEZP92mNhJC4hRMeMGJqG5noJ?=
 =?us-ascii?Q?bi2Q/DSM3O1WUmeOB1TScL40sxU3kpVA0VdrXAjPODVPd658cQZW9VaGABYX?=
 =?us-ascii?Q?xFdRODXrTpdO+vrvLuZJiKZ9/SC63LJKk3dfnmr8qYEVscj7dthOAtO4MJV+?=
 =?us-ascii?Q?z0AsN53cd/LOuh+QM601eKdibJe98petImmFBnTfvPgbbPVyfEqwC43HApBE?=
 =?us-ascii?Q?yEtBeb2eJp1neUjNmsVv6nD1qo+9E+vv2oJhay2/IIY+t9kKndN4LiQBy6c3?=
 =?us-ascii?Q?K/EVFvr4Z5XWmIGdDPbaTGp5Ebfk2iEzlnO1w12xsCjX5FeI0eaqKPWySaCR?=
 =?us-ascii?Q?RUUhfZuEmMy7/NjjNfhoet2zVULVUpDbQkdJHF6PesuMWSFm93vH/KDQJ12k?=
 =?us-ascii?Q?bOHfrwKTqmTFWvcSTE7Yn9j95pSw62rKj42IuH7em2MyBBaU5uqM1Za8zcho?=
 =?us-ascii?Q?w418j5ne2I0rVRpT/KarW08r1frGtxH3Ufs1aFphMCvi7Fz1ka2ByI/nhgPf?=
 =?us-ascii?Q?e7xgE3eO/OXNWi/msQnOTNuY7s6NEun/pa43J/fusaN6gCgiN95MTKzS2ZgW?=
 =?us-ascii?Q?x7CUXKQXjvK0ThCd8lpl/xl6WooHi14go8dmW1a7+B9tt7cPU1otMPe4oi1H?=
 =?us-ascii?Q?zpNyQsIxFWhMckznBfgznkUpKGXBIiSSV501gjJA5P7?=
X-Microsoft-Antispam-Message-Info: OxTYpOi80rmPXKEiD5t7TWPSjKG58VEzOHA3qi5ErFGv92BBgqGDuB+A3Bjm1CNj0AXnGm5Ht9M9Sw2Y8z6FUsgwzdFP6WnGgOr0eA93kYYF0USGjfUdccNcZRHMbNH/jx7ha4R068JbxQg6b1UvCC1AsRLA/t2jIIWhjCS8Pi15Lg+El7AEU+84oOVOQ7H666bEzQX8SjWpk+ZOlcODesSjUSElVsJJDQ6tUscsVtGZwiKcXAs6HKRiiCsqmo5qCpzmKPuYAu2ZeY89wX/O4mhxtfdqT7gKOdLz9QAeb2vMugasGwshB8c184H3QCfjeixlA51Q2U3+WSGtwAXxywqan0t/czzHqMNnj4aUgsY=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;6:lKJDCaaFSc6YJwu3mZxmbObSN/ZXI+O0ItasQiQfRutLy0msFxYAgIXL+SZIeQ8CxUR1hUTLsvkgGY/AjbWew7E4jhpA/o3z42PdRHmxO8L1w/IIpHkd6+6g8l4H1ZaMEURSHOe9Kjr3x8YgVfbtXoRRJPmaWKBNLKXfEtQL6YXr3V5ZochHqkIcFuEx0fzecD94deQXx9teOQQjitd55MyRunZ9ydcjSZ2gNF3rw4aE57NFI6luIiflF/1YX1O3utbO1r+NkZic87yDxxTI7FSjNvDD+SL9si2PEpHCIzFEDonctpQo9itK+tYiIeL6supnV1p22UltmK9xHZP1D+BjdDO+Tdq/ukngbId0BbfKp+F44xiAsMfIxmMTUNo44wVDCR054udIAe6suX2vPm3nfP3BQpD2BXDwE4XddGakp5mfkd9g8sldUA1TGA9vSeNkkO8DQ5w49HuGC9QTEw==;5:OoeQ84hUl/ng6UiTXfanOmx0Z+k7Fz45OA1c1NwJHN118xVNowCsxWz2YblETb1d+Kh87uV1Gl8sYqFW9k1PH+WVxcO8StlsZPAVqwoMefJBTA0zhK1cRGQQvM3YE8Srgz/F1ZHBIt/WxI8aI35/Bysjd2teFc+oTf0Kdm4338o=;7:lh8W7aevNT02e8Ge2I/KSxIK+iXhqzGl0X6wqTRYTgwlNrr8jMai8tFcoSdIQiUZVajmfdxRe+7oxoDgjiXp+zZH0PuZb0xOY1NXmIY8NNRJCOTb+TLWyvQQpdex5RcOBn2KppPRZaQagF0PRYG7HBe5vkhpwE8WDoimeYz9+OWOsZ0fJ2xRE1clt9kM0Q2a9Zvw3btfD9ldBaN5Dz/mgu7yayuNdXJEmfQRQj6sS3MyTzrYOIF5GUQkgXCZwnyJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0164;20:PEXvC78HrQOYQQHewitfbMMfqMCKGpGPCBJzwWLqXvi56kKQhGOEhZFbYNNhzokZOtYQNG0dB2qananGkS1+CwIxOtV4LVvnXuo7ZNYZ+JXrwGVnm8OeCsTvZfuGr9lfY5CfNUrqMbFjuKgDdzHe+1ttmrHXzpwh1KYCP1sxzUM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 23:51:45.8079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d88bab-ab67-405f-fe14-08d5f740938f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0164
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:49:31PM -0700, David Rientjes wrote:
> On Mon, 30 Jul 2018, Roman Gushchin wrote:
> 
> > This is a tiny implementation of cgroup-aware OOM killer,
> > which adds an ability to kill a cgroup as a single unit
> > and so guarantee the integrity of the workload.
> > 
> > Although it has only a limited functionality in comparison
> > to what now resides in the mm tree (it doesn't change
> > the victim task selection algorithm, doesn't look
> > at memory stas on cgroup level, etc), it's also much
> > simpler and more straightforward. So, hopefully, we can
> > avoid having long debates here, as we had with the full
> > implementation.
> > 
> > As it doesn't prevent any futher development,
> > and implements an useful and complete feature,
> > it looks as a sane way forward.
> > 
> > This patchset is against Linus's tree to avoid conflicts
> > with the cgroup-aware OOM killer patchset in the mm tree.
> > 
> > Two first patches are already in the mm tree.
> > The first one ("mm: introduce mem_cgroup_put() helper")
> > is totally fine, and the second's commit message has to be
> > changed to reflect that it's not a part of old patchset
> > anymore.
> > 
> 
> What's the plan with the cgroup aware oom killer?  It has been sitting in 
> the -mm tree for ages with no clear path to being merged.

It's because your nack, isn't it?
Everybody else seem to be fine with it.

> 
> Are you suggesting this patchset as a preliminary series so the cgroup 
> aware oom killer should be removed from the -mm tree and this should be 
> merged instead?  If so, what is the plan going forward for the cgroup 
> aware oom killer?

Answered below.

> 
> Are you planning on reviewing the patchset to fix the cgroup aware oom 
> killer at https://marc.info/?l=linux-kernel&m=153152325411865 which has 
> been waiting for feedback since March?
> 

I already did.
As I said, I find the proposed oom_policy interface confusing.
I'm not sure I understand why some memcg OOMs should be handled
by memcg-aware OOMs, while other by the traditional per-process
logic; and why this should be set on the OOMing memcg.
IMO this adds nothing but confusion.

If it's just a way to get rid of mount option,
it doesn't look nice to me (neither I'm fan of the mount option).
If you need an option to evaluate a cgroup as a whole, but kill
only one task inside (the ability we've discussed before),
let's make it clear. It's possible with the new memory.oom.group.

Despite mentioning the lack of priority tuning in the list of
problems, you do not propose anything. I agree it's hard, but
why mentioning then?

Patches which adjust root memory cgroup accounting and NUMA
handling should be handled separately, they are really not
about the interface. I've nothing against them.

Again, I don't like the proposed interface, it doesn't feel
clear. I think, this is the reason, why your patchset didn't
collect any acks since March.
I'm not blocking any progress here, it's not on me.

Anyway, at this point I really think that this patch (memory.oom.group)
is a reasonable way forward. It implements a useful and complete feature,
doesn't block any further development and has a clean interface.
So, you can build memory.oom.policy on top of it.
Does this sound good?
