Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ED221908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Tr4iBaIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbeLUKN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:13:28 -0500
Received: from mail-eopbgr780049.outbound.protection.outlook.com ([40.107.78.49]:10753
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731874AbeLUKNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRv0/dY0x0e+vtZKPPoEnG92Yz1tumhSE6uRBjUxJ7g=;
 b=Tr4iBaIPPjz4p899AJMf4Zp/2a+3/Y0kqIoWuo3JPUL+DVQdMoTJKshQxiHlXDmTGtsg6kWtRyftclPj8wF7WSmtnKH1xhF8GHkZPc8KhmQFGtspShxQfg0eDm+LMtyv/Z32LM3PdYrhORUbGRIWd9VxsLRRLQG/x6MgoXH14UQ=
Received: from BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21)
 by DM6PR02MB5226.namprd02.prod.outlook.com (2603:10b6:5:48::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Fri, 21 Dec
 2018 10:13:20 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BYAPR02CA0044.outlook.office365.com
 (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Fri, 21 Dec 2018 10:13:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Fri, 21 Dec 2018 10:13:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gaHnx-00056N-0E; Fri, 21 Dec 2018 02:13:17 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gaHnr-0007Ea-TY; Fri, 21 Dec 2018 02:13:11 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBLADB3A024050;
        Fri, 21 Dec 2018 02:13:11 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gaHnr-0007EM-2G; Fri, 21 Dec 2018 02:13:11 -0800
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: [GIT PULL] arch/microblaze patches for 5.0-rc1
Message-ID: <878c9d07-cc61-5599-3b99-8c29ae59a3df@xilinx.com>
Date:   Fri, 21 Dec 2018 11:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(199004)(189003)(6916009)(64126003)(9786002)(356004)(4001150100001)(2906002)(31686004)(8676002)(58126008)(230700001)(81166006)(316002)(81156014)(26005)(186003)(50466002)(44832011)(36756003)(77096007)(65956001)(63266004)(106002)(426003)(486006)(2616005)(8936002)(476003)(126002)(65826007)(305945005)(478600001)(5660300001)(23676004)(106466001)(65806001)(47776003)(336012)(31696002)(4326008)(2486003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5226;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT025;1:ZnReotxFzc2qiSfFrb4XmDt7zCDHo3WF2NL/3SZZCC/jaDvXzSv3n1rtYTNPi69N5qHKhy5EL/OVBXvEiknog4sqbG+AKL66CN4if0uV0SpgvIPPy6D7Ee7hny0b5r5C
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846e9c14-a9e0-49df-9018-08d6672cedf4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5226;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5226;3:UOwKw4XLPIp8K9tk+whBmwXixg419GmuV3AVcFUY7XIJhwyptDLYKGSvFX2R57EuQs6qz5V024TK3VVJwMN61FKj1mDh+722whTsajf/fP9kAI7aZEwI+hRgrofgH5mPAfh5FhZhO67LA1AnvvQ7uG7/i6+b+gwoBXwPDM0j1CUJl7j1168/rOIZPxqYGx7OnRoVW2XGm6UOeLDDg6ZLkGZWVQHG17yvX5clbCUR5juEOErg5QaLbA/yQlwQ0+cwWLLJcrevJlc9JqRz7Ed+T02WQwKGbdsd/AYOOyzb8KgR9nOKtnjTmp2rx6pH8SosOhrA7gSa8NSagrxDAHCysPruOVSyPG+sUBVqDFE1UHg=;25:G+lsZoZTqNObiPxljEb0xNFtsPYehxFbPtvao9OW2WW+qTIuICn0dTJK1XqcYkLxWIFedRfzzT3J98gae4JTeDAlRFZBFn3C5v5mRqwD1xlrAh0vrU4hCGr9KrCy+64/sGK/mIdrzCQAT4J8P/Bd0j80wgCxeNKVPyT4pFK+loJUGeQsCH5t/p9dFhqcEIFUevZMS5SsM59X7GAJ6jUYiFYLwXzw8kvD5GLnLsu58G3BScDHvpJawhqzhxPGfnxa1UHxjfj1PxScoldUTk5EptLsyeEjWEhySUUsFD1GG+vj++UTX4Z+rwxiWLQGgYj7H77O4bWkxDynfr56BYPPZq8QUvXcAk9GpAyX4qY6pf8=
X-MS-TrafficTypeDiagnostic: DM6PR02MB5226:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5226;31:3AM025MhtkaL3tVUzNwwIGv1GY+vLKqtwUXfHWVxen7/HuD3d1iVbKkwCIjDvyXhsclSQi3Tbt+UZcBDaljcvLUlYwjx2XqubvTRzIz50gt7FOKPwJsJQj4DSiaCjQIjSM6CyelWlCAieRkpmFGLBfipsBi+C7JLNoIEW6kbaIyott6HwKqBpPA6lu/5dWpjeZXgoWIVT7YG9pzhTDyfDizOcUhUutmkiAZXMzJNH6A=;20:tiruYKq4xEpxqDFHgCt99Ds+/T4g/JGOEihHCNCqeklTVX3wNKqWBMhubZXYgg3ecnUmBJRiJnDuGEham/myt8cyy5YDsjaTOch7CZrfooL3wZT9WLNovhLxzwSjHmnIxq+N+ocnx4lDXMMMuUKwbs/ntkA9qCWBmdWzKVfB0zMghVYlaqTYX+g2F1sKSfFoMVD4SO1tRRK8i/2lHI2wU0BRKLzN65cgBa9Z3NrCC3cx8/dI7gDAFU7zqrYqkSka+B/GT0mjGvhonqLManRuiMM0hKLhkXaqJFSTkJ8Mg1ZzAFgVYmfbAYXw8KjTETH3H+NACIFup2x50UgNZhWBugWIYcRrLy7VWIhLUMf7yw3cSiBppciM72Derdb6uBovM6iGRY+qg04Xa9FVoBRPLnWvhVr89YHKrEtbwo11tFfdMYcyF23RtT4TiVz5bBOPqURZoUgT52W8AQvrTaRsWeSmDZI0NfPA3t4YWBzLU742xtw2AHnjx9bK5G8R5goO
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB52269906246BE932C0D494CAC6B80@DM6PR02MB5226.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93004095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB5226;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5226;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5226;4:Wrh+Rcr1tmE3vvd/p/97rUo/63tF3gA/qJ5eUnVPIVpH31VHAZQXqOCcSzFxKLFer/21J8uT4HuKQ4M/oOiFEMB6y/SG+2Dv2/2Nl7MdOmY3pfHJD6TlvOkUGcGsvmf2/dKDOviuU5yElAVoCtwI6No8Vj0zv+vZOWaUoP+BKZe+/z81nAq0djD+XiGnNpl9nQ4CbKYDt8Tffn9oW107997OzDlfaR1+v+n6eNF4gDhr/QtizSr7/H0FxK7Ynqdi3Rtdyu9o6LASjEfk2VaByQ==
X-Forefront-PRVS: 0893636978
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MjI2OzIzOlpFMmZCQlplYWhVbUxpQnMya1p4RExnZVNW?=
 =?utf-8?B?Q1F6YnZWU2tsL2Z2OXNDSURGMmR3UFN5QnN4YWZUcWtOUG1sSXJiRjFvSEdu?=
 =?utf-8?B?VG9yWHUyc3Y5WGVuVWZjSHBHMXMwa2QwY2FYaWFkSGdORFdVWTVPamdubzRK?=
 =?utf-8?B?bVd3VGsraktVVlg5QU9TRVJHd0w0VHNHY05MdDVzdDBXdlgzem1RTmV4RG5k?=
 =?utf-8?B?L0ZWdEh2ODNJVTBydTlGc0R6Umowb3phbWZrSW5EVHhpNHdndHJGd05KNzVt?=
 =?utf-8?B?c080eEJuNTNmNXY5MFNOUnVvVGRzdVRtSXNPMUlVd0RMQ3dhQ0k1bVRwTVYv?=
 =?utf-8?B?VWRwcnhqdFhRSkRidHZOK1dYcUplN0l2YjM2N0wzS1hWalVxZk1zSThZYUNU?=
 =?utf-8?B?L29DRyt0Sk5uM0gyY3JhM0w5bk9pM1Z6WG0wWWFnVDdMVnF1UVE3WlJoWnR2?=
 =?utf-8?B?UlVPSktMK1VGNjFaUGIyZTJLVEJlWXdVNHJDMmcwbTRJaHBJNWlMdmRhZEQr?=
 =?utf-8?B?OERqNktiU1VGTWtSZGxTWXhPMEt2Um5XM3c3YmRnVnhsRHNWNStiOFY4WWlK?=
 =?utf-8?B?MjUxRENrWXlSSmlNUjZkREUvcnJ2YzY1M1JJcjN5YktrdzM1ZDJZQm1XSnFj?=
 =?utf-8?B?US8yNWJxWTE3MlpuSzFQaHJwTDRObkd3ZEs1ZDVQdFI4Z2RNdFBydXVENDlM?=
 =?utf-8?B?RkhabTBCTWJucW9URkFMKzBOaXoxQnJ4TzZYTXJrOXFmdzdQK3l6RFEwazEv?=
 =?utf-8?B?bkVFS3Fxa3Iva3hNbkZhd0t3MVZVOW96N1UzZHNzakRCeXRGRHphK2pLNHRZ?=
 =?utf-8?B?V0dWbFZtTGRZdy83dXp6VElDMW1tYWNZU2FBL2E1LzA5d25pOCt2UFlXcGd2?=
 =?utf-8?B?OHhSSkc0WG52c2ExTksydmZDRno0Y1ppbG9Oem14UEg4L1lYa2FsaXJyNFdW?=
 =?utf-8?B?SHc5aGJzeTR2d0Q1ZWszVDlHclluQ2VCOGdNelk3Nkk3L1Z4S1NvdzZjSW1s?=
 =?utf-8?B?ang0d3dFOGFEQlJVQXhsenVHVkQwb1VZZ0lxNnBkcmZNZFNmcHg3QWNEUE12?=
 =?utf-8?B?cWtZbU9ObXd3UDZnZEgwM0RqZHMwQWxVd1NLWm9BNTRQWWhza1FpQjJQZHo5?=
 =?utf-8?B?bi91ODJPWW45L1JWS3ozb2tDK0huZVBDdzhqeDUvdDk1K3NyLy83SDlSdXZU?=
 =?utf-8?B?ZXZiV3dGVVJodVpDRXgxdjFZMnhvZXBxcytycWtmd3JiSkhlZGJZT1E0U2t4?=
 =?utf-8?B?SlBTY2VXdXFxYU9DVmF2SlBOWCtiMlUvNll1N3hvdU5nZ2NQRWpIb0lPVEFU?=
 =?utf-8?B?cnRZcUZWK0hxeXU4R2xaNFczYUVzbXRDT1JrbnZDYVZVbjZXbjVmNkpEeDVa?=
 =?utf-8?B?ZVFxWmNvOThxRVJVYUxYZWNoa2pjTVBYRktBQlBMM3VoWHJwRGpLQVdCYklr?=
 =?utf-8?B?YjM2cWlGc0RzMzExK2pZaEQ4TUI3cnI5ZnRoUm9EK2owbHJJYVRZbXVIdUtm?=
 =?utf-8?Q?kWaoEXU2is2I182+2GvacmTDU=3D?=
X-Microsoft-Antispam-Message-Info: WCc8gY/3oDtgsKEZSLpqtnjTLYZ6FL3EQpkVrV3c331KWRRVNdyv9Cf2rp/13yUMY7TQdoJazMqJkwle4RweKIQILU6PdJNNxzajzuwzUW23QBmVS5uh1OEheUiryW+zThgS8WvnFZr2gKoTmTfH5WcS45K6BPKvxU6IH33pE9F2nWd9QbTGPKJjO87CUuXEPOigJhgug79wFEDT9EmxkBj6+SIkCB4opiLVJ/vGgeRSmdtaFyAoZNg8FOyw0lnlddmDV9VUhI8FDRUBDfVVZlj4D4iMZSrVKwXaBR7UvGxTskVzEU8HikNDY6RQbCOs
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5226;6:CvvfV1KiNdxcbezmKfPwP6KtP+JcLGMFzVroUiKmHpB8Zobv4nhUunliAMS/ifcSFISWtBxci/FT87+guOFOc8/7ivZ4d/16l74+65X7miOVpGcrvwjRhPmCA7VTvGqCWHw+W+CwwV6FIbsyQShVB4n3PUkly9f3RtaHyx8O4BMbb06p/lX8QNm6i8qnbvV71Bw2GfzxtTwlJsmhUszCi8ODh7R7YwBUIgyEpjs6tGc0ZfZYqyyvQ/599xJvVYB2EFwTGjbYpzDO6FPzkr5R5aVgCymAHfpJHoNuW4Lk7ctgOL+gnuKY53mJv/sogJcWqm2Q3TsvVg3V000pbhfiIbkDgqKjvakDgp06VHjhNIuS6qHPrpvl7PNzQKefwDK6r1r5bJefhtlIB5Pz5N7XKg0dWJloJqIDm1pEdXbcnR2vjasNepCekqyDzz4Sz9F7SRGjfClqH/XjZSNcsUzE9Q==;5:+uAg1ABOoLQKG2aliFZi26d5hMx3bmdGPmcvf7j1qp9fDt/tL+BZRq75MBBvemtB5KwRLgiQU6SsB+vqO5svvrC7fPbzpOtXhI1m5LxN6UQ12bakd4Lp4O8RCpbvXVwX7NFISOQKuwfuvZ3B3oPGcN2eB1YZcMRid4Jq4lWjFxI=;7:yzAZmgx7Ed9JbQLjrlZ5HgNjPVgtED+qyNV2EL7BAeFjeCwpnt19aGUq6Z97PVOHY2JuB7BikczujOddW1ZtgXG0NpU17mLY6AFaVHCqFI6wQo/Nznnr6FgUleooBPE5fxB5RcpSmWUdGRrWFKHI6g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2018 10:13:17.8890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846e9c14-a9e0-49df-9018-08d6672cedf4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please pull the following patches to your tree.

Thanks,
Michal

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.0-rc1

for you to fetch changes up to 19d111ccce9f4c3e0820585d991bf5ae9172cbe3:

  microblaze: remove the explicit removal of system.dtb (2018-12-14
08:09:21 +0100)

----------------------------------------------------------------
Microblaze patches for 5.0-rc1

- Fix multiple Kbuild/Makefile issues
- Start to use system call table generation

----------------------------------------------------------------
Firoz Khan (3):
      microblaze: move __NR_syscalls macro from asm/unistd.h
      microblaze: add system call table generation support
      microblaze: generate uapi header and system call table files

Geert Uytterhoeven (1):
      microblaze: Typo s/use use/use/

Masahiro Yamada (6):
      microblaze: adjust the help to the real behavior
      microblaze: move "... is ready" messages to arch/microblaze/Makefile
      microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
      microblaze: add linux.bin* and simpleImage.* to PHONY
      microblaze: fix race condition in building boot images
      microblaze: remove the explicit removal of system.dtb

 arch/microblaze/Makefile                      |  25 ++++++----
 arch/microblaze/boot/Makefile                 |  23 ++++-----
 arch/microblaze/boot/dts/Makefile             |   5 +-
 arch/microblaze/include/asm/Kbuild            |   1 +
 arch/microblaze/include/asm/pgtable.h         |   2 +-
 arch/microblaze/include/asm/unistd.h          |   2 -
 arch/microblaze/include/uapi/asm/Kbuild       |   1 +
 arch/microblaze/include/uapi/asm/unistd.h     | 407
+------------------------------------------------------------------------------------------------------------------------------------------------------------
 arch/microblaze/kernel/syscall_table.S        | 406
++-----------------------------------------------------------------------------------------------------------------------------------------------------------
 arch/microblaze/kernel/syscalls/Makefile      |  38 +++++++++++++++
 arch/microblaze/kernel/syscalls/syscall.tbl   | 410
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/microblaze/kernel/syscalls/syscallhdr.sh |  36 ++++++++++++++
 arch/microblaze/kernel/syscalls/syscalltbl.sh |  32 +++++++++++++
 13 files changed, 551 insertions(+), 837 deletions(-)
 create mode 100644 arch/microblaze/kernel/syscalls/Makefile
 create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
 create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
