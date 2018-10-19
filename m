Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01000ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FADD2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="XiKQbLxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FADD2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJSPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:52:23 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:41984
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeJSPwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfCVrSLLS4Llwiyzb9p0rmevtnhqfCAWc/YZNuwx8zI=;
 b=XiKQbLxaLxvDcoJvTjRTqEW5VqAKuIBKEl9sMY6k2cQSQ0PaIMiXIlJg8vLUWIPneD9wd63k2noN6G9pvQrT8+WaRIVYWTMsIqR6h/xQje27c0mHbZ240RH6TaRIVlqJ+NMrycWUbVd6NYqLJFknZ/p0iWBzmljVFewtUaGN4VU=
Received: from DM6PR03CA0012.namprd03.prod.outlook.com (2603:10b6:5:40::25) by
 BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Fri, 19 Oct 2018 07:47:17 +0000
Received: from BY2FFO11FD014.protection.gbl (2a01:111:f400:7c0c::180) by
 DM6PR03CA0012.outlook.office365.com (2603:10b6:5:40::25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.31 via Frontend Transport; Fri, 19 Oct 2018 07:47:16 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD014.mail.protection.outlook.com (10.1.14.76) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.12
 via Frontend Transport; Fri, 19 Oct 2018 07:47:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9J7lF46018859
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 19 Oct 2018 00:47:15 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 19 Oct 2018
 03:47:14 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 2/3] iio: adc: Add ad7124 support
