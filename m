Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B29C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA7820875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QyUz8STh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA7820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbeGLF5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:57:55 -0400
Received: from mail-eopbgr710083.outbound.protection.outlook.com ([40.107.71.83]:64240
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbeGLF4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5jqhnEVVJ6pT7/imB8ViXDh5C586UFX8oH/yfk3Ygo=;
 b=QyUz8SThmE0rKUG9QB6URLSEv9eNcFCHO6d+n1hfK0UobQrBZH/GIw3t3RZ8gITvEzJZLUBdcIhMS0AoNPmwoZDtwhxcg7TdKYKhEZZFhSU1oA76mtsSQXM/vwsDZpl4p05eEn7xzhI2z/SNa9X2nRtK68ADcFPcGL8mJ/uoTC0=
Received: from SN4PR0701CA0016.namprd07.prod.outlook.com
 (2603:10b6:803:28::26) by BY1PR0701MB1333.namprd07.prod.outlook.com
 (2a01:111:e400:480f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:48:00 +0000
Received: from CO1NAM05FT008.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by SN4PR0701CA0016.outlook.office365.com
 (2603:10b6:803:28::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:00 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT008.mail.protection.outlook.com (10.152.96.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUR017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:06 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:06 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5loqr029741;
        Thu, 12 Jul 2018 06:47:50 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lowx029739;
        Thu, 12 Jul 2018 06:47:50 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 17/31] usb: usbssp: added implementation of usbssp_halt_endpoint function.
Date:   Thu, 12 Jul 2018 06:47:14 +0100
Message-ID: <1531374448-26532-18-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(36092001)(4720700003)(109986005)(107886003)(4326008)(86362001)(316002)(5660300001)(6666003)(42186006)(54906003)(50226002)(16586007)(106466001)(2906002)(50466002)(26826003)(105596002)(478600001)(48376002)(87636003)(1671002)(76176011)(47776003)(426003)(446003)(14444005)(11346002)(8936002)(246002)(51416003)(336012)(305945005)(7636002)(126002)(356003)(2616005)(8676002)(486006)(476003)(186003)(26005)(36756003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1333;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT008;1:jVMNlvSDJ7PSCX4PDWmFjweFA35ips50j8/8ZTmpZIy7kbWn5POUkU0n3y3p3x5hcDuTfJZO8owvJWwxq8pOMpsecwihxDh4BVMR18w/9/XaX+tQdwWeoR5aCXeEQP0k
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02040e8-f69c-4c8b-5ceb-08d5e7bb0698
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY1PR0701MB1333;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;3:TA/i9JQyrlqrGLZ0tc6ufFPwVEmmwdbMmbajCESfuDl6RW3GPuR/cuoxVnzlWnDOqSvR+jxWABk2bSjcL2A+cPHmON3eVr6fvAE5QUD/7wC306+jgmkPFjrPggNR2TFsxCwI3D328RXAfI/bHVPF6iwpW6hcIgpsuOdtqx8ZfjVXiHXVlrNd7hWXg//rKDm7iEfbA2LyxN+KphhmbGZpjJAnS83tP4tQxWGjroPzgYei56jUQqerbhqGLVz7GcH1EOuaKLviPG/ky1NC3i2o78P3cXuzAAfJZwrV+7EanyZoQ1qmZzHdIkrAQ56Y+lq8BZLN8+r5c32pGq5ogr9fqiUyGXRqe3yf6+OrZtHI6+Y=;25:jx5nvH5ApzsgYoBaYkm7pUAvVwEwmc7Wbww19CQAfg2qbPoHnXEoUKXDLrx5ANW1ox9xnyO6ynpAtXq622HvhaDld9NFdRYAmYrM6sxZ+pNA4+quGWoafEqx2UmbGEIFhzPvCpGtWqotBARHHjQ80RAJdxxMgB9xfwn+iUYcDgS0jIVbtzLGZwlIYI2OxA2CKOJL2flUJINS2n9eh/uhm7wTdD2VlVufj0yhlRy0ToA2lognSylfN++qlFc22rTSyaezmNhmcb23AdcVlOiPpwPbn/dH5Ce1j5yvH67R3Qdaeex/8+aYlvZiU5UXTJ6y+NkAqBlypfKWQ0oVwP0KVg==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1333:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;31:RO6+QF41rENEvKPTES3ggDdco/fjyp9va1ujky/pvhmSySiB5OmOp33cL/XLwFOvki0teWzDOJwAWa6cwr/AgEnsJ2W42hfEDbY0MBswqOW+g2n/y0YTmBdhGS05KV0gG6ir3/1k782XKZrSk6exFQ0SRm07PVyyq/yspaj2GAbHm2hz0F5y84y/yAFyF0bzNUJ7F4D2pBoOGYnYraRTttDHw5lwCsUs9lpZZsuQ73A=;20:re3ZLsk/aqgwJ6y9d8ZwrwjvipOQcjWgoyRbGdWtFRbpZt04PA+9+3UsAfMeIF7OJad25GiYJA+YIDP7XdZDdMZPqfKrDtjWvnF3pk9rR9M3/KOadPY0ifPCETpOXsThFIUtbmKItyTo2AjaIPN8ryqhhC4LTgd45yljcYf+twn5sGDydqb+yF1jFKUdL+TqZVhTkeEcBS7p+0Wxrn/jLilXJz8THgyujOCzucBACLOJWhQ6DxaA9bQHDnnlh599Lbuu37eevS7RR0Gf9ruFu0RhV80ZqalzgaS/UgjTGH3Pks9zSNzBVoOAx6w4Wav2xRHsSIMj4CoojULBm/5HX+E89csm87dnjT22rKn81mujjm9fJ5LQsT7Az+XVAbIq3gZhTcU/euUXZStnt72vwXNgTcB2m/tk/Il2A6W/HEIVyg3mOqy/yd4OSUeVds5Hh31VCs5bZ6kku2krl7s0SNqXrm9/J0IgRe2MlHnQ1ohQ33bBxXIIi3XEmxvyllER
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1333D01F6B5AFDC7F596AB00DD590@BY1PR0701MB1333.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1333;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1333;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;4:mEIpohnh0BLWJic5tEbyhhtO4oVDoo5c3KrCP0+OR+T+IoR4yD0fkcJo6Iv5EKk3YIMQzJXQJGQJYu5XE4S/WK59jHA/s3VCSyustri9gqELRdXSkfERTn95SqS2ePSXO3HGrKDO0IkiSpjb5y23/O2NhIPIzD1vGahZO25x6+1vD76PDN6gRmoMyOQZHIUIlxL81N/74aVXf9DfiQcdH1RXGcFuWhT/6T1TrxISPdQffAClk74fqaYjAfdKtpbxinrEXUKJ99N15yQioftkH6/G2uYDzMWWkO8DVJ8YedYR0rNz+zkHZ1o6ETpUti6S
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1333;23:oBvHcCvjW45kK39SGsMCDCFFPZfe35jK8krPUNa?=
 =?us-ascii?Q?6o9ZvWtCStjtC0Rdfiqejf7O0PdC7U07eTLxnW3iFLZOEQg/x+5cz/YhCBLz?=
 =?us-ascii?Q?KBR6c/MdRvMi2IFKK+4kzlHSCLyQlRUciJc05s2Fl9PC7cZUPDspnQbPs5zd?=
 =?us-ascii?Q?Ebxjs8oeBZIasadeoCDZTwLot0BzLu7td2+jyiHBUT6GIrwbX0deVRBC9Nwn?=
 =?us-ascii?Q?rLFplrok1AjHpfhJitrtmYT64K7Prp0MkprD0Wkaig+oO67ifam/TdNPYL/6?=
 =?us-ascii?Q?hCDsVHhZVHu1wpR7ULFMBVTPQSrPERcqKrVm0gGk1MRCUCb4/zE445G35ArI?=
 =?us-ascii?Q?rMXr+kygJMjrKV1PkChKFQtlkhMrTPLUEX1M3bjE8N3Muw06a0ODkQJ6tjB7?=
 =?us-ascii?Q?sd2Q2BmWahwj3e8Vw+kyOhmgAE88GC++PApadLQKutEG7LYVTDQceNu+hvt/?=
 =?us-ascii?Q?9XVnmTBC+B+h/+ZUV6zyo9zeHLRrm2G5+B8XN45DS68QqYc7NruwxlkSNseT?=
 =?us-ascii?Q?i1wbYNJLbMvIfluy3TZ6KJZlPY85cQF8RPvJNqR7ROV6fT4T39fncoZYmcZM?=
 =?us-ascii?Q?GzYbXuVQZQONRXhbQ3njX+J4nA822EUY2D4CPN1yZZioR1gFin07Yq3pUelC?=
 =?us-ascii?Q?bS97ydWmrOSsTPy2GiwDEL4QMDG6JVAuJcdbYQ9snhEL8mWNWMih9oFx9xQW?=
 =?us-ascii?Q?p18+H62GUOGaKu04jvMnOOPhG5tMJQYxDjzpjG8KkNTwTyulDGlvKuBJig7B?=
 =?us-ascii?Q?rlvo37k+fbD5gMuYm3EsfjiLnoFLQTC1d7f9eWtX7C30jmi9TDppNYcNdpj4?=
 =?us-ascii?Q?g7/rCLUtNPIoS23m6mZY9ht2+/s40tVlRL2lkM89iDUwEx2/Ei+kNaDa2X+J?=
 =?us-ascii?Q?BfmzN1xfy2vR8yhDoig3Zi6uUEs885KoWR38kF8wYR2vjKuhff/dLQ0lf1ve?=
 =?us-ascii?Q?Clplc9sgFhj7NHkRSAtQEEh15WKxC51xpVoU/aK4xEm/X7yZnNDmAaD3oHSa?=
 =?us-ascii?Q?HB3MV5yIlggDvQEdAUqvg037UH9NGDskHcOn+gexGfPKL/9wo6si5s6HEOIQ?=
 =?us-ascii?Q?JySuWstvxu+5Vif6Z1YSzkaM+RW6yD/Ozh2njLBQp2WbAProeG0E8J/TcOKC?=
 =?us-ascii?Q?RthTWuUEtnAny9pE3XWaQKYRnoJncCGNPoOnn18TOhjLzf40zJ+p7FA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: EOowjG59eYfsYj6J8EPUEjRLAUZzeZJbElOwPmKGftZaf1XIu2W+pQhcUuZRepMABA+/5/azGaNgWkdU7YIV3nGRurW45aGCvtG/zb3BPop5TiStA1OqAfrrZrX0o2TibGMavVaTnMFV9FtGWDyKhB99+rQu5u9PR58ZBSJb4fcK+dWorKFi0ZFXD6iqPO2MrVhIS8fCOJcGo1qZ6MSUQJMwG3QDZzNJmtmcJFEGa2KEh+sHe7YmOJ96F5K/S02kS57jeBUXjgcCIevtxLKAma8NpZxIZJoMxhaTh36v3BjX8ge8NO2tGPbmtGwTaodxf0+/cTmNu/OAqruiBUOKHuDWQL3FBQ+frvXQmrMHZrB7QzClvZ1bMhfWcooujIXU1my2uco65LN2e8fResdCpg==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;6:rl2z5RD9YyMGumxzLeE1lyPHeJRAliaOkjbmu1ISaqia3gZP4QtsDsrnbbqEu06xEvGrMLbW6e4rOacjYS6j+15GbVoLv5UIbLONbxfy5VnwBiM7fetv8q44eybkGTrgh//r6wEmvO7vy/y4suiEyJYP3/xC/XQfGYipgm1TWp42EKwE8rwJiNHZ7wX1c5EaPVSU8SP8qY0bLZn8LTB8CzAZDjBJK2O/SKJe+21EBd7S5P63kMiLmAqnqdk7EXdCmQOmedURtwRRtIOXJDCahHWkWg5aC6viFXi4Jc7SkzF3QSk81qRsSIZeESY3uTssaLoxb3JbARr1ACu5wvWhK9ekqsdGDArpTthmFLkE7KA3JKfoUYtDMqVC01i3Zlo18sslq+c8X4sMKnNbE73nukj2HjgRvlvfwA/Z6rmGz8MmQO0RMEa1u9i2pCI5iCgSz3YVB5eNu6h/BocR00OCIg==;5:s3MzYOX+HaTXFBt6RmHekRwX6bDCV71830nv91I2p/XTzwZ+QxzA3rktWzgivaBbeHgsZPwuPpzcQ3T+IVONkSOZaxhZw5rZltO32KbOtZTe7/q9Nf04Ghk1q9qmrVHLV4Fx4LaGc916tGfiaolH7GFvYTJE3QuPuslxBsUz2KM=;24:d6E2jgRhu2+rD/q9Mn66Eyk6ZuvR2JXYuWIAjiVAoW9RJ3mWOS8HDTZmnR6PmiY1iz1T1GP1kdf9esw5uRCnbyCpKSGb7RhRH8Ojt1pHzL0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;7:aFwrd1RgQEk1fkdITYHtLrHRvj6VWRCDRjBMw25KWITGyhjeN/+umMEEYnXtPMbdGfUYHhSKqtHngwce272bETAYDH6YrXENuaNoRVqWn8gAv2octC8cnS1MyKx030e4dC8UorQp0W3uRHPYCl3wYbBB0VbtQ9zzrfZS8b1L01RTvyennxuwdNNWo2JVa8w/tACVOntIpyu2nfvF2tWeSBRo7o7hrBD9GA4dDCQBF1snMjMbUdyTCii7INR+ESC6;20:qNLfGlQA8Qq4AyBWFxtMdyLiPqvKSE6jVCWI2oMdTKZpKzxnj+HKmvSeaDrcYD+TjVuv4YR/QPWFz2GiyLvugj0bZIsKO6ykvL7V6qLJgA2a17WrSTZfiaI5INKtPIkmNPp+tPQb85TYnXnsBQYB5p3rW9SlhCUnbu6jKixGX0gR0feFC3dMvDRIAMFFUaDfyhDiAThHbdVRWAn7OgKgUHFHQwGGe8nwSUZhUNm09fhzu4G6NsVR3QIhpcr8cZ7v
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:59.6467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02040e8-f69c-4c8b-5ceb-08d5e7bb0698
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1333
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
 drivers/usb/usbssp/gadget-ring.c | 127 ++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c      | 151 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |  16 ++++
 5 files changed, 317 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/usbssp/gadget-ep0.c

diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index 22479a6378c4..de8bbcec277e 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -5,7 +5,7 @@ CFLAGS_gadget-trace.o := -I$(src)
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:=  usbssp-plat.o gadget-ring.o \
 				    gadget.o gadget-mem.o gadget-port.o \
-				    gadget-dbg.o
+				    gadget-dbg.o gadget-ep0.o
 
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
index 32bf7a4cae34..983705f6cda9 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -1081,6 +1081,72 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
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
+			ep_index);
+
+	if (GET_EP_CTX_STATE(ep_ctx) != EP_STATE_HALTED) {
+		usbssp_dbg(usbssp_data,
+			"Endpint index %d is not in  halted state.\n",
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
+int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data, unsigned int trb_comp_code)
+{
+	if (trb_comp_code >= 224 && trb_comp_code <= 255) {
+		/* Vendor defined "informational" completion code,
+		 * treat as not-an-error.
+		 */
+		usbssp_dbg(usbssp_data,
+				"Vendor defined info completion code %u\n",
+				trb_comp_code);
+		usbssp_dbg(usbssp_data, "Treating code as success.\n");
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -1412,6 +1478,67 @@ static int prepare_ring(struct usbssp_udc *usbssp_data,
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
+		usbssp_dbg(usbssp_data,
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
+			ep_index, 0);
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
+			command->status == COMP_COMMAND_RING_STOPPED) {
+		usbssp_warn(usbssp_data,
+			"Timeout while waiting for stop endpoint command\n");
+		ret = -ETIME;
+	}
+
+	usbssp_free_command(usbssp_data, command);
+	return ret;
+}
+
 /****		Command Ring Operations		****/
 /* Generic function for queueing a command TRB on the command ring.
  * Check to make sure there's room on the command ring for one command TRB.
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 6637fa010b39..0ae4e1c07035 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -328,6 +328,29 @@ int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated)
 
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
+		const struct usb_endpoint_descriptor *desc)
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
@@ -339,10 +362,136 @@ unsigned int usbssp_last_valid_endpoint(u32 added_ctxs)
 	return fls(added_ctxs) - 1;
 }
 
+/* Returns 1 if the arguments are OK;
+ * returns -EINVAL for NULL pointers.
+ */
+static int usbssp_check_args(struct usbssp_udc *usbssp_data,
+			     struct usbssp_ep *ep, int check_ep,
+			     bool check_dev_priv, const char *func)
+{
+	struct usbssp_device	*dev_priv;
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
+				&usbssp_data->gadget, dep);
+		if (ret < 0) {
+			usbssp_err(usbssp_data,
+					"Command Stop Endpoint failed 1\n");
+			return ret;
+		}
+
+		ret = usbssp_queue_halt_endpoint(usbssp_data, command,
+				ep_index);
+
+		if (ret < 0) {
+			usbssp_err(usbssp_data,
+					"Command Halt Endpoint failed\n");
+			goto command_cleanup;
+		}
+
+		usbssp_ring_cmd_db(usbssp_data);
+		/*wait for ep*/
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
+
+	} else {
+		struct usbssp_td *td;
+
+		/* Issue a reset endpoint command to clear the device side
+		 * halt, followed by a set dequeue command to move the
+		 * dequeue pointer past the TD.
+		 */
+		td = list_first_entry(&dep->ring->td_list, struct usbssp_td,
+				td_list);
+
+		usbssp_cleanup_halted_endpoint(usbssp_data, ep_index,
+				dep->ring->stream_id, td, EP_HARD_RESET);
+
+		goto command_cleanup;
+	}
+
+	ret = command->status;
+
+	switch (ret) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		usbssp_warn(usbssp_data,
+				"Timeout waiting for Halt Endpoint command\n");
+		ret = -ETIME;
+		goto command_cleanup;
+	case COMP_SUCCESS:
+		usbssp_dbg(usbssp_data, "Successful Halt Endpoint command.\n");
+		break;
+	default:
+		if (usbssp_is_vendor_info_code(usbssp_data, ret))
+			break;
+		usbssp_warn(usbssp_data, "Unknown completion code %u for "
+				"Halt Endpoint command.\n", ret);
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
index 38e9b80faf2a..45b568d33723 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1681,6 +1681,7 @@ void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
 void usbssp_free_priv_device(struct usbssp_udc *usbssp_data);
 int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags);
+unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 		struct usbssp_ring *ring, unsigned int num_trbs, gfp_t flags);
@@ -1723,12 +1724,26 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 		struct usbssp_segment *start_seg,
 		union usbssp_trb *start_trb, union usbssp_trb *end_trb,
 		dma_addr_t suspect_dma, bool debug);
+
+int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data,
+		unsigned int trb_comp_code);
 void usbssp_ring_cmd_db(struct usbssp_udc *usbssp_data);
 int usbssp_queue_slot_control(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd, u32 trb_type);
 int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd,
 		unsigned int ep_index, int suspend);
+int usbssp_queue_reset_ep(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *cmd,
+		unsigned int ep_index, enum usbssp_ep_reset_type reset_type);
+void usbssp_cleanup_halted_endpoint(struct usbssp_udc *usbssp_data,
+		unsigned int ep_index,
+		unsigned int stream_id,
+		struct usbssp_td *td,
+		enum usbssp_ep_reset_type reset_type);
+int usbssp_queue_halt_endpoint(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *cmd,
+		unsigned int ep_index);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
@@ -1761,6 +1776,7 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data,
 		struct usbssp_ep *dep, int value);
 int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		struct usbssp_ep *ep_priv);
+int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
 static inline char *usbssp_slot_state_string(u32 state)
 {
-- 
2.17.1

