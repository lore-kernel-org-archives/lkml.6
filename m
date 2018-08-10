Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20437C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DDC217C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EEwWg/Me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DDC217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeHJLSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:18:35 -0400
Received: from mail-eopbgr710044.outbound.protection.outlook.com ([40.107.71.44]:47648
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbeHJLSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mY6v0+aLjmh9DlQKJNKIFm84z7djmbcyE5BloLz1n8=;
 b=EEwWg/Me7u/HnXtoApWKv31os/LN7LTAKIKYjjDjDorRyFq4Ks6lxh1+STxSG4uaQNNqoDIOCsnWyTSwW3/yqeNWs2d49uwhxPy1uIWP1nj67fmDkBlpB4Fo4VpDSSgRNSe6Fwo0+C0p7Yp5pasC1MRs+RFl4Vr1Gdbn/KKPjv0=
Received: from DM5PR03CA0044.namprd03.prod.outlook.com (2603:10b6:4:3b::33) by
 MWHPR03MB3134.namprd03.prod.outlook.com (2603:10b6:301:3c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 10 Aug 2018 08:49:37 +0000
Received: from BN1AFFO11FD011.protection.gbl (2a01:111:f400:7c10::123) by
 DM5PR03CA0044.outlook.office365.com (2603:10b6:4:3b::33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.19 via Frontend Transport; Fri, 10 Aug 2018 08:49:37 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD011.mail.protection.outlook.com (10.58.52.71) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Fri, 10 Aug 2018 08:49:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7A8nZOu019488
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 10 Aug 2018 01:49:35 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 10 Aug 2018
 04:49:34 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 5/6] iio:adxl372: Add sampling frequency support
Date:   Fri, 10 Aug 2018 11:46:22 +0300
Message-ID: <1533890783-13456-6-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(6666003)(8936002)(36756003)(50226002)(336012)(5660300001)(47776003)(8676002)(4326008)(356003)(7636002)(2906002)(106466001)(48376002)(50466002)(246002)(7416002)(305945005)(44832011)(478600001)(53416004)(72206003)(446003)(11346002)(126002)(486006)(476003)(2616005)(26005)(106002)(14444005)(77096007)(54906003)(110136005)(186003)(7696005)(76176011)(51416003)(426003)(16586007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3134;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD011;1:E0EWwfOc13AW5ICsx0gLoAkp1q38MxrfeDsJbKznfQvlyoSz3Z690jePlk7yYnzZEJaVBJBdOu37EBiKmVUpRziUrCdZUi+OZ4waM1h0+mBJepgLzGZuEhYRdFKLYSej
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb8262ec-28d1-439d-e5f7-08d5fe9e33b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR03MB3134;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3134;3:Lehj1FPXi6YYvw388dderxTlymwdGs+JvVBueKm54NcyR6MfmOuDzKkq6EAUtlSETbZKI2+3ikJaERKMo3pNHyVywdMy/p+AfHzX3zRrctgM/EkbD9umxZ5XX5upsSoDjZdJZ2D7WfQRMGgOqQfKijxhOVGCZqBpLehYLqziWtv4EVHQTN9vjQmwRqg7pHxjM/IHZ9PVWaMQ/faINl1lwNZG1CtMOR50zEgahztAtFVIHhv2kTR54nKxmwwmIK+YvzWnfpvKnAj8JSEdZ6pNeoTg0RdCu8tnahB8IBY3dhFCvMWiq+RsZc25DQyUvsYOFBxlncb6J92WMuYv85lV0o384XXnOKzZvHRt3w9x4/E=;25:YRcnZk5BohnYkfOhq06jg3LWf51855NeGwyxSnU0eomq3jWVZYzIIyslXgJElE1Ocb9sqG4bbjIfMm2ZLkHT+WEylOfSaQwrW/GAgvosKKoLJtyijS9HF7z7wjAgaH7UENc3/lgUKGaMhSDnukTfysySapdau+jHaIuuGtJECngiTYdlMEpNcvBmYw06vCervGqW4DA1L85g9Ee6xf2+gZ5MZ1F7vgWZ4EH1DcYPtQSjntFePbPz4AqZtbsNVMTC2juu004sm5nOshiJUzbYR+PtAdpxOkzvIQIF10mAHWlNc8nhGofERqvAtRZGMHDDMtbwoeGGUaSMkuTtpSzU7A==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3134:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3134;31:tdiq3n8xC4oz+ZfrfkoYf945fRInKbvq5LMRfqR2TNrzu5iaTnbDJb0tEz3/uaoocrMh4uuOyQM2RHuxGL9PktWU3L4UGpHcUivoWo/drjsXu2RuV9YjXxYUsmTm8LqMvoei0qfpNpHpkdlsq/u/QqvcTtOSIX1iAb3GV38Xd1BSOf7ivYap3wVHLzSRkZriAb4lkxQ922XiuqeibC8oHVXOEdPrGKwBcW5I9yDnUnY=;20:c/3sHaxbxZlzFN0IJhqVE/dwmLAU58YIYbnMzQWW+Um+VhUScv3kbiNKZAkA4cnynI2gHNv52KgFNuLxbjR5KnBmuRPMGyyr0SNDriEnpvWbPickB8Lit1XW+b/Z8++M/5EHbarhJlQoXaVLGW3Yt/BZ4/Rb6EVVkBq5aB4Q3jWjQl57D0LtMu5D37Bp3q5CXBfjCKqYHMGd+alXDSya137F2hsogjsoPvzIrCY7GlejuLuSfiK+ApTJfHogyiYHx8jEbqEdCC2197nw99BHx3ffO5a98MtswpQS71IYy8Rb9xOuskkBuoB7vpa9sibXj1H4qSp9hF2L1fRSYdDxTENVQaWnYtVYSJbtf9Vl/mo/MpGL96hWrY1PSOu9aqDpTDEXXwKMaApoiWZ3CrQnbkJ/STCQgAKVIwi2k2CP8Fr9dB76rsYQTCniYWuL5O+1GzrYX5ur+z46aXTLXqn/6u/Pp8IN0wlqPI62L7B5NlbX2VKFiEIvKusJc4mKvx/U
X-Microsoft-Antispam-PRVS: <MWHPR03MB3134CFD4DB242740B5ED94E89D240@MWHPR03MB3134.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB3134;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3134;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3134;4:fCLQIhG3fKsV4Hy71MhSOOwbV+ctUD+Tug3pLqkbLQVLPEiPQABU4mYyCNrAEUON9IkUo1tyuKSchSHqrjfGG01TxW1PSvZL/92uaCjKv56ogDw2tc/gprkdC0SOW/rW7yoFvRDB18YW7/VQcZZfasMIBNb3R8IGnfUKp8BxEpxp/5JRqq7mKBS7IjU2WGjtvTKD+hBoMz/qsHRLFh3omZcYUXba3JrCRx3hU3WMhymz8nS1411WJtsdxy6VQC+J/iZ2gmCAZLjILvnGt4PwKcp4epovRYPmHMPAj5BMyVAVicuQzDyorZmBFRiaRuw3
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3134;23:B/RXZdhoHnxTr9QnLvF6v+ROaGl0mhYJOFIwK6jxa?=
 =?us-ascii?Q?EpK9ZObB0nSQMcsqdkFykGusAACX6GO36waMrCyeCAmf1af2XGCEnejnuG5N?=
 =?us-ascii?Q?6sTuF71pvBU+JNMLFhwj++3JJXM1EsaAKhpoGbzZP8hpg/ix3Wf9XbVl6br7?=
 =?us-ascii?Q?rlj9FXGwnJxGXTyK/JUnbT0KQZsvkVBMg2T2Y1ka/ffAoLS13ADAmWKOPcO9?=
 =?us-ascii?Q?txhmRZVnC0cdikhR4eQKG+D3RQbPW5o3+vaBrA6SDo/8E7TEhVIzdNexBHjF?=
 =?us-ascii?Q?s0P7Dl2u9zLgd64bllVGLO0gfPhELooaNdKX8XOmCVHrKpbiY3VSPnL9N+Ug?=
 =?us-ascii?Q?I1q02bK4GEC+t2U+AxS53BTTVnDZxgUMkRDON2Lmjd/+JVkJF36RcCzbFXjM?=
 =?us-ascii?Q?U/cGIfjrf/rvu8ZdT/7I0t7mp/moIEEREMoqe5ePmAK2JxqGveSyvvmGF9OX?=
 =?us-ascii?Q?bWfpfy2HU91c/w1PolYR984CfJV0ORZKtEZSLwRaF1oHS4H0kv1hiBggsDxh?=
 =?us-ascii?Q?ZDlbclGhWTJGhTeH+Cs1LaoClc3duQirnr5j0tJ298zXs8GGEnqUIbr1nCKC?=
 =?us-ascii?Q?5nyUDz1IIZX5Dumy84Dzw6DvZ7tQaKpmZnjn8dDwrKmYYIRSTQ9WuRoPkbRO?=
 =?us-ascii?Q?LOtaETdSTADVTieWLD9XBxv4/x3LPYraAlAyyjqezbdF0WU0nQQUeU02miu8?=
 =?us-ascii?Q?ladMp+kiZygy86L8+/Xwhny69XWm+neTsf8Kcu8xpTPuJrZBBRcEZS1KIbW+?=
 =?us-ascii?Q?7KSqc9RF6PcdD1njAuy+Jx9ES4U7qF+1D7T+OI01mVSZ7cpzQPDyC32V9sMQ?=
 =?us-ascii?Q?ZFGEKGxNfoHa9avDNnfyUCeP84HqAJ7MbB0U9841AX5SvUPCX+uhUeduhCNJ?=
 =?us-ascii?Q?s370sW1narcnPsCVDudPPQGVj5sEWqn4l8CxUtlMTPEv2mD5d8BN9iVM8laf?=
 =?us-ascii?Q?aQgbFW2NfmoPTe0AI/CEQFC5DZV05rRBhE04JG0/7/yp30agjhBLjIzvsK/Y?=
 =?us-ascii?Q?y/rMijMfg0HKOvQAPJM6Pu7D8qjlutNLZrGGP9PeIcV8UC/pNWV/99GWHjJp?=
 =?us-ascii?Q?UpxV39uogpaR/+JLavtxCCkSkA/84/qdIP882YTxPFqoVkphg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3Wq/3gaI+XrNApB3GIWuY/57MWucqsCK14FsgvK+aJYIAzdq9TYP11EmN4M+s4QVm6NVa7nkbzB3SmSTsR4ecKncZiqefcxVTyvH591ybWFUjfDYLW6G/uPsQEu3vpulHupEHNNBFLBTaWBha5lSCtjno83ztn1j7uMlOi1e7xH11rhgadK2EZWm5uNav2TYrP0Rzsu7dQ/PsseBi8xkrXzz3JqY0LW9TGdh7iyFMAxV6IvHW+yCR1MRboxe0NuDsKl/0+jRko/9jrI6Pqzr1nqRRscWn1NDtgjs3+jwBgeISGy/hiyyyALrtFMqwWLV44uv8QxNtMQrXRwSg8UupFdJQU2Fa7niazZvBvfJlUI=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3134;6:0PXNDf4CCt8jZjzDzlEJiIRbCOglOzpM/Lra0z4xx3sWALfChdzvhn6PYhCLd/KvPBVYI6js+jsMr23Uf/yC67F4l1ZRpFm3tM64SGFlBMy/wkffyEbsiyjRjZ/tU4PMWVrWTVV0QHFTcUVOHKYbe/KVk7xZfl7Qc5CLavc3JmyahPPh8dqwHmV0jsKLqHcKu4lrF/AJ7VTEFjm5Iw/SFB1FPV4f1KL7P47XN6rrKv1a9H2XoAaFwvDcKcEhnndEJvHYVLwcCNCx9xAkZDnYXcSWhTwhjeZr9Fnhc6l2bJt+SfYFy1EQRK9MnuAEtyHJBQojWE+Fjg1nUqBnGlAO3+7561chYN/mJzlcHAB3KprRJT2x1HYQOKyGzHiAV1OFoUyX/RyRBbUXVnkvjlO6OIcjEy+KyhGkvPeSSBXdbfbneqfJVaAmoSvM9xqyqjnKwrKCTPYZ3lC6x3bgUm3SHQ==;5:ptmt0yNlTfV37xcq9W7E1ob4t22/6A/Vs3tb/+02Hj8V53mNn10Q7xWF0GlCaHe6FkRK+1jsqdgoXLUAfOWyC7Y9tcOygZvS2y3Q5cWgo5nNDYk9+7uWEHoNbbl/yRAt16awZiVnvPG+BOVLswFiNfvxdtjIcQTDdMJU7YpOq1U=;7:2879LKlrREha0BKVQeAT6m9EiTuk5WVmqNr0ui7QaI1s6uI3JpoQ3G91dMyshw5Bg13Qm1Vfq5yOLTOH35/9AT2rm8tHY/h8P3KjbAMePx2+RWpVJlPcCUMwYJQzRD7Q44U2HmjJtBvzVY3gxzJeU3lPY8bOJyxlU3a8+w0hAD1/t3b+B8vJajGsnUIyBcT0pHNTWxOh1AhEGPx2neH2n1u2AG0KigHp3nCW50sYm9Lsm5AAFDU+OiZ5KpQ6ptGp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 08:49:36.6583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8262ec-28d1-439d-e5f7-08d5fe9e33b7
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3134
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
index 1e2519a..fedb623 100644
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
@@ -766,8 +825,21 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
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

