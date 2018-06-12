Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4C8E0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23AD208B5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TybElSAU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="R990zJJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23AD208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934145AbeFLRZB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:25:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933151AbeFLRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:24:47 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CHIkEv027892;
        Tue, 12 Jun 2018 10:24:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=nQ20z7eHpfMRpqM/Hynse9M+0CmkcwwXFJl2aJlZ3+w=;
 b=TybElSAU/kZnRRK9XRsjlMhzmo49DDUn0bpCkAIB1MtO0g/PFJovGK/u7ghCdqysCdNb
 diNdA2bhjwzSIjwEjPJmB69XbGR6bvh5KRSH0oxZH74MmjkUkejl4h5SYN1Hv0Gd//Kl
 qaUkauAUi9aukkw7bw5EYjsMO6od1yNQukw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jjehegt07-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Jun 2018 10:24:33 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 12 Jun 2018 10:24:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ20z7eHpfMRpqM/Hynse9M+0CmkcwwXFJl2aJlZ3+w=;
 b=R990zJJGqkrjvlMW1J2x+jusPoDmQM/LMg4IejAJH/2PFycyY2teqRlSaQiGRLanRqLjGs9TpC7MzZLOuJ5lZUd/BcXzajyMWMKIxHlYfZNyO1zQ5vUW1ppUKQNnt4AnBFXIu1n6XGZRKGkhQfnx1CW8vaAJbCyGsL4hmV/sTsg=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:940b) by
 BL2PR15MB1075.namprd15.prod.outlook.com (2603:10b6:201:17::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Tue, 12 Jun 2018 17:24:23 +0000
Date:   Tue, 12 Jun 2018 10:24:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] mm, memcg: propagate memory effective protection
 on setting memory.min/low
Message-ID: <20180612172408.GA12904@castle.DHCP.thefacebook.com>
References: <20180611175418.7007-1-guro@fb.com>
 <20180611175418.7007-3-guro@fb.com>
 <20180612155242.GA6300@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180612155242.GA6300@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:940b]
