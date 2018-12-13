Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F5EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8147020880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="LKxYnlS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8147020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeLMMrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:15 -0500
Received: from mail-eopbgr780084.outbound.protection.outlook.com ([40.107.78.84]:21285
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729120AbeLMMrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwpI8Qq+ABJJ4Hy3B6VO0fhctVDq3V43sWYw6fVc2xA=;
 b=LKxYnlS9mcmIXTaouFwN3z0obTKc6eak39wqrlC/A9pJFd0rIgpLDq0xI1bcY8K6brZEA+X1yloFe27WHQT0FphDZ6PLjzOc/ZVsabEcVaBTNVfXaG1p6IC9ltYp+OUiEH1tYq+I+1ezELwFYg+0pXzMngQSSZMS3UVZ1rVpHv8=
Received: from MWHPR03CA0008.namprd03.prod.outlook.com (2603:10b6:300:117::18)
 by BLUPR03MB549.namprd03.prod.outlook.com (2a01:111:e400:880::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.19; Thu, 13 Dec
 2018 12:47:10 +0000
Received: from BL2FFO11FD019.protection.gbl (2a01:111:f400:7c09::193) by
 MWHPR03CA0008.outlook.office365.com (2603:10b6:300:117::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.19 via Frontend Transport; Thu, 13 Dec 2018 12:47:10 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2FFO11FD019.mail.protection.outlook.com (10.173.161.37) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:47:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDCl9W8004099
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:47:09 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:47:08 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 03/11] staging: iio: adc: ad7606: Use wait-for-completion handler
Date:   Thu, 13 Dec 2018 14:46:15 +0200
Message-ID: <1544705183-13288-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(2980300002)(3190300001)(199004)(189003)(126002)(486006)(106466001)(72206003)(476003)(2616005)(11346002)(36756003)(446003)(478600001)(110136005)(2906002)(6666004)(336012)(426003)(116002)(106002)(44832011)(305945005)(356004)(54906003)(7416002)(5660300001)(8676002)(16586007)(14444005)(50466002)(316002)(8936002)(246002)(47776003)(48376002)(76176011)(7636002)(50226002)(4326008)(7696005)(77096007)(186003)(26005)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB549;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD019;1:Ki5KOjYZjyrJ24+jzQjw9dPacENQoJM+2l+CwDMA/STUxNuN/l925DUyWokpAsYZAc6/rxzUncvF5OmcCZ7j8pMClG0tuPDexX8unK4FdtsXgj0ZDHEjN6oqoBdpPX0E
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44dc453e-1da0-4dba-cc9a-08d660f918ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB549;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB549;3:Ku9I5vzr43509QvybgQZU1YiHfpOtem1BEzHMcDvYDBOeLB4A1Yt7i58JYRMproFp1cvePhEYlvMwv4Gw1+jjcJ5vC1k/viruFjd0xQXwkqzq+ihJszd8byQy67w88xTL5UjhOlk3OO+wJMmxCR+Htdg559wA8B5o9FWf45sd2CpGW0QINGVCXGYBTMBsbKgXNWJ9Jqb9Yc8orpVxvL8OZclShLqcoLq2V6ByucgtLIELhTOapPZBwHZW7VSCXwjuaHOyINSj4n9i7PJhe3JbNSHJknB+WN+GcwR/4ndSCw/sLkCa1cBnvD0iTsbWYRs7/35qjJ0HiE/D2545mVD8cmtnZiUPWf7N5ufKyohI6k=;25:V01ld1q2J/SMplEnE+YFdoDN74kXGC8kYSvwEgPqAXhFVWL98mRGjMvGpzDWveEM61bP252rxdHutfnsfqDt3c+PNd+drujYf59/aWn9+hh3uLJitNctxcH5VDW7gEzdIAtuK5WBTnajOcxmUn00laHOcf0wbGRrR07Gyw35MVpTg3D+24zRxcBLUelUTkSZJ42lJba8cxwxfOu1SQ55Jlr8H6ohTio7kazzpm3wQmKx2Llecybka7xYjcO3PNyvH4IxNeX3DVpGgdUnVq81EAs0VnMdOVvFWsGMUocIb3iTqbre87F/0zn4v/X/ClNMIBF0+mycE2RuvA6Nr2R0eJj0VXDFtvb/RzLYfE+KMLs=
X-MS-TrafficTypeDiagnostic: BLUPR03MB549:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB549;31:AjhNIA6f90OKFKeuknFLcpaJEoJVPAlEcAqwWl0g3K4bg4XTQOHj0QYlLpnvT7R4qWkdmOUaTf/GOqhxaGpPh6eqrAMb3FLVBv6WuOAwV3cRGZX48Y5dGbSJs5QD4pirmY2k8HrtdPlPhZZ/vcnwxGvV1ySD4j9btF2p380CNwwM4MjMljcD5QwA0jMfCF4i9Vo2ZQBLN+VuFxvcqKUpRwjLcgLlLkETu9nz7sVK2ZA=;20:lsmyS0IE3ij0D7TtfvON0irSG5dXRy0Zp9ayqZRxx9gmS0s6TvihfUPQ5VJ5FrMhhLrJ4KB/E99e/APKLA8dZ19G+vyX5oYnJ6V0t5HFr5xmHMvuz9NgbrAQihu4Ocj89rdg/o8kehjyY0NefXhyW0JSmbAjO3gejOz7suGbc7FgOF7cYPyuZCmsWP17NIDyXS1pmEJzz0atZlmufUBwPQWVhEUoeJLYF72dHryqHkykeiL6geCEMU8iL7Qebh1S6RzAn1iWS83g6k9D0maIQxkXQt0w02bg+be23pXgzpI6dY3TFNK84mIT57nM/OGlo208+8QeB2v3YQGKm4NHtX5IIAExfNrCJRJG1iNz7vH/jQKiNX4VByxWwmp4REvfS41OlAa7zJcMvg/NAL0O33+RiTFSfPKvzFEb8c3LR6VFLi2FOkboR+ob3Hl3AdMaO8xwRMEd4lOBVMjnXyxYSCRfFwuKnlma6ixwQASRlE2tkHcqDZtzyD5T0acJZD2o
X-Microsoft-Antispam-PRVS: <BLUPR03MB5491772CA3E8B297D4EF76D9DA00@BLUPR03MB549.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(52105112)(93006095)(93004095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BLUPR03MB549;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB549;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB549;4:RUfJLbAbMw05JM7RC/efWT7WUZmtrxCdGAXRaHQu8kqIc1DA9Cl1umADxEku2HmTYGB/Nem+LBS3X1l38Swio7ArbdENoWrQpNSH7hmQB9ZtNkfw812pL1iHWjS5lqLlD9Y5T19hgMiB4jsMt4VGISaFCwwu3nqFkvr1sjY6fwqIoN4raHTK1S405Vg+OftbNE+0RxmQoPmvlCXCe/jogulKxCu+CO5VLduY3SKVrvkq2fCcsOgwKvFlINakKY3BDhwyUt3k+ZK8SkbCHkPZNQ==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB549;23:5YV15fzXoq20X24LE0AS0FQsv6Y+jhTsFNbZBC/Z6z?=
 =?us-ascii?Q?1zBGzGH+I7Yb8WBcC9FFo/oBHjhZxzwX49mKNJEIxsYn4weStvvUn8FQ7ips?=
 =?us-ascii?Q?x0m5uFkYdFKuCrd3Ne/s6/nptIth2TyoIBrVdji6kxXgvZEceDDh4OEHV4BA?=
 =?us-ascii?Q?5reMuo14Rb2dBkzII9TXLCVhuNm+RZ4zcpGWpbYdNYsJkFjqy/q9Z9mKzRpL?=
 =?us-ascii?Q?etbmuevw4iQ4nfZgWOmlL5G5O3Apfy5q0fAZdGwOguTEobxBiM4UNMG6xIQn?=
 =?us-ascii?Q?qLdHJtJRt99P8T36GuI9kzujywggwnBRjcKhR6EHX4AYOIZ8rAVjksOWfsLp?=
 =?us-ascii?Q?8qwAcI4xBAJycM+P8Cl4X9AzVecotZpAD6kcPXrxMB/hxPisy9b14yG5y5eB?=
 =?us-ascii?Q?A/QD8NmaIG+Vz/G4OymqCBURSELnWvfBn6CbFyZSltcjwkoYFeXVAH3lOKwF?=
 =?us-ascii?Q?fcZnkBqHUXaRcqXeT0X5N4fXp+++f5RZQJ/EJjekMHZH2rCIOQvRg8z9OHvc?=
 =?us-ascii?Q?u1PPaeNsi/HAZfhntVmYsslThJWdy3iuFseWOrla+Y9VDs/YgwEb8czfwvhB?=
 =?us-ascii?Q?T+AC3ycfsn6M0U+WzRzGE3RAoy7EDOA03oaq6Mq5hWaOQi1R8DM+pMRRgerb?=
 =?us-ascii?Q?ENc+gnEyRYzkqjYhZvJsnzyfF9Gh0S5rtNV2B2nu4GO8IJjiOcMc+HJsHTDJ?=
 =?us-ascii?Q?egShK5Q13nglAoOcHC0BLeHHjiXrclnN8V+UMEzUvjPeUVjhhxNj2PJl9aIv?=
 =?us-ascii?Q?3rJvoARySuzT+TUqxoZ+W6zX8o/QEKMbkmc1go9pxgtjLMjXag86e8a2ULIv?=
 =?us-ascii?Q?ve754MQnD1a9Nqak+Bw2+mXG4kC2rZTsbPj5lj77/cKwq9NSMxAbNUic2iyL?=
 =?us-ascii?Q?fzjgwdHSGjy7oxXThqx/RONtC0w1JZUnWdgl1fW6PQ6o/YksCE9C3TU4WuTX?=
 =?us-ascii?Q?99TwEgXMM9eqaKxfOXaMcTlR9M/Qw7cYQuZ3RM3zy9KWZhR9qF/QnWv6za3a?=
 =?us-ascii?Q?lfzK8r55LjWHezwNa7qVWSBeLBKoPzeN6J2X+W6rPytPW0C3NVpZKy/Tv/SR?=
 =?us-ascii?Q?O/lcAbdiaF1H+O/eEIJWPjFkXtLkTSE49owP67K+9LyUfzNA=3D=3D?=
X-Microsoft-Antispam-Message-Info: NyRWxD4YG5HsYAzk4WGjbKQUyEp+NAQuwIqqkeASUgh/GczYKgaeXG0sjX3O4wRuY5+gz6uqx6xJmoV1cr51PAWe7RdUE41wwo2uwrEppSpNsWz46LX7G8boEtlfsjM7VyWwt2gJijkMr5m/o19zjNvvOSWPdbGyftI4nbSGo86QqQ9Zz6aX7wS4QBFJ2U5lS+L6I0GIu+IteSemYgQhmyg01vnn+i9pjyvcq9ibFJbd46Lcl5sjvBKneuDLym8iG8VTdCXHuSU3trUurYwWxHYeUklOmhZAd+udp7cQshAinkAAf+6g+0V46oc16xH+
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB549;6:yE5opqTNx9wcVznzRCY4QtU6U534jeetKFFzJmOajv+wgeqcy0QVqsRLZiZKP5ufdAdt9yMlGg1CvVhh7Izckh2sqzuSpjNO0nRKVVlJpJBDFwa6xKVkPalcACEH8HkYY1lyYOLZHadqaeqOdXOhoDjVlgb4IWvseLqQp8LcRhlvyEGqbNg1VYdWYPbAFT52pNke3/54O1bkduyoUuzmcaGcFYCLlkpZfRwXFECSZiSLHLgKuvGg/LwcmbKo0r0w/SNXFD+oB/t902yWWlHPIMyfJTQOnfbN+4JWAPRkRnntKCyG/luwfRpCawq+z0b46ihktH/xU4yAK/vpR8aco0qsSVMQjJ1Z3RqKSg6SKIFmXc1M6ymR+Gci67miiLbUoomjgxX2RirtKBuw8192oszZaHfTzKIWTnHCjkmuyDuD156O388qWbovFEQ6+xqeqq4BJWlZuHqr5MIkcqal5g==;5:nQG/GX4Al7Tpv7mQapzts9nrMCTmJ8GufoLxfrFnV/bfKP6AaKbv+iApl3yK5s+yP6+ZGnxBJQazLd5SgcaYdxovLeLwCwPNl54Z7mmw4whb8nUHW7pjy1amfxmlVMmRL3RVK0tLGLhhnJb46i1Ik2XCOp9FS1M+cHkNz2zEJ58=;7:tPgJGiKOen+pLoXal7BZkqYq4LNU1am78H9X6qSaOOZUPBzMIeRvp+vMyh1EI/3lO12XpD0z93iTpAcddraiK9+sG9rdMu6m184Nufb3tfHYEhjLWHzfq7T7mWXnxI+r6Rx1plKpUQzt7aW7in+w9A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:47:09.7476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dc453e-1da0-4dba-cc9a-08d660f918ca
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the use of wait_event_interruptible() with
wait_for_completion_timeout() when reading the result of a single
conversion. In this way, if the interrupt never occurs, the program will
not remain blocked.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7606.c | 14 +++++++-------
 drivers/staging/iio/adc/ad7606.h |  6 ++----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index aa5ab1e..4b1bc20 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -118,12 +118,13 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
-	st->done = false;
 	gpiod_set_value(st->gpio_convst, 1);
-
-	ret = wait_event_interruptible(st->wq_data_avail, st->done);
-	if (ret)
+	ret = wait_for_completion_timeout(&st->completion,
+					  msecs_to_jiffies(1000));
+	if (!ret) {
+		ret = -ETIMEDOUT;
 		goto error_ret;
+	}
 
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
@@ -388,8 +389,7 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	if (iio_buffer_enabled(indio_dev)) {
 		schedule_work(&st->poll_work);
 	} else {
-		st->done = true;
-		wake_up_interruptible(&st->wq_data_avail);
+		complete(&st->completion);
 	}
 
 	return IRQ_HANDLED;
@@ -473,7 +473,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	init_waitqueue_head(&st->wq_data_avail);
+	init_completion(&st->completion);
 
 	ret = ad7606_reset(st);
 	if (ret)
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index e365fa0..cf20ca2 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -28,11 +28,9 @@ struct ad7606_chip_info {
  * @reg		regulator info for the the power supply of the device
  * @poll_work		work struct for continuously reading data from the device
  *			into an IIO triggered buffer
- * @wq_data_avail	wait queue struct for buffer mode
  * @bops		bus operations (SPI or parallel)
  * @range		voltage range selection, selects which scale to apply
  * @oversampling	oversampling selection
- * @done		marks whether reading data is done
  * @base_address	address from where to read data in parallel operation
  * @lock		protect sensor state from concurrent accesses to GPIOs
  * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
@@ -43,6 +41,7 @@ struct ad7606_chip_info {
  * @gpio_frstdata	GPIO descriptor for reading from device when data
  *			is being read on the first channel
  * @gpio_os		GPIO descriptors to control oversampling on the device
+ * @complete		completion to indicate end of conversion
  * @data		buffer for reading data from the device
  */
 
@@ -51,11 +50,9 @@ struct ad7606_state {
 	const struct ad7606_chip_info	*chip_info;
 	struct regulator		*reg;
 	struct work_struct		poll_work;
-	wait_queue_head_t		wq_data_avail;
 	const struct ad7606_bus_ops	*bops;
 	unsigned int			range;
 	unsigned int			oversampling;
-	bool				done;
 	void __iomem			*base_address;
 
 	struct mutex			lock; /* protect sensor state */
@@ -65,6 +62,7 @@ struct ad7606_state {
 	struct gpio_desc		*gpio_standby;
 	struct gpio_desc		*gpio_frstdata;
 	struct gpio_descs		*gpio_os;
+	struct completion		completion;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
-- 
2.7.4

