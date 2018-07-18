Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4534ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E3220850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Qjrje/cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E3220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbeGRMU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:20:26 -0400
Received: from mail-eopbgr710089.outbound.protection.outlook.com ([40.107.71.89]:49184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729185AbeGRMUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKvDpPkZXH3p9rYDtQoItN7CWHfJmBJnWoogECTU2WI=;
 b=Qjrje/cKqyjxmN5frhhI3LVpLfeoPvHMAuru3MsWx/Ua3kHV80Om9T/FebKhPJWvE8RCSGJTqyl970dyOyL2+r+H7ljKd6zKSfJteqGf2upVeL92ex851gxBduHDAIhaSweVmBObz6BF0LfxNFvVHOcpX5W5ohRGSebtdW/D1Tw=
Received: from SN4PR0201CA0067.namprd02.prod.outlook.com
 (2603:10b6:803:20::29) by BLUPR0201MB1908.namprd02.prod.outlook.com
 (2a01:111:e400:58af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Wed, 18 Jul
 2018 11:12:47 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN4PR0201CA0067.outlook.office365.com
 (2603:10b6:803:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 18 Jul 2018 11:12:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Wed, 18 Jul 2018 11:12:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54289 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffkNy-0000ul-8O; Wed, 18 Jul 2018 04:12:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffkNs-000325-Ry; Wed, 18 Jul 2018 04:12:41 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6IBCVgY011680;
        Wed, 18 Jul 2018 04:12:31 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1ffkNi-00031G-V2; Wed, 18 Jul 2018 04:12:31 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 23CAD1214FE; Wed, 18 Jul 2018 16:42:30 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name to 'iio_xadc_channels'
Date:   Wed, 18 Jul 2018 16:42:08 +0530
Message-ID: <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(438002)(199004)(189003)(356003)(336012)(8936002)(305945005)(476003)(2616005)(486006)(126002)(44832011)(11346002)(47776003)(446003)(426003)(51416003)(8676002)(81156014)(81166006)(76176011)(36386004)(6266002)(2201001)(103686004)(186003)(107886003)(14444005)(4326008)(52956003)(50226002)(110136005)(36756003)(106466001)(316002)(16586007)(478600001)(72206003)(106002)(63266004)(42186006)(54906003)(90966002)(26005)(50466002)(48376002)(2906002)(6666003)(5660300001)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1908;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT044;1:Y4pqlhV5GWAsX3wbhoN8mbLDw8s8dk8l58hq3LroqRMYEFC2ceocRd9G5OYgBSQsJBQhdrNuwjhtNr9ATOwYHmH9nrUDntGo1MoIYIly40JG+GYNdTVYyHIz3KWmu/lQ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b35a186-3876-4983-42c6-08d5ec9f6458
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR0201MB1908;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1908;3:zcT+GTmlNUDt9dK8I3wJ9+vuZ1RThowGKhzot1Hj2tVbsvgjIRnpi4CkgJ024aEKr59mrZl7DoqyOnEyvolD0/wQHIHE03JfvpGjteS6nhENJGxlpjavjjc7X43Yudi7PF9XHB297CcmGnJ+kkJpnwHMJiPHY6VzMLk2V4MC/fdjbLj4sOH2hcmKDTIIOdvRjPYZMlqwy14rtHHB9QRXstSyRYX3xXBUo4Z4bR+cjLh4UeonEvi0/ZqcYzS2QFXlv6T8ASwNb3Rfq97DAOCjWV5GGXvXVdEtA1G8ZKPRXlbu8RABjUPnIOuIFGrz1nGTYGui39KdNTrSUoubbG9VukIJDxUxwN+eeHvZeEV+18U=;25:vPtQf/KkMiO71yzYy6k8gFpOuWe/oklOXMyrPAMiYRKh9GsTecLJ7dewdUEWSDBE2Lim+2sjy6ydoD0sdBwuDGNVGvuY6uOFZCiO0hQ5PVjogZZ+/tNfZSP42YDayZ/ukNIPCYYhyIm9Sx4x2qYTDK2PaqlMvui8jdn+F3n24YrLA0aBPwIUfQv/ERPSwLeBJU3+4cZntyGwE0OXpx/AiD/aTUFFNDVjzDcyj8VeEJgwWHD01eGM0zKeOOLk7iec39bYa0S3eqsdo8MxZ9CyyIVb/ZleKeGYL+65J6oyj174vNQr8f9zBWgyRy0ORMFZK6ET5h3NQQTzTFVAZOXuMg==
X-MS-TrafficTypeDiagnostic: BLUPR0201MB1908:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1908;31:TPN6fieKZVlyji0x8ngc1n3t/6tGlnej0bk5upvv+O7rJKSz/mNI50q3wTHeBY2aTN/gE8xAeTH97fEAmDDeX1QBAoVW6HbT4Jlng7ld/WuyNMEpKF7iZF1ualIvqLiUP070Ozbbo6ZKs74zLLMMZTQKST3UTXM/MEQn+AmPStsi578gvwE0gM2obfYhxrYWHqbCqWm1qayPeOaaDhDN4+jnGpEKpQFcmPEI2nzRllA=;20:IACqmTLSOoSgVVoYypc1HotzGnaNgJ+LdIxWqwObqnNuI3EiAfQVn/lwLqji/79tt0dKFv0MMVvipD2klfQpw0ZJQ9LCH6NXtrNN7WtTZzOGge/hfn9b5U9Z/fJJD9yeI28ZM/UxNM1Oncku+fukMx2UovX9U5l0XE7alLalMFs4OAtYyDsCs0np12mzbF4o+H1oN1czCdIDhT0bUaWtGVEt3MGEIOTn0ZwQkjV6uOPlbGQ0HNdDEERojxzD1DHiV9xkA8RfffiTEHDmQKg6ESOJsSLqs6e264zKXqzzO7VRohXDMka4IEH70288AAcRgCug+BH+JnSfGyuhEElj3OTERhhLNw/Tp6FfBHCsfKjqA755/ekXuAsFLBmKnaHWDsrSrh2rpZPXS81/zs68SEKBuCfznO/JRWiF8nUvk1zFdyPEHEIBzn3chkBKTHmeHgMGcJnLUBE/wFpgZJS2y6bTyisuKp3FwaimlmH7O/1A+THJ/bqN2o9P1xy2hsN7
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR0201MB19088574F349A559C20BA637C1530@BLUPR0201MB1908.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR0201MB1908;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1908;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1908;4:xIyNGMl3KQTyJblxbFWm3opWDrpbhCLSa8ACFJ6Ou+OQDcRjF2fTeQ2y81asUXW58NURstoAefYElBA++Eb1XESvKAJ+pQWyebeTI9neuurI0Aqh26mGs232b9D4rskCVVn9e980lNwAqPvipOfDlYO8QuAyWokfLiLgT8QATlckbl1y9t62oTjrM3vzU/7YPsEkfiN2NmRazOaOOLmBB1tdHDiE5lk9G2F2Nd4QNvRYCcr2P56/68/fwoWzRNDV0BmfwD+8IxyY1iO7fifv2S+12Z+E+qLAu9oei3Z120bZ3AaTncWxc0wR0add1+tH
X-Forefront-PRVS: 0737B96801
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0201MB1908;23:D+aSlFgUwZUFW+CpoI8y65PGkE+ojoaXPJyQAR3?=
 =?us-ascii?Q?C6YtorBitxEdO7D/GfFBwgCQKFe0ZiDG/pfVZM0+Et/NYPuL43aR3GbY+oR6?=
 =?us-ascii?Q?EtSDhtH29AZlbXdKaj7jl/820NH8bnQLxEAufbHQLW6aCY+R12KnqEwbRTeh?=
 =?us-ascii?Q?tuqZuMl6g+y+44d8ue1yGY6jjHW82dOMweM/d4dFfuNqP1KPK74HPBIP+rI8?=
 =?us-ascii?Q?dnbW9Bv6hqhZ5JYoZESgcnIV3tcUJuO/+pg2lx5SALGfXHLeMkx/iZ20sRbO?=
 =?us-ascii?Q?mRxyJYBIgtxgyNkgMFs6IENXgTPsWnJnuaolb+yRy+awdsUI9Z9LIG72wv2e?=
 =?us-ascii?Q?v4JJYUCQQBq8DKu7uiaQ/VDZ6rSHZAMBx18QhdUlzD7ohxkdGnngMrlwwmmn?=
 =?us-ascii?Q?AWqlK5PGohH3P/miDQA5eVMjRAo4AegiWq4bOSMsBEggH7BzkFkg1NaZgFbE?=
 =?us-ascii?Q?hJxZS+fHvna5wXVeswOqVzHI/DvC5tLgnVHeB1ZDSuvRqj3YCAIXyiDKWtIu?=
 =?us-ascii?Q?1vtKmDH5J29KFYX+wggih9O3Ha7MFwTVbk9Fzh4uJwDUeHu6aGPVEguf67a1?=
 =?us-ascii?Q?clAlWdjGfLQYJF3GqVOtilh7RocDPOXQkvHUDZEM0OgCro2ADJ6bEEzqdoLB?=
 =?us-ascii?Q?TlfX8LxkJGY5p7Vb7Y2565QXT3upbeqtBhJouMat3ie5ltX/wqWcOMZHiStZ?=
 =?us-ascii?Q?6IFWokZ772Kzz9IE7lZasVGMUYbGggZ9FhpGn92qotWVnlH7cdo0zWLAPjES?=
 =?us-ascii?Q?V431XiYB69bOZxUDyNFzCV+Hqa7pcs5zlGf4OhjlrMXZh4ojKd9jO6DGDq/1?=
 =?us-ascii?Q?waIx3b9aysQ4TlG+ijFyw+Tfs9/qkhQOmCfhBTmjL/B0p0tIv1BjZ5P27kT8?=
 =?us-ascii?Q?C7cpjUTfyML2sYvm8CTWEOOmSF3CmGhA8fEpCAdfcveimg08246gCUQpe0e/?=
 =?us-ascii?Q?pB/W2O6i8mAfwsV1Zd5qjuXo0UXswEAD/9hGpG+r62YeoCwHAlA0gvX5TLGa?=
 =?us-ascii?Q?k7H6X6dYgoRqg2j7lmCvLaI0/SCW3IDAX8KAUdkYqDZNSqjSngrNUvZjrEPn?=
 =?us-ascii?Q?pTUYJ216NSuXEYKQWDEZ0QWxEzw//ga6dDqYZjMyDPm1+8pNp3aluHfaIhyw?=
 =?us-ascii?Q?KTv7W+6Tv6AA2JYkwO9gYZGf4smSdutRWctnsnVwuDjYg/y3q7gAOObFQPU3?=
 =?us-ascii?Q?XuBpNDaVU10QGeMkzxtnJYTN3bOuEskgdwQ/nOf8A4LEEy1WVghm61WjJflU?=
 =?us-ascii?Q?6gWPuXeXl22Kb5xqCgO010ELa4q8sbw/KIltBn5H7rZONjk9mRIv/F9LRVyR?=
 =?us-ascii?Q?Gkw=3D=3D?=
X-Microsoft-Antispam-Message-Info: QDOssYIwFeYgLH+lE84kEQWkQd3jkcHA1mFQHNKk6mSa/XguW9Yw6aPdImfEy0mqiHYh5PiTxCMBOnkAxApSu5oKqKcvmKAsVjAWYAz1+YEWdt3mzj9vK72ySF1+P/SyUeZp3wvhUbFPpojIApBJIv26EmgfXpMT55bEOcfd1pH9O0B9ugPmkfpadedJbGZMKzF7Z7VWGVRqjsMFqWMIUwbeQrnm9HedW2TXCnmanIIqcvsmN/HIceStAASz8EMk2Fn6UybwNZwCxXvMTt7VE61x6dOwM8tksg1UWvjTTZY1WkBE2V9aT7IoFBDHzAdDyaCd6QGDezz8mf17J362AoVA74EZ6rqSHWFfXJlhn5k=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1908;6:NYasFW0/Ng9QjXxI0HbKlF/F9R/5M56uPORYB1Kch0DxstXcxcwyUYsahBulUWSa5HMYqxS8Q4tsORo6FIqQ+cdEoWIqYHwsYfg8TdITjgh8Z0QjTwAvl0yvPy1aA+Uzk8j6o2z2WPxi2oEPY0E4YEuTVtIS5kPuX0p+XLc4TKmP1V5T64b794Xagt0Y6Y4t0up4Bfkq3DJZGaXe+CYHxsrzEBDSneAEkjyiXip+MExtvDqrsxBmD55RKBivRwZe4LutfLEiuajq/k9qfwExly483gv91FAxsCZaXERvTs0r/MRA4wwZxF07OwSyW2XlZ6z9MN9C0D1Uq0Rym6ZFSBTOLv1CubxVUKZ3LPvjA5YJiC7JP4H+FiCmqMGYVbu4nhBX4VyDdfDdAWwZm0JZO4wYdhR8yhsbiZrlwxHNPwQ5gjSVEMh8IrylvsXNrat06x1+RmbTdXLwm95JPZAdVA==;5:IRODmgXR4Vz8UuHfN37RorDpinbFms9pj5anLNKlL9L8diZh8Ik5mI66Ln7Hpzt44zsmnu+0+Q/zDWmMrhET1PB4WuAmb+AHA7SBX82IKqh2O5kV44yNag2sN+Q6J5K6gZA6Ojrd4odGU5dsWSyTttTcPPz+rlQI9bIY8gkBhGU=;7:ltRyY9NT2ZjbSDCYOwUEKhUF8yXlMXZgtZLaBTITxEv1BjwcbRhbzSOEP81x1YEkbSjQPi4IdKtsEum5g+hijmVxPeSmlZjep2tNZtsKl/Vubx4UEY2tpucwvtIyHZ5I1kK/2munc7SkOj1LXLgzpSq4woA4pZRhsVMrmluzmmMzvo3oX3FborXmCKaAdZbPLDNc4ZtK5Iu45DTQShIw9BFplE7+K7Nnz24U02hvl2dk4SIFnxQECcvy61K2arph
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 11:12:46.8379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b35a186-3876-4983-42c6-08d5ec9f6458
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following checkpatch warning in xadc driver.
- Reusing the krealloc arg is almost always a bug.

Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
warning.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d4f21d1..27b45df 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1040,7 +1040,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int *conf)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	struct iio_chan_spec *channels, *chan;
+	struct iio_chan_spec *iio_xadc_channels, *chan;
 	struct device_node *chan_node, *child;
 	unsigned int num_channels;
 	const char *external_mux;
@@ -1083,12 +1083,13 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
 	}
 
-	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
-	if (!channels)
+	iio_xadc_channels = kmemdup(xadc_channels, sizeof(xadc_channels),
+				    GFP_KERNEL);
+	if (!iio_xadc_channels)
 		return -ENOMEM;
 
 	num_channels = 9;
-	chan = &channels[9];
+	chan = &iio_xadc_channels[9];
 
 	chan_node = of_get_child_by_name(np, "xlnx,channels");
 	if (chan_node) {
@@ -1119,11 +1120,12 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	of_node_put(chan_node);
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = krealloc(channels, sizeof(*channels) *
-					num_channels, GFP_KERNEL);
+	indio_dev->channels = krealloc(iio_xadc_channels,
+				       sizeof(*iio_xadc_channels) *
+				       num_channels, GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
-		indio_dev->channels = channels;
+		indio_dev->channels = iio_xadc_channels;
 
 	return 0;
 }
-- 
2.1.1

