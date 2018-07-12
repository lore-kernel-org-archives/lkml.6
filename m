Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A239C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290D20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="gIV9wuKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2290D20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeGLF5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:57:00 -0400
Received: from mail-eopbgr690086.outbound.protection.outlook.com ([40.107.69.86]:50096
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732317AbeGLF4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al2KBErFB8gGu2kF19VXJUC1ozSso5ncSVHZJMrgT5M=;
 b=gIV9wuKTfX6UgCFoImMVmvTFLRLlD5+q4hNQfqntzxXndNSNDFYJzrvdSfcC0xKjW8Tv2x68uTZDLe+1nK3wyjKnVlC0e4xbhr7YYpeTfwcvSSRXbedZVM2LQl92JKP5SJ2KIj5Rd/gSXM6Li/volcDSJF72V/KARiCgBykWPng=
Received: from BY2PR07CA0087.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::40) by SN1PR07MB2303.namprd07.prod.outlook.com
 (2a01:111:e400:7a45::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Thu, 12 Jul
 2018 05:48:04 +0000
Received: from DM3NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by BY2PR07CA0087.outlook.office365.com
 (2a01:111:e400:7bff::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.20 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:03 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT045.mail.protection.outlook.com (10.152.98.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUV017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:08 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:08 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lqKW029870;
        Thu, 12 Jul 2018 06:47:52 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lqEO029864;
        Thu, 12 Jul 2018 06:47:52 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 25/31] usb: usbssp: added implementation of usbssp interface.
Date:   Thu, 12 Jul 2018 06:47:22 +0100
Message-ID: <1531374448-26532-26-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(36092001)(189003)(199004)(486006)(4326008)(7636002)(1671002)(5660300001)(8936002)(356003)(8676002)(87636003)(107886003)(109986005)(305945005)(76176011)(14444005)(26826003)(51416003)(86362001)(575784001)(478600001)(4720700003)(6666003)(47776003)(54906003)(26005)(36756003)(105596002)(186003)(106466001)(50226002)(246002)(316002)(2616005)(2906002)(476003)(48376002)(16586007)(50466002)(11346002)(446003)(42186006)(126002)(336012)(426003)(266003)(309714004)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2303;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT045;1:eS2nW1akkWHQ7rgyNGkX6r4x0NrJSlBAnPzlc6uPhgn7c2RGzO/de4G+UW39cu6pFb9bi55as2qdZiFhGlxTyqDgN58ZGx1gIGu9yito6l+yw6hE4Uf2MtZwA1O0wZNb
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08c64c2c-33e7-48b9-9939-08d5e7bb08aa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2303;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;3:3JbMxaLAnT2wS4Ttu07ygJPrVXWSnsw/jQgg4RjhjH8bhQOqx5gkKSwI4i/Dbcw/a18CwMOla88Aqs7HjiFOZue5liZgW+qwj1oVVjs4b82yrRNH4Um1IUqDjtNBL0qYT60C3/4KzpIS1Sl6VCssDrUmIhtG8WiYdfOaJS96rgAaAEyriI97mOZ25YLZjbiSp46eiBXGx+Wgx06/x6czJTmoIwVFw9SieJZpvNfaFO4GgiPNRlczYOOCiXjV96T4G99YrfSwoT5zy0A4i3NhS4yf+nUC8g+59H2qkUIsr7urSP7dnKMYWXbZ58FObav2JlWSs3v7Jp6myMO3UFysAI7/4OrI+gFq0EPIj+YWOLk=;25:XF4rCA+dAx/2kebV4XMEPn0mWP/kGDDbU9ACAsA8L39tpR/xkhxFljci/dLpahiBI9H+7nvs5XdEIvqyqxCCLeeM4egsAfFT1nxOXkyjHWk+9dD+q1mvs9IO1R0AoRswn5KS8y0/dF4hpB9lLMTdhR/FQsp5NQUoZ7IdJJEFFx6pPQwHfbl1JTWiQpQda+vRYgJHwOxUdsLAxFSR49Jf7+yGCjpeBYMcFANNggTosy0VoqLEl3ev+fS1t6TKiKyF77HDW6ewabKiF3XInUPJ5D3eHJvRIGwCtus8vRY3NxCo2LAHOIjyE02xu9XBrCqwhkaVbRnA02Z522U9hk7z/w==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2303:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;31:98q9zo/Gf6zHDSU7gZtr9eKBkK53tMTe9CWNZPiwxMffJ7cpkCq8Eb8SvZp5wxUegWLl2Ue6Gx/9v6nECuslkKqB57KuzSyoNaUShlbm34Z3931uB/WnGQyZK3qXWW24SckMvJiKAGeKAm54a3hbVGafAUw0OZdVOdROWTPq6vUkahDMlzKjjoMfk8+VgI09US9pfWY+e9OluWj/ANR9CMn2NvYBhcp94NlUapuqFyk=;20:Axg41AWDY+3iJrbTAbA2D/P4XtUjiVPjpB1ISew180uePZjG5n2ImBi9fkJlWviT3kYO4rSPv1X2vWBIAgJ52cvAYuWvflNlZyOPypcmIjgvhYMfpK2j/rt9SxIx77WsWjf06PsAB1FDt6o/I9OyLp0ZVhmrjviTxZdoA43Ghsz8Tlabm20RlQn/IXbBnpg8vjVcfm78+CiVqL/VkUT4HFy4BHAX47zXCPD1fo2rvvcEwv8pijbNi//EIPsYhyIF+fEEG7vMFWa8aMCYYoAiChZcC998IelKmXrHmGeYJhTR7pCuFtiXMy9s/VQSggwimv7EvMY908iAmY+nPqOpFWPTKuNLUX4U/TqnS1iseKWQSViwT6RmshFElD+wiFmcvRMXwUNvUWWonIP9410mK5Js12F4M1NjPnz+sdssGePcfqoFvQf86r8Ve5j1wEZIUBz3K/iUOmYWYI/ygabc7pb6gIHjuJPhdCn6bfGMUZlfm/XpgtqvYnGMh5dir3kK
X-Microsoft-Antispam-PRVS: <SN1PR07MB23036D639C9662BE2573BDCBDD590@SN1PR07MB2303.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB2303;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2303;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;4:cpu0isaLWBxU2GtePFPjOO76xoVBkin2j+MvN46EkhTrE5zXsZnh1wKE/jAiL7r6a3oifyjYSWPQsKzRtsVIwl4lAMbBexnwNR//Oy8pF+OHHX9uYlF0Gxi8WXkomBX2ZjCKCPEgNbYQz5ooGzI18NLqyW4DydQdswXhBQZ6m0k48LqoNX06u45AWTbYu3aTTUZBTAh2tBLnBRPa+APN4RvoOP6XyowFmtwYWf1vnR94flPSRwk9HQIRTB167MH9ZOuy2UwbEwxRidn1mvgncUt0Op7YENuPF/8reCe2hMx439P48KtajB2LK3WrSgad
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2303;23:ZaY/vQ8faS6LSf/lkFMM4gAVKHhPrQRSxTEYB2NDk?=
 =?us-ascii?Q?Vgr+6lvUN46mn8EjaOCMMbaYaVNGuJzxSxmB+KfHq5UKy9CrLk5SNfWV0l5w?=
 =?us-ascii?Q?F1Q2t7R1JiFixFsm2XeqxqjAYwr3AESRNcIk2alpBuLNl6NcYiMtmphwdQa8?=
 =?us-ascii?Q?aNciSlqTgYwFNpSQ6AWJEbxwJpvw8j+yKUW731Yz7wj4tYSVIDhVTWAA9Lvw?=
 =?us-ascii?Q?1cFPOD8/aT+KAhFp5YN564BIukpnuZwBgk73sSMeTfLiL0NKiUtW0Hvei2NV?=
 =?us-ascii?Q?5I+aTOJvte+93K1a7MBXkXWUZe6pyW0pXB3LIOUzJpREO93VNiteeUrNmArw?=
 =?us-ascii?Q?ighSPvXuQF7Fa98ydSU0ZXTDdnOb0VFSyTNHTGLwjDoKj7o2Vw/H9ePfN6Wn?=
 =?us-ascii?Q?Zd1DoG2JesDUT/dXoVduP/LbuqDnBUbFLmaQJnKjW7kOehj2yeIx3ZvOKj0m?=
 =?us-ascii?Q?ALNcuKdQbaekbndXFGPGT1J7rvCXlmi2r2JC6WiUkX7KRI1QlxkujRhaOqdJ?=
 =?us-ascii?Q?URLyImDdYJ+Xvty/l+ZG1kGchzC7xw1fcIAKp87NE/TuBx0RBatEjqUBmKtw?=
 =?us-ascii?Q?L+GJv3+T/0ggjKRfEhzBNUlDiU3xgDM8soHawRkCQrIaVm2rGIlyDTwY/2ne?=
 =?us-ascii?Q?v0Eu53tCJPnjFjUjb0pxlvweFo7A0GqfY6rOUFAqZdrucKmyIMkOAYLc4Gtv?=
 =?us-ascii?Q?FLvwfg4GI1wr8ssnrrjqAII5YQVZ2TmSDdHkyCWYzwJ0FRg1MxzbbrjnK+/G?=
 =?us-ascii?Q?mEGUiYo+XvK9tC1K4y8rwaIf192CMScIKYr5/CK2yuIFKKriwivWFf0v5PCI?=
 =?us-ascii?Q?riMAobcWvqSXAC5oGW+NpSGETiA9BaEVXQZjAxxLvKTjsxCVj9mbMHruvI6R?=
 =?us-ascii?Q?S/Jn/LlYM9FOwvEdbmwg3iQsq487z/1cf0FMec9lvYKgXB+TcStM0cBf0pgy?=
 =?us-ascii?Q?f+Eumf98VxxT0+SRLReSbwsV7dBxsdYi1bg7w9uB2Tc6XYOaHLE04GkqJzjj?=
 =?us-ascii?Q?eHy1BqyyaVWRSB0wg5p/I4aCBtFLEPea8jXqppy/dLvRlw7uVjsXpxAJUOCw?=
 =?us-ascii?Q?qKt5rMmSuPLro5vzSzG3Ru0iS+s94IP2cWuUGcdL9ehca0JP13vv9majWI/7?=
 =?us-ascii?Q?GWrApB0p1nSQ/dJZ+2wMc27T/JhNfxwXxHu7BbC4LS4BsChJ024xnWVgZAqz?=
 =?us-ascii?Q?S+3p6Uhz6JnJf2NsUKBmSTlWNghgV17EpO2V6+ww171z4JT5zjqdczYVQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 2JS9/ulODElUwwsUw7774d1wZYbRswYJT4cVEQHcZdzQf2HNDmuj3H5RhotFHPUZT7CxZUlfh6Y5BbZ+VpMXgEWZYjdXWVRAiVmR7Mt7DYA+ADjWMrzBPdNfdyTtNIrXk/jr2t/IxXLb+BCWl/i98fGbxYW6V3zeVL7gJ5k6nmkjUFdbPRTZQkW9ZLPJOUQxZttCqkgN5Q37TPdKj4cz5/FYpv24eeiVa7+Ulp8xiUpB7Oryk8/P1Mb5oF1lrvkUu4jHf90e4TY7y0OUwBAtgZrJrtonJ2ex/yi/0PjpMwXkCX8tWw8c/efdF+ccq296QHnoVVup5V5O8aKMYTq2s9qE9tVk/hRkWCA2XjbOcxxcyXS/9wLIYAwjtpPBgBPFTi3N3/i0yOSKJb9CxfQ8Qw==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;6:Yj/+LNc5bJgyoGVXfI4oUznsg04aKKgHZ/YBEd4saetAtheslCVuKDU6g68PYAicAIOJZPlIYHlsU4PHnhEoYdexHvAvPyoGlSQzC9GD+HWdSQZVCN7oYot5itKUnrTDmFtfNW6dgw6IN8sNXNKXxpZ6c8NB7/ZW/cmg+SgJP6Ljwxtf4btb9iOx9f/93B3/Tk9K9wYfPWwBWE2iLwmGAFnOrJMfFbADlkVi64CiXrXKEg3Ceiyo4z8RVHeoxVGyqMzsXLaqLXDwSNFocenkPCp2iLF8Dgia2gPy1YVz/C99aJwQofIc83MUWrTYM90XX/3vlIOIigAGyqAjuUshB+nliWSYH55J3BLyG0sn3PkrngSfA6vgt+6b9vqK7lg2ktjiNmpnsZB4ubLLX49TjtoePA69N4JkFBvOStdQmQ1ZHvH/OdruqlIG+JokcUy55NzyrFdxCyTKi+P0I9sfAA==;5:XXMRU+6Y3YoNvKu7Ol4mmD2qW9I2LRgaIPH6VOnYztc3zr721SCTMHPmfyfJcbYauaXTj+C8bLA1jYk/gz8BN06/WQfgfCjPI46S/iqX2NStr4uHV8MbYwHMrW5vkaSJezFppG7e4ZM5/5IE+QWK/vnTVJI98uqWXcF1WVS2tOs=;24:q/ulxjGlp4TC9rud0Qu/QNO+xB9l3guS8gOui0vdZO8+pqzfGJLutJZrL5tJKPxbo3a7dPT9m4rrsJw/0i40EkurSVTeb0N964Sy7/RDIjQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;7:S2fKddRfgi2ICS2MCmymbV4p7spHgAz1UfVMugKF/FoREcGo6qPyNgIYVd5DnWaQtZabqdyTwbs+kjwg+9iQsCFKY4YY761dPLanDzK2olrD9q0dsLwnGG5lCN3sZjG4j3S5a4SvVNBFAbW6oOo9YHyVaKV4D+iAMhkp6HapirbCWmXbkwt6yNb5MbCMpJvC+UCaZDwRMJNQvGZssA2EQSNDteyL5d1ZcPGrc7WVP2mZx5pFYIAZ+63uy47hYQt/;20:4WcEc9coA3FHGJwNZ424kDn8pOOrxKxeAHBaDjMIpSt1UNDus6UGeLvvx0ayvOSTxbCXi6rqeC165BByIsNn3FIYxTG9r8lr3ebG/5TMQCqlskhfnRknqSCZfomtIQRyEbmK3U9PbyR5fUefaM10vMr38cIvYn5FsZgXk0j1hxFDOucVRcftmoWLODpVi9MyYNVetu+lF/Un1Hwsm66L6+60l9m6z4AZ7AHYQLhZjHyZeTWh3OTyihV72SxwanS0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:02.9966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c64c2c-33e7-48b9-9939-08d5e7bb08aa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2303
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add implementation of most function from usb_ep_ops and
usbssp_gadget_ops objects. The implementation of
usbssp_gadget_ep_enable and usbssp_gadget_ep_disable functions
will be added as separate patch.

Patch also adds usbssp_g_lock and usbssp_g_unlock macros.
They are responsible for proper handling of semaphores.
Some functions belonging to usb_ep_ops and usbssp_gadget_ops
can be invoked from some different context.
In usbssp driver we have Hard Irq interrupt context and deferred interrupt
context (thread context). Additionally, driver in thread context can
calls commands on which ends it must wait and must enable
interrupts to detect completion.
Therefor when driver is waiting for command completion, the new event can
be reported and driver starts handling it in Hard Irq context.
Therefor driver use two separate SpinLock objects. The first usbssp->lock
is used in Hard Irq context and second usbssp->irq_thread_lock is used
in kernel thread context.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c | 180 ++++++++++++++++++++++++++-------
 drivers/usb/usbssp/gadget.c    | 107 ++++++++++++++++++++
 2 files changed, 248 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index 411c3971082f..356571eadb3d 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -12,6 +12,30 @@
 #include <linux/usb/composite.h>
 #include "gadget.h"
 
+#define usbssp_g_lock(flag, save_flags) { \
+	if (in_interrupt()) {\
+		spin_lock_irqsave(&usbssp_data->lock, save_flags); \
+	} else { \
+		if (!irqs_disabled()) { \
+			spin_lock_irqsave(&usbssp_data->irq_thread_lock,\
+					usbssp_data->irq_thread_flag);\
+			flag = 1; \
+		} else \
+			spin_lock(&usbssp_data->irq_thread_lock); \
+	} }
+
+
+#define usbssp_g_unlock(flag, save_flags) { \
+	if (in_interrupt()) \
+		spin_unlock_irqrestore(&usbssp_data->lock, save_flags); \
+	else  { \
+		if (flag) \
+			spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,\
+					usbssp_data->irq_thread_flag);\
+		else \
+			spin_unlock(&usbssp_data->irq_thread_lock); \
+	} }
+
 static int usbssp_gadget_ep_enable(struct usb_ep *ep,
 		const struct usb_endpoint_descriptor *desc)
 {
@@ -40,24 +64,27 @@ int usbssp_gadget_ep_disable(struct usb_ep *ep)
 static struct usb_request *usbssp_gadget_ep_alloc_request(struct usb_ep *ep,
 							  gfp_t gfp_flags)
 {
+	struct usbssp_request *req_priv;
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
 
-	if (!ep_priv)
+	req_priv = kzalloc(sizeof(*req_priv), gfp_flags);
+	if (!req_priv)
 		return NULL;
 
-	/*TODO: implements this function*/
-	return NULL;
+	req_priv->epnum = ep_priv->number;
+	req_priv->dep  = ep_priv;
+
+	trace_usbssp_alloc_request(&req_priv->request);
+	return &req_priv->request;
 }
 
 static void usbssp_gadget_ep_free_request(struct usb_ep *ep,
 		struct usb_request *request)
 {
-	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	struct usbssp_request *req_priv = to_usbssp_request(request);
 
-	if (!ep_priv)
-		return;
-
-	/*TODO: implements this function*/
+	trace_usbssp_free_request(&req_priv->request);
+	kfree(req_priv);
 }
 
 static int  usbssp_gadget_ep_queue(struct usb_ep *ep,
@@ -65,12 +92,32 @@ static int  usbssp_gadget_ep_queue(struct usb_ep *ep,
 				   gfp_t gfp_flags)
 {
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
+	struct usbssp_request *req_priv = to_usbssp_request(request);
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
+	int ret;
+
+	if (!ep_priv->endpoint.desc) {
+		usbssp_err(usbssp_data,
+				"%s: can't queue to disabled endpoint\n",
+				ep_priv->name);
+		return -ESHUTDOWN;
+	}
 
-	if (!ep_priv)
-		return -EINVAL;
+	if ((ep_priv->ep_state & USBSSP_EP_DISABLE_PENDING ||
+			!(ep_priv->ep_state & USBSSP_EP_ENABLED))) {
+		dev_err(usbssp_data->dev,
+				"%s: can't queue to disabled endpoint\n",
+				ep_priv->name);
+		ret = -ESHUTDOWN;
+		goto out;
+	}
 
-	/*TODO: implements this function*/
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret =  usbssp_enqueue(ep_priv, req_priv);
+	usbssp_g_unlock(irq_disabled_locally, flags);
+out:
 	return ret;
 }
 
@@ -78,36 +125,53 @@ static int usbssp_gadget_ep_dequeue(struct usb_ep *ep,
 				    struct usb_request *request)
 {
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
+	struct usbssp_request *req_priv = to_usbssp_request(request);
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int ret;
+	int irq_disabled_locally = 0;
+
+	if (!ep_priv->endpoint.desc) {
+		usbssp_err(usbssp_data,
+				"%s: can't queue to disabled endpoint\n",
+				ep_priv->name);
+		return -ESHUTDOWN;
+	}
 
-	if (!ep_priv)
-		return -EINVAL;
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret =  usbssp_dequeue(ep_priv, req_priv);
+	usbssp_g_unlock(irq_disabled_locally, flags);
 
-	/*TODO: implements this function*/
 	return ret;
 }
 
 static int usbssp_gadget_ep_set_halt(struct usb_ep *ep, int value)
 {
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
-
-	if (!ep_priv)
-		return -EINVAL;
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	int ret;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
 
-	/*TODO: implements this function*/
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret =  usbssp_halt_endpoint(usbssp_data, ep_priv, value);
+	usbssp_g_unlock(irq_disabled_locally, flags);
 	return ret;
 }
 
 static int usbssp_gadget_ep_set_wedge(struct usb_ep *ep)
 {
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int ret;
+	int irq_disabled_locally = 0;
 
-	if (!ep_priv)
-		return -EINVAL;
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ep_priv->ep_state |= USBSSP_EP_WEDGE;
+	ret =  usbssp_halt_endpoint(usbssp_data, ep_priv, 1);
+	usbssp_g_unlock(irq_disabled_locally, flags);
 
-	/*TODO: implements this function*/
 	return ret;
 }
 
@@ -182,19 +246,39 @@ static int usbssp_gadget_start(struct usb_gadget *g,
 				usbssp_data->gadget.name,
 				usbssp_data->gadget_driver->driver.name);
 		ret = -EBUSY;
+		goto err1;
 	}
 
-	/*TODO: add implementation*/
+	usbssp_data->gadget_driver = driver;
+
+	if (pm_runtime_active(usbssp_data->dev)) {
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->ep0state = USBSSP_EP0_UNCONNECTED;
+		ret = usbssp_run(usbssp_data);
+		if (ret < 0)
+			goto err1;
+	}
+	return 0;
+err1:
 	return ret;
 }
 
 static int usbssp_gadget_stop(struct usb_gadget *g)
 {
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
 	struct usbssp_udc *usbssp_data  = gadget_to_usbssp(g);
 
-	if (!usbssp_data)
-		return -EINVAL;
-	/*TODO: add implementation*/
+	usbssp_g_lock(irq_disabled_locally, flags);
+	if (pm_runtime_suspended(usbssp_data->dev))
+		goto out;
+
+	usbssp_free_dev(usbssp_data);
+	usbssp_stop(usbssp_data);
+out:
+	usbssp_data->gadget_driver = NULL;
+	usbssp_g_unlock(irq_disabled_locally, flags);
+
 	return 0;
 }
 
