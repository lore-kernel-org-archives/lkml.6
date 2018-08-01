Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB06C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB0120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NP8MMCf3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fOPqrVZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB0120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbeHBAoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:44:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726880AbeHBAoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:44:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w71MsDMj010839;
        Wed, 1 Aug 2018 15:55:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=q+I4Lotj8vM7zyt0xOvFM2hn5WPkYOqX2wqKYahZlUE=;
 b=NP8MMCf3rIQgKgLGRkbsTUaHqPSDjNF0uovoR3ngLV4ty/QZft3bk9oYONBdfjjc3WBQ
 SlxC4JI+FZKKZmk6psKaPI3bNAH6Vq021I4kKe63qrsY1riAo/4dicbfDeBNDTpWJU1A
 2LbQPBF7qSe74xHOtEbF8EFB83uY7vonbts= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2kkn2j0580-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:55:56 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 15:55:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+I4Lotj8vM7zyt0xOvFM2hn5WPkYOqX2wqKYahZlUE=;
 b=fOPqrVZgfdJEviQ8dAcasx04wEE4ePYUxpjtc7TMUA05P0C7TPio2Hd7uDT60i/MfrJ7ET0ko3Ag8xZAhf/8Gc0IyikCmKQYkqJ2xkBNBUOY2YVdtjipzgv8Gmq0oDv9ZY8qLLXklm5+lbc5DBC1LFGnqmDPKDIYDVKjCyTR8i4=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:7cca) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:55:47 +0000
Date:   Wed, 1 Aug 2018 15:55:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
Message-ID: <20180801225539.GB32269@castle.DHCP.thefacebook.com>
References: <0d018c7e-a3de-a23a-3996-bed8b28b1e4a@i-love.sakura.ne.jp>
 <20180716220918.GA3898@castle.DHCP.thefacebook.com>
 <201807170055.w6H0tHn5075670@www262.sakura.ne.jp>
 <ede70c6a-620b-f835-d66c-b4608fe0ef54@i-love.sakura.ne.jp>
 <20180801163718.GA23539@castle>
 <de9a2bad-d80d-98a0-e155-613a34c0b7be@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de9a2bad-d80d-98a0-e155-613a34c0b7be@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR2001CA0001.namprd20.prod.outlook.com
 (2603:10b6:301:15::11) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e9550aa-b809-45c8-2378-08d5f801ecec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:AynjNyunCyFp61+zK+KDNdT1VXFV4mgGEuJ2U2+J6WM19L7psillPIWgB03LF30tdshF+xHqz9+aqZJCPCbK7MheFmAr3CM+eT0AHhKS5hqbYYaoiRNSd0hbSUWrY69K+FKYsx7wTHjYo1xCyrxV9Cof3MCSmNjm3wcpc693A/toyBRejqIGO0YvmlausxGcOQAlS9fMtae1GKaqqE3Bs4VbGrR5RE78FG1/i+bamJxa/hEsUOHmdGGeQjp7zzp5;25:Ol98QzigqzdHHbGCvPLpR4icuo5fQhTmyENTXTdBNHEqrr461yC2PJs2Kde46uBwowMMS3Quy5H5lZXurc+xW2CSCCuwEMtRU82BVBxlPHOKkSFpGI7Gy7PrtGVB7vMoaiTtGXyKUdew0HserPLAOCVBI0veL6sLIGejhWdriCoSXK16QxUubYWonhIsQGe1CFfzJ15ChcLGl4/n5ugXWkfp5aEc2iKzedplWUxeEb8piQFi+isEEluWym23Cy9MDicwB9dP3EbBUlZfPeDZWH1N9FGW4YKP167WwB8mmyYo/nymanSQH/LtVMiiZMLlv3fFjFABMChxcuiqQYKVMQ==;31:+ujMHPIGUstuslGP5J9axr3ITNEsRAEyLJ5vZpDFSXvuUlYla6vy4ikNbXIFbDOSr9ugXn2CA1Sl0NuaFuqBX8Ay7FmIMc9avKSyi/wzO7XubnD2P0+z3Rz+IIWLRnSJwqvgYPiXBvvA4LkuANqRgLhKidx8mro4iJ8qnz7oSsv9dekeDVaKbmdJ3Gyk7roNlMR5iPA5paWBSexfqwV8sXzTO+1Ik9PwVpFnuL3udQY=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:1xJ9YvAcuhFilcn5DOlVhsYHnGbzK500E8TpN9wfBBAwyNopb2gCq0wA7UPYPGtsr6rHDDp990+zHRnheLhGwYatgBAnNsk7iVY0W/tRH6DVWHU12Kqb8nn2R6514rY3vu1NgiIIj6TKT0VoY49fm0PGwitru/n7Kz+FolnOBcAxhJMmsbkCMFhGM6TzNHbcnx/bpUQW0XNqLRX50A0YHTGDcDvpTzl1rindu9gAM6HlO3Szo6om2kPls4NnrOXYpF49pyvc2zFEYUXQeoBGe4rR8RohRQi3YqOFGbJlo497/cX7oB98+8WsXuh2kYHDic3k21gGlOdf6EMZlFcduXmZxxjtiVF0Y1UaY9jr2SWu4oTBTM/cNxDTbPr/TpsGLjh8vANchUN4vhDNmNCgjwoP6R7IeSrcJywC335SnytpPS0LuUuDm7J5cyb90ML5Ox6tOO6pvZR6nusy9sxbW054vzxAc+XdQujmm1lO4ZTr/7xbJumWqWscGixaiDcO;4:Bxkoun2KR4PHisS/M6HvZgdLqpyMx5U+wGpOfS4tcckuD7r2gGzWW0S9sQBqZHr+Wyf18jBNQ65PZ6mtpkTIVAmb+IQjo+GnvRDmsUONyxH8sRkZ2frE29QPCZOuLYXfsjD7Zaif+t0OqUKLnyekBlR9BZY6/0r8KH/NsxR/9aG1T9OOkT6moS1Ub3D7pUKEGh0yz2VsNfh3gBLZ+J/QTaOy2xGLgmKC2NRc7cE0xgL+04NI/ZEjcT3sB2kH/Q5cG0ua7AAHXODaS4VyCZLbZXqkT+6UShoDFqHKpO42gzuIN+GJoPp3RuaeiHCGcTUZ
