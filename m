Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480AEC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D3A20684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="hbZic/iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfBYRSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:18:04 -0500
Received: from mail-eopbgr700042.outbound.protection.outlook.com ([40.107.70.42]:30592
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728428AbfBYRSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eA5yMlcA+KhL6T9akJsjuWHtkdl4nJRWSw7RBZGUyc=;
 b=hbZic/ivWQhcyc+8cSHSeYnuE4YqGixcWF4KfVmDCMHoaESCSTCp2SqinquxBh8LZChqaNiS1b7QtXvlz4jM4+margAHjujrBJzd09Le6BS49oWNtDLOBVvzFmyETsHQ9CpFc5imAcrFu4KJWGGIxlZaF4CSmcU+yVjoQ2w2n+I=
Received: from CY4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:903:33::19)
 by DM6PR03MB3754.namprd03.prod.outlook.com (2603:10b6:5:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.16; Mon, 25 Feb
 2019 17:17:55 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by CY4PR03CA0009.outlook.office365.com
 (2603:10b6:903:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.14 via Frontend
 Transport; Mon, 25 Feb 2019 17:17:55 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 25 Feb 2019 17:17:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1PHHst5022585
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 25 Feb 2019 09:17:54 -0800
Received: from ben-Latitude-E6540.analog.com (10.50.1.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 25 Feb 2019 12:17:53 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <biabeniamin@outlook.com>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 1/3] staging: iio: frequency: ad9834: Move frequency to standard iio types
Date:   Mon, 25 Feb 2019 21:17:30 +0200
Message-ID: <20190225191731.5822-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(3190300001)(189003)(199004)(72206003)(186003)(26005)(77096007)(478600001)(2351001)(7636002)(86362001)(305945005)(6916009)(106002)(106466001)(336012)(14444005)(53416004)(426003)(2616005)(7696005)(51416003)(126002)(8676002)(476003)(116002)(246002)(50226002)(8936002)(2906002)(36756003)(50466002)(48376002)(30864003)(4326008)(356004)(54906003)(44832011)(6666004)(5660300002)(107886003)(47776003)(1076003)(16586007)(316002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3754;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117eabb4-cf88-4725-2b3b-08d69b452e52
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR03MB3754;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3754:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3754;20:gdg+B/7s/dXNultog3dFH9iYiQLbQdgwfDFfS2u6/19rrIaEsqVqhLdMX8Ska9NDFDP241rAnB982l7c3PePDwFDV0R1iiZa6O6I6JO4CuJBU9s8gOjj7BHWFDtp6kfGvad4fN/KhgVMs96jiUfyz6f4aWBhKnylVnsrS09cLAk/F2dyuXyMccDzpoBetoO5ZwR1ICPR+NeVVfq4qPY+CYojNaT+yJhjB+uXzht05roeeiEhnMLNLlnWaLX+SK09pbr8yA4rbHRLVp7Y2O/jfU+Dk/Ie3fe+Gix6nQbg1w9dMgUYdrBHNMTZXtBK8nlLuvV/egB61RJzdbc5fB68+R50VGyKeG521PynM+BNzVcs/jzDKq2crxSf6IhEcEntAPBfLFpySiOe0xwcpZSkLwqXxTOdVufxFPdswmCVqb6jtwlhUktFbvpjIY7ywuMDledwFe7qlPJArX9luxfdZioUx86tIFifZzcwAZGJHSAT2a5wM/mbq9vsth15dzH9
X-Microsoft-Antispam-PRVS: <DM6PR03MB37547C972048B22FDA8C9BE1F07A0@DM6PR03MB3754.namprd03.prod.outlook.com>
X-Forefront-PRVS: 095972DF2F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR03MB3754;23:aL6kbVtjbc6EL4QvL6/APE/bnll3UPu0Tv/7eV7L1?=
 =?us-ascii?Q?u3KiSY6EjM7fu2qnckrU6SxPBRqXr7zBWMn02rDl3el2JkygrdsZxowNSZgn?=
 =?us-ascii?Q?GuJ5d5j6X7LcOC/lEEOU6yWa9oeIlwxwMr7tKB1PjKIbCk31zlgW4/nT3XHA?=
 =?us-ascii?Q?qb1Pr1rvCwLBiy/vgqI64uHMJugyFQ0hncn7meB3eviMMfwdEg6svISA4oly?=
 =?us-ascii?Q?q6E4YcPtx4miNpDx2XvAazP8P/B1eid4kdJukO+Gn0+iCVB4zZjyfoJAmvsx?=
 =?us-ascii?Q?8toVFjnk6Oe2pb/vFZf7S42+WlSemCBrxMEd2uBrIAAM58A4cUk8JtVJZLZz?=
 =?us-ascii?Q?do41AyuoA5cvrhi8yp61KKuv4SuHIjp5FPXssJ4nczS3OhMyK/9vWet+zlq8?=
 =?us-ascii?Q?41up60ubT8+EiWruAwrHTVjy7wbAKTWfzS2KOMeCCb5TI5Nt61US377nd7iz?=
 =?us-ascii?Q?fbNQiiOtTV3ggN7tNvK7FcAzGaHM7lJ1IYoKUXK1ivgR2CH5sL9AUW4sLoHv?=
 =?us-ascii?Q?97NBmspRkbwBp9h+ymskGXSmjxok9RqOIF8qx7TSfbXOynTKbu2GHVkDGX7D?=
 =?us-ascii?Q?+riuSJMJjdpd1XM1t84XRcOmSpx02IMTVFORqnSKrKJ/pWHLX+k5WWFHm87u?=
 =?us-ascii?Q?c2SI8b0Avdl+S3KqU61KHbwX55pTqwxe45qqAbm4DkLK93eGbgaDmbG1eBlA?=
 =?us-ascii?Q?TNBnjQkoFFfT6P2+0UTQw47nKmMH+q0+8DHUfma/QnK2xDVATzp4b0FxMnyW?=
 =?us-ascii?Q?Yp71dME+Cnw43E3H2nSt1P9dGALWfMfDrpe7nN6AXnflBiTVMzzT4MSBm9tO?=
 =?us-ascii?Q?ktvEslsM+a0msarVinzG0ufsJtP6L12O9zgdRZ8cTbb8KDc/DIJuYS0/Nh4G?=
 =?us-ascii?Q?61YimUAIVeKCoZ3JAUS4cI95JiGj7onEfSFh3OqNmoZKNFMxIXLoHQayaC9o?=
 =?us-ascii?Q?/GBtKMk5NCQXWkkcQOEOGBPXbtsXiQv6W8seRHd9Umb2RJaIUdOLa/9UTLRa?=
 =?us-ascii?Q?UMtzlZiSTrSP8YnUm+Qs7BmgZjuohWSVA8+w18cpR67Lgty5NmSv2VYzic2R?=
 =?us-ascii?Q?RplWSZRut/a4sRup+mSjtXhohjl+v0WDiWYiEObKOKnb9qzPcG48WsJQaL7g?=
 =?us-ascii?Q?bH8KVeLVw8n5ZZIro8u6brikchAblje?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: giMTliuToh8Mdc3hiZnkOiyfiXcsoAgRzGm1Ocf4juZ/VAI0FB0sXT1FMuaYZpzPuF6B9o9TlN4qxe7b+O+KzVKlTbBixuPDMGfK3OM8Sa9hAGarcfmuxlKSO0H/5Bt5962cm7sNOOgnDb+GQlzw0+wOHLudGqGSk/tyMNp2eI+lN89qIkizj0qEiZ9O/HBaL9HL8D54aWotjAIFJGh21e0dR4jYoMyXAzf47dH/TQm1PrJLqmsScToOCGmi5U77egfG2WtCKXJhbGybwtMH3VdaEMeY9a9pLizISaPIxnISTFuKwnCQABY+MNc9VxFzTrYZrIFWk8ZoxC6PgW2GX0opZSbfh2wATZ5MFjqSS2UDOA+goPnlllBrK33lSb2wMAeCPsvl6MgRwaaS9omZyGeK6YWiJd5wVMk8gBkE9MI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2019 17:17:55.0648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117eabb4-cf88-4725-2b3b-08d69b452e52
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frequency attribute is added with a standard type from iio framework
instead of custom attribute. This is a small step towards removing any
unnecessary custom attribute. Ad9834 will diverge from ad9833 in the
future, that is why we have two identical arrays for ad9834 and 9833.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changed in v3:
        -based on Jonathan suggestion, i replaced default option with
        Ad9834 DeviceId
        -added a local variable in frequency to simplify the code
        -added ABI documentation

 .../testing/sysfs-bus-iio-frequency-ad9834    | 129 ++++++++++++++++++
 drivers/staging/iio/frequency/ad9834.c        | 104 +++++++++++---
 2 files changed, 216 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
new file mode 100644
index 000000000000..b912b49473a3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9834
@@ -0,0 +1,129 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_frequency
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents the value from frequency register 0 of device. The
+		value is between 0 and clock frequency / 2.
+		Reading returns the value of frequency written in register 0.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage1_frequency
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents the value from frequency register 1 of device. The
+		value is between 0 and clock frequency / 2.
+		Reading returns the value of frequency written in register 1.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase0
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents the value from phase register 0 of device. The value
+		is between 0 and 4096 rad.
+		Reading returns the value of phase written in register 0.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phase1
+KernelVersion:	3.5.0
+Date:		April 2012
+Date:		February 2019
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents the value from phase register 1 of device.
+		The value is between 0 and 4096 rad
+		Reading returns the value of phase written in register 1.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out0_wavetype_available
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the possible waveform of output:
+		sine - for a sinewave
+		triangle - for a triangle signal
+		square - squarewave, this is only available on ad9833/7
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out0_wavetype
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents the output waveform of channel:
+		sine - for a sinewave
+		triangle - for a triangle signal
+		square - squarewave, this is only available on ad9833/7
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out1_wavetype_available
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the possible waveform type for accumulator
+		output:
+		square - for a squarewave output
+		nothing - when orbiten is activated
+		This is only available on ad9834
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out1_wavetype
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents the accumulator output waveform:
+		square or nothing when orbiten is activated
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_pincontrol_en
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents the PIN_SW bit and determines if the device is
+		control by spi or by gpio pins.
+		Reading returns the selected method.
+		Is only available for ad9834.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_frequencysymbol
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents which frequency register is selected. These devices
+		have two registers for frequency and phase but only one
+		output. The user can select which one controls the output.
+		0 represents frequency 0 which is mapped to
+		out_altvoltage0_frequency
+		1 represents frequency 1 which is mapped to
+		out_altvoltage1_frequency
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_phasesymbol
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents which phase register is selected. These devices
+		have two registers for frequency and phase but only one
+		output. The user can select which one controls the output.
+		0 represents phase 0 which is mapped to
+		out_altvoltage0_phase0
+		1 represents phase 1 which is mapped to
+		out_altvoltage0_phase1
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out0_enable
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enable or disable the output from channel.
+		0 represents disabled
+		1 represents enabled
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage0_out1_enable
+KernelVersion:	3.5.0
+Date:		April 2012
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enable or disable the output from accumulator channel.
+		0 represents disabled
+		1 represents enabled
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index f036f75d1f22..8465dac656dd 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -81,6 +81,8 @@ struct ad9834_state {
 	struct spi_message		freq_msg;
 	struct mutex                    lock;   /* protect sensor state */
 
+	unsigned long			frequency[2];
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -89,6 +91,11 @@ struct ad9834_state {
 	__be16				freq_data[2];
 };
 
+enum ad9834_ch_addr {
+	AD9834_CHANNEL_ADDRESS0,
+	AD9834_CHANNEL_ADDRESS1,
+};
+
 /**
  * ad9834_supported_device_ids:
  */
@@ -100,6 +107,24 @@ enum ad9834_supported_device_ids {
 	ID_AD9838,
 };
 
+#define AD9833_CHANNEL(chan) {						\
+		.type = IIO_ALTVOLTAGE,					\
+		.indexed = 1,						\
+		.output = 1,						\
+		.channel = (chan),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
+}
+
+static const struct iio_chan_spec ad9833_channels[] = {
+	AD9833_CHANNEL(0),
+	AD9833_CHANNEL(1),
+};
+
+static const struct iio_chan_spec ad9834_channels[] = {
+	AD9833_CHANNEL(0),
+	AD9833_CHANNEL(1),
+};
+
 static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
@@ -109,10 +134,13 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 }
 
 static int ad9834_write_frequency(struct ad9834_state *st,
-				  unsigned long addr, unsigned long fout)
+				  enum ad9834_ch_addr addr,
+				  unsigned long fout)
 {
+	unsigned long frequency_register;
 	unsigned long clk_freq;
 	unsigned long regval;
+	int ret;
 
 	clk_freq = clk_get_rate(st->mclk);
 
@@ -121,13 +149,24 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);
 
-	st->freq_data[0] = cpu_to_be16(addr | (regval &
+	if (addr == AD9834_CHANNEL_ADDRESS0)
+		frequency_register = AD9834_REG_FREQ0;
+	else
+		frequency_register = AD9834_REG_FREQ1;
+
+	st->freq_data[0] = cpu_to_be16(frequency_register | (regval &
 				       RES_MASK(AD9834_FREQ_BITS / 2)));
-	st->freq_data[1] = cpu_to_be16(addr | ((regval >>
+	st->freq_data[1] = cpu_to_be16(frequency_register | ((regval >>
 				       (AD9834_FREQ_BITS / 2)) &
 				       RES_MASK(AD9834_FREQ_BITS / 2)));
 
-	return spi_sync(st->spi, &st->freq_msg);
+	ret = spi_sync(st->spi, &st->freq_msg);
+	if (ret)
+		return ret;
+
+	st->frequency[(int)addr] = fout;
+
+	return 0;
 }
 
 static int ad9834_write_phase(struct ad9834_state *st,
@@ -140,6 +179,39 @@ static int ad9834_write_phase(struct ad9834_state *st,
 	return spi_sync(st->spi, &st->msg);
 }
 
+static int ad9834_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad9834_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		*val = st->frequency[chan->channel];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ad9834_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad9834_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		return ad9834_write_frequency(st,
+					      (enum ad9834_ch_addr)chan->channel,
+					      val);
+	default:
+		return  -EINVAL;
+	}
+
+	return 0;
+}
+
 static ssize_t ad9834_write(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf,
@@ -157,10 +229,6 @@ static ssize_t ad9834_write(struct device *dev,
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
-	case AD9834_REG_FREQ0:
-	case AD9834_REG_FREQ1:
-		ret = ad9834_write_frequency(st, this_attr->address, val);
-		break;
 	case AD9834_REG_PHASE0:
 	case AD9834_REG_PHASE1:
 		ret = ad9834_write_phase(st, this_attr->address, val);
@@ -323,8 +391,6 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
  * see dds.h for further information
  */
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
 static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
 static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
@@ -342,8 +408,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
 
 static struct attribute *ad9834_attributes[] = {
-	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
 	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
@@ -361,8 +425,6 @@ static struct attribute *ad9834_attributes[] = {
 };
 
 static struct attribute *ad9833_attributes[] = {
-	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
 	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
@@ -384,11 +446,15 @@ static const struct attribute_group ad9833_attribute_group = {
 };
 
 static const struct iio_info ad9834_info = {
+	.write_raw = &ad9834_write_raw,
+	.read_raw = &ad9834_read_raw,
 	.attrs = &ad9834_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad9833_info = {
+	.write_raw = &ad9834_write_raw,
+	.read_raw = &ad9834_read_raw,
 	.attrs = &ad9833_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -435,9 +501,13 @@ static int ad9834_probe(struct spi_device *spi)
 	switch (st->devid) {
 	case ID_AD9833:
 	case ID_AD9837:
+		indio_dev->channels = ad9833_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad9833_channels);
 		indio_dev->info = &ad9833_info;
 		break;
-	default:
+	case ID_AD9834:
+		indio_dev->channels = ad9834_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad9834_channels);
 		indio_dev->info = &ad9834_info;
 		break;
 	}
@@ -474,11 +544,11 @@ static int ad9834_probe(struct spi_device *spi)
 		goto error_clock_unprepare;
 	}
 
-	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
+	ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS0, 1000000);
 	if (ret)
 		goto error_clock_unprepare;
 
-	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
+	ret = ad9834_write_frequency(st, AD9834_CHANNEL_ADDRESS1, 5000000);
 	if (ret)
 		goto error_clock_unprepare;
 
-- 
2.17.1