@@ -202,33 +286,51 @@ static int usbssp_gadget_get_frame(struct usb_gadget *g)
 {
 	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
 
-	if (!usbssp_data)
-		return -EINVAL;
-
-	/*TODO: add implementation*/
-	return 0;
+	return usbssp_get_frame(usbssp_data);
 }
 
 static int usbssp_gadget_wakeup(struct usb_gadget *g)
 {
 	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (!usbssp_data->port_remote_wakeup)
+		return -EINVAL;
 
-	if (!usbssp_data)
+	if (!usbssp_data->port_suspended)
 		return -EINVAL;
 
-	/*TODO: add implementation*/
+	usbssp_g_lock(irq_disabled_locally, flags);
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(port_regs+PORTPMSC);
+
+	if (!(temp & PORT_RWE))
+		return 0;
+
+	temp = readl(port_regs + PORTSC);
+
+	temp &= ~PORT_PLS_MASK;
+	writel(temp, port_regs + PORTPMSC);
+	usbssp_g_unlock(irq_disabled_locally, flags);
 	return 0;
 }
 
 static int usbssp_gadget_set_selfpowered(struct usb_gadget *g,
 		int is_selfpowered)
 {
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
 	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
 
-	if (!usbssp_data)
-		return -EINVAL;
+	usbssp_g_lock(irq_disabled_locally, flags);
+
+	g->is_selfpowered = !!is_selfpowered;
+	usbssp_g_unlock(irq_disabled_locally, flags);
 
-	/*TODO: add implementation*/
 	return 0;
 }
 
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index b4e26aab1fb8..38df3d3e937b 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -265,6 +265,22 @@ int usbssp_reset(struct usbssp_udc *usbssp_data)
 	return ret;
 }
 