X-Microsoft-Antispam-PRVS: <BLUPR15MB016276C7E9396BEAF942640BBE2D0@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(52314003)(58126008)(2906002)(52396003)(476003)(966005)(16586007)(5660300001)(316002)(6916009)(39060400002)(53936002)(6246003)(93886005)(6666003)(6116002)(486006)(4326008)(23726003)(229853002)(105586002)(68736007)(8936002)(106356001)(54906003)(33656002)(446003)(25786009)(47776003)(1076002)(11346002)(305945005)(97736004)(7696005)(9686003)(16526019)(186003)(7416002)(81166006)(478600001)(8676002)(81156014)(86362001)(55016002)(52116002)(76176011)(50466002)(46003)(6506007)(14444005)(386003)(7736002)(53546011)(6306002)(18370500001)(42262002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:l9zpmsJSYbyEa8KU0d8QXg30sG00JsxY08VROPohC?=
 =?us-ascii?Q?u1RlzMT0NXimpNNGB+co3/NsqOvv1faNHkPWxVUz1Q63uR2xoh+gPIeysXTv?=
 =?us-ascii?Q?OpnQitkZYvkAu6uQGO8qheVgv9cyt86sHorS/6pza+TTN1pvj58RmnF2pm/E?=
 =?us-ascii?Q?zgZTt683cqxlDzdV5lpgOA9N4OlZbj4c2zvBQiOKSLKWwUMfgyBBkEJO+edp?=
 =?us-ascii?Q?U1XgEIiRbJChJsM3cClKGPhnB1d4u+iSBEAGaDJuY0+12DMV3+jWEELcAnZY?=
 =?us-ascii?Q?BySKRKwK+kXS+z4HlEeinN0q7t1sr3ngE8v1SigmHOGNJTrALqvR+wF+a+mp?=
 =?us-ascii?Q?xomvvyIeInTBpZIMIBVUP2LDxydz9aVwMBzoiqbuQVVhXtRv1om7a43dGpdP?=
 =?us-ascii?Q?eRrLVCeehllBEJHjnlshRT7lyv0aZbDPgmBU/gcCVAv5/ageNTEAv5Puqr6l?=
 =?us-ascii?Q?CR7g7botQu8LSSECMzEQaRB8NrwsRBC7+d4LtNYx/fzEW8qlus32Wy+KRqX3?=
 =?us-ascii?Q?PF7uWy0ei4pBbOz6Da+iPJWualh5XtSaCASQ4A9SC1YK9Fr0mv58H7w2+914?=
 =?us-ascii?Q?r9HopU+M2B9po/jkbE7qfz6zO9Tko/M09pLp21bjFL9d6ZO40gnw0ZH/cU8Z?=
 =?us-ascii?Q?bcKajWg9/wQLJuj/koJbzM0nAEjelAKzmSahkEvC5ma3H10Pqq/Xnzj8wsxA?=
 =?us-ascii?Q?SzGxzxCjSDaZcdNGiTiEb2K3GwIM76XJvL+xvJDGpLGIRmb+zuQiYQLhahbI?=
 =?us-ascii?Q?YaAs6xgoMlnp8Yh+5D7ONZGgmI/7DSbfZ6BLv9eQ8keRAuEJEyKXwu2ip2r4?=
 =?us-ascii?Q?7G/7yVu+xF/OukVtxwO6dSvjSBRT0Pgpgjs6qknz3/7kpp8UyMy0htpulHiq?=
 =?us-ascii?Q?6gXcJvBO/l10oIgNKWSklxriG6Lr7Q8oA82ZMunhG/ph06yMB/mgIQsJ0B8T?=
 =?us-ascii?Q?0yZRnbXapwK/U2FsOYXYQDWUHvmGSS2wOoz5ZVKczmDDcQt8P8MJkeZ3EK0F?=
 =?us-ascii?Q?kAaSYBDMRPkwDvFEdJ7vtjh8MyCgmBKHrMxAF7lkA4z+iR3L8l6CkQXZ9Q5R?=
 =?us-ascii?Q?Y4l+VL6yob4Wc+rvJwLyz7BSh9XCc7tLWJELjkDw9CgHjue2ePpZZkvAlPg0?=
 =?us-ascii?Q?+4N4uqibi3yrOfhLSXcUx4Cz6lmICLOStBetDb3OYQpJdRYJOQJPUU26BhAZ?=
 =?us-ascii?Q?7q7LAUPfd+K4r1Zg/KIFospYn8FTr6J4Z5egEw2Mumxhmkna5W9Txpnhwy4U?=
 =?us-ascii?Q?T4jPdYhm184Hh76p5ZK9IGOEG+SCmutDzKHIoXCd2ODb8DZ4U6eVWmcZznCy?=
 =?us-ascii?Q?ByrJ8cJJ82KcCA5SuclJNmVRW2mVgj2ByBTyzPwoGFSkcTvQdKD+WbLStLrU?=
 =?us-ascii?Q?SDLGioYZTBgxu8/lr7BuT6L56+vVd3+ilEMO2HTkYg9f70I4AeG/UfhVax9q?=
 =?us-ascii?Q?6lIsTVsdCHv5VutA7oGBJHIHeWgDKo=3D?=
X-Microsoft-Antispam-Message-Info: G0pqSqjO6syISztHRCZYC5N9Lyti5MExAbcrVMqLPjG7PgNXeuFZe6HTl8kFGHbwi+y4n+w5LFft9ffciqmY6C46m4+xXPDqE4ahIBW/qlu5axHH79fQx6Gr+NDq4rZ+Q2F76pV5QmjAC+3DMy+JOIUJKck68bHjiO4KyVf141Qj7ZmYNnhN+q4qI1SksrWIea+9T218YQNfNjD0Y+2hoyDOUtlXsHdP1Ac9dk7WqJrkldJmfVYOVX/f+v48+PCD0BVZAyFe0hi3UnqHQ/LsCF8TZ7683o+CkGQh+IBX2/eD99XMpB50sskydCw2v+cwNtehOMYz2VWLGS/fAFc4u4QI4f9eoGdSnJcJmHvvCis=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:awBqYPOmiKonnINBoWZGy1EwgnvmgV2fTNsjR+gjCYq5t/8AVl+ch/MqEB/qalg54RDk6lE7OY923re9ZswEdq5+wMDjsbqk/SSZILgHTw8jzU0WYwC9TYpUY0M/p5J5Nif1DEXnEVWgod9488BZBzWwn5IYASavxbT5GFrgqO/U4b637020yAstroRQ4DNXqFLYla5wchPuaWOtoac9e9Fb5+VuCdKq97j7l1iabrlaEZIAdi3bs+YTILYP0OH9fPfbUx6UMRHmGY0m2g/Hr1AuLUjNBzfFPY1U+XRnwKl//nGkWSixEqe5YMtS02BnudBBFu/icG/FR8URTXdtwuNmxuNEfEbFAhnJ4+n2G9E1eiv8xbLKYc5L1McXR5dzE7vtcrhFRyFfTrfm+WSQityaHLpl+HZDSAGZHfrdGgj3f4OC5ROByLNZNazkHAC+MFySyzLtMhZQXf2ETZ0z2Q==;5:zn8b3pyrXwqbdHpxkZ+CpvSssz3grpRnqc4URzo+l7+BGnAo4Bgc2vB9dcSFmu1UBklcxg0vD2U4JC2zL0ZXPqj9v5I/dAYEYNcqPdCI0bpihsRo/lrPZT6IPGYC780FnLAusG5aWuC5u68WJmcabqXun9YVZaX9JdvExB43IEY=;7:V788IAeLgpViWc7FLJqAzsQLGRDHOWMnLj83+Y0meJz3D0f6csiwnYQRBtiVPhPMBkiaag/+8autrIP13ml1C2nuY3vL2LRoUZBm0xpA1p9rIQNFTU3VKrnCCXHyPbMyvefJyOagv2eZLnSX2DC44ki7NAk3TJS+FxlsDGEBIl02oMPlwoaxg/S3zKUmUKFYi/F6DGUOisQMDZG9DHx+W182xhJQwGpEP3NGl+Ikoop3wSGWsAqvwWFm6sBWCO+c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:5S/GC5l0Cqhace8YmiNJ4JPiOOKn5hEroUYw2646c0zbudFnJ/kgOiBSZedW528JcQ6ZlDIpqUSN3lwLfb2jIjurBj+Q8eG9MeNNgkEwh3QiYjHrfF26+RAlXf8zWtG9x96vkixC1Fvt9hmPSMKUyiaVngVMMAu6eKNN99DdJ00=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:55:47.0225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9550aa-b809-45c8-2378-08d5f801ecec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 07:01:28AM +0900, Tetsuo Handa wrote:
> On 2018/08/02 1:37, Roman Gushchin wrote:
> > On Tue, Jul 31, 2018 at 11:14:01PM +0900, Tetsuo Handa wrote:
> >> Can we temporarily drop cgroup-aware OOM killer from linux-next.git and
> >> apply my cleanup patch? Since the merge window is approaching, I really want to
> >> see how next -rc1 would look like...
> > 
> > Hi Tetsuo!
> > 
> > Has this cleanup patch been acked by somebody?
> 
> Not yet. But since Michal considers this cleanup as "a nice shortcut"
> ( https://marc.info/?i=20180607112836.GN32433@dhcp22.suse.cz ), I assume that
> I will get an ACK regarding this cleanup.
> 
> > Which problem does it solve?
> 
> It simplifies tricky out_of_memory() return value decision, and
> it also fixes a bug in your series which syzbot is pointing out.
> 
> > Dropping patches for making a cleanup (if it's a cleanup) sounds a bit strange.
> 
> What I need is a git tree which I can use as a baseline for making this cleanup.
> linux.git is not suitable because it does not include Michal's fix, but
> linux-next.git is not suitable because Michal's fix is overwritten by your series.
> I want a git tree which includes Michal's fix and does not include your series.
> 
> > 
> > Anyway, there is a good chance that current cgroup-aware OOM killer
> > implementation will be replaced by a lightweight version (memory.oom.group).
> > Please, take a look at it, probably your cleanup will not conflict with it
> > at all.
> 
> Then, please drop current cgroup-aware OOM killer implementation from linux-next.git .
> I want to see how next -rc1 would look like (for testing purpose) and want to use
> linux-next.git as a baseline (for making this cleanup).

I'll post memory.oom.group v2 later today, and if there will be no objections,
I'll ask Andrew to drop current memcg-aware OOM killer and replace it
with lightweight memory.oom.group.

These changes will be picked by linux-next in few days.

Thanks!
