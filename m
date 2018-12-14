Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBECC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6312054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="b0t28VCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6312054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeLNGvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:51:12 -0500
Received: from mail-eopbgr710082.outbound.protection.outlook.com ([40.107.71.82]:44347
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbeLNGvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNqh4i4FOyKF8XSvFlGbjG1WqjSUzLSR0dwyRlQObH4=;
 b=b0t28VCUTdHCrpN31TKkwZjP8yt6kYpb2DbrGHKVY92P2wl5KhGPRglKJsfhtOX52I06bCDIQruPz0pIERglfqKppxA5OVZUWkTfiLmzyYYnrPm9YQ+p1AGbuarsK0Io0mN2+6gN0xqXm1WVxshRpTRzz1Ncx+0srDYhyg4EURc=
Received: from BYAPR02CA0072.namprd02.prod.outlook.com (2603:10b6:a03:54::49)
 by SN1PR0201MB1903.namprd02.prod.outlook.com (2a01:111:e400:5223::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.18; Fri, 14 Dec
 2018 06:51:07 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BYAPR02CA0072.outlook.office365.com
 (2603:10b6:a03:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.19 via Frontend
 Transport; Fri, 14 Dec 2018 06:51:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Fri, 14 Dec 2018 06:51:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33397 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gXhJN-0007Gw-0x; Thu, 13 Dec 2018 22:51:01 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gXhJH-0005Yx-TP; Thu, 13 Dec 2018 22:50:55 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBE6olxL025140;
        Thu, 13 Dec 2018 22:50:47 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gXhJ8-0005Xo-RU; Thu, 13 Dec 2018 22:50:47 -0800
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
To:     Mark Brown <broonie@kernel.org>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <20181213153127.GN10669@sirena.org.uk>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
Date:   Fri, 14 Dec 2018 07:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213153127.GN10669@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(376002)(396003)(2980300002)(199004)(189003)(26005)(229853002)(50466002)(77096007)(2906002)(5660300001)(426003)(81156014)(39060400002)(81166006)(336012)(8936002)(8676002)(478600001)(65826007)(230700001)(186003)(316002)(4326008)(36756003)(6636002)(54906003)(7416002)(47776003)(65806001)(58126008)(476003)(64126003)(31696002)(9786002)(65956001)(110136005)(356004)(446003)(126002)(305945005)(6246003)(106002)(486006)(6666004)(63266004)(11346002)(31686004)(36386004)(2616005)(44832011)(106466001)(23746002)(76176011)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1903;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT026;1:Wg9+zkn9RkleYO2/mSdVZkSURr59tlsO+OCriAQqrlFdwRuFbdyk38JtPKyz7bEKOBNYxVVIlpM6MUmj1fp2DgEyehOwN3k9Ld7ecBZIaKNYgWFGALJLk3tWQWGD1x23
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 197e3601-e557-4220-e9d5-08d66190854a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN1PR0201MB1903;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;3:wEF1zdHm+icTXRhrBxCCS8b3WD+aGCY52AG7SpYk0OQy7ZLsMbpNL3l2wiecD7GLuNcbriEOXXiPsMK5zTQjeNEDzZMFP+g7upk8OIcM+gjA1zeLh8gUqRL51uTV+DenI+w8qEOvbtrCqpe3lUbY/mp4Zfzw+HgGMHOn79DGVlk/rmtZR1voTKyV2QghkonV3Vr3LMfXU5R+0QcAtbwbX1xfV+rv2ZPi1C1CKNmFwfaE8aFqqM1ah1FkxE0PpXe1sPZ/zm9VUjghHDg236d3bj7sPeCSbXTQG6MeeUPn+yG1HDhOSCCi4QSgb9gZYmkK2ZMHLHtEKltdPdGOfW9aK9/NoKY9MecyY+HjCMm9O7E=;25:Yrs/Xr8GX8zOcicYJFxjZi4UWVeqROnaB4EKNOGZI3q2krh1lo7yio/nsv8gQ3BHsPDQZhbEpTj6U6kt/hB2Pr2CTwLgede7jtUULcKo1K2pF+oLHvBUu6jas74TAtK4VC7p1IJcRUudz4BqtFk6u4FIyQRGgEOIBihokcsS9srYVhzM3uP5LWrPl11+QeFc8yK0OcJHzu9QWXrCokd+RmEGfd9z2Idk4/mDakaEUNrn0IBkZMq7+aCQKcLNEdTh5P9iUsk9i+xrc+/l9LWWSKeEghyLlNfN8Yv0zhFvIi2cD6Kg0IDfS1UOqjcbiks1SJ2+nFoIxIvm39/2VYtnWA==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1903:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;31:cA1EOVhWIDZxLX7EozFCMv7rI0ALpvnoyj1i96TQ8crKbAzBldTfJitTwqH/N07AJHOxVypE8W+rC35VjVF+pSPlhThPIBr0zYafSvRQC5THpsdhul8EkYBKZxeHSmNiWBPY6dbZRDklP0RqwZyHZdUuwvKqHd2zmwrY9l3z5wnqwd0t8vnpid0M1Wpf8zuGkRWfZ8AntEYSQJ6uWW/8rSNne80BKIk3HeG4lcj5qXo=;20:IZ87fOI0t5Seokrxop3obc2gqoktHl4TalC25UnaOSPo9QYOUopcvn/lH3onqYQvymNcYx8galhFQHFz1YFZwyhF0FWf9CbIdbecwTE3DbdLkhgWD6k7vvdtro+ET23nL9jj/R1nGN76PxnoH+iQ9y602IKpJUNHSMTLbg7hCrRa8DoVk0EeldJbvzvFXHXHJDZ61W/4joVWO7VQ3ilmfBfhBOe6e8TzF4URwVj1Kw5iYCrRhcVhbNMtuKDJVofEM6QTkbdpKqCTu6PpI1zsuSKAH2ae7HZUzOHpdhOSvdNubIehaM+2ni4bme4apvs49ws6eR1u/sLdhevfrOO9ZZGpfGMxtbYQy7CNy1ge5PyvlVAomzw/vwexZ/H6N1tDbsl61DsYyc5GuuCcJAglbYuXxic3QOhvxGMRqp+6PWFd5ufQjqsKRWH089qRN60V53O9U5QNvD39dGm0gQzKygf4AnIgifBOfDy3qAZXNeMrMNGpAvBxvxJBipurGnuD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB1903F198FE380956B1CF5BB5C6A10@SN1PR0201MB1903.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR0201MB1903;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1903;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;4:CnYz671f02kH6Oc0qLcm/npiu4RIFvcTKxVIk7wilwI96m8GxHhYJudO+daVUgen37qRxC220sXQ28humuwVOjYkmBkFHfHrSn6XUT905DWVdPRuvpv2ulbMOEs/bsav6MTW40jrY3b6BjLW/VM9FMkLuh26aBHINqgIngXC3fwf1vrvZx3fVsQN2bxELL9XPADwq1b7+7sRFPIEJ0PvxVlsAwQlo95Mj5sco8gl2URUJqF1sMSKcNw5kcTJGzzW+ffW2m3sGMVmFS4Ys9p+7g==
X-Forefront-PRVS: 08864C38AC
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR0201MB1903;23:jW9S+bp8SfzBxH0O05awEovQJpMb2OGFPYG?=
 =?Windows-1252?Q?wmrsiBZAz1mx8oLePiBykyRG2+0SAPDC2OtfAlFt8ufwn4Rdy01gSsKS?=
 =?Windows-1252?Q?YnIDbTRHnFkUaWgpOKLA5tuKVWMsWyB9dfiWqMyPm4MvKPuoV/tUvOWs?=
 =?Windows-1252?Q?V8/LSMTdFe82VDjPRIdbmlXvksD88XExWVSxN86bUC/+kWvXVTpTKXAU?=
 =?Windows-1252?Q?/zoQpajNiJc3Upkl87ye8HCM3G5VQdMmgrjUgW26t1adI89wLw5ndAZZ?=
 =?Windows-1252?Q?ugg0FtFW4/MITITlqvp0KaFRis0XaLwIfdgmAlr/CO4gJenuGAfbkYDG?=
 =?Windows-1252?Q?/ZGMwAlVEx3UtpMr+QKlnuvk2xLRUMw9F/OetO5FJhRre7V1Da9l/3aN?=
 =?Windows-1252?Q?FuS5jaYCcuAGJ+vm0IX0lo9x1VghvD+H4YAFjtC47BLHekgTKqZjS9FB?=
 =?Windows-1252?Q?fsSZugkrcCse+5Ovy8KnA1Fpz7FnHMuWeHh5H8cmw5YtegqXOAthdy1Q?=
 =?Windows-1252?Q?w3LsKfwdbua3DYMVMLtOkq9wYUqPHSHdQaykuqE9MKooO8IAKPozE2Gh?=
 =?Windows-1252?Q?4VHRmROBq1LQtkzV8dcD6HpisV3ljJGQ2sFKQpDbsr61nG/Fb8pFZlDB?=
 =?Windows-1252?Q?F1I346WK6w0glsV++Eixsc0SwW0mVzmScQK/p+p5aMK0lYi3yOUoCyvp?=
 =?Windows-1252?Q?FvDhJLopGbfBeJnhT9xreKxBIo0h0Zrk6YNCf9KMaPcsEyEq3vKFvJLr?=
 =?Windows-1252?Q?E3YLPzUmfiET0FprOo1pA8RaQVqHZ37UzMTnWQfpLGmIMRjEpwu/bCYr?=
 =?Windows-1252?Q?fHn+36mzxrReoRyUE7ZwmWMy9rBXRDznQA5/Lg1UvJQZvRDO3Hd4M7oK?=
 =?Windows-1252?Q?hhaKRGdN9zdcwIShwt7qT5vE9o2D68Nq/l0A0mlvAj17vouXPmcpcBcN?=
 =?Windows-1252?Q?th+KJLbXbF5J3PZGPN6hJQcu4PRnSWCu289JmicNgkJp6IQ82h8YneoP?=
 =?Windows-1252?Q?8moYod4C1Fz2jDGscNmqWPJdfSwPlmEHNHLqjrfKKmL34gx6ICJmxvyX?=
 =?Windows-1252?Q?fCVw+sxJEsKKhV9ejTwaxqHFNEIvS/8i0dPkMPOtiOpOKrSxKIGcS+2Q?=
 =?Windows-1252?Q?QW3KBxNX4ZXAxv/vlVi6bQ8Fesg6x89LIMtjuvE2c/+IfUyOyI9pzzNa?=
 =?Windows-1252?Q?jEnGOqRxo4W0uZN3drQ1NQws3G3J7396SECZ8PfDPihFkM5+JGV4XiLV?=
 =?Windows-1252?Q?/Y684MR0BrMaClsRDb4TUxEb59eqb53/o07Icfi9T6/gyLrGqPmk28U4?=
 =?Windows-1252?Q?LlpJ+6z7dJVAFEVyJk5EZglAj1y3SSpzVi9rjjklVYJuKWHXX+LGDKGg?=
 =?Windows-1252?Q?NBsFFAkbLhKbPh7A5PpQNCt+avFGXHHiBV+k1WT73ZS7Qk1ICmGwEFbw?=
 =?Windows-1252?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Of2v8JqLSTh3ELkWqX4PRxf9h7sAUnFB8DQfJ+o89nQChqx+s2fvK/PeThFaPGDZuHTjR6IwFqjO61loU5lclLZYIZe9RUdCjYCy+r9kX+4BxkMTDKNGxSRBfsqpaJPx8+sC9p5/h7sHuX8muHzrTUHI7SXkwJCgnsTSnUUWphZNzYw5sqlQUArDiNmUNVdc23B4RvKZ8G/39Lji+QdGQOWWk2a+PLUvh3bvYaA/GwA9LPsEtguicYeXDPh6IcLrwOVZpa8Cn3errdm/86vYrEojuZgPaGuze9fFbUcDZj9MKVYLDlI2B6iIauCnC8l6
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;6:S1QLcKA/2GsjcUmODT5AvR1Zs7rRYePP+Py5ceocxGqwyQ/9876zibEwhnJh5a2IXnKaM4IATy0k+QrhHK+wA9torzcZrYhL8yuTHjSln9M2VY95njvWoAp/9Y4VhP3gYLPLS593bBYoezMp3G1W0RSTJJ3B5UMUYqgHUbHTAggV0vdK8EtPgjkY30+DE/Q1/7Mo2UUivjs/JZrKqh/ROMy8HpiR15vzOo2eFQrBub5SSg0XBadiHvFMWcypD1z2Er5HBHejLxPy44U43/yfDOedAtud2MO2aqWDCtW4Cj+1JIB3Bdjwdzfh+DORgMsPjp3xwB1TlpBeiS9klzy0XJViHhXG2vtFmLDOLKLZA+eWtkp7S3ku1Htivc6PUaxzFySD7Tm8qANatvVZ9kKQ1YTI0xAYAe0cfCA5j5qv5K1grGkAgThHCj3CobXb92QWmYKeQ13VmBvMktS6ZZigHg==;5:v8IaQQNxaDB2y+YZ/UyppfB6qwCo1JMujht0UNwjnhymmOIsRzKQ4xwlHVsYASoXdnC3HGywy3q82bt8ImHIMk4Z9rkjku0W2x/tze5sfMrCH3qEsLKuMUUQX5XRdjIzemBQnrGnhdmn7XJn+YStfj0m1NLwI8CWqpxg5WTFuL0=;7:qFdm43ouNYWC5SEc1yW80pLiURjLdX1Xu7niCnT7t4Xo9tewT/2aAgk7XHJOfgR8znJHsvJDP5qd0pbOpaeq0fVWuYcCauO6zu+0bWHCbX3mInLUHLd9UZWr9f6Z9bBSyZ0AE83a/JqjyEsaEbuT2A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2018 06:51:02.1779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197e3601-e557-4220-e9d5-08d66190854a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 13. 12. 18 16:31, Mark Brown wrote:
> On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:
> 
>> @@ -0,0 +1,185 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx ASoC I2S audio support
>> + *
> 
> This looks otherwise good so I've applied it but please send a followup
> patch converting the entire comment block to C++ style so this looks
> more consistent.

Is it the rule for your subsystems? Or did it come from any generic
agreement how this should be handled in .c files?

Thanks,
Michal


