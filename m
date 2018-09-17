Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B11BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4FE2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="U/rJn3fL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4FE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeIQTMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:12:46 -0400
Received: from mail-eopbgr690051.outbound.protection.outlook.com ([40.107.69.51]:59431
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728367AbeIQTMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzarhEKjH4bFxmnCAsq9G7Xufpt0jiGEopcXTjYX8TU=;
 b=U/rJn3fL0OrkVfsYpe42RldNVD2D2eVtYc7hEuCDieA9880BTh7iI0pYANGfjb0wyr6JTTaK07GDedSPO1GrmK9MDqDjZfcgabIOTLBLeXa45w2KsAcZG9zd+k1MYhWN1pXtXbGObo7hJfZie7Q4zDT+lsXo9UEgtsDR/VUlld0=
Received: from SN6PR02CA0035.namprd02.prod.outlook.com (2603:10b6:805:a2::48)
 by BYAPR02MB5112.namprd02.prod.outlook.com (2603:10b6:a03:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 13:45:04 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by SN6PR02CA0035.outlook.office365.com
 (2603:10b6:805:a2::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 13:45:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 13:45:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpm-0004kO-Rb; Mon, 17 Sep 2018 06:45:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tph-00057c-N1; Mon, 17 Sep 2018 06:44:57 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HDiqsU028487;
        Mon, 17 Sep 2018 06:44:52 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1tpb-00057E-EY; Mon, 17 Sep 2018 06:44:52 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id A2BB112142C; Mon, 17 Sep 2018 19:14:50 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 5/6] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Mon, 17 Sep 2018 19:14:32 +0530
Message-ID: <1537191873-6582-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
References: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39850400004)(136003)(2980300002)(438002)(189003)(199004)(103686004)(356003)(2201001)(50226002)(36386004)(52956003)(90966002)(81166006)(8936002)(48376002)(50466002)(8676002)(36756003)(4326008)(81156014)(2906002)(6666003)(42186006)(6266002)(5660300001)(106466001)(305945005)(44832011)(316002)(26005)(2616005)(486006)(476003)(126002)(54906003)(47776003)(478600001)(7049001)(72206003)(63266004)(336012)(186003)(16586007)(14444005)(106002)(11346002)(217873002)(446003)(110136005)(76176011)(426003)(51416003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5112;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT011;1:xBYC7aX9yu1XSty77hzXHjjvbSPViEu6l/h1Ko0pkuMGa4S3Ou6O9MTlBgmf2mGHLcrFdRy9ryo0ohek+qbEHMU1HzwvuCvXBvLpDkj/3MFE5d47T16jsAyMwBA/J5Ax
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71aaefac-8f34-4ca0-463e-08d61ca3c58a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5112;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;3:lZfCg0PAPNpfhKkaWACJSoGT9ZDJvSa568bOZH030jOYnWlA8s/XQGcDlUp5rmwrgo+jCukshhf2WXjSllhe/yvy5LeoMu6rPilz6T0NKZZ0JwAgQWWYp9ff1KMLXVXaamLgnNuKhAc1dUdtFxRQzBa8XgDCOr0SmXXRcOnbjQ6ab3BnjAwPBrjCKVA81YutZPh2DdqU6LNAA2wcoqIp3qCR8yPZIpRDlQlWd1MasTnvWOiGs4AKXXs1UgXLVoH15Vis9mi7GShHAwS9BY3xCAvsScfGRFRvsYc2eM91Yk4mjlQy4j2lvPdTbCiComQntDR7985YSUHudK8GVWhdRz8kQbz87Lv6sUVkF7RDVYQ=;25:XqEL0UNMaRv9i//ock7zgt62uD8F9PZE6J3TQxJ1dMEH4nYQGuUL2cmBOTPX8LZPBS1bNzRT68BGgNZlpoJgwQF5T57QunKSn4/hKARjnQTeIw9htGfYkYI1MCFx/63cAbdIlcGq89MwdlvUbrNAVj86AWWr6lsCxJooJJPC9MY+Fvuon5CXUl2dJ+FE41BmeCNFAXbHrGTHFfHPKaVnworlophmdhdrFnWir6QjJGROhF7Klx4iJPK/B7ujxmw9XDZm4wmtAdHkMxHfVM28Idl+Ib7QjKhn6yHE31DGtF17dQvK8XTDg9AhU/4sj8XRR3wxJ/3Z5xGya1tkxUvdKA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5112:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;31:hxaWNsmciiHh4ou+Bm5Bt69UvLgH4xmlIUNb69gA6F/GTjxEioork3K2hEMZRUkcYNY+GjFRfA/bBZ+6tlM81WIpzwGVzvt1soLBtX24IUA8R7uensiRmTYLpXFbgWJ7hT8tKrz7kIW3tFNf5RA7+x2EoN78PvdB2aHKqjeDz+iZYghnLACE1csSJwymLkfmQKISfRw87dbb0rAg0Z+PtuzjfdErXnXNbrDJEJbTMsw=;20:8hcdnfbOX1xWZ9Dgyixm6qOQiNElbhCLnBJm2I/Q63DqIBEBbYhiLcaFYn4DPAZdeYFJbRAIEy3230H6sO0JSNcB3xLGIYBnEODC4rPved6hYaezEBzHYUYg73ckp1BIONt3S0sfZztUsiQm/Ilb97e618CLoJllC7K6JK70ZRnNo5z4ma6NfX5K63NDvss+OqqFdOtmRKZWN4qfPdEBO//DEwrHJpX1+187rlWS6msi1g/6zB21UMxHFXNTbg9gsNk8tLnhtitiXf795SA+j15yWo8MlHR88hmRBAMZRe5pSC/edjYc4DFt+wUzQEJNRbU2cZnaOhEdTFM611qMKWjw+OdOYNW9SXu4IHjEeySXl2gaCR0X7+AHIWhcPtguSPwnRP0uVBrsWC32Iq0Z/eIgJCxXkISOw0CHz1Da7ugx6qQzJSwbSPYFw423OUg32xCiB5PCY5zhpX9AdxjaEGdBPmEztlxpDdu8ZN8rw4OExV1jNExpVti1XTWESlHU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5112A62202DE946993E2EF65C11E0@BYAPR02MB5112.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:BYAPR02MB5112;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5112;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;4:LrJ5mWwSpcSaJMKyEVkC6uDRAFRW7bScuHfhZzqyi/SQg89ftlW//G6jJByz/FfnCZ/fGVc/97Z6UjyXGbDNh69YeNKDc4j0pslokoIb4Jvp5By5htt3CTHlpcERtHBsNM7O5AxanQY0VX0t2zQkPasYL7R6HN/qJQJOw9oAiul2OjIhE6gYKm7LQURXH0tNikEivTl1gpfyHIpGm7c1yOB+T5qGYq147eOumZ5zN/i0RJgbL9QIMR3NxFWuAaFupFK2mIVhPEN4NvPzjn8qvRd0Zu9KfkYwSRsZRsWjYTl//tdcBEMHFm4v6YwHPe8LkOJdXy7+DisYzhAkMMZA6o2k5cgqCCkvQiyENK0nOLDAHEw2hH/EjESevgxWvx1r
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5112;23:wjHu9pQZWTvrerFQETfELxGdim9LE0tzNLOiZDyyD?=
 =?us-ascii?Q?ONgK7lHqPSFZWFFw1bN+DBcJsVziRikF8bwvPr9gss+/rd2hgbS/99QBVPg4?=
 =?us-ascii?Q?D6pUokeZ1FFZZeZy4u62jkpkjl1SlGKQd610nFn5a6nnu3p+J5TQSc7IQN+p?=
 =?us-ascii?Q?LWtWAasfeQyhVqMD2D/oWUXAzOzp0vHRnc9qrJTgXVuxyzqJLpx7WRm9m/h+?=
 =?us-ascii?Q?xvhv5aNw8wUlcv0BUr1pB+HMZx5lLHNYdyJBuHSQZftKY3RQe/1EiKLidtSy?=
 =?us-ascii?Q?wYiXoj6IjgDUsbmjwSIE6JsBN5VEXMLSBvFScGs4ciyqpufSvNcs7Pvv/2yv?=
 =?us-ascii?Q?VPP8cTqXwWPmShankF7PPIWu4ruvVHrg7rllSji1RgNkFghfKbEGxkL63KQ5?=
 =?us-ascii?Q?OogK42QIuSXwvRk6GYR7F/aoUPuiQeOSlJ8Z/1Unlhm3ICLyaXkpzMBw9zCx?=
 =?us-ascii?Q?x6IlpFA5NCM6PtcOVZ3FiahQUZAdKkNomMshVXS8GwVLgYP60x7fxSO0IBmR?=
 =?us-ascii?Q?3rqa3qKcNezqnfiRAHCLMhkaobY7Z5EGZIEgUc+3XGfllrNq8TIQiYKW6kZJ?=
 =?us-ascii?Q?ZApa56DYJ3VZsk9OYM75I7PkqwGqxPcEBZSRFABNtTFnmuNDgZxvu+Pcex/G?=
 =?us-ascii?Q?Neg5Ja/8Od6RDWG0IRP5vV/3wiXFfgQ5K1CjFsUBzvlFo1DmO7WaI4RkO+7b?=
 =?us-ascii?Q?prCaIo7/bkGXv1Fi1mW6P1M7wPZH8ifQY8U6l18NjT+V0bvS9WcnoU5JGlIB?=
 =?us-ascii?Q?9kvONcQedpZSSaj0AAEf4ZKLWn59G5KroNShqIcvL8f64fTpvVbA6JkoNEC3?=
 =?us-ascii?Q?Og/e+4n55dPGkT6kD5WAIELaM4h/6hGgqAnyJ+vLKvjlo4xjL8D6CVYoB/D9?=
 =?us-ascii?Q?cI6RgpHM9D0k6liUaODzYNVN2LM+qhos6nsyS2qXQbHNq2DKeNxCmV8ef/Ye?=
 =?us-ascii?Q?XiwmuZJFrEuRpPhThUVqOSj1tmCg1IvoHA63fyqNxO4UDm1vm5LMVbfcsT7E?=
 =?us-ascii?Q?XIXfivN3MCOokXPhAgYcWrj8rYbvdxTILPlX9FgIJU9t52LncQ9nzxhaHjPC?=
 =?us-ascii?Q?PnSlS72RS+47Qozu9ilKRy9d2HQxAwDxH0A3NmrzsjG1R0WYndYlcx1AKzl8?=
 =?us-ascii?Q?kQ0iJ22DMXO3algOjdzEPfvQ1pdSpjVh7iVoiYhJAEBacrtVdkHSAixEAAld?=
 =?us-ascii?Q?HYdmd87iRqtCHQ0USK/4flPBTnOVRtbKFtvFnDCITXevYke02r/L7uK65cvC?=
 =?us-ascii?Q?kIPM2LlVlTuMVJ1RMz2BnfgCYJg0tekOyQilHCg?=
X-Microsoft-Antispam-Message-Info: DgGUrtwP6w3N795qQapykrzvAm87X6D/Imt1czJtMfQFIG4ukgVhCuaxR41yu7K7cIyaO9FLTh/q46VoTElei5FWXxbDYPHFcfJGzxaNUFtLBFTQ0uGyRU0VOTqjYpbaUsPw1+gbvVX8uq7Zh3hVB/Y8gQTNJpR8rknUAq2evwZY23cySE/btRN0psA4TDesh6k3nbbtb2pnUdvqSDnM6qGjlx9MQUe3D9WSO9v9w2I1cDUHyioNSm9duUyFNlZ7Py8KoOYiX9zrf2wE92IJVLyg0avr2+U/pk9jN+zvBSBHyJ9Ea0nim58zbOf8IQFQXOZQu+M//vWAgNWp4k5frkxT7S17remhvUY9ioPon2E=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;6:L7rXUkJ69hTH8h2y0+VCMK8x/fZwWfa4UteYW7yFsxk+xTcokpayuN6FTU6lzaNEDYLYHZRTqBgWMHZfNSQABfx/uxCm3dfU12C5NabiOk0x16e+jq5NUwKb+ivf8ujE/hhFcc9ntb0XpowKlpexopG9VEwXONitvSBgNWXPVRz534MpW7N0Wp3cnjtC+cinBvCGutII6TlVpDT8UnluPEZ3znFiAZpfqZ4PtyYBch/mPaXg66kN47TEhrD/9WnS/1lc6qCsr/lkmWr5lDy1o/Km8rcrwNL+jOpRVLsFQl6YnWMr6oVQHeVMBP+rz34Y9b4bNFRZjHMR9iOgB2en684R51UnaFULri8lbs+L79q5L993kmjI3GpYgdZ1BxzW/lva+42olfN5Bn4EkDxr6nOtb7jzdx9h6kyZlpDnyno9pFhlMcIPlo3Ik6Jj/N/h+yCupkPt84pOk0MnxiSEeQ==;5:a1cz+8fbrWQAD5C+7FZzLnMUTJIi813vmG2LVX80Q9nmsXBQZX3o9IcSbftYgHR7T9TNlNEn85jkHq7yPjFY8P13Rn4Y22Nt9undxtOAeCmxjASlfHFY2/rKmT06n8r0J3Lz4KD/+42OLQWqzmaVFLFpDR4E9TgS1LJ5BWrw36w=;7:/fo6dRr0W+xHSKvFZAKmtvjss2/xMnvroJsgU/Uoa/RXjGaLP9kl1PpqLm8Fh0y/0H+hJsyq3zBERI4g+y303IX5FdZ5dmeUSMUo8wRfAYMzHvpdlaUPZjrIXzN0aAxiAWaUOdQa8/Qx5MhmWn6Savgv6ECX+S5rFujntdwK6AOFpofPzgBfHFrldigW0pyPsiRcav2DPJ8e/4WAXQaeGBPh97FIJk4YHeQfehBQLKoCrqANcMPVIDUcj3fI4KGz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:45:03.3299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aaefac-8f34-4ca0-463e-08d61ca3c58a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
corrected and uncorrected errors. Add interrupt handlers for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |   2 +-
 drivers/edac/synopsys_edac.c | 304 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 287 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..b1fc7a16 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARM64
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6bf7959..7ab5b9a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -272,6 +273,8 @@
  * @bank:	Bank number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
+ * @bankgrpnr:	Bank group number.
+ * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -279,6 +282,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -385,6 +390,68 @@ static int zynq_geterror_info(struct synps_edac_priv *priv)
 }
 
 /**
+ * zynqmp_geterror_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: one if there is no error otherwise returns zero.
+ */
+static int zynqmp_geterror_info(struct synps_edac_priv *priv)
+{
+	struct synps_ecc_status *p;
+	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
+	regval = readl(base + ECC_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
+	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
+	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+
+	regval = readl(base + ECC_CEADDR0_OFST);
+	if (!(p->ce_cnt))
+		goto ue_err;
+
+	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_CEADDR1_OFST);
+	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
+		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
+		 readl(base + ECC_CSYND2_OFST));
+
+
+ue_err:
+	regval = readl(base + ECC_UEADDR0_OFST);
+	if (!(p->ue_cnt))
+		goto out;
+
+	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_UEADDR1_OFST);
+	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+out:
+	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(clearval, base + ECC_CLR_OFST);
+	writel(0x0, base + ECC_CLR_OFST);
+
+	return 0;
+}
+
+/**
  * edac_handle_error - Handle controller error types CE and UE.
  * @mci:	EDAC memory controller instance.
  * @p:		Synopsys ECC status structure.
@@ -399,9 +466,25 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d ",
+				 pinf->bankgrpnr, pinf->blknr);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -409,9 +492,19 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "UE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d",
+				 pinf->bankgrpnr, pinf->blknr);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -421,6 +514,42 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
+ * synps_edac_intr_handler - Interrupt Handler for ECC interrupts.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
+{
+	const struct synps_platform_data *p_data;
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv;
+	int status, regval;
+
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+
+	status = p_data->geterror_info(priv);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	edac_handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * edac_error_check - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
@@ -428,10 +557,13 @@ static void edac_handle_error(struct mem_ctl_info *mci,
  */
 static void edac_error_check(struct mem_ctl_info *mci)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