Date:   Fri, 19 Oct 2018 10:46:52 +0300
Message-ID: <1539935212-8796-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(438002)(37524003)(199004)(189003)(50226002)(4326008)(8676002)(316002)(575784001)(26005)(77096007)(54906003)(6306002)(8936002)(2906002)(53416004)(186003)(23676004)(7696005)(2616005)(476003)(426003)(106002)(336012)(305945005)(126002)(7636002)(44832011)(486006)(246002)(2870700001)(6916009)(107886003)(478600001)(966005)(4744004)(5660300001)(6666004)(356004)(72206003)(14444005)(36756003)(47776003)(5820100001)(2351001)(106466001)(1720100001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD014;1:RJFeYJiK73MNEcW4CYnOsfrCn0y7reLj9OKKrFt2ckIjrgbaDzuN+SbNW/Fcm2w6PKbyDus1LW1qU0UMXrTtmPA1ZnaPuJFHVet5fqgfWnUzgvl0wsEsJSXkvuGyCe/C
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffcbdcfe-cf30-40df-c01e-08d635971746
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;3:wPVWVFlygk/YW0cTrVrsG6z4TfCy3EZylGrXjvnEc0piWNOok4emJpfvIWW0xSD4Az2EFrmVshQzVxnbo1i5OSo+w1xrEcbIXkT+fwrDKDpSZ2MNuombHQb0SVmnV5E6PZBa5+vqYkPI+x1eBGObsdX6GQLsXoa4ZxJELxL8QPv03jyDhUAwNvNVpJUS9wiPq5ccqsgqQ2ldqNWDUv9VimmXmPFCBhIDkYwWX0TLa3QOrItjSstLG5ZOwAPNmCi8HLmOcqLFAxmRQe/e6WNazaEyWVbgDMcJNLVhKofGF+tz6VQz188cOxvpB3aMiOAkzSqPkOdOp7HcuCq0n+3ADbMqQhiirTTigxqCTmbdfS8=;25:jhy4/BfWz4kp1cUMrjxBNbLJeoNnq/iJbanzFR+Q7ebBScUfe+h9jUjd8+y6oAkSCqOTTmBxuac5lcuudHwk4pdCG4XTIw5waG9EjaQIvNJyHuKMCo6vRHYbjKUJ396uO807MrYYUpcrzNPy98a3/gHqY/xqnq2tthwnxFpJrER54yonWTq4qzieaunq138uhgWOZ3+dU3XWZVnBI/NeTFqFciOD17bSr6Var/rrNXnIaYqSxuSED0/k58Gf5maniItBTlwadd6QxXwqR9GcMdsBResFjaRElQCsn8QS/rQ6aDktpW1h0TZsqDxAmsOzu686WxcYEpLrwtS511gt8Wd+d64dVlr5OAbUNxliDyI=
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;31:M5GT/ppyFV/YyP6FAvesc+xeD9tHJQyk4Solt0cakBkU8+fQTtpq9+NDl/9gE/Wbe63RYRZUZPjeBlKyi+eEXvHAoe+/JDEsk2+SlNu9Bmb6CIiGhpGd4nmDpJ844lSsUYOkVd7GRyrJOMDpP7f0vn2UxjiDVMp//7ExS9vR44FA/71GvZHIYuazNjSuOFw8/OCv5EWLCFA6/g9HVNBTQJNb7M/AerV/FD5sQjBaLzo=;20:LSu1heX8VmBrDqR5EToJOIFPfRjDBHmb9VYc6bbHK9a4hW+b+nNGHpi2ppJq5gM00eAL2zmnjJI6gZ/1e2jnoIHWZptRZKhVDfAa9AYr0Hi4DNUICfXdZuR+E0vcBtDlw2MlPstljRFLKAuoh0JXDTveyg7+GP1t9iZP54wX9a1kPMeiYkUc6IeD0p17M6aDTpc6ZItMQWhI1hcakZ9xmml/njJdNmXh8kPFX2JBCgPMYJyxtj2EMmYFiuHE8UAulKDVG8zdxQCwmVp/gllJUgAhShyGwE99pNttd0/VYgD7qbg0aCgwReZ+btBxsxqydMdMpCsarVBhGyEINwNVShVnJOUQ5pTMvICrvebXx28A5l8CCex617HuFAxyH/eA368P2w9VqXYDXnUfEY3A4GCo0i+xtD8tYVtaFFZIGC1dgW2eCtsY2y+NbmwTgrhko0PT+ra3lf6CqRG/RQQsaP0fBDo8O0fdfL0OlAPrmKjrZkqak3STZOxTYvfX0xKQ
X-Microsoft-Antispam-PRVS: <BLUPR03MB552306E3D756ED001FDB0679DF90@BLUPR03MB552.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(9452136761055)(170811661138872)(95692535739014);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(4982022)(52105095)(93006095)(93004095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BLUPR03MB552;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;4:N5YIb9yt7PqBOw6mXYzeaHdVOao+A6/RPyiRD/hylkQywT2h/l+DaJpQcdLfm66wbNp6IZ+DJ7rP01IXkvKMc2PjVRDEvZjkn0SuD5MYu++TscqiVCkdBpzkBNXd865HjwMuv2rLgJ9wwMSmr4m1lkusExmAzJEGfckxAMVkhQA59daulTjUNsuKYWmq1z818DPSkZwQ1sACgAx3GsN5IJE9v7dtQh6+1+XdzFNu6MbQrYSYNLyfaOOx4JROn6ks7VG6tatsXYJTr5whkrbAEnH06ItpSuOkf2lUyOHDO652/LSqF+9kQ+2Jm+DBMvZWBvn5LxxFOLb/aU5S9Ledue2wpVRGMikdxF6vH6JV2EEXArCgqfYr4EhSb8CEC8gnU5aOw88F6egYHHvdcO6ePvgRt9H9PlbEbAgd4djTowl/n+uIYpiKTcOpwvqWvfPzowaxlkj+pceXTlQW1ZGvzw==
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAzTUI1NTI7MjM6dHo0NU9xOG9TZlBzbERCTWVjOGVEbjVlT05V?=
 =?utf-8?B?d2lmUUh6OHYveXhLeGQvNE91a01jdlNrQ2VWV1g4RVVxZkE0WkVJRHpjSHNL?=
 =?utf-8?B?QVBVQUtRSmFlNWtuMDdJelE3cHU5TjVrOG9qRlRUQ1VlQmlNUUxlTVpxNXRX?=
 =?utf-8?B?WmpDSjhzNXIzVUoxNno0bFZvNnIyM1pKcGxZbHpQWFp3WjBKL1NSZU95VjJK?=
 =?utf-8?B?VzVBZzVHYnNFUHdkaUNlMTRFd3BBelMxMmxEblpDTjJ2dGE3Z01YRHIvUG5z?=
 =?utf-8?B?Yzh2cHllTHpQc25UME9iSFhIVmZsRG1FdXJZWGRCVzRKVG92cC9xOUk5WTdz?=
 =?utf-8?B?NTZIdlJXTmc3cGM1RmJZeC9vZkJVaUd3MllsOVVSVWd0cytISUU2US96NXFB?=
 =?utf-8?B?eUdyUUFpK1V1TUIyMWp2MW9yUC9WZlV3N2tqclhuQ0pWQ3NOM0ZOZGFnQm9X?=
 =?utf-8?B?UzlRZnBsL2FRcHJ5UkVJYU92cU5JaEh5QzRrUDl3aVhFeEtlNWpiWFZLTFBJ?=
 =?utf-8?B?MVZyZHhSVzI0ZGJOeGcxYTgyb3ZVVG1OVXlXZldsTE5wb3c4SDd1Nkw4RGx4?=
 =?utf-8?B?OENMUlBuam1mRHVybFpMMENrSENFTVJNTTZZU0N0YWNiditrdWQzTEpiZlJL?=
 =?utf-8?B?MHJ0aGNpRUxTTVdONlQzQU5sYmRkT2QwSG1IL2JlWFlKeTBOQkdIUjNEclFh?=
 =?utf-8?B?dTlEUG9SNkgwTkVrRWcreERLY3I1K2JEbkZma2taa0xsU3lweEZUQXNkWG1B?=
 =?utf-8?B?aUkxcGhzOUc5Ly94Q3NpTElxUmdubUF0b3pYZzEvb3FkTEpMRUd1d011UytL?=
 =?utf-8?B?UUhWaU9VUDlpZ2lSRDBjSTh2b3pvd05nMFV1WlVhOTN6L041d3htaFJrVkJD?=
 =?utf-8?B?Wm1JWVFYV3pDNTdHbXZjQzhwTi9HcUErYVVTdlZRaDFQSjBtbXJpYjdaUDY2?=
 =?utf-8?B?YmdrWXlMWStHSUlQR2hkYU1ud1VyZ3BEd2s5dGN4bkM2Vm5yOW1JOWtOYVRV?=
 =?utf-8?B?QStlbDRpM2FOdFVneVoxWWdXNUxVZ3cxR1MvTEs4c2JJTUF0RHZUdld0WW1V?=
 =?utf-8?B?WXNNa0I0Z25JVkZJcklHZEozU2h6RlI1aDI3TUFQcEdUQ3B4ZW4zRzUwNm5I?=
 =?utf-8?B?b0NCSzh5T0k5a1Z5ejZEc2kzVlJtQnU3Smk1aFhOOEMwUlZ0MGs4ZWFIV29a?=
 =?utf-8?B?TVpNc2NZclpCb3dlbTA4dFRjRTBWcXpqRnVBMFR1SXJwaVk5cmhhQ1hraU9k?=
 =?utf-8?B?TElLNU9kaGtjWURhUlRkYUptZ2ErbngrNzVoQzk0ZHd0dXRhMVZFRENLdmtW?=
 =?utf-8?B?cTI5SzQyb2ZPN09HcE1VUjNBVmdXby9BSTF6QUhFeUxCdzF6eVhMYlpYNmlZ?=
 =?utf-8?B?emVrU2w4MlE5VVFOSGowMWtDRll6cHROMi9TTGVYcmxiUytMeU5LckxUNCt0?=
 =?utf-8?B?MWREMXZUbEQvUTFXamtIN0IxWUxOOGoyWndNUHhobnV1MFpiaHI4MVo5ODlX?=
 =?utf-8?B?b1FWYi9FKy9nSGxENzFEWWthUCsyTkErRDVDTmdPMTRXeDNVbWpFQ3lZUVRB?=
 =?utf-8?Q?IAd9Ohffa96QBu6PysBhxjMlxFZmo3qYPOoDp+ubzkQ=3D?=
X-Microsoft-Antispam-Message-Info: tiU8lhTX9O1iw+zfxTM2idlI48wvKRVoCw+AYvlzhcEPcqOyiNQKxP1EB/sLLdwq/lHiL7VdM/8FauKz0Y+tDqk20MyJgRODR/r81LqBmfqZAABLFh0r1EgzfRXMzxp9EdQK4PK/UBydpXuud6Ff7gg2GMEn7Gbzb8L8axo4IOvmNtZ7VJVAvoYG1TeFCRbfCLN53yrGFuk5pbC/82iJo7wP84yCvkGZCd53LmGKc10asttiBy+K6UXBFD2QTbTkewhDTJtVw5h34LSg0MBj1Z3tQlmnGjyZHCvX0yyHFMRLWuWwv57pqB8AEpU7K7umcJhdbfBptOkPpNE2h9QCdjc4K7hzsikXAh1Spcp63CY=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;6:oILLgZzozLAJQIT+g6v2FUxGSURc5w9HmjA6ELYk7pMfjMDSeZn08G2J1tTh48GWkX6IofurPZOSH/gB2WX+rH1zK321zW9qrztt2+mjgkRTJ2dUhvSU/yBh0rkJu16PA9htAuPC5G2jVwP5qupepdZTaKif34J93jSxyIBTHESYOm2vBGAUucw2iEmkGyGx8qMgxWffy7fCqwT6WAkCykTSFTweEUPp5unZYgbkk13YVOQC3tfbLnlJLoo4bo7AMpGlms7IdD9N9CFj68ZG5LrxiUEXH45C6h4hB4oNnZk/rl5vN1vZCwjY6CvAyN5KXOkJwgq7dQG3673SfPbzICBWSuO/CIr+4BTLY2y7DTizOIglsT+zukxTHmbCfafit3fb01/Csr8agSLz/yrTomoONzt2+kbdVos4zwrP0rtP6fKdvTpzfXEzwgeLMIAekvDN3jri+uI1bWToPL1Lxw==;5:498gUtY9s+OF8MZKz46ojZ+YU4o3QCgP2cCAjkpkuMTwCAJT10BJdTR5Giq1htunNo4h9emQa5bM4Qa2MvEXtaN4MP+YOPRw2ahf9deD0CiG5ctztaOjnt1ms7ubMj4gHQ+51JRjoBpobT9ONtpEcHcNYLVwYLbjlMxPKDVltcw=;7:0oJmLKawG9c4U78DWW4cFIWKlsYcdbG7Nc9Y6V/1q/m7tvG2e6E+ioXMYRI2taqFhMBo+cIbpDyMeuGb5AJA+T7ibKYSMAl/HyMytNwZg2sGoIyLNzBt2alMHNm/AaQC4DhwPZPyD0ZkDcq+mmllbs0GI/75ksvdDFIYUml+hv+fplH4qTfbLHR4WGNFRk20TQhG/MbsG3tvDMyFN0sdwJEwIUNtrOpkG5OtWF7AFnl8QWfNaWWifmEU/1XGNsAM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 07:47:16.3382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcbdcfe-cf30-40df-c01e-08d635971746
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad7124-4 and ad7124-8 are a family of 4 and 8 channel sigma-delta ADCs
with 24-bit precision and reference.

Three power modes are available which in turn affect the output data rate:
 * Full power: 9.38 SPS to 19,200 SPS
 * Mid power: 2.34 SPS to 4800 SPS
 * Low power: 1.17 SPS to 2400 SPS

The ad7124-4 can be configured to have four differential inputs, while
ad7124-8 can have 8. Moreover, ad7124 also supports per channel
configuration. Each configuration consists of gain, reference source,
output data rate and bipolar/unipolar configuration.

Datasheets:
Link: http://www.analog.com/media/en/technical-documentation/data-sheets/AD7124-4.pdf
Link: http://www.analog.com/media/en/technical-documentation/data-sheets/ad7124-8.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Nothing changed.

 MAINTAINERS              |   7 +
 drivers/iio/adc/Kconfig  |  11 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7124.c | 655 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 674 insertions(+)
 create mode 100644 drivers/iio/adc/ad7124.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f642044..3a1bfcb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -839,6 +839,13 @@ S:	Supported
 F:	drivers/iio/dac/ad5758.c
 F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
+ANALOG DEVICES INC AD7124 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/ad7124.c
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a52fea8..148a10f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -10,6 +10,17 @@ config AD_SIGMA_DELTA
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 
+config AD7124
+	tristate "Analog Devices AD7124 and similar sigma-delta ADCs driver"
+	depends on SPI_MASTER
+	select AD_SIGMA_DELTA
+	help
+	  Say yes here to build support for Analog Devices AD7124-4 and AD7124-8
+	  SPI analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7124.
+
 config AD7266
 	tristate "Analog Devices AD7265/AD7266 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index a6e6a0b..76168b2 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
+obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7298) += ad7298.o
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
new file mode 100644
index 0000000..c6d9798
--- /dev/null
+++ b/drivers/iio/adc/ad7124.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD7124 SPI ADC driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/adc/ad_sigma_delta.h>
+#include <linux/iio/sysfs.h>
+
+/* AD7124 registers */
+#define AD7124_COMMS			0x00
+#define AD7124_STATUS			0x00
+#define AD7124_ADC_CONTROL		0x01
+#define AD7124_DATA			0x02
+#define AD7124_IO_CONTROL_1		0x03
+#define AD7124_IO_CONTROL_2		0x04
+#define AD7124_ID			0x05
+#define AD7124_ERROR			0x06
+#define AD7124_ERROR_EN		0x07
+#define AD7124_MCLK_COUNT		0x08
+#define AD7124_CHANNEL(x)		(0x09 + (x))
+#define AD7124_CONFIG(x)		(0x19 + (x))
+#define AD7124_FILTER(x)		(0x21 + (x))
+#define AD7124_OFFSET(x)		(0x29 + (x))
+#define AD7124_GAIN(x)			(0x31 + (x))
+
+/* AD7124_STATUS */
+#define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
+
+/* AD7124_ADC_CONTROL */
+#define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
+#define AD7124_ADC_CTRL_PWR(x)		FIELD_PREP(AD7124_ADC_CTRL_PWR_MSK, x)
+#define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
+#define AD7124_ADC_CTRL_MODE(x)	FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
+
+/* AD7124_CHANNEL_X */
+#define AD7124_CHANNEL_EN_MSK		BIT(15)
+#define AD7124_CHANNEL_EN(x)		FIELD_PREP(AD7124_CHANNEL_EN_MSK, x)
+#define AD7124_CHANNEL_SETUP_MSK	GENMASK(14, 12)
+#define AD7124_CHANNEL_SETUP(x)	FIELD_PREP(AD7124_CHANNEL_SETUP_MSK, x)
+#define AD7124_CHANNEL_AINP_MSK	GENMASK(9, 5)
+#define AD7124_CHANNEL_AINP(x)		FIELD_PREP(AD7124_CHANNEL_AINP_MSK, x)
+#define AD7124_CHANNEL_AINM_MSK	GENMASK(4, 0)
+#define AD7124_CHANNEL_AINM(x)		FIELD_PREP(AD7124_CHANNEL_AINM_MSK, x)
+
+/* AD7124_CONFIG_X */
+#define AD7124_CONFIG_BIPOLAR_MSK	BIT(11)
+#define AD7124_CONFIG_BIPOLAR(x)	FIELD_PREP(AD7124_CONFIG_BIPOLAR_MSK, x)
+#define AD7124_CONFIG_REF_SEL_MSK	GENMASK(4, 3)
+#define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
+#define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
+#define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
+
+/* AD7124_FILTER_X */
+#define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
+#define AD7124_FILTER_FS(x)		FIELD_PREP(AD7124_FILTER_FS_MSK, x)
+
+enum ad7124_ids {
+	ID_AD7124_4,
+	ID_AD7124_8,
+};
+
+enum ad7124_ref_sel {
+	AD7124_REFIN1,
+	AD7124_REFIN2,
+	AD7124_INT_REF,
+	AD7124_AVDD_REF,
+};
+
+enum ad7124_power_mode {
+	AD7124_LOW_POWER,
+	AD7124_MID_POWER,
+	AD7124_FULL_POWER,
+};
+
+static const unsigned int ad7124_gain[8] = {
+	1, 2, 4, 8, 16, 32, 64, 128
+};
+
+static const int ad7124_master_clk_freq_hz[3] = {
+	[AD7124_LOW_POWER] = 76800,
+	[AD7124_MID_POWER] = 153600,
+	[AD7124_FULL_POWER] = 614400,
+};
+
+static const char * const ad7124_ref_names[] = {
+	[AD7124_REFIN1] = "refin1",
+	[AD7124_REFIN2] = "refin2",
+	[AD7124_INT_REF] = "int",
+	[AD7124_AVDD_REF] = "avdd",
+};
+
+struct ad7124_chip_info {
+	unsigned int num_inputs;
+};
+
+struct ad7124_channel_config {
+	enum ad7124_ref_sel refsel;
+	bool bipolar;
+	unsigned int ain;
+	unsigned int vref_mv;
+	unsigned int pga_bits;
+	unsigned int odr;
+};
+
+struct ad7124_state {
+	const struct ad7124_chip_info *chip_info;
+	struct ad_sigma_delta sd;
+	struct ad7124_channel_config channel_config[4];
+	struct regulator *vref[4];
+	struct clk *mclk;
+	unsigned int adc_control;
+	unsigned int num_channels;
+};
+
+static const struct iio_chan_spec ad7124_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.channel = 0,
+	.address = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_index = 0,
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 24,
+		.storagebits = 32,
+		.shift = 0,
+	},
+};
+
+static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
+	[ID_AD7124_4] = {
+		.num_inputs = 8,
+	},
+	[ID_AD7124_8] = {
+		.num_inputs = 16,
+	},
+};
+
+static int ad7124_find_closest_match(const int *array,
+				     unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val <= array[i])
+			return i;
+	}
+
+	return size - 1;
+}
+
+static int ad7124_spi_write_mask(struct ad7124_state *st,
+				 unsigned int addr,
+				 unsigned long mask,
+				 unsigned int val,
+				 unsigned int bytes)
+{
+	unsigned int readval;
+	int ret;
+
+	ret = ad_sd_read_reg(&st->sd, addr, bytes, &readval);
+	if (ret < 0)
+		return ret;
+
+	readval &= ~mask;
+	readval |= val;
+
+	return ad_sd_write_reg(&st->sd, addr, bytes, readval);
+}
+
+static int ad7124_set_mode(struct ad_sigma_delta *sd,
+			   enum ad_sigma_delta_mode mode)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+
+	st->adc_control &= ~AD7124_ADC_CTRL_MODE_MSK;
+	st->adc_control |= AD7124_ADC_CTRL_MODE(mode);
+
+	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
+}
+
+static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+	unsigned int val;
+
+	val = st->channel_config[channel].ain | AD7124_CHANNEL_EN(1) |
+	      AD7124_CHANNEL_SETUP(channel);
+
+	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(channel), 2, val);
+}
+
+static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
+	.set_channel = ad7124_set_channel,
+	.set_mode = ad7124_set_mode,
+	.has_registers = true,
+	.addr_shift = 0,
+	.read_mask = BIT(6),
+	.data_reg = AD7124_DATA,
+};
+
+static int ad7124_set_channel_odr(struct ad7124_state *st,
+				  unsigned int channel,
+				  unsigned int odr)
+{
+	unsigned int fclk, odr_sel_bits;
+	int ret;
+
+	fclk = clk_get_rate(st->mclk);
+	/*
+	 * FS[10:0] = fCLK / (fADC x 32) where:
+	 * fADC is the output data rate
+	 * fCLK is the master clock frequency
+	 * FS[10:0] are the bits in the filter register
+	 * FS[10:0] can have a value from 1 to 2047
+	 */
+	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
+	if (odr_sel_bits < 1)
+		odr_sel_bits = 1;
+	else if (odr_sel_bits > 2047)
+		odr_sel_bits = 2047;
+
+	ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
+				    AD7124_FILTER_FS_MSK,
+				    AD7124_FILTER_FS(odr_sel_bits), 3);
+	if (ret < 0)
+		return ret;
+	/* fADC = fCLK / (FS[10:0] x 32) */
+	st->channel_config[channel].odr =
+		DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
+
+	return 0;
+}
+
+static int ad7124_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	int idx, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ad_sigma_delta_single_conversion(indio_dev, chan, val);
+		if (ret < 0)
+			return ret;
+
+		/* After the conversion is performed, disable the channel */
+		ret = ad_sd_write_reg(&st->sd,
+				      AD7124_CHANNEL(chan->address), 2,
+				      st->channel_config[chan->address].ain |
+				      AD7124_CHANNEL_EN(0));
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		idx = st->channel_config[chan->address].pga_bits;
+		*val = st->channel_config[chan->address].vref_mv /
+			ad7124_gain[idx];
+		if (st->channel_config[chan->address].bipolar)
+			*val2 = chan->scan_type.realbits - 1;
+		else
+			*val2 = chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		if (st->channel_config[chan->address].bipolar) {
+			/* Code = 2^(n − 1) × ((Ain × Gain / Vref) + 1) */
+			idx = st->channel_config[chan->address].pga_bits;
+			*val = -(st->channel_config[chan->address].vref_mv /
+				 ad7124_gain[idx]);
+		} else {
+			*val = 0;
+		}
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->channel_config[chan->address].odr;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7124_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad7124_set_channel_odr(st, chan->address, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad7124_info = {
+	.read_raw = ad7124_read_raw,
+	.write_raw = ad7124_write_raw,
+};
+
+static int ad7124_soft_reset(struct ad7124_state *st)
+{
+	unsigned int readval, timeout;
+	int ret;
+
+	ret = ad_sd_reset(&st->sd, 64);
+	if (ret < 0)
+		return ret;
+
+	timeout = 100;
+	do {
+		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
+		if (ret < 0)
+			return ret;
+
+		if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
+			return 0;
+
+		/* The AD7124 requires typically 2ms to power up and settle */
+		usleep_range(100, 2000);
+	} while (--timeout);
+
+	dev_err(&st->sd.spi->dev, "Soft reset failed\n");
+
+	return -EIO;
+}
+
+static int ad7124_init_channel_vref(struct ad7124_state *st,
+				    unsigned int channel_number)
+{
+	unsigned int refsel = st->channel_config[channel_number].refsel;
+
+	switch (refsel) {
+	case AD7124_REFIN1:
+	case AD7124_REFIN2:
+	case AD7124_AVDD_REF:
+		if (IS_ERR(st->vref[refsel])) {
+			dev_err(&st->sd.spi->dev,
+				"Error, trying to use external voltage reference without a %s regulator.",
+				ad7124_ref_names[refsel]);
+				return PTR_ERR(st->vref[refsel]);
+		}
+		st->channel_config[channel_number].vref_mv =
+			regulator_get_voltage(st->vref[refsel]);
+		/* Conversion from uV to mV */
+		st->channel_config[channel_number].vref_mv /= 1000;
+		break;
+	case AD7124_INT_REF:
+		st->channel_config[channel_number].vref_mv = 2500;
+		break;
+	default:
+		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
+					  struct device_node *np)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	struct device_node *chan_node, *child;
+	struct iio_chan_spec *chan;
+	unsigned int ain[2], channel = 0, tmp;
+	int ret, res;
+
+	chan_node = of_get_child_by_name(np, "adi,channels");
+	if (!chan_node) {
+		dev_err(indio_dev->dev.parent,
+			"failed to find channels node\n");
+		return -ENODEV;
+	}
+
+	st->num_channels = of_get_available_child_count(chan_node);
+	if (!st->num_channels) {
+		dev_err(indio_dev->dev.parent, "no channel children\n");
+		return -ENODEV;
+	}
+
+	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
+			    sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	indio_dev->channels = chan;
+	indio_dev->num_channels = st->num_channels;
+
+	for_each_available_child_of_node(chan_node, child) {
+		ret = of_property_read_u32_array(child, "reg", ain, 2);
+		if (ret)
+			goto err;
+
+		ret = of_property_read_u32(child,
+					   "adi,channel-number", &channel);
+		if (ret)
+			goto err;
+
+		if (ain[0] >= st->chip_info->num_inputs ||
+		    ain[1] >= st->chip_info->num_inputs) {
+			dev_err(indio_dev->dev.parent,
+				"Input pin number out of range.\n");
+			ret = -EINVAL;
+			goto err;
+		}
+		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
+						  AD7124_CHANNEL_AINM(ain[1]);
+		st->channel_config[channel].bipolar =
+			of_property_read_bool(child, "adi,bipolar");
+
+		ret = of_property_read_u32(child, "adi,reference-select", &tmp);
+		if (ret)
+			st->channel_config[channel].refsel = AD7124_INT_REF;
+		else
+			st->channel_config[channel].refsel = tmp;
+
+		ret = of_property_read_u32(child, "adi,gain", &tmp);
+		if (ret) {
+			st->channel_config[channel].pga_bits = 0;
+		} else {
+			res = ad7124_find_closest_match(ad7124_gain,
+						ARRAY_SIZE(ad7124_gain), tmp);
+			st->channel_config[channel].pga_bits = res;
+		}
+
+		ret = of_property_read_u32(child, "adi,odr-hz", &tmp);
+		if (ret)
+			/*
+			 * 9 SPS is the minimum output data rate supported
+			 * regardless of the selected power mode.
+			 */
+			st->channel_config[channel].odr = 9;
+		else
+			st->channel_config[channel].odr = tmp;
+
+		*chan = ad7124_channel_template;
+		chan->address = channel;
+		chan->scan_index = channel;
+		chan->channel = ain[0];
+		chan->channel2 = ain[1];
+
+		chan++;
+	}
+	of_node_put(chan_node);
+
+	return 0;
+err:
+	of_node_put(chan_node);
+	of_node_put(child);
+
+	return ret;
+}
+
+static int ad7124_setup(struct ad7124_state *st)
+{
+	unsigned int val, fclk, power_mode;
+	int i, ret;
+
+	fclk = clk_get_rate(st->mclk);
+	if (!fclk)
+		return -EINVAL;
+
+	/* The power mode changes the master clock frequency */
+	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
+					ARRAY_SIZE(ad7124_master_clk_freq_hz),
+					fclk);
+	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
+		ret = clk_set_rate(st->mclk, fclk);
+		if (ret)
+			return ret;
+	}
+
+	/* Set the power mode */
+	st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
+	st->adc_control |= AD7124_ADC_CTRL_PWR(power_mode);
+	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < st->num_channels; i++) {
+		val = st->channel_config[i].ain | AD7124_CHANNEL_SETUP(i);
+		ret = ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, val);
+		if (ret < 0)
+			return ret;
+
+		ret = ad7124_init_channel_vref(st, i);
+		if (ret < 0)
+			return ret;
+
+		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
+		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
+		      AD7124_CONFIG_PGA(st->channel_config[i].pga_bits);
+		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
+		if (ret < 0)
+			return ret;
+
+		ret = ad7124_set_channel_odr(st, i, st->channel_config[i].odr);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int ad7124_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id;
+	struct ad7124_state *st;
+	struct iio_dev *indio_dev;
+	int i, ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	id = spi_get_device_id(spi);
+	st->chip_info = &ad7124_chip_info_tbl[id->driver_data];
+
+	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
+
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad7124_info;
+
+	ret = ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(st->vref); i++) {
+		if (i != AD7124_INT_REF)
+			st->vref[i] = devm_regulator_get_optional(&spi->dev,
+							ad7124_ref_names[i]);
+		if (IS_ERR_OR_NULL(st->vref[i]))
+			continue;
+
+		ret = regulator_enable(st->vref[i]);
+		if (ret)
+			return ret;
+	}
+
+	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(st->mclk)) {
+		ret = PTR_ERR(st->mclk);
+		goto error_regulator_disable;
+	}
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret < 0)
+		goto error_regulator_disable;
+
+	ret = ad7124_soft_reset(st);
+	if (ret < 0)
+		goto error_clk_disable_unprepare;
+
+	ret = ad7124_setup(st);
+	if (ret < 0)
+		goto error_clk_disable_unprepare;
+
+	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	if (ret < 0)
+		goto error_clk_disable_unprepare;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to register iio device\n");
+		goto error_remove_trigger;
+	}
+
+	return 0;
+
+error_remove_trigger:
+	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+error_clk_disable_unprepare:
+	clk_disable_unprepare(st->mclk);
+error_regulator_disable:
+	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
+		if (!IS_ERR_OR_NULL(st->vref[i]))
+			regulator_disable(st->vref[i]);
+	}
+
+	return ret;
+}
+
+static int ad7124_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7124_state *st = iio_priv(indio_dev);
+	int i;
+
+	iio_device_unregister(indio_dev);
+	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+	clk_disable_unprepare(st->mclk);
+
+	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
+		if (!IS_ERR_OR_NULL(st->vref[i]))
+			regulator_disable(st->vref[i]);
+	}
+
+	return 0;
+}
+
+static const struct spi_device_id ad7124_id_table[] = {
+	{ "ad7124-4", ID_AD7124_4 },
+	{ "ad7124-8", ID_AD7124_8 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7124_id_table);
+
+static const struct of_device_id ad7124_of_match[] = {
+	{ .compatible = "adi,ad7124-4" },
+	{ .compatible = "adi,ad7124-8" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7124_of_match);
+
+static struct spi_driver ad71124_driver = {
+	.driver = {
+		.name = "ad7124",
+		.of_match_table = ad7124_of_match,
+	},
+	.probe = ad7124_probe,
+	.remove	= ad7124_remove,
+	.id_table = ad7124_id_table,
+};
+module_spi_driver(ad71124_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7124 SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

