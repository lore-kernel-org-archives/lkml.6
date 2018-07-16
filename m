Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDE7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177EF2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KhwY7OKg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YEgFUm0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177EF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeGPSpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:45:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728075AbeGPSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:45:18 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GIFPMO017329;
        Mon, 16 Jul 2018 11:16:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=bpPvMuaWuYuzFBJ7xvah72j3wh+fdTgY/6YDdUXVwks=;
 b=KhwY7OKgxz/GkggOo1PTbkolIszqfJHLU0EZYQ9dT5C0hVkFVJwVRSWuNYbWGpLFEXDo
 +DsGBo/Me3c/nYAYJ6fwglb9kFpYw46eyXAaI7uBuIbN1m0BMFjJOtr05XSXSOxxql6Q
 9a1nfGW4VJYgoz+kkohKuwZoNva9cSQWY+s= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k8ydt87hj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Jul 2018 11:16:34 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 16 Jul 2018 11:16:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpPvMuaWuYuzFBJ7xvah72j3wh+fdTgY/6YDdUXVwks=;
 b=YEgFUm0QA8dgdx0DR+ve+bClpmUEPyyGE/yqx0cSt/SBu5lZKDJuKZsJEiyCsYvTKSATuLgIt9flVRA/xErTLHdyMaGnTajjHnyxD2246g6pyJacLJllfKAeX7/wBQ+iB4Xb3IzryXcm/efUNAjr4PGOitABDkYeHPUxQ7abSOY=
Received: from castle (2620:10d:c090:200::6:d1ae) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Mon, 16 Jul
 2018 18:16:28 +0000
Date:   Mon, 16 Jul 2018 11:16:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     David Rientjes <rientjes@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [patch v3 -mm 3/6] mm, memcg: add hierarchical usage oom policy
Message-ID: <20180716181613.GA28327@castle>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807131605590.217600@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807131605590.217600@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::6:d1ae]
X-ClientProxiedBy: MWHPR19CA0089.namprd19.prod.outlook.com
 (2603:10b6:320:1f::27) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a71b38-bb8d-46ee-2af8-08d5eb4840d3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:O2CS5+NfsmeXBOszEWscK2hxzpjasPM3S81C5lfRdh7yJtji7OfHCrXNxaa08HlexTrKZi+u1DGutePjzBe7xRUaL9shk4b4YZ5d1AbveZUqNTTs0yjT4uVua9jzuCYsJgZM4/Jw4G3jHFie7k2D25g0UL94wBlctq9U6xvFdKmTfU6EIf5Jn5a0F4zKCyeJWchSUeWxYar5vOxnff/NtD6epkSUFAJo/nJdmnmB4qJ+RbHOYi+NpOqBtxNm5ij3;25:Ej3pt7bBBBaajr/2omkBNJYNUkdv1lEesnEkUBzIFQg/v1EvFjil8jKg/d7SzvBNwonQljGAUHR2YCBnS7Rr3Ee2fISbTw6kpkg6vcZJlcOCY4yrQVK4yvNb3IE5xYgZwZoGoMDXhtmKmdeWyRRnORuRYnZyG/bnbpwVxdTNfXB5HFRXbgOVGNL7aozFyctaFC8RSDRrlWM8ERbzv44x07tMNw1GGDLPMTyLmNGOWWbrIzTLUJzBxNzc1Xhc8ZYBVP0akxLQxxzLPZ+gz5uyc3vVaoTG8THJbc8E3fzv3b/vQX4bHHIhyjqYZmtCfRjJDTt/R/f9DKFyqUfhzpTccg==;31:L+21jtCBSSBWHSvQqpE8fSzsY603AewBF4eKFX093gXZLoex96oLJt9XL5cMF49yA2wDzl+Z/wQp2wRIA7yXQjoYBMToInYjAsOX5pg6mRd3e2ZFeYDZA9bCAe4juhzOwA3c5Z5EUehDZ763UIeJrMHu7yDRpTQIf0ESy8l+tGZaNaVMuOTMfVP+PmKQwbpAeo3XgyPQupAbPdim6WuoVWs6ZZASA9NXKG4FZsJ8mOY=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:l3H3Q953D9+c/taUclnOnHb+ztU75beKhNyUbq03FEwr9lNh3Mrnh/zI/bTqV+PlRerJ5GqMBdEus6s/JMTL9s/ilYQ7H6vJSPw/Tc0L4R2pkU2laNUaGMvs2octLtrbxQjfvNZf5qOY+5XPgqtlDetkT3Hchhau6cLrNaUzHCUFHBFJYq9CAo33FLo/0PrMdIvCmx/XpAdysjD2PUAxNhbnEfgwwstOrZWh7/WF1Co0Q0MiowCoK54J676T3Avk+EkJChFaWUaspf+mNPY+AXoImMUyqr4ntqQB5FNCjaK1Bt97fqaZrIo+WNPgvdJOOutz6weVIeal7Y5MIlhre0ZP1ljalJxQYZEXXn7k6/r3UBBkAgIoAhv8cJ24tSYiHsbBqxJwEYREOsmvaXTL2tliyGFdfLrP2vAl+uJ0afUWoJqS8x/TVy69DZSYkXALXYyM8zTGfhfxKEM2yhn6JW8TcEkRhZGrMjI94JIzExb3gzpEKv0ZEAO7kPf+f2YO;4:tKl8ujCieE580PHJQcZBypvVAAXkw301s7jF3acSPjETLvji5qmEIgbNOia8h9rkVMFJVWBl7A1F4OBn6KhCaPYKLEFNi1l2L6jl2QIUrUjGB4zWmP6H5TRzdAihu1eTKUG2pJPGkpZhzTdy5Dumo4DrOUH0/69VFsHjjlJdwb5ikx6zrJVicz+YXJugwSN+xzdCfqbrnMhWGgHHPUaxdf3NQ68peBqxIPqX9bUMWM9X7ex4eT9jGKrK3nmBiRKwVu58/CPQ5j/FuSO1tAu8Vs23IRuIbxwNy5V5ISZXzRZh4gfAHbqjpzsbA0r/KKj2Tr7MBi5JDQycDdHcPp0PSA0Si/cPApc/1tXlZ8lOH9I=