-	const struct synps_platform_data *p_data = priv->p_data;
+	const struct synps_platform_data *p_data;
+	struct synps_edac_priv *priv;
 	int status;
 
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
 	status = p_data->geterror_info(priv);
 	if (status)
 		return;
@@ -476,6 +608,39 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	switch (width) {
+	case DDRCTL_EWDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_EWDTH_32:
+		dt = DEV_X4;
+		break;
+	case DDRCTL_EWDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
  * zynq_get_eccstate - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
@@ -485,19 +650,43 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
  */
 static bool zynq_get_eccstate(void __iomem *base)
 {
-	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
 	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
-		return state;
+		return false;
 
 	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
 	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		state = true;
+		return true;
 
-	return state;
+	return false;
+}
+
+/**
+ * zynqmp_get_eccstate - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the ECC enable/disable status for the controller.
+ *
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
+ */
+static bool zynqmp_get_eccstate(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+
+	dt = zynqmp_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		return true;
+
+	return false;
 }
 
 /**
@@ -539,6 +728,34 @@ static enum mem_type zynq_get_mtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
+	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+		mt = MEM_DDR3;
+	else if (memtype & MEM_TYPE_DDR2)
+		mt = MEM_RDDR2;
+	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+		mt = MEM_DDR4;
+	else
+		mt = MEM_EMPTY;
+
+	return mt;
+}
+
+/**
  * edac_init_csrows - Initialize the cs row data.
  * @mci:	EDAC memory controller instance.
  *
@@ -600,8 +817,13 @@ static void edac_mc_init(struct mem_ctl_info *mci,
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = edac_error_check;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = edac_error_check;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	edac_init_csrows(mci);
@@ -615,9 +837,26 @@ static const struct synps_platform_data zynq_edac_def = {
 	.quirks		= 0,
 };
 
+static const struct synps_platform_data zynqmp_edac_def = {
+	.geterror_info	= zynqmp_geterror_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_eccstate	= zynqmp_get_eccstate,
+	.quirks		= DDR_ECC_INTR_SUPPORT,
+};
+
 static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
-	{ /* end of table */ }
+	{
+		.compatible = "xlnx,zynq-ddrc-a05",
+		.data = (void *)&zynq_edac_def
+	},
+	{
+		.compatible = "xlnx,zynqmp-ddrc-2.40a",
+		.data = (void *)&zynqmp_edac_def
+	},
+	{
+		/* end of table */
+	}
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
@@ -639,7 +878,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
 	struct resource *res;
-	int rc;
+	int rc, irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
@@ -673,6 +912,28 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	edac_mc_init(mci, pdev);
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"No irq %d in DT\n", irq);
+			rc = irq;
+			goto free_edac_mc;
+		}
+
+		rc = devm_request_irq(&pdev->dev, irq,
+			synps_edac_intr_handler,
+			0, dev_name(&pdev->dev), mci);
+		if (rc < 0) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");
+			goto free_edac_mc;
+		}
+
+		/* Enable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+	}
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -684,7 +945,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
 	return rc;
 
 free_edac_mc:
@@ -702,7 +964,13 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 static int synps_edac_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct synps_edac_priv *priv;
 
+	priv = mci->pvt_info;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		/* Disable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 
-- 
2.1.1