X-ClientProxiedBy: MWHPR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:300:13d::26) To BL2PR15MB1075.namprd15.prod.outlook.com
 (2603:10b6:201:17::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1075;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;3:JU8oiy6p07pwpUpGDWuMlmJ8l/SFqJa+unF4MyAFYbtEbxCGKE21u4lpYUXpaqgelR4na4A7t7zIZhgSjR4nzgT89h0BpGbRlNV59tlsDcniDFWrAwQncH1UCN4Wt4X3FoFNtZKhNt0B7FJYMA/manU73pbKyZL0jh+54N6xVRz4ta21sxuQ+FwroD0P/givSxN88/YqxdC0iaPOeXEXnDk6KuwTSU2hPpD9MQeMMDkAhfRYUcKmnjTUkHrm6a9S;25:jTxIq7w8X70FyigzrTTcK/k8kKun5LjofXeWQgnjYH5rfWY02oTOM8roa4lihXp1DvZMTc01Vn/+D62vbw0w8OgXuylf9h+7uBNUMxfyn47SzXvndoCaTwj0l6rr4ovXx7TbiHcaO4aqf7G6jieJ4d5Gs0aAuk1cU1Nv03GElKT6BbgREeo05N2PuBXDpK9m3IFqFroRFbqR27jfYdk/O61vOXInmW/P6nPZZ3cx/qH5TsIoyB6dkObiomzZS37FLSuHB4oIIXyhyZehVB9XUOntrJSBiysD4XxMgEsW4Okz6MjDkvUNJl6OElL0UiTzeSNvdJJjbFSz30gE4QOWQg==;31:0k6uOh7g6Q7AijhQnYSkb2OpuLOP4rSslMF67WmPP0SndhikD8rrJwaLZs3fOeFhBYfKrIltdi2a/bHXGKyQ0L8JjSch2oDulSL2mhdGHgWaTksJDuK0MINpVnay9GQZ41UlPYRtzADY6q9zqq1HjIQUxRvrMtfmtOT4LH2jva7RXSDbyPIFqC7lzdLcGojiJ0ng8NhY5GJTPEcCz7rtgO2YsAlFEIYDHLbXtPLL4sI=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1075:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;20:xNzY/XHW+FlRqCNuN/r7h42w3aZnZWaMV85AP57zLBqAo2olRfmMVDtdRNEC4bhlKZLxbjU2ppT7alptqP/iXGGVjO/VlyrJwgZvtjOTDBoQ9GP7xNEmLmnOFRgc7GaBTldi2CyEPuGfZyYKpzIA4V2P3DFtl7LcQfiwhRsWMrM1kvu7UhTN6IXmKFMM2RFqCGQg9qAVFqX99M428WHmRx9sb1jiDz/t/ZQb8UBbnWC550UZh42xROdLxNPZkczUJWdLi3KOYLN3ICiVjBpnEQxm91b3xXNQySQQqSWoIO2JL/aSE4pF8ppw7CC0ir1X49Hafw7ZjT86EiH6SnT24J6YRkYN0U9pGqDP7XTaoV0TPma7h2REm7ZBh94OExKTGCnCQy+G1I342nexro3ClTqwHBB7RZSgFCw9pwf4OUZrnrzXFR9uct0ptNECwXO6PCAFU1Q7nfU0xAUYW4uEKc1+Yo37gwQJ+OIf8yYYH1NWWdLNK27DcHD83sewscGK
X-Microsoft-Antispam-PRVS: <BL2PR15MB10758CB06A1190DDD5952801BE7F0@BL2PR15MB1075.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL2PR15MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1075;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;4:rHUJ5T6O5YKgiQ+maWvLd2C3VG6x244bLxmEouw1FHIBvpeEmQoXL7GXY6emvbIhKQlGLlEy7JHWxqG+lD9K10staejCBC3xdka/QTQiyKoJfwNiQjWVNMU+sV9Hw2+XJW4sh8xQJN3WK1jyugqGu1yZQ8yj7pfPfSOpW2bDhQpy+qOzwqhCDsL1u4UtzjJJ/ipBzK2waKaD051G7UdHXL3lW8WdZsoNkW2NO2+Nc2UtCPajt+GV/5Ha7PVxAr0d6kUFLdeoMSWg4CVujC+8Gzuv4+thyGuIr0vTjMNDeYt9P7lRzkgKGBhZf9wV6F6L2iGd5dSECvZ26iU2vfb9lPToh1ikMclzBTfkA5JP6V5fXs2VU/7Ovx8Qnvl6RqvBs20n7v7UPV3E4LHtyoXJtFg9O+Hkvla4upAH+Yk+0sShDOswV3qI0XewwVlVGJlcXh6XDINSZxnwHYFh7hQZQA==
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(39860400002)(346002)(189003)(199004)(55016002)(6246003)(54906003)(966005)(53936002)(6116002)(486006)(446003)(476003)(47776003)(58126008)(7416002)(6306002)(11346002)(68736007)(25786009)(16586007)(9686003)(229853002)(478600001)(23726003)(4326008)(1076002)(33656002)(39060400002)(6506007)(7736002)(52396003)(305945005)(6916009)(6666003)(8676002)(97736004)(52116002)(8936002)(50466002)(81166006)(76176011)(186003)(81156014)(386003)(16526019)(59450400001)(46003)(316002)(105586002)(7696005)(86362001)(5660300001)(2906002)(106356001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1075;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1075;23:JEY2Vdc4n0iz/U8CPTV33xq2K2i58dSmrD8mWJLFG?=
 =?us-ascii?Q?SuHBkTIUBypAz4St2456NwEyFXNbXzSGEDNKYSmg42W418LsboRTFeDjwsfY?=
 =?us-ascii?Q?3oQr7WoyH4NepQvZWeQm5vg9x7BG38ILO3dENGSYMUvzmddS88uOlbtgAf9b?=
 =?us-ascii?Q?0qRoPJfaroW9YMO6WzeU1sAzqQOuJU2yPJQyf1kSzouarAAkiAB/GNLC+yDw?=
 =?us-ascii?Q?fPv9XHuTo4IJXvjhlmWvDPQC8gjpjM24GmJIw5yIDVkJcVCzt2iYX0XfkS/m?=
 =?us-ascii?Q?pValaov6GFkhxoWkTBK9k5Ho4mXYCldI9C+PWJQ9n7Uju+4pWLVD1E6+WvHY?=
 =?us-ascii?Q?UZDjFP+a9ZMQFmLTFznG2w625jYyoiElVEvmcdWAEzf6+g+0+tZlHY2dtKzq?=
 =?us-ascii?Q?RjMXVAq8RjWaC3+OUyGv+sNWPsrFPi7PfWB2lw19e7lFWKn/uDnHLA+L8zUd?=
 =?us-ascii?Q?Z9eT8xJST9OLGLpmXXizvHYj7mkWeOqX631Oc3zuhxZNV2tbUmkRMdiKPHH5?=
 =?us-ascii?Q?XHrF8yN8+ao+JhP9Yt3gBIz/VSQtgjgDgu/Yd6ycDzpdDU45/tuN+GAw0U7i?=
 =?us-ascii?Q?eLcKkIyctG34Z2ktNAndL96I8X/PhujoGZItApMFJnax/dvRiYZ5s1eWH1rR?=
 =?us-ascii?Q?/y57fGmLsHTsWo/EL5L+Bh1PwrguiNmw5lSycdNKfoJEdHetxYumd/OUPevh?=
 =?us-ascii?Q?AyoBL92zqMvfnG0Rg48MwMO9mv0g4xx0rS4EjeSdR86rktqVv5p+fWKzzMtV?=
 =?us-ascii?Q?jTRFFv5zfaXsJBRq9sZ8Nqj6e4wlP1hkEJ84HRwURGEaPgy/oG5dLFU/AgXD?=
 =?us-ascii?Q?29KW5i0c2cXnCCP+TOwJjjQ80aTsH6VCywOx6dGdZk7EMi9aIJWy4MmKT/CZ?=
 =?us-ascii?Q?0ua3hPqaGIYmM3MPmJBkSxJ3JRs3lFGfCE8dxzdIrpLi6w2P2IYyI8ndXVOt?=
 =?us-ascii?Q?EOyUL7yGwkCNDjARcY0knE+80lf80LUi514CVxd4Vg5mmj1XwMtzRCRNAc5P?=
 =?us-ascii?Q?ge5fFYjtz7DHAghC8cNZW9rVa/SklaWJjssBOwG2zHz6NKjSXbshncsL/um7?=
 =?us-ascii?Q?7T7AeB6GI5KqIy/ZBCJPpXAcj2PtABfJ4t4RQ5m+0px6P8yIgnc5eowtwMib?=
 =?us-ascii?Q?cpcG8s8yz0lha60MJrQjRYCSSv7QaQesApZcX/h2ukYebuzfb0DSMJEZ0zlO?=
 =?us-ascii?Q?J/rtoxlWOQzlULWhufpE6WepeFvgOiL6dATQR2yrH8pWkY9Pzd+/skw5hzPL?=
 =?us-ascii?Q?Z1T6w9HJxPb2New1YPP+tRviy85bvQzxFd4G+vO3oIfx/B/qHpxxKw6J/6gP?=
 =?us-ascii?Q?6dm9jr4u0prUr+girRH+0DalAMp7vqFDZPRHdY0WUFI0TeIUO1eUVl0lk0vG?=
 =?us-ascii?Q?GF5lQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: XUB+5pF16AnoIFaZGrC+OSY6LkjB/mpkVbXM1T0ijTTXAwa1rw9pPgvK4sWXsf0C5CjjhKR+ci8aCiERVcLwT56bSIkEFQFXHOOaIwzERcWZ1mKuMCEJMZa3yto+kWM+JXSetg9xlhxL0ZmRpTaKUuho8BHmCF6BhNRwlAEWEEbyKIKPgc8JKPTBkcjmaNmi
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;6:JcGHKW2nTJvqRFzRD6coPyIoYHkrnw+e0zLhxO6J0i4I4sEl37NpIwUUjgU53YC870eG2vEpFHslNATg+yUuLg3UEG7z11w3QDu4l6X7VA2M8xMVmNdR2kB0BG2Dp9/aAT05ZrweSxVwZGpcBlTHbzBERRFqTwKLjqwCwltT0nvstkaVCIG+FCA1ynp+7yFPrn9Os6tUOmcWhXqhtINnJ6M9lhGTZvNqhYkK4UTmsx5a6RixsSz1+9SAkaoFPClLNMgLJyn27Oq6kXQ4qvwKqHcaOufPyjT1N51PPfsyJuld4nssln6K+klczg5sXpJIxPTYJd01zcgCvOa9doufxMb1/qIkAdbTQVOvXwUBiSDdBC6dxrNScSdeTfhVS4YGCgBibtusjujEmQLPUK6hsPJmAkFI4cNwVH8PO04k/TMhBwVQ8Nt8Cj9owSiyjou08zWgyB8nU5z1MYufJSKITA==;5:SkxcSUSYNWvESTDn9pXwr192VdHnPRBZZM0j/xxCQHhggEzRZ/4o3+OYYJM4l/0h9H8B+C9oFNConz5QOztTc90qSEBRHBLeFNOaDsXbiXrMLbTNjQggzA+cJfh4Vexk/wxltOHGEtkCIHrLbTY9wj7ijBYpaCBPgFKXYqQRvCA=;24:k45CLJDtdKN5Kbtb5ZpRb8/vYXKzKknGGMnRIuPGB/ZCTIMJ3Cj4kivJRMWAT9O5dVcZCfTvL3aHl9+kGVpyuFf+cFNClkUFX1av9e9fdZw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;7:9Z3hs1F4+Hf4YxEuieRsV0LikBqz+gUwjs3jWR3Y/xXzMxFLCtcqoeZQ4/67neEc1GBpuXj8lnuvDCieu/qmJmOXTSzdq3+Svks/6wWCRNpiTz45TIUKPtFxJ053VqDB/6PXVYfoezrZxCL6+vrKxS+47sFHo0Qo5rba0gzXk+VETc0cNPqAzUxTFdr7wCj0WIjfbTuK1Zh+I11i9LGE/D3+wn0F4j/6tUZYXbnIC/BEbG1lTl0bsHdFrbXwsrty;20:pundv98aTAkXZ+RPcSWoGB7PHx1PZaXDBBtvKckCZQwtyyNIhqkEHBbh+GhbIk4aFSHkEuimGDIKwDZ7l2bSDug7Qg36a5pQzLEUKJ2FotGP8JFokURaDqx8PgGwrowsNTnJnrbgrC/JFn0NOoray0aB0jXQ1K5eHtHbqNQY7Vs=
X-MS-Office365-Filtering-Correlation-Id: 59e24e25-c3f3-4582-9568-08d5d089584b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 17:24:23.7996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e24e25-c3f3-4582-9568-08d5d089584b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1075
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:52:42AM -0400, Johannes Weiner wrote:
> On Mon, Jun 11, 2018 at 10:54:17AM -0700, Roman Gushchin wrote:
> > Explicitly propagate effective memory min/low values down by the tree.
> > 
> > If there is the global memory pressure, it's not really necessary.
> > Effective memory guarantees will be propagated automatically as we
> > traverse memory cgroup tree in the reclaim path.
> > 
> > But if there is no global memory pressure, effective memory protection
> > still matters for local (memcg-scoped) memory pressure.  So, we have to
> > update effective limits in the subtree, if a user changes memory.min and
> > memory.low values.
> > 
> > Link: http://lkml.kernel.org/r/20180522132528.23769-1-guro@fb.com
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Greg Thelen <gthelen@google.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linuxfoundation.org>
> > ---
> >  mm/memcontrol.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 5a3873e9d657..485df6f63d26 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5084,7 +5084,7 @@ static int memory_min_show(struct seq_file *m, void *v)
> >  static ssize_t memory_min_write(struct kernfs_open_file *of,
> >  				char *buf, size_t nbytes, loff_t off)
> >  {
> > -	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(of_css(of));
> >  	unsigned long min;
> >  	int err;
> >  
> > @@ -5095,6 +5095,11 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
> >  
> >  	page_counter_set_min(&memcg->memory, min);
> >  
> > +	rcu_read_lock();
> > +	for_each_mem_cgroup_tree(iter, memcg)
> > +		mem_cgroup_protected(NULL, iter);
> > +	rcu_read_unlock();
> 
> I'm not quite following. mem_cgroup_protected() is a just-in-time
> query that depends on the groups' usage. How does it make sense to run
> this at the time the limit is set?

mem_cgroup_protected() emulates memory pressure to propagate
effective memory guarantee values.
> 
> Also, why is target reclaim different from global reclaim here? We
> have all the information we need, even if we don't start at the
> root_mem_cgroup. If we enter target reclaim against a specific cgroup,
> yes, we don't know the elow it receives from its parents. What we *do*
> know, though, is that it hit its own hard limit. What is happening
> higher up that group doesn't matter for the purpose of protection.
> 
> I.e. it seems to me that instead of this patch we should be treating
> the reclaim root and its first-level children the same way we treat
> root_mem_cgroup and top-level cgroups: no protection for the root,
> first children use their low setting as the elow, all descendants get
> the proportional low-usage distribution.
> 

Ok, we can keep it this way. We can have some races between the global
and targeted reclaim, but it's fine.

Andrew,
can you, please, drop these patches from the mm tree:
  selftests: cgroup: add test for memory.low corner cases
  mm, memcg: don't skip memory guarantee calculations
  mm, memcg: propagate memory effective protection on setting memory.min/low

The null pointer fix ("b2c21aa3690a mm: fix null pointer dereference in mem_cgroup_protected")
should be kept and merged asap.

Thank you!
