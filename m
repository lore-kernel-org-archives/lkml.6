Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C9C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D96B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hiF2ievu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D96B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbeGSSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:46 -0400
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com ([104.47.38.52]:30491
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732550AbeGSSnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8J685Z7HFn3i4A0QUt8w3qTULG8RO+jYkt4/c8Jeo0=;
 b=hiF2ievuYPQ5uSiO5GUqWPXqrWOegJ30/vyWdRc45GdBDugfmT6efxO7m9urNo4DuVG4duD+4QNxvPBWTkXuUsBthS0N0A/GgIKp1GfLWgCh22u4LOsp2U+7c6e4SZdWEwmJSdiCVbDZD/Qk8UqGHkZAtrbXj/aqPQU6SXd4mE0=
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 DM6PR07MB4714.namprd07.prod.outlook.com (2603:10b6:5:a1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Thu, 19 Jul 2018 17:59:22 +0000
Received: from DM3NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:22 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT006.mail.protection.outlook.com (10.152.98.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:21 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS7019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:20 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:29 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:29 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxDCF005866;
        Thu, 19 Jul 2018 18:59:13 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxDVE005863;
        Thu, 19 Jul 2018 18:59:13 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 17/31] usb: usbssp: added implementation of usbssp_halt_endpoint function.
Date:   Thu, 19 Jul 2018 18:57:50 +0100
Message-ID: <1532023084-28083-18-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(189003)(36092001)(199004)(76176011)(106466001)(1671002)(105596002)(86362001)(186003)(36756003)(336012)(26005)(426003)(8936002)(48376002)(50466002)(446003)(109986005)(107886003)(8676002)(16586007)(246002)(2906002)(11346002)(4326008)(316002)(6666003)(42186006)(486006)(356003)(4720700003)(2616005)(54906003)(476003)(47776003)(126002)(305945005)(5660300001)(14444005)(51416003)(50226002)(7636002)(26826003)(87636003)(478600001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4714;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT006;1:kipMj0qFjkgPz+7zcjI76j2kamftFRC7QRxKV3WUAKVJp97RdyuydnxE59dlKDO+IWxpIHbz2knNgacym1nzsuXe1u4FnXSyPwj+RMlpXiq0RPUjQsvGlLMVGzh1XBVa
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2589c8f7-6091-4345-0870-08d5eda15b71
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4714;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;3:8/KANytmVoZnntTcKDMrHro0Y739oSnIeSH03VcIaTMkD6moNK6o+qkWkRfvi5yX0+CkVjzv+Xjc4CoQCehBdSnEkDqaN2B4LGOi9D+Tdw9nLOUdXEob5/xg96b3cKEGPxtoPkbR8H/Cy60S9nVbGtdSZWoPSf2Kvi0+0By1iCprhR5FHiUyxqMcsP7oF1j8xAx0vXSaEloJ/bBVHXIU9VWdKYbLFoW1mtcL/67K20Ee6CaJ1t1p4tSP3L6Y4nsNaPl+Kp5/lVO0aKdrGy7s7B6lIp0g8pZTT9A390IRqDa13tAUA7l5nYl3BIgRVtPinCbIcQCY0MrnhYiW+4hZRUpCC5czPT9Vb67n36Rw5Kg=;25:iF4YZU4rtgJKYAyIiXr4UCaqcIu4NappHvLDTUNbZzcYszvkVztvonsx+hn8UAK3su6g8HXSQktZq5AR8d7qdSakivGqq+eafmirqskK8Mu310pS3GOQ0I0BhaWIgH78T53ELoIwVEls+fNXlDt6Mh2huAGI0XdFa3lKmz89lcsHyvOFdccnmB8PGSmeY8kWXGxI57B8/P1Lpxo8PFbFQQjCFwJ0M150HKAYKJhFnQtx7+VOvJqz5SR0uPUhok9clU8gb63UmeIKt0Vac1x3Th4buhLupBS0wAe4B0JTcaEj0ERpJun4gwSJ6DFtiUmoWuAek3lGCvTjdlskzY4fWw==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4714:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;31:CTzSxMGp5FIlw94W0n7En3y+eZZpcq8HPihXvKWOG7FDMyX4uyuedIFsi0xFz5EQWyGvUWvbBgG/Y7xJoy6wV5wyZW5zWjzw81ua3cUNZ8qpLgMZHw7BkmZuCn0GfapoBJOXuDqeDrypwLZO9Egf7aSSnW8//tzXB1TiCDHZBS9Wi/NeYlNTaTGAh8CvsTAuSHYFgkjkRrUREJlCl/wjfAdxVN7UpbjH28933v/AxzA=;20:JXEzU6yjANNNqqlfGbY/iLobaQhmCAxcfIeo+gUsWXG1sqMWdV/aRs9r+HLVeyaF8U7+Ee0iJm9AuxwfVQGJ0nVGlyOWsGuxd8KgYZUjCHZ/Wvg57lSB/a1qbntCa1gbnSQz8zmk8e+ajIww98jUM75rVoXhMsJTpHVY8KGlQjFkFZHd5eXn7rSrSB68ci8GT4DtgNVIRovMGyVEzwv1qQa8726hcEGJgKMOEfYgfWjoZBCG1GOqn8Oii+M41r8zuaGeJAaUDUeP8r3sBUk9shZQukDHTxdT3FNhAOwraC50bmQ5X0w1RroLIgfaJysckIjYyY9UKMUJArshoPT8lTjq7UAGUNtiOfjxzooE7iOkPtCdvwhawchEDAL/eD0yVKasgyyYujUFYpVxzO/2Gidg2BYj0wZr7kweCosg/844XHdLivbyE74GvpSWo5BGHym0WefAxExY3VZWqHrdUXSeC0Rc23n9J81cyNnbc5DL0EAbmCJ4vIcBqn8IMUmY
X-Microsoft-Antispam-PRVS: <DM6PR07MB4714F9EC8C959F35C77378B4DD520@DM6PR07MB4714.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93003095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4714;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4714;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;4:u4nOkVbzfvcd0bmBx4ZQge+oRMT/3YlADwyyro8qiyhxItyNVcdjVRm9bqjGZHLhLRwcHo4pME81p0QnvCLpnJ3QSfYQNHHJijW8vG3+f1DUKfxeLe3xJvEqmg+PSuKZdJJgte6HNvui2toLdQ42GVI/FyIGJcI3tl0ITf5wUFQbUmYD8/H+X1Fv/mhqvgfwJIwP42TGI/vQuVN48t8GKTHQZEWNb6dVHoa+DEd9mtdgP/9DaW8hauwOaaBojp37hihmPp+TvOiUTM/tV4v1rB8WihR8hrdLZORzhRWFTcFe58oeOoM1dpqfJreDOztJ
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4714;23:KsFysPCOVEjj+Q3ojDjmsRy9iWSqSqgTXywz5Z908?=
 =?us-ascii?Q?NtnPgylNDVnbDJ/D1hjSYvWScX/2g4PMlwyx2ZnBYXE5dYrwjIV7Zw9cg4NM?=
 =?us-ascii?Q?tlTWnKutMXRgBEOGvMyBPL4/5/7wDXTk8uTdWm/V4ygtGX0YG6wnHKzR5JGX?=
 =?us-ascii?Q?oLsLFHEU0KJhxbi4gNikFUNASScPxfRa5gybpeNcsAytETTIbrQAcIy22LdP?=
 =?us-ascii?Q?Ln6mM6Vjfzrt6jp1qPqeZO/JxnZBiBkv+5QCgZaw/krBxrB86hfhZS6yw4eJ?=
 =?us-ascii?Q?VT67AJbhhRQvH47oUIM0uumqLrqQQtKKDtYZ9+7Y6dtsjEIHPbjT6qRWil/x?=
 =?us-ascii?Q?9fXHn/eD+9ukFFy2xxF2xgIjqzCYtjMn/uNxUF0ynWgHISCJptKAmeF54XQ4?=
 =?us-ascii?Q?tn94cp+SxRmNVYcC6bP/3G0JckN1XjLblhM5FAC9OL8zt9QbmlCzpg2kwU+2?=
 =?us-ascii?Q?kamwyxxtgT6vg6YSc3kZgWSLDn/RAk+LcBnoqUdysLKyGc+h/6odyEYgI6uA?=
 =?us-ascii?Q?i7O78EGF/O9KkaXrhnrzdRKpD5+6hO8bHe6ZhatAY5QeGUtofsrZRug0lCzX?=
 =?us-ascii?Q?1TQc+03N7h9eWcHth3SKA9AIwVIZLDxQD1B5SaFMpNpPWvlQbLKv1TJvFRTF?=
 =?us-ascii?Q?DE7u3A9miXcugj4yuzHq7IxxJmJEJJZpF6FkUqT4+ase0qOPv2D2ykXfeU4L?=
 =?us-ascii?Q?y7oL3g9u93GuzHtKdTdKmf2rF0QgfHSpw65XbdpdVJaKdSWsMSjaYMOrSikc?=
 =?us-ascii?Q?S6lOzQsdGmRrrM3XVHxPGYRw6gLHzShgf+Wazr3wC+rEGQmuvT+D7CFq0IgS?=
 =?us-ascii?Q?KJPRUIBW7IVstq8/6U80uJ/swHesLxtEvEDiikiOTI62xWDxDXLsTZ/B4sbG?=
 =?us-ascii?Q?mkaU8i/eEfuVA7cGQjU+d3HyWruSQbwUV48QKPSi5Eb8A8G2WbU5gnCjP/Ix?=
 =?us-ascii?Q?uZiCKvsYLo0Z5TgO1KeFiuB9DuzIaBJEv17nPe+al+g+kInHwOKdx2IsSget?=
 =?us-ascii?Q?s3CFBDdPzh8HJdtjQP1US7fz54zMc6ns1L3c8rvrjCwdbEsmPjJa3LEQ7g+X?=
 =?us-ascii?Q?3il5+N2GwaxQtNWuYjOuSIEsksu6BuUK1NSRUwIzEWBN1h7el4jfjjMmIOHK?=
 =?us-ascii?Q?u8hRQ0ZCLLDgtglo31Jp97IWPqxc9AykEl6D8tLum0p37+8XNdzPQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: +hyslkR3oFMney2Z0rK3tSViFvZOwTFdLyLitnzsnHkbbQL5c2YpkI+l1Xu/SCphs4dbQfY7cMGM+yHkE6/xRN2uL36aUMQAgGvyFDngymTqQJem6Svg2KTh6SCblfG/eMQCvvZKXKiM6ZmfMytD7oGaTQ1qvSeVBY+irHWNBE2sYBX4Iv26cerdsPKJjGGwtcydMLnjPxtTSqiAcknMM84sxFOdCLcUehnrTr83Z9rdTnoLkerStywFwUIj6ckG8KHQ4Ve5hE6BadUr7KoBkViZD7q78ICFoYrTi3xObjuNTrjovjpIulFF919zvbPrWrTvnwGx8ynZ39fR0943lqpF3dUwr9cH5AZdG558bOATZo1/H6VmI8Opmpzkl0+gO4TnDpix0S8Ag5tducamhA==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;6:L2lY8vti8tmhigy1xY6nF/ggxUsoWWOSacXV5sUXFup04uFle5/RUUbHwhbweYuO7ztsD7XuHrUMCVDS3b2CT5Plu/S58/klCyuuYIApSXtoqkHEj50TMeL8Nb7Qu5WnvxbZcuFp+MbBC8YHkbHeBPSGXj0mmXaj0GnBTHLrZ8Yy8ousOIdjPKYdo2FCX6nndlrG5YO4II2w5QT/ECqgC80gm7IQavA1EKWIXKgprM1/wWQo8pqnteH+fsqDAox2Jugm90RktvFOo5xKaIaRV3g2EKTDmAUkq3r6HbyPPMOGLht6FJM3eR+GpSAOoWJdeYhJMwcH1z+bm2As0UC7nHlHVO4lWRZfkxwAPwj0ojj9F4iLu4FzclHCo+JppPaKyEFc8VjIUeTCh8yht1RT3U6ToP0FnBm6zr6vGAfDGScfD2Tz0DorBt72Ol0d2O57frQ0xjN7Ht7AkVO82ISL7w==;5:m38zLC14gV8ah8IbAEBAHHIsxzrJG3rcu85z+1RzhZ9neUWHVlxAnn8idShTFfeQfSgQV4urGrIezIG4yd7KGOiqRnHvYXMKvIrz0owFwr7sjM3JxlfK8WR4qBrOTX8jLlaWi7C85AUs+C2BSORjFJ0/b8UxCDI8rG5+ZE0iamI=;7:+bNBX5txaKIVP01LJc72WCMQwRBMwK/wnk9jzaFcKS66NTS/kfIR6VxVS6Zdr+t/jdX0rohINMDWRDtqwqftAL9E9B6RzQpPNnZVaXVULXC9+o9SrozBa069NV42+MAR7e87bnMtIrwYn6i6F+szi70lRP6jXBppKeno+EJJDgsdq6pCMJ5ODJ0lEE6Ap3p4xEgcJWjpC7NqaMDDHox7J5j50aU6YnmD7LfO1sSEi3nb/4vUuFHy8Yxu98sF9VbW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;20:kSvxHH2edwZ5vl3HOjCwt6mueNR3Nb1TX9uqZPwexJB41LG4187FET7wvgxtnxMEzbWyQZLb/gBQV4lSBhgC7pE7yuzNqQML4+v2aqgqjnvOdcWrLpM+4rrFpKLiedlyEM3iNZv1O7wPVLVv+xVnyAaXUKHsn4NzIXTKv53/KUk4TL7laVxWW4/Fr6eWtqo+FTZiyscOe8TrQkgFBYhjq3dpek5qkT2WdQtbgElXEopIbkK65lEIzZ2ZZkk8hoRm
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:21.9163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2589c8f7-6091-4345-0870-08d5eda15b71
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4714
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds functionality for halting and clearing halt condition on
USB HW endpoint. To halt endpoint driver must first enter it to
stopped state.
To stop and halt endpoint driver uses Stop Endpoint and Halt Endpoint
commands. To clear halted state driver can uses Reset Endpoint command.
After clearing halt condition driver can rearm transfer on endpoint.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Makefile      |   2 +-
 drivers/usb/usbssp/gadget-ep0.c  |  23 +++++
 drivers/usb/usbssp/gadget-ring.c | 129 ++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c      | 152 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |  17 ++++
 5 files changed, 321 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/usbssp/gadget-ep0.c

diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index f867124f286c..b267fadcb104 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -5,7 +5,7 @@ CFLAGS_gadget-trace.o := -I$(src)
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:= usbssp-plat.o gadget-ring.o \
 				   gadget.o gadget-mem.o gadget-port.o \
-				    gadget-dbg.o
+				   gadget-dbg.o gadget-ep0.o
 
 ifneq ($(CONFIG_TRACING),)
 	usbssp-y		+= gadget-trace.o
diff --git a/drivers/usb/usbssp/gadget-ep0.c b/drivers/usb/usbssp/gadget-ep0.c
new file mode 100644
index 000000000000..c889a3102740
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-ep0.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include <linux/list.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/composite.h>
+#include "gadget-trace.h"
+
+int usbssp_status_stage(struct usbssp_udc *usbssp_data)
+{
+	/*TODO; function must to be implemented*/
+	return 0;
+}
+
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index f3ee1c4d82dc..59ba92494a56 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -1082,6 +1082,74 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 	return NULL;
 }
 
+void usbssp_cleanup_halted_endpoint(struct usbssp_udc *usbssp_data,
+				    unsigned int ep_index,
+				    unsigned int stream_id,
+				    struct usbssp_td *td,
+				    enum usbssp_ep_reset_type reset_type)
+{
+	struct usbssp_command *command;
+	struct usbssp_ep_ctx *ep_ctx;
+	int interrupt_disabled_locally;
+
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, usbssp_data->devs.out_ctx,
+				ep_index);
+
+	if (GET_EP_CTX_STATE(ep_ctx) != EP_STATE_HALTED) {
+		dev_dbg(usbssp_data->dev,
+			"Endpint index %d is not in halted state.\n",
+			ep_index);
+		usbssp_status_stage(usbssp_data);
+		return;
+	}
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+	if (!command)
+		return;
+
+	usbssp_queue_reset_ep(usbssp_data, command, ep_index,
+			reset_type);
+
+	usbssp_ring_cmd_db(usbssp_data);
+
+	if (irqs_disabled()) {
+		spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+		interrupt_disabled_locally = 1;
+	} else {
+		spin_unlock(&usbssp_data->irq_thread_lock);
+	}
+
+	wait_for_completion(command->completion);
+
+	if (interrupt_disabled_locally)
+		spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+	else
+		spin_lock(&usbssp_data->irq_thread_lock);
+
+	usbssp_free_command(usbssp_data, command);
+	if (ep_index != 0)
+		usbssp_status_stage(usbssp_data);
+}
+
+int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data,
+			       unsigned int trb_comp_code)
+{
+	if (trb_comp_code >= 224 && trb_comp_code <= 255) {
+		/*
+		 * Vendor defined "informational" completion code,
+		 * treat as not-an-error.
+		 */
+		dev_dbg(usbssp_data->dev,
+			"Vendor defined info completion code %u\n",
+			trb_comp_code);
+		dev_dbg(usbssp_data->dev, "Treating code as success.\n");
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -1408,6 +1476,67 @@ static int prepare_ring(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+/* Stop endpoint after disconnecting device.*/
+int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
+		       struct usbssp_ep *ep_priv)
+{
+	int ret = 0;
+	struct usbssp_command *command;
+	unsigned int ep_index;
+	struct usbssp_container_ctx *out_ctx;
+	struct usbssp_ep_ctx *ep_ctx;
+	int interrupt_disabled_locally = 0;
+
+	ep_index = usbssp_get_endpoint_index(ep_priv->endpoint.desc);
+
+	if ((ep_priv->ep_state & EP_STOP_CMD_PENDING)) {
+		dev_dbg(usbssp_data->dev,
+			"Stop endpoint command on %s (index: %d) is pending\n",
+			ep_priv->name, ep_index);
+		return 0;
+	}
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+	if (!command)
+		return -ENOMEM;
+
+	ep_priv->ep_state |= EP_STOP_CMD_PENDING;
+
+	usbssp_queue_stop_endpoint(usbssp_data, command,
+				ep_index, 0);
+	usbssp_ring_cmd_db(usbssp_data);
+
+	out_ctx = usbssp_data->devs.out_ctx;
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, out_ctx, ep_index);
+
+	if (irqs_disabled()) {
+		spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+		interrupt_disabled_locally = 1;
+	} else {
+		spin_unlock(&usbssp_data->irq_thread_lock);
+	}
+
+	/* Wait for last stop endpoint command to finish */
+	wait_for_completion(command->completion);
+
+	if (interrupt_disabled_locally)
+		spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+	else
+		spin_lock(&usbssp_data->irq_thread_lock);
+
+	if (command->status == COMP_COMMAND_ABORTED ||
+	    command->status == COMP_COMMAND_RING_STOPPED) {
+		dev_warn(usbssp_data->dev,
+			"Timeout while waiting for stop endpoint command\n");
+		ret = -ETIME;
+	}
+
+	usbssp_free_command(usbssp_data, command);
+	return ret;
+}
+
 /****		Command Ring Operations		****/
 /*
  * Generic function for queueing a command TRB on the command ring.
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 32d095b32e9f..4dac1b3cbb85 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -320,6 +320,29 @@ int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated)
 
 #endif	/* CONFIG_PM */
 
+/**
+ * usbssp_get_endpoint_index - Find the index for an endpoint given its
+ * descriptor.Use the return value to right shift 1 for the bitmask.
+ *
+ * Index = (epnum * 2) + direction - 1,
+ * where direction = 0 for OUT, 1 for IN.
+ * For control endpoints, the IN index is used (OUT index is unused), so
+ * index = (epnum * 2) + direction - 1 = (epnum * 2) + 1 - 1 = (epnum * 2)
+ */
+unsigned int usbssp_get_endpoint_index(
+				const struct usb_endpoint_descriptor *desc)
+{
+	unsigned int index;
+
+	if (usb_endpoint_xfer_control(desc)) {
+		index = (unsigned int) (usb_endpoint_num(desc)*2);
+	} else {
+		index = (unsigned int) (usb_endpoint_num(desc)*2) +
+			(usb_endpoint_dir_in(desc) ? 1 : 0) - 1;
+	}
+	return index;
+}
+
 /* Compute the last valid endpoint context index. Basically, this is the
  * endpoint index plus one. For slot contexts with more than valid endpoint,
  * we find the most significant bit set in the added contexts flags.
@@ -331,10 +354,137 @@ unsigned int usbssp_last_valid_endpoint(u32 added_ctxs)
 	return fls(added_ctxs) - 1;
 }
 
+/* Returns 1 if the arguments are OK;
+ * returns -EINVAL for NULL pointers.
+ */
+static int usbssp_check_args(struct usbssp_udc *usbssp_data,
+			     struct usbssp_ep *ep, int check_ep,
+			     bool check_dev_priv, const char *func)
+{
+	struct usbssp_device *dev_priv;
+
+	if (!usbssp_data || (check_ep && !ep)) {
+		pr_debug("USBSSP %s called with invalid args\n", func);
+		return -EINVAL;
+	}
+
+	if (check_dev_priv)
+		dev_priv = &usbssp_data->devs;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_HALTED)
+		return -ENODEV;
+
+	return 1;
+}
+
 int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 			 int value)
 {
-	/*TODO: implement this function*/
+	int ret = 1;
+	struct usbssp_device *dev_priv;
+	struct usbssp_command *command;
+	unsigned int ep_index;
+	int interrupt_disabled_locally = 0;
+
+	ret = usbssp_check_args(usbssp_data, NULL, 0, true, __func__);
+	if (ret <= 0)
+		return ret;
+
+	if ((usbssp_data->usbssp_state & USBSSP_STATE_DYING) ||
+	    (usbssp_data->usbssp_state & USBSSP_STATE_REMOVING))
+		return -ENODEV;
+
+	dev_priv = &usbssp_data->devs;
+	ep_index = usbssp_get_endpoint_index(dep->endpoint.desc);
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+
+	if (!command)
+		return -ENOMEM;
+
+	if (value) {
+		dep->ep_state |= EP_HALTED;
+
+		ret = usbssp_cmd_stop_ep(usbssp_data,
+					&usbssp_data->gadget, dep);
+		if (ret < 0) {
+			dev_err(usbssp_data->dev,
+				"Command Stop Endpoint failed 1\n");
+			return ret;
+		}
+
+		ret = usbssp_queue_halt_endpoint(usbssp_data, command,
+						ep_index);
+
+		if (ret < 0) {
+			dev_err(usbssp_data->dev,
+				"Command Halt Endpoint failed\n");
+			goto command_cleanup;
+		}
+
+		usbssp_ring_cmd_db(usbssp_data);
+
+		if (irqs_disabled()) {
+			spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+					usbssp_data->irq_thread_flag);
+			interrupt_disabled_locally = 1;
+		} else {
+			spin_unlock(&usbssp_data->irq_thread_lock);
+		}
+
+		/* Wait for last stop endpoint command to finish */
+		wait_for_completion(command->completion);
+
+		if (interrupt_disabled_locally)
+			spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+					usbssp_data->irq_thread_flag);
+		else
+			spin_lock(&usbssp_data->irq_thread_lock);
+
+	} else {
+		struct usbssp_td *td;
+
+		/*
+		 * Issue a reset endpoint command to clear the device side
+		 * halt, followed by a set dequeue command to move the
+		 * dequeue pointer past the TD.
+		 */
+		td = list_first_entry(&dep->ring->td_list, struct usbssp_td,
+				td_list);
+
+		usbssp_cleanup_halted_endpoint(usbssp_data, ep_index,
+					dep->ring->stream_id, td,
+					EP_HARD_RESET);
+
+		goto command_cleanup;
+	}
+
+	ret = command->status;
+
+	switch (ret) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		dev_warn(usbssp_data->dev,
+			"Timeout waiting for Halt Endpoint command\n");
+		ret = -ETIME;
+		goto command_cleanup;
+	case COMP_SUCCESS:
+		dev_dbg(usbssp_data->dev, "Successful Halt Endpoint command.\n");
+		break;
+	default:
+		if (usbssp_is_vendor_info_code(usbssp_data, ret))
+			break;
+		dev_warn(usbssp_data->dev, "Unknown completion code %u for "
+			"Halt Endpoint command.\n", ret);
+		ret = -EINVAL;
+		goto command_cleanup;
+	}
+
+command_cleanup:
+	kfree(command->completion);
+	kfree(command);
+	return ret;
+
 	return 0;
 }
 
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 1827781125bd..64168ea16dbf 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1687,6 +1687,7 @@ void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
 void usbssp_free_priv_device(struct usbssp_udc *usbssp_data);
 int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags);
+unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 			struct usbssp_ring *ring,
@@ -1731,12 +1732,27 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 				union usbssp_trb *start_trb,
 				union usbssp_trb *end_trb,
 				dma_addr_t suspect_dma, bool debug);
+
+int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data,
+			unsigned int trb_comp_code);
 void usbssp_ring_cmd_db(struct usbssp_udc *usbssp_data);
 int usbssp_queue_slot_control(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd, u32 trb_type);
 int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd,
 			unsigned int ep_index, int suspend);
+int usbssp_queue_reset_ep(struct usbssp_udc *usbssp_data,
+			struct usbssp_command *cmd,
+			unsigned int ep_index,
+			enum usbssp_ep_reset_type reset_type);
+void usbssp_cleanup_halted_endpoint(struct usbssp_udc *usbssp_data,
+				unsigned int ep_index,
+				unsigned int stream_id,
+				struct usbssp_td *td,
+				enum usbssp_ep_reset_type reset_type);
+int usbssp_queue_halt_endpoint(struct usbssp_udc *usbssp_data,
+			struct usbssp_command *cmd,
+			unsigned int ep_index);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
@@ -1770,6 +1786,7 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data,
 			struct usbssp_ep *dep, int value);
 int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		struct usbssp_ep *ep_priv);
+int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
 static inline char *usbssp_slot_state_string(u32 state)
 {
-- 
2.17.1