X-Microsoft-Antispam-PRVS: <BLUPR15MB01639C4DC14B9F5972427F82BE5D0@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(366004)(346002)(51444003)(199004)(189003)(54906003)(23726003)(46003)(1076002)(52396003)(16526019)(476003)(50466002)(486006)(316002)(16586007)(386003)(6116002)(58126008)(76176011)(186003)(52116002)(6496006)(7736002)(25786009)(53936002)(86362001)(9686003)(305945005)(4326008)(11346002)(5024004)(446003)(14444005)(6246003)(55016002)(39060400002)(47776003)(8936002)(106356001)(8676002)(68736007)(478600001)(81166006)(81156014)(229853002)(2906002)(105586002)(33896004)(33716001)(93886005)(6916009)(97736004)(33656002)(6666003)(5660300001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:5dksZFdEqwS/QlSpPChDpqfNLzd6BD8Vb5BqzMNiM?=
 =?us-ascii?Q?h+plT7chp+qwRXqYrL6mYjcEH2yylGZEQkXSk9k30NN47rCpdC3aFy5bhW/b?=
 =?us-ascii?Q?eYLWyomkFiAo1CzjkYZlijVE3LvpZl1XXIZKSNHiN7NjQBZWXaNFYx1PmGBZ?=
 =?us-ascii?Q?1jUT+yTuq+vMkjudRjaYs72fu2AGr/Mt5sBZVLaZtARPYya9qpsmX/mCyh+v?=
 =?us-ascii?Q?nGmALhecRHY/ffRpMK+ysDAOssnJdFsjWMl3rzEJTu0LGHVOBooIO19lIwZv?=
 =?us-ascii?Q?Md+g5LGYJXOthT9JnN55xAKiAzp4HnF+WcYxONbunXFAg+trikDwS4CkJJef?=
 =?us-ascii?Q?98L2Gxl33IZkRZe6y7WR8Y17n/qLE7K9K+aKyilQxE7K2hZ0VB8GWmZD/vVr?=
 =?us-ascii?Q?P5wQzgQ4pe7v0HupBIBsUt4NZ9DWz1z54cspO98UdhEtGU+4PP57TxfLKZNQ?=
 =?us-ascii?Q?SHkHZY+iKfMqCrDlQbIO0GllmGvdWjgysAxOdD5pbCdrlUiOH0mm+BJOZ4FS?=
 =?us-ascii?Q?bDU8H3eMZbm2FLovt1xmi/Vt6ik5dGy58GlHtI+D7Xy0jRtOJelPPijIlanH?=
 =?us-ascii?Q?hHagi/P8s3DX/Yz65QknrC5JAPiFKh4+akCh1II1+fSWJYwBYWR7/9lLhYzr?=
 =?us-ascii?Q?CUp1QOeOx0hUlVzhjU0Y1OM/x4SIIxbtq/fp3U30IaiJhLUofjtoTwl8ss/r?=
 =?us-ascii?Q?oB7gblt775dSIfsv9SPPIJF4MoL2NBuQQ5yAGR0ZzDcSPWNmOg6wv40WYn+I?=
 =?us-ascii?Q?780KHqeLvf16qj8/BA3bBLygk4glcMB3gCyMZVNRtIRmranebahXRT8hGird?=
 =?us-ascii?Q?pm49BdTTf9T+MMQ9mXrB29gN7iSlVlAgVsxC5ZKccYgDZRK9Grl0i5DJblsv?=
 =?us-ascii?Q?2qM7pNmT43aDXL/zbAfhLqWMCO3HzQj8Dbz7yyxVSap3WFWVjg4rxcykfBMa?=
 =?us-ascii?Q?YAcCAfNkSl50gGQvWFDmzAeA/GW6drMDFahgsUGOQ79sfcTfkia5UAuZL3k0?=
 =?us-ascii?Q?HU6sHTng4ehJmcnxr5euQg7vQgPzNEmNkAr0HyOx06A/q/H+gKDubBU3m5IY?=
 =?us-ascii?Q?88yA2rlDSHx4ljTVgYhhehWqPxq1R5cZ+TqBnq++ixKdsfNP91UCwcT+1ILB?=
 =?us-ascii?Q?Z5dLEXgIeOyotIhQqeUa7+Ksx7QrnTbLVAnfL/c7d2HGBbFOA048N1XAy4bL?=
 =?us-ascii?Q?217vkaXjD/ZcOthB4bo4AeH1n0qdsL0f1UR2CeAfYCU7dSlR7/bTGkxHnOOt?=
 =?us-ascii?Q?0w9xNIWOiynwhgOMD6KSgbJPDGoY1bg7w6zB1Kwpb+R3MyOGsat10VFIurUy?=
 =?us-ascii?Q?Oia0ZKue0E/E6mX/KIQnnsC9IYHcUTnILzNoQ2s61jzEXk916Up50x6a4lIu?=
 =?us-ascii?Q?eDf3ooiZHJ6VLi8csV4+Rx7AWM=3D?=
X-Microsoft-Antispam-Message-Info: utb+FH53Yfq4o6bjLDgT5Yr7S4SuPAZ5YwGs6jZ5afs7wjet6gL2mPLZm7jwtf0F2AuiCIiTqRuPv/T0lsocTjkYmd7rFm/mRFT/4ZqqizRcUyAsBtDNXTr3phNc295LNK/oF1XmHrHwV5Sm5ctf/TsGw174Q5+55OT/Spz/Y10QXfU4Yh/Jot3sfLaZGD5VfaWnflspUsg77IFQa4ic9uc71NJ5rtSsJRn+xjMDdzzZqb6PWpYfqU2Ikpa00SiI8X3xldSuGOS7j52ofEWDthjJqxCJEDupOB3CTxCSKgJuyQZ9NOlZrV2A+0JMTwV6Y+GahRmQOaancqdCT9yy4jL+rQcaSFVvW5MRRXhXDK4=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:DPGTEk609heNGiagNkrhV01ef/PisibvufOol1rEEA/8YpkYxA9PtAm25N9EOG+YqZIq1ebWxgKDMtp85zhKqG+MuJ0hKLdApaiRE44LaVlg+ONTvUCAU+CLThuAo8bBGWv3zRQ5QyzsI5WdCnLkDHdqtWWldFtQACYZYI1VHs5r77MxU9X41ipBV5bKygjFFcqJMosoenYx6wc4cMOO7AH0qKeMBKjpBWHYVw7stZMujWIzEKZGVyKJkciJ+JIW7LWZc8c8yeDQgM5LPNB2VAXNzIuHezeW0GOu4OpPjajb/8Xg1lBFGPvVfkXW6x2w9XqDopl3KpZfnA0YP14R9GZgUvRaSNwNW0yGZySF6FXfY808W9D6GsrhSpYyTJKpO66maGI4AKnJZ0GcHGWa8H4lcK69mqgHWubS4pM5rrmzj+/FcNeMioeSUZE5AIezO22QjzN+zD9G9g9tdhXHJQ==;5:mel4t90z+KdzKYeMAB02jklkiyzOeW50TFrh6YXsXcBrtTVtTkIAbo2kB/sxpuIYFYz0PqzBvY7SR9NDVPvzsVlHaV00rjGEOHp4WZRe5ixjJ1x5PhEcdFu38ZM4ywYZh7+57jvUY8iSbXMXwbND2tBPjmAw+8VyU3nqFDwhILs=;24:UW1xyPE+DHFRVM+chd1WFWgPqtKnNmQpjcJZ+TST1aUbasJtXrfrJJDZTXwlt6pxYc8bmqFNWPM6eyKtH/CFXjtASLzaGM1pRpEQ4EElTlM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;7:b0V36lQSS3ugOjvQy5+ozfoC7fcEmTrHtBEQY92x/RQO0ZDZagOvXrDPJu0Zd8P6ovJ+cP+1t5F5F9qC6gNs4IhNebTSvp7XXC4xpkIV46XUOytZUPAZPD+yL50LDVUTB4JC+V6ywedso3Ei/Cjlg1GIVGfd5tlwPGEzfTpuZrhCdrHZJQlAiOqyoNmIZ+7jDhTyiYmLZj9O0n4DigLRqUo3io9wXrdVi4IPMocEp0hiruHvvduPxAxUie3Ok5nC;20:CpOV5KlyfDyqY+VI9zfX2VSF8ipEZ+9iPhy16YtgNYLLBZxrnTN/jYuwSYkLs0yD1P1+BcheEgRgm1NF//iJWpcashRb7TZszwb4YdCP+s8zN0AkBSsAYiKSbHfDzDwzQjp1XHTuOXXgG/QVT2bNtqf23srMklp4X5N19kubC90=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 18:16:28.2890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a71b38-bb8d-46ee-2af8-08d5eb4840d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 04:07:29PM -0700, David Rientjes wrote:
> One of the three significant concerns brought up about the cgroup aware
> oom killer is that its decisionmaking is completely evaded by creating
> subcontainers and attaching processes such that the ancestor's usage does
> not exceed another cgroup on the system.
> 
> Consider the example from the previous patch where "memory" is set in
> each mem cgroup's cgroup.controllers:
> 
> 	mem cgroup	cgroup.procs
> 	==========	============
> 	/cg1		1 process consuming 250MB
> 	/cg2		3 processes consuming 100MB each
> 	/cg3/cg31	2 processes consuming 100MB each
> 	/cg3/cg32	2 processes consuming 100MB each
> 
> If memory.oom_policy is "cgroup", a process from /cg2 is chosen because it
> is in the single indivisible memory consumer with the greatest usage.
> 
> The true usage of /cg3 is actually 400MB, but a process from /cg2 is
> chosen because cgroups are compared individually rather than
> hierarchically.
> 
> If a system is divided into two users, for example:
> 
> 	mem cgroup	memory.max
> 	==========	==========
> 	/userA		250MB
> 	/userB		250MB
> 
> If /userA runs all processes attached to the local mem cgroup, whereas
> /userB distributes their processes over a set of subcontainers under
> /userB, /userA will be unfairly penalized.
> 
> There is incentive with cgroup v2 to distribute processes over a set of
> subcontainers if those processes shall be constrained by other cgroup
> controllers; this is a direct result of mandating a single, unified
> hierarchy for cgroups.  A user may also reasonably do this for mem cgroup
> control or statistics.  And, a user may do this to evade the cgroup-aware
> oom killer selection logic.
> 
> This patch adds an oom policy, "tree", that accounts for hierarchical
> usage when comparing cgroups and the cgroup aware oom killer is enabled by
> an ancestor.  This allows administrators, for example, to require users in
> their own top-level mem cgroup subtree to be accounted for with
> hierarchical usage.  In other words, they can longer evade the oom killer
> by using other controllers or subcontainers.
> 
> If an oom policy of "tree" is in place for a subtree, such as /cg3 above,
> the hierarchical usage is used for comparisons with other cgroups if
> either "cgroup" or "tree" is the oom policy of the oom mem cgroup.  Thus,
> if /cg3/memory.oom_policy is "tree", one of the processes from /cg3's
> subcontainers is chosen for oom kill.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 17 ++++++++++++++---
>  include/linux/memcontrol.h              |  5 +++++
>  mm/memcontrol.c                         | 18 ++++++++++++------
>  3 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1113,6 +1113,10 @@ PAGE_SIZE multiple when read back.
>  	memory consumers; that is, they will compare mem cgroup usage rather
>  	than process memory footprint.  See the "OOM Killer" section below.
>  
> +	If "tree", the OOM killer will compare mem cgroups and its subtree
> +	as a single indivisible memory consumer.  This policy cannot be set
> +	on the root mem cgroup.  See the "OOM Killer" section below.
> +
>  	When an OOM condition occurs, the policy is dictated by the mem
>  	cgroup that is OOM (the root mem cgroup for a system-wide OOM
>  	condition).  If a descendant mem cgroup has a policy of "none", for
> @@ -1120,6 +1124,10 @@ PAGE_SIZE multiple when read back.
>  	the heuristic will still compare mem cgroups as indivisible memory
>  	consumers.
>  
> +	When an OOM condition occurs in a mem cgroup with an OOM policy of
> +	"cgroup" or "tree", the OOM killer will compare mem cgroups with
> +	"cgroup" policy individually with "tree" policy subtrees.
> +
>    memory.events
>  	A read-only flat-keyed file which exists on non-root cgroups.
>  	The following entries are defined.  Unless specified
> @@ -1355,7 +1363,7 @@ out of memory, its memory.oom_policy will dictate how the OOM killer will
>  select a process, or cgroup, to kill.  Likewise, when the system is OOM,
>  the policy is dictated by the root mem cgroup.
>  
> -There are currently two available oom policies:
> +There are currently three available oom policies:
>  
>   - "none": default, choose the largest single memory hogging process to
>     oom kill, as traditionally the OOM killer has always done.
> @@ -1364,6 +1372,9 @@ There are currently two available oom policies:
>     subtree as an OOM victim and kill at least one process, depending on
>     memory.oom_group, from it.
>  
> + - "tree": choose the cgroup with the largest memory footprint considering
> +   itself and its subtree and kill at least one process.
> +
>  When selecting a cgroup as a victim, the OOM killer will kill the process
>  with the largest memory footprint.  A user can control this behavior by
>  enabling the per-cgroup memory.oom_group option.  If set, it causes the
> @@ -1382,8 +1393,8 @@ Please, note that memory charges are not migrating if tasks
>  are moved between different memory cgroups. Moving tasks with
>  significant memory footprint may affect OOM victim selection logic.
>  If it's a case, please, consider creating a common ancestor for
> -the source and destination memory cgroups and enabling oom_group
> -on ancestor layer.
> +the source and destination memory cgroups and setting a policy of "tree"
> +and enabling oom_group on an ancestor layer.
>  
>  
>  IO
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -77,6 +77,11 @@ enum memcg_oom_policy {
>  	 * mem cgroup as an indivisible consumer
>  	 */
>  	MEMCG_OOM_POLICY_CGROUP,
> +	/*
> +	 * Tree cgroup usage for all descendant memcg groups, treating each mem
> +	 * cgroup and its subtree as an indivisible consumer
> +	 */
> +	MEMCG_OOM_POLICY_TREE,
>  };
>  
>  struct mem_cgroup_reclaim_cookie {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2952,7 +2952,7 @@ static void select_victim_memcg(struct mem_cgroup *root, struct oom_control *oc)
>  	/*
>  	 * The oom_score is calculated for leaf memory cgroups (including
>  	 * the root memcg).
> -	 * Non-leaf oom_group cgroups accumulating score of descendant
> +	 * Cgroups with oom policy of "tree" accumulate the score of descendant
>  	 * leaf memory cgroups.
>  	 */
>  	rcu_read_lock();
> @@ -2961,10 +2961,11 @@ static void select_victim_memcg(struct mem_cgroup *root, struct oom_control *oc)
>  
>  		/*
>  		 * We don't consider non-leaf non-oom_group memory cgroups
> -		 * as OOM victims.
> +		 * without the oom policy of "tree" as OOM victims.
>  		 */
>  		if (memcg_has_children(iter) && iter != root_mem_cgroup &&
> -		    !mem_cgroup_oom_group(iter))
> +		    !mem_cgroup_oom_group(iter) &&
> +		    iter->oom_policy != MEMCG_OOM_POLICY_TREE)
>  			continue;

Hello, David!

I think that there is an inconsistency in the memory.oom_policy definition.
"none" and "cgroup" policies defining how the OOM scoped to this particular
memory cgroup (or system, if set on root) is handled. And all sub-tree
settings do not matter at all, right? Also, if a memory cgroup has no
memory.max set, there is no meaning in setting memory.oom_policy.

And "tree" is different. It actually changes how the selection algorithm works,
and sub-tree settings do matter in this case.

I find it very confusing.

Thanks!
