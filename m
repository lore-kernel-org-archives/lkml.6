Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE305ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D33220856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="IWJMHedD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D33220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbeGSSn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:57 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:57161
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732377AbeGSSn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGzRgSXUXdmAd3b7RqHQo2QfgvcQEebm3NKJI1kv8a4=;
 b=IWJMHedDtu7FbgQdq9wof6VDfRIW21KA47aZnrIrxuIbf6UH+ZYT6zHWZvv1ySR6N2Od2eCcIoWCK4XLPhGpTJ7h5625qW+R9W2/Wzl/RxwEaL213AYasiL8YsBktRNsbU6ZCY1mJ3EsLLyPLD6WrOnip+lUxCThbCNT6HU3rY8=
Received: from BYAPR07CA0067.namprd07.prod.outlook.com (2603:10b6:a03:60::44)
 by BYAPR07MB4710.namprd07.prod.outlook.com (2603:10b6:a02:f1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:20 +0000
Received: from DM3NAM05FT050.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by BYAPR07CA0067.outlook.office365.com
 (2603:10b6:a03:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:19 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT050.mail.protection.outlook.com (10.152.98.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS2019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:18 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:28 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:28 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxCqd005787;
        Thu, 19 Jul 2018 18:59:12 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxCBc005785;
        Thu, 19 Jul 2018 18:59:12 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 12/31] usb: usbssp: added functions for queuing commands.
Date:   Thu, 19 Jul 2018 18:57:45 +0100
Message-ID: <1532023084-28083-13-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(36092001)(189003)(199004)(48376002)(14444005)(186003)(87636003)(478600001)(107886003)(50466002)(4326008)(109986005)(26826003)(36756003)(5660300001)(1671002)(2906002)(305945005)(426003)(105596002)(106466001)(47776003)(6666003)(7636002)(4720700003)(126002)(50226002)(76176011)(476003)(446003)(486006)(11346002)(356003)(2616005)(42186006)(51416003)(316002)(246002)(86362001)(54906003)(16586007)(8936002)(8676002)(336012)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4710;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT050;1:05Avnc3cdjirbVh/aNQTPxahGwmx0YDyNX/BXo8e6HmGLMKyLJDL0VaTvYfvaqwQAfQGnagKJBQGacMkSE+DAq/0u7DnFJAVm8GFy3OwFNbIgKVh16q3awC3+tHDxYrP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd083632-1a00-4670-51f1-08d5eda159f0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4710;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;3:pk4XBskyEoBSi5OFU/5REBDT5CRdXEocgMI+ePaEIOPj1MCLzpaxr8FgOn4lPqujm9t5pYelSHPO/27viIGhI7W9Ra8omTLRRITwr8a7BfXAwJh2euGesTLEHuOKbXJxY3Hs/a3q0l4rn/GuIi+WnDGx7wpLDKaNLw5Kv+6eI9YgNscmhfkdEzjX4JeHW4QEzxS4e94z3+09rCpgJ+oTtmhSxq7wcitvr+lONGi1jv55Fql7WRkkUp8nu5/gw43Wn9qat/jwZKOt8ycpccq695lGodhfkJmIj82P2JaydWlKN7Yumzm7/zLe11Utl1qFZFRuo7xZRaca1N1RAp7fTjWYjZMJR9kgQKKsj36DNfs=;25:o+4w9PjXFXRPsBSYNPwLbiHevdMKQjTeWsALJDgxryDrnBV1dKTxvGxjsBOcqKYaOCSLQEfdYIv9cn6/4ckQxQGTBi0zDmkQtn7D2Kan2LIYvzi2IPkLUheP+pinoaJC+eWd0DuIdKSZqCDhGhwsxcRurTeJHpQxR6kE9zarcQ4N9xzz12B7r5s4iMWPy0JjAmTcCC5jnWHTJGiR3PYxAPxGwKpPqK0dM2u4wi0hPvzI+8+ZGp4HeKDsHWDTe7FYHYTrbIyyxflziVQ6ciwcHXebCTIiI3uq9U1pI6s4ptvFC2InOYqAHOrc3XXgaGtVOMcvdrd4YnWWBgzVPPbKcQ==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4710:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;31:z+rRw6SF+34lFbbrmyhHJIt78/X6bhbIgEBenZIasw0jrTktttsV6lPLA1imTweLcrCqjqO1/06ku1UGb/wb6zKWo3Qn4uhHCi5kPmMf5jOw+Zxf00QYtJvBvNW4wFqCbS9+FyIuC5fmnwU4JULpLxE5J1FBoXm8794aESuH4JA3ScrozkIhW6BSBsVzMit5su4R3BOkjKLlXlQv/fDF+VQuqZC/KBOWX/EKxSRlryk=;20:+NtodTXbEMQNQhSC93yW6OrdytcNOlp8oq3eAW0E28iAH0P3xhZXRYYJmEUcU9styGqqBDu3lBQXDuwzEmCErxEKatiYKZGPExOrxEgdNyINK/96CU6I1KqEYOf8UZ1MYeBZbwiUYythG2TCF6z2Ym/TdjwmK82kJD7ledmz4JFmSdL+RYtK85s7Qds0MQ9G6QeomjllFAbgJrx+nmwaUqMgW9lyxM8N6JswgkOCU6vllN3qIUsBtzaXSUC9meiIlZVEPvgAaDqDChgt34YaWdebkl3nVZEVCFEeAwcUkNaBH7tGr6H2Io72/ts/xPNXod07H9s5eqS97k6RDUv3Q3AQH/Hnaj77OBCJQxG0bWN7FXCQ8S+LacY3vuJ2Ka7XDVsZCaO7EbSUTq/Gg/yugrwRsXdf27r4xOtj2+bS7nPlrK4oxvej0q/utXEsZv0y+ljosfFhQO/dTS8vPAq4QEGuz759Osj/09U0dxVQGSJlj9trjTX63evoMQna4Z0f
X-Microsoft-Antispam-PRVS: <BYAPR07MB471083AEA4E82F3BB089FFFDDD520@BYAPR07MB4710.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4710;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4710;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;4:9reZDa6mis4i1/GBgmHkTkX9NxbC+MW7/w62hfniF3OEcu40PBqQH/TXYu9fFvgW0vuVD6dpE8bVbZCt97Ida5C2GoAHRlnylsYE/AlHXTgZhDBmQHob9lSwfdonIemSkXdCncvy7qns701NHyMtqS7VD3cSJWxCb2RD3pyts3IK11GZyLdjunx6D51tWGfCIISIUHV7X9lE7c2zR5TqlvsyBqzIu0ejXgP5Bx6Z90jSHyQbur3VxoLbwde2yOIRtFszpMU3ySAgQuHTxlbMJCAuEPGkwtb+yV3Y7ID5a0PMcvi6Ic6FgPGu4gTILJQ0
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4710;23:3F65NKzuXyOat8HpozGufx7iR06QuGhau1qRPritQ?=
 =?us-ascii?Q?U46fgxiVWmSuoqJ2vujAxMar78fu+w5j2Zb7tXlaMrNjHuAwBKs3z1tb6co0?=
 =?us-ascii?Q?CHGtSehoi5qR7lLM2iBKyDylHw14c/Pqn50M7ba51JnN2IYhXWXPKbcJz2sW?=
 =?us-ascii?Q?BpjhirNhWSO18k6u/tfDjBo9Atd6MYlEXdbMsTZrZa/+6E9oGR3x75U1pKXb?=
 =?us-ascii?Q?MTQp5vAVKjVIusPeJMl5P7vChE8m98ZdgNCsPzGkk3fC27LYVbHXUxy8xEQV?=
 =?us-ascii?Q?FEjuoVM38kjiKtibilYrB9Gf/G0yC132DKyRZ3FGIq5SJRTr4S3eNgpGA30W?=
 =?us-ascii?Q?yrJlOr+M7Hf+7B+ToV+v+rgCkagAmhKvxOL5cnMIL4QeEIthMxn/yHxeDQda?=
 =?us-ascii?Q?0+6ELd3U2tBou5fcDZZ026ue1ZaSMzB1f3mf9aPuZLjaMTNZGSFmsVXhhF7e?=
 =?us-ascii?Q?En9MbevkZG0AmmO84oDBeM4DDCdYqiK98jKub+A6XQGksRIWAdmCsclpfws6?=
 =?us-ascii?Q?T7Fciroac0su1SafsiGH1qjLVA0VylvSIj/CLwXPqKEUHaAKc8wSUW+Us8SD?=
 =?us-ascii?Q?0tOV8kHOCHOrYAWkxGXzgCO+xbH/qbU229W55Mqh1/Fecj04fVPqPN5vFZUb?=
 =?us-ascii?Q?5+Rg3JGuQ/FbGMBELil1Cf6XLYacIw2hFvJdNjGFXW/RJphaCzaRUL227FkZ?=
 =?us-ascii?Q?o3reF7torjTpIp0IMIuiQrz2O4K7nsOPFP19a2LUSzGzXwrVxW/vBo6MdGA+?=
 =?us-ascii?Q?Q1XpBV8AJ/qLy8PG1B+XO9nInbxarM1cTCnVbfXUSwIqgi0WIAJpT2w9cyfi?=
 =?us-ascii?Q?a9Z0x5qbtl0PoVXocvmgL9uPXZSH8SEyX+wknX8EcRrj0TB6Pnwyooj3Q0ys?=
 =?us-ascii?Q?08AVcQxehQPhLwf4mkNcbnUAe4llpVWmSXvxT0acBtLX4DGnL0VijaD1sfKh?=
 =?us-ascii?Q?XNeXYGegbsPyxhyD7uxU+OhlBBrLl7EorbXlUNmBXlPdw1rEfvLFuJqyRQj/?=
 =?us-ascii?Q?sxdl70g/kcfBjwB6wu6TKxlqiyPWbA1rg46kR3e/ugPzIM+BTfLTd2lyI4Dz?=
 =?us-ascii?Q?Mq/a8Fh6pFB2mXHv3U9LpFACsLyH5vCgc8RK5OGgpaVOt1dn59OiiUctjzju?=
 =?us-ascii?Q?m+rd/djmFsWmvWFw/fH3z84Yx5Vg9gR4EDVKOsxJmkq9gD/SA/D+g=3D=3D?=
X-Microsoft-Antispam-Message-Info: AfKxBfJ5dHplgOc9hU6qDY/mv+kSOh4y41nqO1blgXWW4liOTxYGwDVJ+CO2DMIxMxzzBcQBgPq6H//6cths5SVJQJzPTBC8jnE/+K4rmgjtJYkegqk8Wr3rjx4lZJrd68ut1sVR8y1/szCtnmo9j28k4weVSwqYH9Ogb1ge4OiUKy6mc8D7/yXCixjIpfl1ltppnZblJ8R3IuOeHRGMs4hiS4rLtSG59kqW7OMYZOK92Gh/oXzwOwMIRA2rZFfhZM5OLGjDQ15AwlVawe1F1g0QyWTpcszQjriO28p77tVIM4Oi2Aw4B2KZkOpeQOLdvHsBMjY/mY7yJVs8f35uQKq8Wjs6BQ5l5G5KqDwn5wwUKV4NrXEo0O9hfNBW9SPNGCIsRE7Iu4xSHxvYwfNIPA==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;6:smKl44MAiCk0tdE2692WhxQH9KddEGbukymZ/WkFb5D4TWBqThuEkjtgP85/MImzb0H+djUVpW1Wtc/Mp2l+zLkCrNRzKLpd0sn18vNs3o1q27ZSrytdfEKy8EVy2OYgL4c6fieLc5uPwsbwpNnxIlgusIOjz2GhYjIBlpAa904UIClNMeCbMIdWBzYZTd3GY8v8t8f22i83UBSTYC2idBeW8lRqvPD7DCccZ57q+RfzQQIZ/9oX7bbvFBqfnzdm4l0SOZFKnDw6NX8fnR0OrTxY2L5zwrqNEVv3vAcN4T7092CYTgNxQlWXfmMRdWf9XKXp6iHi2bQUk+ymiJ2Qr3PU3FGS11PFTesVWvBGCAwttCHHtjbCEOyf3oRjL+gtSzSX0+GQvAE6K1gX0MdzNl7Yz3RAy6gpO9FMWv1KY64CHGAFUbaWLfIrLaypx9LFzLHF+UVu5cPuiUAZ6Uyfpg==;5:XhxagXbZMQzotldapy11gSQIfakquHltasOUFJiHnJeS8AMonMcWUNmcKTszIhAlwEvlloeL6GhAnDXRwKA2XJewfuPDE5/xZ8ygnZ1FPV6eI/hXXXrg3n9ofU09Mb5+lERU+gwHR4p5vf3GMsBvW1pEB/Rbvea6mferyBECprs=;7:0TzdbcU0Jh2mXbwC/Braa9eAzfJwkIXOup+CmWm6YglT1d/cCsqUXE0j/Ish7QWN4V7SMDAh7OnqDCzZcMuWPES0ClHKu/sKOswf/ylG0s2PZVjFuj9bvOt07ruHkHJQ8BdZB7yGWp3b5RkNWj6LDM5i3kkds4xSfLR4tt6yo8gvr2SooreD+jwYyDcPg186CxLGsPF9ltfplttOhps2RlsDXMt0Dfkh7HeeVB/bDif/oLL8YEXVYrCuXY3GO07f
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;20:ThtjxV3H5o6xNXE7EgwRhal7OTDmjvxdZMmBeEFf50rZlkCjDJiGsDOZaJzbUJspU56UUi5y8z6Se9fXw1uxUztg1KBcdpmKPDgaZVAPvf6qqdmS15V30BUZYXkBY2i/E/RnC9b9mxk4s6zVrm0KugPRwE2yiWYc62KTz9Fk4XAOBk9mewZ/w8zUV3Ef2bWUZtWzIPKMS+ZoFTVJaTo8XEKBL6So/olcMYaagBB4BmXK3+Tkfy4XIznNeF2XkaRD
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:19.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd083632-1a00-4670-51f1-08d5eda159f0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4710
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines a set of functions used to send
commands to command ring.

Commands added to Command Ring are handled sequentially
by hardware. After completion, controller should
add appropriate event to Event Ring.

Controller specification said that command may not be
completed. For this reason, driver should start
watchdog timer before arming Command Ring.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 538 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |   6 +
 2 files changed, 543 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 3075909c2e31..f6a6269e071d 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -10,10 +10,55 @@
  * Origin: Copyright (C) 2008 Intel Corp
  */
 
+/*
+ * Ring initialization rules:
+ * 1. Each segment is initialized to zero, except for link TRBs.
+ * 2. Ring cycle state = 0. This represents Producer Cycle State (PCS) or
+ *    Consumer Cycle State (CCS), depending on ring function.
+ * 3. Enqueue pointer = dequeue pointer = address of first TRB in the segment.
+ *
+ * Ring behavior rules:
+ * 1. A ring is empty if enqueue == dequeue. This means there will always be at
+ *    least one free TRB in the ring. This is useful if you want to turn that
+ *    into a link TRB and expand the ring.
+ * 2. When incrementing an enqueue or dequeue pointer, if the next TRB is a
+ *    link TRB, then load the pointer with the address in the link TRB. If the
+ *    link TRB had its toggle bit set, you may need to update the ring cycle
+ *    state (see cycle bit rules). You may have to do this multiple times
+ *    until you reach a non-link TRB.
+ * 3. A ring is full if enqueue++ (for the definition of increment above)
+ *    equals the dequeue pointer.
+ *
+ * Cycle bit rules:
+ * 1. When a consumer increments a dequeue pointer and encounters a toggle bit
+ *    in a link TRB, it must toggle the ring cycle state.
+ * 2. When a producer increments an enqueue pointer and encounters a toggle bit
+ *    in a link TRB, it must toggle the ring cycle state.
+ *
+ * Producer rules:
+ * 1. Check if ring is full before you enqueue.
+ * 2. Write the ring cycle state to the cycle bit in the TRB you're enqueuing.
+ *    Update enqueue pointer between each write (which may update the ring
+ *    cycle state).
+ * 3. Notify consumer. If SW is producer, it rings the doorbell for command
+ *    and endpoint rings. If DC is the producer for the event ring,
+ *    and it generates an interrupt according to interrupt modulation rules.
+ *
+ * Consumer rules:
+ * 1. Check if TRB belongs to you. If the cycle bit == your ring cycle state,
+ *    the TRB is owned by the consumer.
+ * 2. Update dequeue pointer (which may update the ring cycle state) and
+ *    continue processing TRBs until you reach a TRB which is not owned by you.
+ * 3. Notify the producer. SW is the consumer for the event ring, and it
+ *   updates event ring dequeue pointer. DC is the consumer for the command and
+ *   endpoint rings; it generates events on the event ring for these.
+ */
+
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
+
 #include "gadget-trace.h"
 #include "gadget.h"
 
@@ -35,6 +80,146 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 	return seg->dma + (segment_offset * sizeof(*trb));
 }
 
+static bool trb_is_link(union usbssp_trb *trb)
+{
+	return TRB_TYPE_LINK_LE32(trb->link.control);
+}
+
+static bool last_trb_on_seg(struct usbssp_segment *seg, union usbssp_trb *trb)
+{
+	return trb == &seg->trbs[TRBS_PER_SEGMENT - 1];
+}
+
+static bool last_trb_on_ring(struct usbssp_ring *ring,
+			     struct usbssp_segment *seg,
+			     union usbssp_trb *trb)
+{
+	return last_trb_on_seg(seg, trb) && (seg->next == ring->first_seg);
+}
+
+static bool link_trb_toggles_cycle(union usbssp_trb *trb)
+{
+	return le32_to_cpu(trb->link.control) & LINK_TOGGLE;
+}
+
+/*
+ * See Cycle bit rules. SW is the consumer for the event ring only.
+ * Don't make a ring full of link TRBs. That would be dumb and this would loop.
+ */
+void inc_deq(struct usbssp_udc *usbssp_data, struct usbssp_ring *ring)
+{
+	/* event ring doesn't have link trbs, check for last trb */
+	if (ring->type == TYPE_EVENT) {
+		if (!last_trb_on_seg(ring->deq_seg, ring->dequeue)) {
+			ring->dequeue++;
+			goto out;
+		}
+		if (last_trb_on_ring(ring, ring->deq_seg, ring->dequeue))
+			ring->cycle_state ^= 1;
+		ring->deq_seg = ring->deq_seg->next;
+		ring->dequeue = ring->deq_seg->trbs;
+		goto out;
+	}
+
+	/* All other rings have link trbs */
+	if (!trb_is_link(ring->dequeue)) {
+		ring->dequeue++;
+		ring->num_trbs_free++;
+	}
+	while (trb_is_link(ring->dequeue)) {
+		ring->deq_seg = ring->deq_seg->next;
+		ring->dequeue = ring->deq_seg->trbs;
+	}
+out:
+	trace_usbssp_inc_deq(ring);
+}
+
+/*
+ * See Cycle bit rules. SW is the consumer for the event ring only.
+ * Don't make a ring full of link TRBs. That would be dumb and this would loop.
+ *
+ * If we've just enqueued a TRB that is in the middle of a TD (meaning the
+ * chain bit is set), then set the chain bit in all the following link TRBs.
+ * If we've enqueued the last TRB in a TD, make sure the following link TRBs
+ * have their chain bit cleared (so that each Link TRB is a separate TD).
+ *
+ * @more_trbs_coming:	Will you enqueue more TRBs before calling
+ *			prepare_transfer()?
+ */
+static void inc_enq(struct usbssp_udc *usbssp_data,
+		    struct usbssp_ring *ring,
+		    bool more_trbs_coming)
+{
+	u32 chain;
+	union usbssp_trb *next;
+
+	chain = le32_to_cpu(ring->enqueue->generic.field[3]) & TRB_CHAIN;
+	/* If this is not event ring, there is one less usable TRB */
+	if (!trb_is_link(ring->enqueue))
+		ring->num_trbs_free--;
+	next = ++(ring->enqueue);
+
+	/* Update the dequeue pointer further if that was a link TRB */
+	while (trb_is_link(next)) {
+
+		/*
+		 * If the caller doesn't plan on enqueueing more TDs before
+		 * ringing the doorbell, then we don't want to give the link TRB
+		 * to the hardware just yet. We'll give the link TRB back in
+		 * prepare_ring() just before we enqueue the TD at the top of
+		 * the ring.
+		 */
+		if (!chain && !more_trbs_coming)
+			break;
+
+		next->link.control &= cpu_to_le32(~TRB_CHAIN);
+		next->link.control |= cpu_to_le32(chain);
+
+		/* Give this link TRB to the hardware */
+		wmb();
+		next->link.control ^= cpu_to_le32(TRB_CYCLE);
+
+		/* Toggle the cycle bit after the last ring segment. */
+		if (link_trb_toggles_cycle(next))
+			ring->cycle_state ^= 1;
+
+		ring->enq_seg = ring->enq_seg->next;
+		ring->enqueue = ring->enq_seg->trbs;
+		next = ring->enqueue;
+	}
+	trace_usbssp_inc_enq(ring);
+}
+
+/*
+ * Check to see if there's room to enqueue num_trbs on the ring and make sure
+ * enqueue pointer will not advance into dequeue segment. See rules above.
+ */
+static inline int room_on_ring(struct usbssp_udc *usbssp_data,
+			       struct usbssp_ring *ring,
+			       unsigned int num_trbs)
+{
+	int num_trbs_in_deq_seg;
+
+	if (ring->num_trbs_free < num_trbs)
+		return 0;
+
+	if (ring->type != TYPE_COMMAND && ring->type != TYPE_EVENT) {
+		num_trbs_in_deq_seg = ring->dequeue - ring->deq_seg->trbs;
+
+		if (ring->num_trbs_free < num_trbs + num_trbs_in_deq_seg)
+			return 0;
+	}
+
+	return 1;
+}
+
+static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
+				  unsigned long delay)
+{
+	return mod_delayed_work(system_wq, &usbssp_data->cmd_timer, delay);
+	return 0;
+}
+
 irqreturn_t usbssp_irq(int irq, void *priv)
 {
 	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
@@ -47,7 +232,6 @@ irqreturn_t usbssp_irq(int irq, void *priv)
 	return ret;
 }
 
