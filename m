Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F7C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FC821736
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="SrFd6+K8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfAVABv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:01:51 -0500
Received: from mail-eopbgr770137.outbound.protection.outlook.com ([40.107.77.137]:1376
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfAVABu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh6iNnofBHg+SfBkz90mSCOXspQU3haU5XylNk+TDyU=;
 b=SrFd6+K8nvelHB0JEqOaiWdq+Ww+wIhnwy9WrsVQL0U4ftn7x5gdl9H5u290EaYB9SMB0/t2QSt1pYin2ZN4/wRDU0sN9Lcak2Orn4E88ZxmL0P4bbiHj+y/3oOfNBqJOrHTdAVsp8V+x3YS7XzODQM1HlBPnrfMaozK7AiABXc=
Received: from SN6PR0102CA0020.prod.exchangelabs.com (2603:10b6:805:1::33) by
 MWHPR01MB3215.prod.exchangelabs.com (2603:10b6:300:fa::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Tue, 22 Jan 2019 00:01:46 +0000
Received: from CO1NAM03FT059.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by SN6PR0102CA0020.outlook.office365.com
 (2603:10b6:805:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27 via Frontend
 Transport; Tue, 22 Jan 2019 00:01:46 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT059.mail.protection.outlook.com (10.152.81.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.11 via Frontend Transport; Tue, 22 Jan 2019 00:01:45 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x0M01hAX016639
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jan 2019 19:01:44 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E940A7A4C07; Mon, 21 Jan 2019 19:01:42 -0500 (EST)
Date:   Mon, 21 Jan 2019 19:01:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <kernel-hardening@lists.openwall.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] tty: ldisc: add sysctl to prevent autoloading of ldiscs
Message-ID: <20190122000142.GB19379@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
References: <20190121162642.GA2944@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190121162642.GA2944@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(199004)(189003)(54906003)(126002)(316002)(16586007)(2906002)(4744005)(58126008)(50466002)(52956003)(76176011)(103686004)(42186006)(46406003)(6916009)(336012)(476003)(36756003)(88552002)(97756001)(8936002)(229853002)(75432002)(1076003)(2616005)(86362001)(90966002)(305945005)(6266002)(6246003)(106002)(186003)(8676002)(786003)(446003)(47776003)(486006)(106466001)(26826003)(26005)(4326008)(23726003)(36906005)(356004)(246002)(478600001)(11346002)(33656002)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB3215;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT059;1:T7C1fLkOje7QZhk4zsGvEUm/RlNlQYBx3i7hf6rh66isAuKfSS6ofeTMf1QBEBdsevup368JTR4NfAUIVzKeLESWrQcPPNV3cdFG/rLfMaq3QDu73+H/My+ZS7v9w6D00AJeHskNq6oJDuKcV2yU/PCjPD3uM9/yXB2mBaF/Hko=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0c8a6e-6b69-41d7-71df-08d67ffcccc9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:MWHPR01MB3215;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB3215;3:MhCwskRDlG8tMjct3EHZaxAZuNfkZFCCRLsANNBpCx4hxHa6RTOf73Rf8SIkoUn+IfU/ujaxvYLBNxxHlXXA712zHs+6gAfdGIaQpEEmT/Z7kCpDkzOek1pPfASd/eIBHEHisBjpVB1+NOX28j+lrvNWw/hdQxysYpSUB1WhJmas1iwtzeULKyxONMOz6z5baDLncxt7J7ilMmkowzY+PZenkGhlge9QT0C2WP30bV6K0hUgVWu15i8nCdT70/xQ7PHVFwTBBIHfyqdNTVGuZl1VsHJB2SswPrq5qa3dGQxFCiL+S85McKRJnQGw9Tm/OPGPc4703uCYy9AvW2JO8e2TZUh6PDm1GelZddLLr0lUvmkJYNrlhr0x25iYnNB3;25:X89HCGxAiGhQEJBrztVE6TtI+CNz0pmTAK9QoEZp/xuJx+IWpYGtZndkX3wvf/+wS0rpyK00bf66CyqVzYN23Xysl4FCS/iigfNMz5aHYPWIWiXiyQP2vl0zhEdtBkDTtYYgZqHhTRdsWzIc6H5NBJVWdvlYiHuFxcppJH+f46N+29tus/ScrfV2+G6/rBfkT0aX5Usq0Eoo5LOVDRv2bHCNicQvbB9SWX0lm7IwRbakClpR+IQBYvqlkD/64st2pDrlog0CAF4dZZQdbTS5wY1pT6wxZnqmVASZS13YLdunB3BqIiz2oHqabw438QtQXNebDZ0u61m+NpZfAddnhw==
X-MS-TrafficTypeDiagnostic: MWHPR01MB3215:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB3215;31:oU5T995AC9oWybsovPTWTiKyxdKtHhb/uTXmRrCIqnAx+9RROVP0AKq5BRpL9CzbuDKuCJO623ZtnrBWIGZQTTRrmMOQmxeJHSvkUnjJDg+JCMcvPoc/CwyWnk0LpuK6lMk/nKUEgkDiifrnV1gy59nyciq/1L5Kl/G0Qv6x3yeyeOLoxXyqsGqeAf4FzJnT6/9VVLDTUwbf972vnmTEU3Ii2/th4y95GqWrm048FIM=;20:IWy4RteRpIZt11ZUQvpcekls8qVAnTmSHriXiu/YI/h3C2OSp4FJlGRu8PT7z3hXefFyszgKtkUpFHC+uNRhb8tLHN01ebJVLHiLbsRenTFxY3xUNqphOs+hsEQ+g5LqvIzK9oA6NN+cI4TEDFIRr+gLYeclB+PAMyI50nSKTuZLDKa4vpllFGgdLRemRbAwEBeQTQCgrrO0efM/GDI7WD7wW1leSN7JaaRtQRm+AIMS+eAy3neIGLNjIZc5LxLNWW5mXWlUIEurio50HIzD83ZQrNCvhsHLTWkrYotPZeHFP1vPxUhGGgPg8eqaE57l50OuzcMMHAbvbfvr6ccm1tJSQtYjKMbg986T+U6gxEBsV5z2CBdvrTiKRkQT2RpGwSSDjCInYPeMlAOS/NPpEp8Oa1DN2llHWivxZpJbiyrYs3P0X1AiJXY89dn6wIfjMrVaTgGLxQDlOSyckSfXsIDDrOEgwEmCCbX4uQ0SA1HMvhI89YCVqNd73l0LEqHaepVSfUx3orgcp4SfDFgd+gVMYh9aSrMXVQO1lN9NSj9cQ46KbQ/aI/2JXLLYwVETMpdY8w2jgaTYAPrKdU/IP/BlDfTEOuj9sTgLeboPxhI=
X-Microsoft-Antispam-PRVS: <MWHPR01MB3215A6658CE7E967B5A2FDD6B5980@MWHPR01MB3215.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB3215;4:pAdo0esLxQNNMSh3YaPM0bYpMUcGHFJ+GNtw+irzC+XMDAvFhbU3ndlNUVX0EX2xfilGWbyfVNZ6xUDYAuiELgZhnF3iOIrZrJh53tvPONyzw5Tnofzuee+T56wasIRpt7VedhXLLhLj9+FPbLjvTHXVmcgzX0VtW82GG1syU6Nnp+TUu1BlpRonmzgY4LBhE9mp6EjLlEGbG/6RvIPEoUliLJ6SP6qDdpMRRQvYi6q6OZ7TvCRXxbrtO4S9T6/wrWnxmJosYmx5CXxmSJZIq62cgBvOvYAorabKDQsfH2jdtJp7D1o5vU0cFVmbOT0i
X-Forefront-PRVS: 0925081676
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR01MB3215;23:VyF6Ns7rwM/eA4WTk3v8J4WpH/SaCyy12wPuCnZ6i?=
 =?us-ascii?Q?HJD1ri0w6bp5obSf9tu5PfUZg7ub4jZ2D3JCIPSBm9Kz8BYQKcQANMSNarPL?=
 =?us-ascii?Q?LkZYPmBP501oNIPM2zztDEu9qWkWvAv35WLEx2bqfh49nbf+7K5GLnPqipLJ?=
 =?us-ascii?Q?RMq08fOnDKuSeOlAgc54MdGcmLJrz37RF86L40EVdjWNvW4ikaXI1ylYpF7M?=
 =?us-ascii?Q?RQhMBqEOemBqien56yKIeqekzXD8lb9x6HywXjRFfmysqZCs6vSdlp0h3lSN?=
 =?us-ascii?Q?rcAGeu0QsptYAerZkT9q8+bVHFTrywFhkIaz08ChfkmYYiMYlt0H5ujSvGeO?=
 =?us-ascii?Q?B9YN7leDCn1O5rkL5EVJ6bIWWk03tjS/9/ehJB4VxPsdRqkWYlL/MU7hVOfZ?=
 =?us-ascii?Q?1pKLmWb1Jg0b8WaF6mNiegVlZmuFKYxqYoXLneMSxD636qZRA2kue5Pf2thX?=
 =?us-ascii?Q?isjOL3jQEotDbUEOYDFnbsJt9HdrSQSyecO2Veaf44c4Ij1zxfOATfupSYS5?=
 =?us-ascii?Q?jav9IuQIclUzVrzMZMFTkVu9eXCewOLcpkROhGmk4NtZZxCdtswldDZMerby?=
 =?us-ascii?Q?ruEGXHSFTD1uQH79Bjbi3RP0WUlsoUb1o38fnX+R275diYGPB/B6C9x9BlBw?=
 =?us-ascii?Q?D6pNYBcDHiwNoS36IujH9QR4/hGw1rHPQ2OoywH3V0ELi+HbRyFp8PbkRE2V?=
 =?us-ascii?Q?eP7QNZS1Q0PonqmqEqNMHEC8rW9vECmUmoRTj/cY7I64ZaRK4P7RsIuOfisf?=
 =?us-ascii?Q?Oiba4kS3E3VsYzXnms0KQdZ1gCj7ozDBgX6Rc0NG9Vn0VGw4BRPPnLbPiQwr?=
 =?us-ascii?Q?4+xZudtZf/7bGeC9mkTfn7IAtJUICvyPzgTETlZKDcIsqs3nUUlStiMnhU0B?=
 =?us-ascii?Q?6J0DXNN2mBjAMIafShZ5vbH1H/0oBCRfynx0eS5bIcSmWiwxfDTwEc0Nn0gv?=
 =?us-ascii?Q?029yon+1GJPWrzDCxP951ZxGLaZDhKvmV2hmfiorOAqerL9veA+pWXhR7O4L?=
 =?us-ascii?Q?MET54cIxjmrfHk0XqdmCtHVuVv8kigp02+xwtQmDvjqjpmP7vzfdb6AkNFbr?=
 =?us-ascii?Q?he+fWj4gYlwT/RDH8AaFaJse1srdP7N+oUfzBuv3OK+qhJvnKv3M3pSzfu8m?=
 =?us-ascii?Q?dTAfIpuJuLf1EyDOdtaz99CaoBCbOoUkAy1Tsmr9zbHwb/F+a8Mfj+hqQvpr?=
 =?us-ascii?Q?sPkqeWqefKQXjwMKFMQ0qeR/mEX0Ha+DS1lrwxVbzd1aJDGzfwmmP0tsP/aG?=
 =?us-ascii?Q?6nVG87LO7KPEjTWsxY=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qav36t3PYA9p/f9hQljoMLl/U29SaCn0COeEksmk5bwnN3OvfvpqvZpy+HOw5rhLFTELrIiBN1p14s6T9ZMZuxsT0VQpcr/Ir97QKMLNeUQb8HIY8flD8bjXOEmXkWf9XW4zK8npJ8V5WL7Rz+GuMz8KHdzZzkg2c+Pg4GMjN/Jr7oHotWwdJaHp4s3w1I6EstyXeDYLnn5H85QoujPC/DxzNPRkQ2pFJJbL8ri5yw/dq9/J8Rdr7i2AF+MVpWniR77pSU6jpS2gMNHFcB2sPEZwuoYKPsYI9lS8vm6zm9vPVnhpu5xDW24nhBIafGZ4I9B5Ee8r8XK9sGzK0IOx6KkY2cXuYhwvv28XEJyYNhf0sXAGkHjoc7IRKkKXTiCypF8Z8YAm3S0wqpAPJADbtqUbMOyiidD4d5UgThWWOHs=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR01MB3215;6:gEr6GUi6f9frmYIx574qh7Y702OqriXrSbv6q9QWwdMbgJOicxGyw8ZIujAH2bLN48F8QqIsYeuXv+9Zctyyi36/+XgItX/MrVBrYcElvmEVBT6arRJ1xSVjO6VDcxREesldFITvVT37jvMiSXOjkAVDFDRe9Tf1mqvFJ2Z7Pbvc9M7se1l7xh5HdpnRPkecHMX2xNwZ4oT+svtsOlxauscQYGrz/ch+ojBjOj9SqmBIh6nLZoWKS63Qiq9RwXvqUMLZGYIUjLd4NEkGZwlaJ4L1Tj3hn9TaX81X1dN1d1rB1nKNaaSjgVutL8GsviLDFLkaM25tsRjP/S6T2IPtUxnN2ecSGlQiS4HG/jhoDg8OUheHDjn0svDdxCnBdlD9q4k8/2VKdQ4pKvMKJLJ1HfJzzMVhy0SG7AOso1dHgRJ8TJAf8QWtkAz7N3CjC840t31e1+5rg6bVZiyu4KNisA==;5:JQkidaZad5NRTScw8bj89fCYBJaMCktAdE80FfjoMvd7h1f0l7OGNG+skPrHnG4NDjwJM9fXli8nHzV2OMUeUVCN5OV6gH7XpNjaHInsgBIJRV9ndGIv9cN2Aext/JUi08o2atWzkv1ZK2uIXmss6fU1ekbEsJ5NfqzKrMje3QIM1CcCulFXaksDjTOWbA2ESVP2dAnL9ElCaEc/ot2Urg==;7:k0tFRvdyjnQON4EPuS4Pv7BM0HCxw5WboWKtjvtWOd0rFjOxETGNNDh5BmxzvQe8VqDXx4vbI5qW1L66eSWA7BzlBoHRd16x7faOwwG8KZb1d0pRbwxD17jYwaEQazpCNldPgGNEVzjQa/3IA3sf8w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2019 00:01:45.8275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0c8a6e-6b69-41d7-71df-08d67ffcccc9
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB3215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 05:26:42PM +0100, Greg Kroah-Hartman wrote:
> By default, the kernel will automatically load the module of any line
> dicipline that is asked for.  As this sometimes isn't the safest thing
> to do, provide a sysctl to disable this feature.
> 
> By default, we set this to 'y' as that is the historical way that Linux
> has worked, and we do not want to break working systems.  But in the
> future, perhaps this can default to 'n' to prevent this functionality.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

