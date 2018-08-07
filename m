Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7503BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A2F21524
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="OxHrmb5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A2F21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389833AbeHGRJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:09:36 -0400
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:49046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388593AbeHGRJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP6KdyHkoQT8SkCCh6U48gpvsYo2t3T9SMHshnQNxKs=;
 b=OxHrmb5UL8FVxzaOmEZ6V2D4jdrx+uFQoAW47hDNH693H7NP0cKeYYmPkmbS4fqPR+o6iTJNfvM8SWRAH34DkLMYiDsbNz3smMuvmnYrEIOOknCZ+ka3WyJM21ucrsn1WnwqMn3NsuUj1UHsPvZCanZFYoo7t1xAPTN1SiCsFyA=
Received: from BLUPR0301CA0022.namprd03.prod.outlook.com
 (2a01:111:e400:5259::32) by BN6PR03MB3124.namprd03.prod.outlook.com
 (2603:10b6:405:3c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Tue, 7 Aug
 2018 14:54:50 +0000
Received: from BY2FFO11FD012.protection.gbl (2a01:111:f400:7c0c::137) by
 BLUPR0301CA0022.outlook.office365.com (2a01:111:e400:5259::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Tue, 7 Aug 2018 14:54:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD012.mail.protection.outlook.com (10.1.14.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Tue, 7 Aug 2018 14:54:49 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w77Esm35029178
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 7 Aug 2018 07:54:48 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 7 Aug 2018
 10:54:47 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/6] iio:adxl372: Add sampling frequency support
Date:   Tue, 7 Aug 2018 17:52:19 +0300
Message-ID: <1533653540-24796-6-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(47776003)(316002)(4326008)(106002)(16586007)(186003)(110136005)(77096007)(26005)(72206003)(50226002)(54906003)(11346002)(44832011)(126002)(446003)(476003)(2616005)(426003)(336012)(51416003)(7696005)(14444005)(76176011)(356003)(8936002)(6666003)(486006)(2906002)(246002)(7636002)(53416004)(48376002)(8676002)(478600001)(5660300001)(36756003)(106466001)(305945005)(50466002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3124;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD012;1:pt7oeFWzgDLpLlUR1Rp5GDsEoXbbGCgVPuqfVvpVUNT/pjGzNnyIAVhfjPwt4VHceZWCfqTKDcqmaiQD2GEkHbVUw9S4nXriXL5NNRr0SUK8odAAlem638i3hdGDq//f
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8acca6a-2d19-47c1-aab4-08d5fc75b99c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN6PR03MB3124;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;3:bNxqo6XroCpK57RJ/p60P4pXq2YLkLduFfxzvKA4Z36QqiVcFX7voIy4VFWAz2o/vgtsQS7H0cwjycNGXs5VBeduCdkcUd/keFT/45POwArQ8QEwNrkcTUMPyRRWOH5zphzuov0POoA7EZhSzLFl1E5hVss3AmtTMDaNqE+8omy1aDI8P/lWx6Rndz9AhDxlTfkBrE80T0nhITv3iWIltvNxm6YpPc/e2/URKjxyg0FfIF31/IbLzOuVhJPt5rgcE+N8G459oHK3vwhzYRfvHqmS+e2dYWM9/VNqrugHuWIcgTtQbe33/1L0fx+VTta3qcdOSxaF9aj3dah01kQ2pnbI9KLuwfBO/Xc/HdEbGX0=;25:7kgTqj3C+h1IK6mT8AxhMVVoiMAm+0436NgOt5Zu1NygU1D6XwKnE7hUfa1DWSBKUDwvkVPDqxFHBIpkSgvOW4S6dTx/o7DgQc5jcreDgS5eHQa/WnlodalA70UY1wt861IyZ85jvryzrQCZOMAZqMx/NZBYmGPQUBQkoTZ4cvmJR8EZwLHDecgEV98P2B2DYOEMiRHGiZr+PMdpTWEueB7TNw5jvFHIInca1YVcmk2NbX8tn9n3XxJHFudGymAmtvF69kUeTKOX8FfrWSN4Q9eMmiSDth8QnP9P9+qiTfwh2aVFtAK7qnVXqmJJN7KoX1OJ0Zp+Btm/rbh7gp2rzw==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3124:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;31:+gGlzz/s1fzrb0LAdR9cyTAcJKKc1P58Eq15ISyJO9pMewhHfK5fSrPKZ91w34EfTykXzOoDz+QjpXrnzJAvk70y1Zz9UWG/r1FjIIdm6v0x8aCNwfK6yLPQdAvZeM+n0aF0sJzaWofiZkDX/MfC+6HRO/Rx7guuQc9OyDQubRWMosjRJ4RJIEONBNUZZfr5RBXY919XwZ1iZk/1Lg5L5hxGDcAjPC1Szp313100drk=;20:tQ0k3dqR5j88aUVHtZ7dplSwSY2PnF0kvNA0EeClX3E1VWcVXGbLEGPTcT4hSzPhrc6F4mCCupcZVNVl92FwdssmT/SuHL/6g7CnIiGqtb0FGJXzd3l5qYHDjcklo6MIiPPsj6M7nz7YuYIEGzzfAKgo7lX/vfGm6HnA3RolRtO+WOZ+IkEukOn5me4Fm42fc/GmWg+3fkYKynICE3W8nVvWoSCiDLDkV+wVVHpxw7KY2lMaAsaWu3tZ++8b9ZhRFyEpuehRoHPWzMbTAcmSCobftxy8Ms/TG5qjaJb6fhjO6y9pit10abXvm+S0OXqePNB6rx7AUmVhQPI5C+5aZdm3pesT3uvgbCL+CrY7lc1bGFSaB8RQhE8xuLWx4Tfd7d08zYQbPq0fDujBYel1QSDjjYBjdYkawEV25fDaVbHTuQES4BKQ9E4jEmvEgQI6j68ss8Y1m6q3iBv1TnTlEAzTjfiZBoptPtGDuaSbXFGSBDwwbgdID6/EWbrnmmXF
X-Microsoft-Antispam-PRVS: <BN6PR03MB312474DCD7E32C8329FC1C049D270@BN6PR03MB3124.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3124;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3124;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;4:sxPop9Q6FdUO+eEOoZx3dosCx0+lDA/3fEu3mbLMo2M/lFBKFm+TE1kLxJcWCvqvLj/c1uVKrzcUjXCwSR4B0SgrS3Yy5fyNv/v0iNuYCamyY60DC3Vy/MvACePfRJmEk0zJQ5iZuTF+5sh744OY0EOCrTGMcYzXdR5QhOwekRIyx5e/YQHatYQYI1NsyfRTHB6avIEo8gDF/c+ECnQ41APXfRTdRZnRntLHupjPS+Rgn8uBO1pHhdri0lU0+KYyIVeDPxaJD3TSvenUQNpZ4rjv+a951Ms/argaG71qguDpQK9t2IDztn1gH75I+Lus
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3124;23:HgSmESEFqUFZT7NVFGHGHIAZflsRV6+ZETjv9PUfd?=
 =?us-ascii?Q?/JsZwSjVSggkTZwV0cKISvYE1MIuTrJGm4rdxsBENtK22VlEE9oh4DbhV+IL?=
 =?us-ascii?Q?qUS/zW7TnxpHIKIaH4AkAziSU4AJ+0cpITuJet6qFBCVpl7Kp5RNaATslHZG?=
 =?us-ascii?Q?z0VpAKH/S6s2dCDAAtE5CBEMWWZSjKgk6gYlgDczh47RiCtwYUMZYgv33DkA?=
 =?us-ascii?Q?b1p24VEck9BUKcQpsMDskssc+axxRDKRNa6PzQNibvhoS9ugtxGUXbmhaKMd?=
 =?us-ascii?Q?a5iD+UllTo//HPg1tV66LaKHXLDBLrEDL4iB2qKaeCsTA2IvAJLMSCi/axRx?=
 =?us-ascii?Q?VczzK7T9HCzLg4xac3ypVUwx/qPgXZ8Nq6EzODjEjO7LLqayHvYTDHqJu+O0?=
 =?us-ascii?Q?Zw70ZnByhg54l3+UwI6M4vBc3AnPKlRFM8e3xfw0yvJWwMaaKfIQFjJhED4X?=
 =?us-ascii?Q?E6hGQi1GsiYBsHT2r/p14zoDpwCpLLj6Hk3V8J7SWnMNHwu5GJbuI+3X7hPT?=
 =?us-ascii?Q?ynC30IpmPWXDJ8NxWtqV3emRGW9hRJfiH1vlvbynnKqxsh6bwG4FbMFwsDuM?=
 =?us-ascii?Q?UL0XawOrFKsRX8IDiUne4GSNKE1hWYMz1aWxVxI+pkc2u8A4ibhLwaeBciZI?=
 =?us-ascii?Q?T2uieGEwjkSqEWKDArmFejE2uY1MMilW53YyjARAfmLSvRbRpPkI7YgxNKwo?=
 =?us-ascii?Q?52lEQphITdf/5z6dAayEjS0eqgdIPO0NnV/AeJvwj60TjNJ5fiZl3fAdoC/g?=
 =?us-ascii?Q?eiobTfjTT8TBcpsBevB8yz6NprrDMqcU6ub/Lzdr6jbQN+tCepOJEL1NIbLx?=
 =?us-ascii?Q?9zkfm7LGNQSx8GH11/MDCm3A0sW/+f10nplZJe5McFCYP4s3m28i3bxbKgfG?=
 =?us-ascii?Q?i+2HoX/zdGPr4kdc2UnwBJpsZVdwTrLXtJrdN3/lbt+6/wF298liNb/iAn3g?=
 =?us-ascii?Q?KkNV7Ce3pi3m8Z5uSJCNX85ME+ZNdPw6FBkKPyd3xQROj8rhh6SzUVI5nBF+?=
 =?us-ascii?Q?k529k0B/9LmH/8Lb5Rx7llUTGgxDmaPQPnu5lBWJl/mcsEVLfo8pCDVHhKfL?=
 =?us-ascii?Q?Q8llZm5W4Q941WKyu9LwdoRbJ2R92E6AEF7eSQ4PozAv+5WtQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: i0aOuPtfbU+U5C5HDJ9Cma71KlywmoPe7PDIZrfQIb215bqN37a7mvjArtRI0/d5/hXxF4jjmlZP/z3XIfW3dvljYnKBZpCXnwkCchYcpfY4eyWHFUizSA4HxX+trs4szwsp4ql/1agbdPHaWx3Qt1ff2kENNPk4v+Lnw9k9XBNElfE5pRGQgMaSG0maHpsr2Nqhb5mIOBhS5r5MqsOjF8zP09hWbGxt50MahYThSd34X4ABcdX7w7bX5CYXA8T+Y6Uu42DcxFaARH7cdteUZrp70492b8r0lPsiLDUTjWaJvGdnfF3XOXTsIZZ+51uoiZUkN3Uaqr5vsi0lXpvXJ/p62MBOxGc6AQ/I+FVDlDs=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3124;6:/dlhqZjMVy2jJae4sjxGOnyoQwDhkCPSDwnKApfQ02IBgMYBXyXpuNr1tKcNu1zht4TjWaw4dt0v08dR9pu0Pnt+tsh1mDx7hsoXTbutv0wP39PGGEm/KfLpphtR9xPVtfvoIyqfHpOmmXFxMy4qhhY9xxzoPyNF2XZpJywCR6yIeJImHHYeWr4tZ9t9rvGVIOqGsNYQmk3zVFZ1uMIi3RruOnWVvm/TcQMZ3D2EiTVvC4UH053OElZ+OpGVVgM3IuF5FF25wAaczGiDWNDa6CS7R4Xq7oM8umwkxHTX3oYgLuCTN5ooKukXrz7fiNe4kwRCLgJa+caqPVgKywnX4YwhCFzPj1lCH8MJltSvRPQ5wEoGai6aBe9OkMcaCXIOkc5XMWxo2Ap0YZaUFHBlnr0ey6yTFb9938Wv6pmf9ByO3jJd6z0J2uDOdm1aw+u1VPXFJX/zcpVF51ey8W2AjA==;5:0hdy9fiUHB6XAFzW8kMFlRsFifwOQm3YPIDHbC8lkarxsPhv6xMub/KVST2dxhmhw/PiPWmweugmOf0INCDlDdVdh12TFyYqVfufKBkul4kI2ksWag5fmJl/FZI6sjrshW7a1l9lepWMJ30mun+oPI3GIpchVNxiT8nDPr/pg2U=;7:X8M6/Uq/izj7I2bOziR1pPD3wUp8Dt332qBTxjadTwzRmWWwzoa9GN8czKg/s4iBAYZy4kUskmIEiN7GmolS3+B64WB7MSuGwv2AG0KR4BEyVEZHrfzI3Mndx38PD7X4OoSV2Wu8NhkBSxV69GFYyPV0Bga5mfC9a62yDX0MUBDNsff+jeVhBMS2+LLSknLV93Mopahg24UD39SjPZdKD953jLWgiTp0Le7qvhQyos4MoELi4Usc/sbbSWAxDI+U
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 14:54:49.5250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8acca6a-2d19-47c1-aab4-08d5fc75b99c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the sampling frequency.
Also, the user can read the available frequencies and read the currently
set frequency via the read_raw function. The frequency can be set via the
write_raw function.

When the frequency is set, the bandwidth is also checked and ensured
that it is constrained to at most half of the sampling frequency. Also, the
activity and inactivity timers have to be updated because they depend on
the selected ODR.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index dfdceeb..76c4a1d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -223,7 +223,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -311,6 +312,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
 	return ret;
 }
 
+static int adxl372_find_closest_match(const int *array,
+				      unsigned int size, int val)
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
 static int adxl372_set_bandwidth(struct adxl372_state *st,
 				 enum adxl372_bandwidth bw)
 {
@@ -631,6 +645,51 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = ADXL372_USCALE;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adxl372_samp_freq_tbl[st->odr];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl372_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int odr_index, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		odr_index = adxl372_find_closest_match(adxl372_samp_freq_tbl,
+					ARRAY_SIZE(adxl372_samp_freq_tbl),
+					val);
+		ret = adxl372_set_odr(st, odr_index);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
+		 */
+		ret = adxl372_set_activity_time_ms(st, st->act_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
+		 */
+		ret = adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The maximum bandwidth is constrained to at most half of
+		 * the ODR to ensure that the Nyquist criteria is not violated
+		 */
+		if (st->bw > odr_index)
+			ret = adxl372_set_bandwidth(st, odr_index);
+
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -763,8 +822,21 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 	.set_trigger_state = adxl372_dready_trig_set_state,
 };
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+
+static struct attribute *adxl372_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adxl372_attrs_group = {
+	.attrs = adxl372_attributes,
+};
+
 static const struct iio_info adxl372_info = {
+	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
+	.write_raw = adxl372_write_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
-- 
2.7.4