-
 void usbssp_handle_command_timeout(struct work_struct *work)
 {
 	/*TODO: implements function*/
@@ -149,3 +333,355 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 
 	return NULL;
 }
+
+/****		Endpoint Ring Operations	****/
+
+/*
+ * Generic function for queueing a TRB on a ring.
+ * The caller must have checked to make sure there's room on the ring.
+ *
+ * @more_trbs_coming:	Will you enqueue more TRBs before calling
+ *			prepare_transfer()?
+ */
+static void queue_trb(struct usbssp_udc *usbssp_data, struct usbssp_ring *ring,
+		      bool more_trbs_coming, u32 field1, u32 field2,
+		      u32 field3, u32 field4)
+{
+	struct usbssp_generic_trb *trb;
+
+	trb = &ring->enqueue->generic;
+
+	dev_dbg(usbssp_data->dev, "Queue TRB at virt: %p, dma: %llx\n", trb,
+			usbssp_trb_virt_to_dma(ring->enq_seg, ring->enqueue));
+
+	trb->field[0] = cpu_to_le32(field1);
+	trb->field[1] = cpu_to_le32(field2);
+	trb->field[2] = cpu_to_le32(field3);
+	trb->field[3] = cpu_to_le32(field4);
+
+	trace_usbssp_queue_trb(ring, trb);
+	inc_enq(usbssp_data, ring, more_trbs_coming);
+}
+
+/*
+ * Does various checks on the endpoint ring, and makes it ready to
+ * queue num_trbs.
+ */
+static int prepare_ring(struct usbssp_udc *usbssp_data,
+			struct usbssp_ring *ep_ring,
+			u32 ep_state, unsigned
+			int num_trbs,
+			gfp_t mem_flags)
+{
+	unsigned int num_trbs_needed;
+
+	/* Make sure the endpoint has been added to USBSSP schedule */
+	switch (ep_state) {
+	case EP_STATE_DISABLED:
+		dev_warn(usbssp_data->dev,
+			"WARN request submitted to disabled ep\n");
+		return -ENOENT;
+	case EP_STATE_ERROR:
+		dev_warn(usbssp_data->dev,
+			"WARN waiting for error on ep to be cleared\n");
+		return -EINVAL;
+	case EP_STATE_HALTED:
+		dev_dbg(usbssp_data->dev,
+			"WARN halted endpoint, queueing request anyway.\n");
+	case EP_STATE_STOPPED:
+	case EP_STATE_RUNNING:
+		break;
+	default:
+		dev_err(usbssp_data->dev,
+			"ERROR unknown endpoint state for ep\n");
+		return -EINVAL;
+	}
+
+	while (1) {
+		if (room_on_ring(usbssp_data, ep_ring, num_trbs))
+			break;
+
+		if (ep_ring == usbssp_data->cmd_ring) {
+			dev_err(usbssp_data->dev,
+				"Do not support expand command ring\n");
+			return -ENOMEM;
+		}
+
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_ring_expansion,
+				"ERROR no room on ep ring, try ring expansion");
+
+		num_trbs_needed = num_trbs - ep_ring->num_trbs_free;
+		if (usbssp_ring_expansion(usbssp_data, ep_ring, num_trbs_needed,
+					mem_flags)) {
+			dev_err(usbssp_data->dev, "Ring expansion failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	while (trb_is_link(ep_ring->enqueue)) {
+
+		ep_ring->enqueue->link.control |= cpu_to_le32(TRB_CHAIN);
+		wmb();
+		ep_ring->enqueue->link.control ^= cpu_to_le32(TRB_CYCLE);
+
+		/* Toggle the cycle bit after the last ring segment. */
+		if (link_trb_toggles_cycle(ep_ring->enqueue))
+			ep_ring->cycle_state ^= 1;
+		ep_ring->enq_seg = ep_ring->enq_seg->next;
+		ep_ring->enqueue = ep_ring->enq_seg->trbs;
+	}
+	return 0;
+}
+
+/****		Command Ring Operations		****/
+/*
+ * Generic function for queueing a command TRB on the command ring.
+ * Check to make sure there's room on the command ring for one command TRB.
+ * Also check that there's room reserved for commands that must not fail.
+ * If this is a command that must not fail, meaning command_must_succeed = TRUE,
+ * then only check for the number of reserved spots.
+ * Don't decrement usbssp_data->cmd_ring_reserved_trbs after we've queued the
+ * TRB because the command event handler may want to resubmit a failed command.
+ */
+static int queue_command(struct usbssp_udc *usbssp_data,
+			 struct usbssp_command *cmd,
+			 u32 field1, u32 field2,
+			 u32 field3, u32 field4,
+			 bool command_must_succeed)
+{
+	int reserved_trbs = usbssp_data->cmd_ring_reserved_trbs;
+	int ret;
+
+	if ((usbssp_data->usbssp_state & USBSSP_STATE_DYING) ||
+	    (usbssp_data->usbssp_state & USBSSP_STATE_HALTED)) {
+		dev_dbg(usbssp_data->dev,
+			"USBSSP dying or halted, can't queue command\n");
+		return -ESHUTDOWN;
+	}
+
+	if (!command_must_succeed)
+		reserved_trbs++;
+
+	ret = prepare_ring(usbssp_data, usbssp_data->cmd_ring, EP_STATE_RUNNING,
+			reserved_trbs, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_err(usbssp_data->dev,
+			"ERR: No room for command on command ring\n");
+		if (command_must_succeed)
+			dev_err(usbssp_data->dev,
+				"ERR: Reserved TRB counting for "
+				"unfailable commands failed.\n");
+		return ret;
+	}
+
+	cmd->command_trb = usbssp_data->cmd_ring->enqueue;
+
+	/* if there are no other commands queued we start the timeout timer */
+	if (list_empty(&usbssp_data->cmd_list)) {
+		usbssp_data->current_cmd = cmd;
+		usbssp_mod_cmd_timer(usbssp_data, USBSSP_CMD_DEFAULT_TIMEOUT);
+	}
+
+	list_add_tail(&cmd->cmd_list, &usbssp_data->cmd_list);
+
+	queue_trb(usbssp_data, usbssp_data->cmd_ring, false, field1, field2,
+		field3, field4 | usbssp_data->cmd_ring->cycle_state);
+	return 0;
+}
+
+/* Queue a slot enable or disable request on the command ring */
+int usbssp_queue_slot_control(struct usbssp_udc *usbssp_data,
+			      struct usbssp_command *cmd,
+			      u32 trb_type)
+{
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			TRB_TYPE(trb_type) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id), false);
+}
+
+/* Queue an address device command TRB */
+int usbssp_queue_address_device(struct usbssp_udc *usbssp_data,
+				struct usbssp_command *cmd,
+				dma_addr_t in_ctx_ptr,
+				enum usbssp_setup_dev setup)
+{
+	return queue_command(usbssp_data, cmd, lower_32_bits(in_ctx_ptr),
+			upper_32_bits(in_ctx_ptr), 0,
+			TRB_TYPE(TRB_ADDR_DEV) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id)
+			| (setup == SETUP_CONTEXT_ONLY ? TRB_BSR : 0), false);
+}
+
+int usbssp_queue_vendor_command(struct usbssp_udc *usbssp_data,
+				struct usbssp_command *cmd,
+				u32 field1, u32 field2, u32 field3, u32 field4)
+{
+	return queue_command(usbssp_data, cmd, field1, field2, field3,
+			field4, false);
+}
+
+/* Queue a reset device command TRB */
+int usbssp_queue_reset_device(struct usbssp_udc *usbssp_data,
+			      struct usbssp_command *cmd)
+{
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			TRB_TYPE(TRB_RESET_DEV) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id),
+			false);
+}
+
+/* Queue a configure endpoint command TRB */
+int usbssp_queue_configure_endpoint(struct usbssp_udc *usbssp_data,
+				    struct usbssp_command *cmd,
+				    dma_addr_t in_ctx_ptr,
+				    bool command_must_succeed)
+{
+	return queue_command(usbssp_data, cmd, lower_32_bits(in_ctx_ptr),
+			upper_32_bits(in_ctx_ptr), 0,
+			TRB_TYPE(TRB_CONFIG_EP) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id),
+			command_must_succeed);
+}
+
+/* Queue an evaluate context command TRB */
+int usbssp_queue_evaluate_context(struct usbssp_udc *usbssp_data,
+				  struct usbssp_command *cmd,
+				  dma_addr_t in_ctx_ptr,
+				  bool command_must_succeed)
+{
+	return queue_command(usbssp_data, cmd, lower_32_bits(in_ctx_ptr),
+			upper_32_bits(in_ctx_ptr), 0,
+			TRB_TYPE(TRB_EVAL_CONTEXT) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id),
+			command_must_succeed);
+}
+
+/*
+ * Suspend is set to indicate "Stop Endpoint Command" is being issued to stop
+ * activity on an endpoint that is about to be suspended.
+ */
+int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
+			       struct usbssp_command *cmd,
+			       unsigned int ep_index, int suspend)
+{
+	u32 trb_slot_id = SLOT_ID_FOR_TRB(usbssp_data->slot_id);
+	u32 trb_ep_index = EP_ID_FOR_TRB(ep_index);
+	u32 type = TRB_TYPE(TRB_STOP_RING);
+	u32 trb_suspend = SUSPEND_PORT_FOR_TRB(suspend);
+
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			trb_slot_id | trb_ep_index | type | trb_suspend, false);
+}
+
+/* Set Transfer Ring Dequeue Pointer command */
+void usbssp_queue_new_dequeue_state(struct usbssp_udc *usbssp_data,
+				    unsigned int ep_index,
+				    struct usbssp_dequeue_state *deq_state)
+{
+	dma_addr_t addr;
+	u32 trb_slot_id = SLOT_ID_FOR_TRB(usbssp_data->slot_id);
+	u32 trb_ep_index = EP_ID_FOR_TRB(ep_index);
+	u32 trb_stream_id = STREAM_ID_FOR_TRB(deq_state->stream_id);
+	u32 trb_sct = 0;
+	u32 type = TRB_TYPE(TRB_SET_DEQ);
+	struct usbssp_ep *ep_priv;
+	struct usbssp_command *cmd;
+	int ret;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+		"Set TR Deq Ptr cmd, new deq seg = %p (0x%llx dma), "
+		"new deq ptr = %p (0x%llx dma), new cycle = %u",
+		deq_state->new_deq_seg,
+		(unsigned long long)deq_state->new_deq_seg->dma,
+		deq_state->new_deq_ptr,
+		(unsigned long long)usbssp_trb_virt_to_dma(
+			deq_state->new_deq_seg, deq_state->new_deq_ptr),
+		deq_state->new_cycle_state);
+
+	addr = usbssp_trb_virt_to_dma(deq_state->new_deq_seg,
+				deq_state->new_deq_ptr);
+	if (addr == 0) {
+		dev_warn(usbssp_data->dev, "WARN Cannot submit Set TR Deq Ptr\n");
+		dev_warn(usbssp_data->dev, "WARN deq seg = %p, deq pt = %p\n",
+			deq_state->new_deq_seg, deq_state->new_deq_ptr);
+		return;
+	}
+	ep_priv = &usbssp_data->devs.eps[ep_index];
+	if ((ep_priv->ep_state & SET_DEQ_PENDING)) {
+		dev_warn(usbssp_data->dev, "WARN Cannot submit Set TR Deq Ptr\n");
+		dev_warn(usbssp_data->dev,
+			"A Set TR Deq Ptr command is pending.\n");
+		return;
+	}
+
+	/* This function gets called from contexts where it cannot sleep */
+	cmd = usbssp_alloc_command(usbssp_data, false, GFP_ATOMIC);
+	if (!cmd) {
+		dev_warn(usbssp_data->dev,
+			"WARN Cannot submit Set TR Deq Ptr: ENOMEM\n");
+		return;
+	}
+
+	ep_priv->queued_deq_seg = deq_state->new_deq_seg;
+	ep_priv->queued_deq_ptr = deq_state->new_deq_ptr;
+	if (deq_state->stream_id)
+		trb_sct = SCT_FOR_TRB(SCT_PRI_TR);
+	ret = queue_command(usbssp_data, cmd,
+		lower_32_bits(addr) | trb_sct | deq_state->new_cycle_state,
+		upper_32_bits(addr), trb_stream_id,
+		trb_slot_id | trb_ep_index | type, false);
+	if (ret < 0) {
+		usbssp_free_command(usbssp_data, cmd);
+		return;
+	}
+
+	/*
+	 * Stop the TD queueing code from ringing the doorbell until
+	 * this command completes. The DC won't set the dequeue pointer
+	 * if the ring is running, and ringing the doorbell starts the
+	 * ring running.
+	 */
+	ep_priv->ep_state |= SET_DEQ_PENDING;
+}
+
+int usbssp_queue_reset_ep(struct usbssp_udc *usbssp_data,
+			  struct usbssp_command *cmd,
+			  unsigned int ep_index,
+			  enum usbssp_ep_reset_type reset_type)
+{
+	u32 trb_slot_id = SLOT_ID_FOR_TRB(usbssp_data->slot_id);
+	u32 trb_ep_index = EP_ID_FOR_TRB(ep_index);
+	u32 type = TRB_TYPE(TRB_RESET_EP);
+
+	if (reset_type == EP_SOFT_RESET)
+		type |= TRB_TSP;
+
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			trb_slot_id | trb_ep_index | type, false);
+}
+
+/*
+ * Queue an NOP command TRB
+ */
+int usbssp_queue_nop(struct usbssp_udc *usbssp_data,
+		     struct usbssp_command *cmd)
+{
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			TRB_TYPE(TRB_CMD_NOOP), false);
+}
+
+/*
+ * Queue a halt endpoint request on the command ring
+ */
+int usbssp_queue_halt_endpoint(struct usbssp_udc *usbssp_data,
+			       struct usbssp_command *cmd,
+			       unsigned int ep_index)
+{
+	u32 trb_slot_id = SLOT_ID_FOR_TRB(usbssp_data->slot_id);
+	u32 trb_ep_index = EP_ID_FOR_TRB(ep_index);
+
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			TRB_TYPE(TRB_HALT_ENDPOINT) | trb_slot_id |
+			trb_ep_index, false);
+}
+
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 927c34579899..0970c7ddcd38 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1685,7 +1685,13 @@ void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 /* USBSSP memory management */
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
+int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
+			struct usbssp_ring *ring,
+			unsigned int num_trbs, gfp_t flags);
 
+struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
+					bool allocate_completion,
+					gfp_t mem_flags);
 void usbssp_free_command(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *command);
 
-- 
2.17.1