+static inline int usbssp_try_enable_msi(struct usbssp_udc *usbssp_data)
+{
+	usbssp_data->msi_enabled = 1;
+	return 0;
+}
+
+static inline void usbssp_cleanup_msix(struct usbssp_udc *usbssp_data)
+{
+	usbssp_data->msi_enabled = 0;
+}
+
+static inline void usbssp_msix_sync_irqs(struct usbssp_udc *usbssp_data)
+{
+	/*TODO*/
+}
+
 /*
  * Initialize memory for gadget driver and USBSSP (one-time init).
  *
@@ -288,6 +304,91 @@ int usbssp_init(struct usbssp_udc *usbssp_data)
 	return retval;
 }
 
+/*-------------------------------------------------------------------------*/
+/*
+ * Start the USBSSP after it was halted.
+ *
+ * This function is called by the usbssp_gadget_start function when the
+ * gadget driver is started. Its opposite is usbssp_stop().
+ *
+ * usbssp_init() must be called once before this function can be called.
+ * Reset the USBSSP, enable device slot contexts, program DCBAAP, and
+ * set command ring pointer and event ring pointer.
+ */
+int usbssp_run(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+	u64 temp_64;
+	int ret;
+	__le32 __iomem	*portsc;
+	u32 portsc_val = 0;
+	int i = 0;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init, "usbssp_run");
+
+	ret = usbssp_try_enable_msi(usbssp_data);
+	if (ret)
+		return ret;
+
+	temp_64 = usbssp_read_64(usbssp_data,
+				 &usbssp_data->ir_set->erst_dequeue);
+	temp_64 &= ~ERST_PTR_MASK;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"ERST deq = 64'h%0lx",
+			(unsigned long int) temp_64);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"// Set the interrupt modulation register");
+	temp = readl(&usbssp_data->ir_set->irq_control);
+	temp &= ~ER_IRQ_INTERVAL_MASK;
+	temp |= (usbssp_data->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
+	writel(temp, &usbssp_data->ir_set->irq_control);
+
+	/******************************************/
+	//enable USB2 port
+	for (i = 0; i < usbssp_data->num_usb2_ports; i++) {
+		portsc = usbssp_data->usb2_ports + PORTSC;
+		portsc_val = readl(portsc) & ~PORT_PLS_MASK;
+		portsc_val = portsc_val | (5 << 5) | PORT_LINK_STROBE;
+		writel(portsc_val, portsc);
+	}
+
+	//enable USB3.0 port
+	for (i = 0; i < usbssp_data->num_usb3_ports; i++) {
+		portsc = usbssp_data->usb3_ports + PORTSC;
+		portsc_val = readl(portsc) & ~PORT_PLS_MASK;
+		portsc_val = portsc_val | (5 << 5) | PORT_LINK_STROBE;
+		writel(portsc_val, portsc);
+	}
+
+	if (usbssp_start(usbssp_data)) {
+		usbssp_halt(usbssp_data);
+		return -ENODEV;
+	}
+
+	/* Set the USBSSP state before we enable the irqs */
+	temp = readl(&usbssp_data->op_regs->command);
+	temp |= (CMD_EIE);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Enable interrupts, cmd = 0x%x.", temp);
+	writel(temp, &usbssp_data->op_regs->command);
+
+	temp = readl(&usbssp_data->ir_set->irq_pending);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"// Enabling event ring interrupter %p by writing 0x%x to irq_pending",
+		usbssp_data->ir_set, (unsigned int) ER_IRQ_ENABLE(temp));
+	writel(ER_IRQ_ENABLE(temp), &usbssp_data->ir_set->irq_pending);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Finished usbssp_run for USBSSP controller");
+
+	usbssp_data->cmd_ring_state = CMD_RING_STATE_RUNNING;
+
+//	usbssp_debugfs_init(usbssp_data);
+
+	return 0;
+}
+
 /*
  * Stop USBSSP controller.
  *
@@ -1104,6 +1205,12 @@ int usbssp_enable_device(struct usbssp_udc *usbssp_data)
 	return usbssp_setup_device(usbssp_data, SETUP_CONTEXT_ONLY);
 }
 
+
+int usbssp_get_frame(struct usbssp_udc *usbssp_data)
+{
+	return readl(&usbssp_data->run_regs->microframe_index) >> 3;
+}
+
 int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 {
 	int	retval;
-- 
2.17.1

