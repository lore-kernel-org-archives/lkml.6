Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12090C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CA621019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="YpTQtwx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfAUV45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:56:57 -0500
Received: from mail-eopbgr760109.outbound.protection.outlook.com ([40.107.76.109]:58708
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbfAUV4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYvqp4hrgCFQ836s5UO6vH3TJDt91NQ8hh7mp7rPDg4=;
 b=YpTQtwx1zrNSQUuRwnKpcKWDpSLFbk0SKu0JJCZnHHfX0WKbhinqHaP9ksODm/TTkvagk4wa4KxJvu0mKWiTZhvMWycyN+ZBV2MZQy7tZeMc1NNsIDZ5i2YBC2udXCzfxyT8e0TeUAiPdfW93xPd3gde5C1BKZTYBDco1hNXzbo=
Received: from SN2PR01CA0070.prod.exchangelabs.com (2603:10b6:800::38) by
 DM5PR01MB3211.prod.exchangelabs.com (2603:10b6:3:fa::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Mon, 21 Jan 2019 21:54:59 +0000
Received: from DM3NAM03FT033.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::208) by SN2PR01CA0070.outlook.office365.com
 (2603:10b6:800::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Mon, 21 Jan 2019 21:54:58 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT033.mail.protection.outlook.com (10.152.82.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.11 via Frontend Transport; Mon, 21 Jan 2019 21:54:57 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x0LLstj7018541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jan 2019 16:54:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C217B7A4C30; Mon, 21 Jan 2019 16:54:54 -0500 (EST)
Date:   Mon, 21 Jan 2019 16:54:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jann Horn <jannh@google.com>
CC:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] fs: hoist EFSCORRUPTED definition into uapi header
Message-ID: <20190121215454.GA12996@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jann Horn <jannh@google.com>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Pavel Machek <pavel@ucw.cz>,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
References: <20190118161440.220134-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190118161440.220134-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(54094003)(189003)(199004)(86362001)(88552002)(229853002)(126002)(786003)(54906003)(36906005)(58126008)(23726003)(42186006)(16586007)(316002)(7416002)(26005)(478600001)(106002)(52956003)(336012)(76176011)(486006)(2906002)(11346002)(476003)(33656002)(6916009)(446003)(2616005)(186003)(36756003)(97756001)(90966002)(75432002)(103686004)(106466001)(46406003)(39060400002)(6246003)(246002)(47776003)(26826003)(1076003)(305945005)(6266002)(50466002)(4326008)(8936002)(356004)(8676002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB3211;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT033;1:blzaCQoRML2WPWYM82aNIqCLMp98sKaBp/1OJRHmOG0GaquLSHus2yL8p22YwZob+fj+OLJ3Q3ky+5V9X9N8x7pnmmCfgYsth6oqvlL82zLQmv09xwYuJHG6YpAoTx29UsQvXUPtwZGNP7nJEMMMVcPG3n7smLQ0tCzlZeMYP5o=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b028e0e6-b436-4e5d-9242-08d67feb163f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR01MB3211;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB3211;3:vlIYeirAcuv0BZYACfmeaI5n3qb5NE/Phf9WISkHu/NVI5F1vneOaIrmCMtGdi6WZLUAUJ/TUZpNivVVcIn9Sd9xZDxO+hnzIlkvmnvfba6hNe21J5Dfl5A8YeteASDBqYyQZrEifSdrSvK0sjK6Up/4smAkdzSpe8aswkZZup2t1txD9OXltZ1C+ETOzB7Sz1xzT9og38zG+svB/HZRvcxpK9PXhSleAttXMogo28+ySkHFL6PEXep0P/EuZlNMvOahPOTl+wz2ciZhreiALV6INbLcGcoC9LAsmuOF6+350Zybbi/skSVYS5UdhRV465lCY1OxqMdIJKUN5utBHeZ6XpejZwzw3+lEw/Q3NCxs3SJ5xQUM98rTxng2dzdl;25:3+jKSLdQ6MjmL09GIp9N16TJYy4FzXl+CPG964XfUkGb8+2HOVPLOTm4icZFw1w5D0gNTrQIeVQALs8VeqKwsP9IccqFYwqZHxQ5XYVTBQPgttDqXzot2uKmTaNdto7ADlJEKfSW3Ir7btt10WY2t1Ttu6u9Zq60EkPb6Dt0H01oA7SOCa+qy9qpB65X+oWqVx99MNb0EM3i+u4zbtdWiC5hmVDizAhmTyQIDpnncxAoCN23ZEQ8seT2jE3LBFlmLbMKJovQvGsMbQdHU0fIqZzEfCmEttTo81db/DM3S1yWPwE/5KokIiVqxrZKrwzj7i9dT+ULYSyB58hS3PTGRQ==
X-MS-TrafficTypeDiagnostic: DM5PR01MB3211:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB3211;31:7TvF0CXF5Ret914xCRVIyZbrthJcH/srW/DLdaniDpebbO0lNeXdplHf+Pnb/hg48m63+tS7SxB7ehke3MfXGGQ1LGX+ibmHS25HqGMf1ZrdbISkwhJrDiRtRgNLswwc5g00zN0gS11iJ3e78cu0imKfvhOZXakRh+IUzA4U7U0rDhN1+x19or4sTajire3Po8+gXA0YbRsuXu8LKtIuo3B6dWpHS3lECdYkryBf+0M=;20:ebtY8PGy3q/R4q3Ij0hY63EpZh3Dh8aCrNfnnawHvxZ+1GbCAMuagvo2FGLmyCAQQu6Kvdb9f2d26TXfchzVIiCsA6gcj4z8QHd/VDXadNsheHS7Vmdkd8vKUR7DihCkg1MYi62gGZ4yroS4MYpqsdMmwGT/+3r22ZJMEQv8+jb43CppTBhPY8oXx2yJqZXmh7hrNbp5Gvteg4b2RurIBd8RuMrJnp03brA60WpfBQDPdVymPIl0UMpb+vqOfKXCeqdVoGAVEu9GTpxWWvljtpiIbPv4bOQnG+ZAx7xwdEfyrhZtjbxDEDvRl+F1UCDFLTFI9eNer1feZgp1ZrcxeL3J6nbLNcWgu5aWYQjROZrSyt0jhhSrk3e7tJh06v8W6MKZbxzot8mxAvrWigmb3viI9G982pKJtyvxtbEMI4/CKnCgElKkeG6OwBwI2zZeDocfnwQYIDmwmTV6zd91AVbIqtNmlFqNnACzCduBnYDSIEJLlDykaKUjB0hcYohpE6TfGaf4jaEdkeIduOmQTZ1Z2LFh6OUOsjPhYr/Mv+zuEkoQGUkA4Jz05jhFNVUfDZEpYD/Zh/B5/msJFx3DtHtT0iRsn2tRzPwBB4RyFuY=
X-Microsoft-Antispam-PRVS: <DM5PR01MB321138871B29B25F029D55E7B59F0@DM5PR01MB3211.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB3211;4:RQzmg36BGgth+Dp53Cu8UvlpLMGF+g3PK87zsGx0sdCa+v3pApClsj7WZfGPMkZNzK9h5CFBY1LTUEMbJzk1FTFkr05MRZLF7j42+QvT5G7lYj/9hNpIFOm8sTkEQJX1VNIr8sXKhhkw0kB7gtUWvzPP+v1mVdxOc8/63yCqGn6cVRsKIzWxj5iCIV+K64HsMZCStH9Agn7xdsiMYyxe7aDH1prcAHpi9nLrkoFa+G7UUDe5SEW6t3ETSX+Wklhe6bpzJBB2C3kES0sJ0NmvhkxiNrQuR9Au8cEVZEtn6UeCxgec3lfyHZbD1PtOoqHG
X-Forefront-PRVS: 0924C6A0D5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR01MB3211;23:7Zhk9YHnFFDUcuU6Hb9Z0PKxybUMsd5GOnieEv4oT?=
 =?us-ascii?Q?eosFwV6wME8+dq7ddG3RyHXasFoSR2YMWeTpcKUniUzBgPN4bei37mzpSLqk?=
 =?us-ascii?Q?/2zQuC1ZYxBjgdkEmDxzebcHSuuLp9/RI8ZBA8xI7PIdZIP4/qNzj55Y+gMb?=
 =?us-ascii?Q?3GuamgkGNeWvebMJY5d/J33w9gxYtrg5NH27zLPOqFZ8+Mnx7iXvrL1FqZzc?=
 =?us-ascii?Q?kpTMXlCWAoXxUGIuBOs9NhOAEtN6J69NIMd4YxSRlhuxBy0OfJeUKnKROSV6?=
 =?us-ascii?Q?x6+EdPkbO/nlWLUZaRbB17xH4eIhRKJwyteE2yCgNsHJSNsGCrGHg9B0Chn9?=
 =?us-ascii?Q?Z1f0amZi+Thc/xatKVx8soissilGKHBpbJJnv8NmuPgDdq6ke7c5Efj6oE6w?=
 =?us-ascii?Q?bjB16dUlrezrX0UyuRARICU2JPfuWK2Rd+qdPCYEeqhA7PcoazpDYL/i7kXE?=
 =?us-ascii?Q?ifF8CEnVowdYWvng37pwEUbgB7SvBcZdFN/cEtCwe/l7LdIDpjSWXk77CZOf?=
 =?us-ascii?Q?nb1Sz6L2C7vgiDhpXvf0J6gY0P7hGh++QIZSFw6NNknacNc43UTxomP9rJvt?=
 =?us-ascii?Q?UB1gQBDOOTV8t7D8oY2iqIgjdaLwVuooMuJ/ovS9H6TQn0UcZ/1BN0p9X1Ds?=
 =?us-ascii?Q?ZDpctNmtotcP2yOosn4Yw4AqyLtRwkfO9TYA8GEAeAfXpdvrwwc6F73pM42d?=
 =?us-ascii?Q?xULAOCh954+xKw+TyvT7vtUsGVpsqAm+5n6Ie98dhPBTBxmp0KvMSgk/IYxh?=
 =?us-ascii?Q?MpOMBFVv1ft70ReSv9pQ20lQdY2HbPLatsj8fZ+gEEe2t1TyLOudIL7g4uFL?=
 =?us-ascii?Q?lBQ3jCsK1vvLotYeXZsuvaHo4zDwyMOFwxwGEWulg5ccSUu9Ptsjf5sNSOXf?=
 =?us-ascii?Q?ROaMzdzLxkhwKG+JZMTfykMVOY94Zk8VKAYZPv8B8AusZ+Nz75qaTzqsiODd?=
 =?us-ascii?Q?/6gjxVG46oLvh+KZyq8QNmArQVk1n9zM4RSfjHzdv7/KSIYhkBPq9aCQueQU?=
 =?us-ascii?Q?ZogYfotZZzAJYmO5RczI0F4fjIOGyp/sdY1rWAP9Z/kwd/bhvaMFAbdrkdeq?=
 =?us-ascii?Q?wyWZ6Pns/W8a784etiPI/QJUqSS6/AsoqSKSvddDl3j5cY2NQdJjw6weZUzn?=
 =?us-ascii?Q?SPBH8HdQGAEj4YMEig78V8pp2u5rjz1SLZB7ogoqlC8RJEbUN3ITicb+8Q3T?=
 =?us-ascii?Q?I86M1H5kP6MXOJXA0uSK1lWMIxXZjyFz27Hz4tk7mASb9lBXJ9kD5ap8RDp0?=
 =?us-ascii?Q?V4NO612z6DGakjBpXRMs1VqCC5hqBsmI1x715Z8?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +NpxNIZriifmsS5Gs4w95LZBd/7gbU46GK+/IAit0U5dG/abSI6d/lLztAhocinFMNPVTiJQgFM1zZ6DphrtGXKgrlX10rIK3UoqjuljdMRxKl5eLnoALIrPkMN0UGHSPevRF5C4+uphqM/2eS8cdYhVPqCeFL1PCIvvHSSo9247glwfiqhy6SZdqCQvC4QfbDKgPnuIw16ICo/FTqXq+rrBr0Ns2K6d1du8hdx8Bi9MHsIEG7l+hcnWdbRqMNjmbUm/TE/UqkoLk6HF/93x8xhNmMo5HYLagWP68gZUL8BqwzCmRhT7mNsHha3vb5K8GE/gAj37Gj+WUWu5oYg3iUeVrWsIK7KVBO3ArjHhI92gJkuLsVNFBtLuln3Wj3KEL1eFH8B8WOyZOhUWZizMgYXnT0Hxtkq1+hCp9F7oYck=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB3211;6:RXkyO6/7wOsH+mMdB6JzQyoEI9PMH82ceB5m3VnMX9GU1LnbL9xIZeMuc4qMHWRakf5V5BX+Opm2jWD140cqVAxqlo01bD0fyzUhh1/J9TL2Ukpuiz40o3HXIz7qywmA0Lw/BL9i1IwpSEGebKfot38+hno05+UhQ/DDKDL5aKsl+ACvP79YP4uIBg7P+c33sRHF00QgTA72weV+/rgJyN6Aa+KW/vGxS+4g8EvQdg1/AMBJcLgLZh3NTfT/hX8nMZH6xLFv92+wWwvia+CBgTWTNEb3rx8dGuoZZg9NuR9hVwuVfeRkoU/ApA2uLxRcCg4DN9SRGbtDz17FJeYxI/+/O8RdeVsSHAzhP5VIBbGKkbfCJ8saxj+O/Gm0Ck5hlmDzJ8WOQy0BD5y7DMRgdibsyIBi/kWjo6fRwXCUFHBAX1+TrAG5+MbNl40Zfe+zqFb2fnqMOI7lMKOmjjXl3g==;5:s2ZjGvd0XCsWZ8oecYF5VVrV5UebxwQDxcH6IxEWYQAKC2j1Dc2xxa4h4TEsdJRPf853QeFF205t2uqXonIL4Tw6FhbmyS3DOhnj2BFRkoTW5+Pl8cNqPswSuDHSXdq23a4tYCX/fPsF1hTrRhUNC2QiVyXhDB4+12MN1Pmq0CJA5yLHeUaPjwvi+/ZXGVyZ6hxomj+6/wYrLv+K+RtV6g==;7:/YZFbOaiiWLmNEOz0A7oeldLMfLwTflisKNURtCAMcfunfkBBnwAg6vDpte9cOHcaEdjTn3oAT1bRXV2elJNXq/PozaVYmgxuEaAMEDErue/ld5wVrUYZ9xZWhBx6P45XFz0U0fHQ5KT3/0MYGPiSg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2019 21:54:57.7435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b028e0e6-b436-4e5d-9242-08d67feb163f
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB3211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:14:38PM +0100, Jann Horn wrote:
> Multiple filesystems can already return EFSCORRUPTED errors to userspace;
> however, so far, definitions of EFSCORRUPTED were in filesystem-private
> headers.
> 
> I wanted to use EUCLEAN to indicate data corruption in the VFS layer;
> Dave Chinner says that I should instead hoist the definitions of
> EFSCORRUPTED into the UAPI header and then use EFSCORRUPTED.
> 
> This patch is marked for stable backport because it is a prerequisite for
> the following patch.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Before we enshrine the overloading of EUCLEAN and EFSCORRUPTED, I
wonder if we should at least consider the option of assigning a new
error code number for EFSCORRUPTED.  The downside of doing this is
that for a while, older versions glibc won't have strerror/perror
translation for the new error code.  On the other hand, I'm not sure
it will be that much more confusing to the average user than
"Structure needs cleaning".  :-)

The upside of assigning a new error code is that in a year or two,
we'll actually have an intelligible error message showing up in log
files and in user's terminals.

					- Ted
