Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D6BC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B92223BF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="DIqUGv+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B92223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeHJLap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:30:45 -0400
Received: from mail-eopbgr720041.outbound.protection.outlook.com ([40.107.72.41]:24306
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeHJLap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgRgPiruDGCotFyun6Wa2FlPgUAUL7bPQo5618qG01I=;
 b=DIqUGv+CKJb7LQPA7f1WtnMc2v4juuUV5p7bQgk8gpKuvCmCu/tTo/leaopvhEKncmpjO+8NTmESwbXqnKGuvgLbb7wDlYtD1QjHnsn60T4+Rzg8ejM8XJw6ohb33OlXByCAcpcBRT9V9eAMPoTDaIaGdaozE8nK1IcaP4CMTaE=
Received: from CY4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:910:4d::40)
 by BLUPR03MB551.namprd03.prod.outlook.com (2a01:111:e400:882::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.20; Fri, 10 Aug
 2018 08:46:38 +0000
Received: from BY2FFO11FD013.protection.gbl (2a01:111:f400:7c0c::193) by
 CY4PR03CA0099.outlook.office365.com (2603:10b6:910:4d::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.20 via Frontend Transport; Fri, 10 Aug 2018 08:46:38 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD013.mail.protection.outlook.com (10.1.14.75) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Fri, 10 Aug 2018 08:46:37 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7A8kaEB018800
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 10 Aug 2018 01:46:36 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 10 Aug 2018
 04:46:35 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/6] iio: accel: Add adxl372 driver
Date:   Fri, 10 Aug 2018 11:46:17 +0300
Message-ID: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(16586007)(106466001)(14444005)(8936002)(54906003)(316002)(110136005)(2906002)(106002)(50226002)(47776003)(8676002)(246002)(7636002)(26005)(305945005)(356003)(51416003)(7696005)(6306002)(48376002)(126002)(5660300001)(7416002)(50466002)(36756003)(478600001)(336012)(77096007)(966005)(186003)(53416004)(476003)(2616005)(6666003)(486006)(4326008)(72206003)(426003)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB551;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD013;1:M4ONnjyPZZPLJFPF4u1fEd/HrBUWiYJkA0O9eTPHbPykFRyhK7ylAfitsv0VlT0DvtowQQanWwfT333MENpwxs7Fl1uL/TvLgsjyX8YKYX3qcROujeS8+etHGSKdByT5
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47391a7b-bd1c-490d-12d2-08d5fe9dc923
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB551;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;3:9O++qbEnz/mqZ1daJaa87cs037YDRJR4yuQ9Is/QHLc/QW7lEaFQXCxNa4o9DwndzKbfKONnlwvQ+O0ZPS/17mn+Gbn2inV+970weEOpiW1T5kxUxdGyYD7HyRShyhcLjOUMhIcBPipfScRm6LQ94nKel85b2phZD0b1ARAJMsYIc+rWSCXjXJTY05ATwQr2qnn2C4QG3Ppdi6p9CSnuYYPOJhrL/tahxQFafOdauBhY9p55YT21gbxALCRmeoIPsmiFcV4G249a0G78PPkrRjdlMRgxVqzXYglbrZHeQO0qEhyopfowhmaYKNYrxXTh6wggOklK4GXjF6HcXGHU6y0hy6/dTywhJJsaEiueQa0=;25:Bn/XcemnSKaFsLRRt/zq6Dkt7GJ1Pu3wdy1r220tksL2GO4v6YsUKH+lfU6FDfjdcMjBTVlsaB59dGYAo+vKUrj19ids6xranz51PBytO11Rz+PLjPG6dYaXjCPYWyNdwpIx+8oyOSpRmLmdTHW3Gw2bpohl7DnyrRJgQXCapkMLod6/NrcaStbbv3Qy2N944gWvbrdjaV58mV62w8z6NeNUHKAzZyRbq/rnvZmy6D55XdUi42yL++ZCemXa8rwDL8T4TNwbD4TO9Sw43/bHu6f28WVDS2ryHSrfJax22Mz2ThggZjbmnkdGeHeJcFS5r4LKZgdODetM0cQH5pA3Pw==
X-MS-TrafficTypeDiagnostic: BLUPR03MB551:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;31:NPPTJrutsAjzUVOREYOnQtzyfv+pcRNpAc7LG0Tns/02Yp8Lo4WiLjvwu3PiAVgNEJUmk8N6NAcL3ktYJr/JEn47/g7wyw1sseD4dthH9W6PCJZRplUBBdy7q3ME0vCfnuBWsghUmDZtXLRGJRwczlKqVKckxln4XzgvRgPdxob/B5mA7Q8uch19juY5/ngZrJLDwbVpAitk6LnboPgfCy3tM0QTwUgIK5gcjq6N+6o=;20:Sznb4qVGMNf97fskHg9eWBVklEsHN/qN2iz6gNkFo5oGyLnVT/O56KsfTDTZ5uhJLdv4xTYdvmGA+rrRUheSLRnzEumhEV3zCVPJDv6AUdXtRaZ7/HLrQyqky6vPLEBpwhmG8gwbmZH5KRs8QewzkvY/dlJr7/LJXZZtZHp1Ms6TWEbYPx7NMFRISGvvmKymtbX6Ux4D5uLju+08KbNFgpqwSxw1Ua+qM3dC79oHLtSDiz28WFbOqiQKP/bi49gXD08pCzo3+IkB3VoSU65NoKP2VP22DhQ3u0kqAN47kJem4G5B22OPqVSyTGMTnP0Oa7hfUzQsMH7CM4u355Z5cgfR9OgCtA2GLfsGqcpek/f+JdLCs0d0L09zsM79bYGKr1qF/rtUZ/oImKxsBu5tMcWaUe7eSiHnYznMseWi/gw8Z5zajAoQrt88TgsrVJ3YlI+AJeUmc/5ziawIKwRpnv8KoTC58dlNGqVhWHvAw1flOnx2qxHMHJnxK6+xXrpo
X-Microsoft-Antispam-PRVS: <BLUPR03MB551CD57D9033A24C2C5E5EC9D240@BLUPR03MB551.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR03MB551;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB551;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;4:7odMIKDtYkdx0ZMaMqAmcRDTvXcWMwq1MEV+dV/Y12D+PtUXjeZ3PWSG/ip9s1eH98Cf9aZh8+0iQo+5yReXqDNrJbfpqldXilinEB4XTMSmi3QD+KTB1s4dANWyAc4F1lFvq7BtEkXaDPXWtNrjgedYYVB2U33PGVCihsXPwpO/VrqNkDpXneiyPq7WExnjzc+H+h/FmeYHSUV5igmeT15rHnMo9tFhA2c8v89bqcB5jPbIpOS/ll5fna59nBFvBA4UtPxDJfnnhvPIe8hy6cWL5UWKyMeQNZsts+e8lgjwk36r6uQj5idfWsBWElqe
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB551;23:y6CfIUCrss1h5fCxY6VIBZUV8FftvWl1NSeN3DOVES?=
 =?us-ascii?Q?AzGqfRYXcav8lqF3Hi9mVPhL4cbdk+cmexDNggZ8JCBdJVSuC/8Jc/Veg6pP?=
 =?us-ascii?Q?1pr511UAi2NMoIyLasuLANiAjLqfGnfw5sIrXQcGICPBr5LaSg4/7kVSxmRE?=
 =?us-ascii?Q?UBF+3vzQeJfUuIhIQ4/U82djlTr2PO9jGoaYphQO8vUa993F/CCj2kGts6sY?=
 =?us-ascii?Q?KgV4yw/iVEXBkNP0UkY6A7pAvk1yVu1NzzBmennURIiOgHkDkJC0mL4eBQww?=
 =?us-ascii?Q?h/RSmSC/to2Mw8kfA32HLb0JiOKtVztat3MbcvEzvvI+qLKyrbRNwkgiDgbV?=
 =?us-ascii?Q?3Dd9uhZPnCGlvysHf2QKPVW5AvgP5tZx2aB0Fxlt131jJvgefO+ERfEVDu7w?=
 =?us-ascii?Q?NMZb4IDM7YqLCFrqM0rjpebVvRy/FjvZR2Y8D3biM8WQPuCc3OvGoQzgaPj3?=
 =?us-ascii?Q?mwWfEKjiY///Kc1JAz/ckfKzv8mdsdWacFLT8JSK/3BlC0WzXib+Xc6mBjFk?=
 =?us-ascii?Q?LIGTFWeZl+pNPtJa9wizic0j613ZteBC2belgc6aQJVmLOQtZ8oPvzfgj4Mf?=
 =?us-ascii?Q?F7D5ObkAViXjmu3u1TEJNPraO8hpYNGyvBfljjYpqn6sfx7O6W7yV6lmx+HM?=
 =?us-ascii?Q?0WrdP37p94HLdGT0HJbU0K5tEphfLRM2dkFp14W1jSB1M1XZWUM7ArNIocx7?=
 =?us-ascii?Q?4fEKC3gE3GdmCMXfzBEOuIYpC30Jv1hp4BfoaQIGusJ8wcX9S6AY7K5PRnka?=
 =?us-ascii?Q?efx/vA60ysD9+Se+CVbNBsigSHi/slSZNcLTVfJjc85n530CzVPn7p5J+seY?=
 =?us-ascii?Q?GubNXtPD/E0Fbx4rEsSYYKwJWoVLyjblYmfdNjUYosfvAvgoGMAbpfTxeUMd?=
 =?us-ascii?Q?O6fyphtypTrfdLTHWHCnZ0llGE2sRYI94YOA11h7C+olqlwF6OoVGXFEaxPd?=
 =?us-ascii?Q?6Ci5ppCI20Oh6IN25JJzuEdhdtB4hV+oQu6+hYcQREo5Axub195yfL2h6qA5?=
 =?us-ascii?Q?eN56H0Adu3QYeXK/yNPoh95cSBq+PnWzg6AFy2v9LvvrUn0qGojU/vk/9CKW?=
 =?us-ascii?Q?6haFUeWtRtFyiAsWA9CEC+ZyAk?=
X-Microsoft-Antispam-Message-Info: IoumTEdMNx11a6aec+WdTSA3BfMdKr4fyfvRG6tLJD12vCkG5ansXBubM5XrT+GQP1YGxC9mLFT4Q3JRclvJXe3K6M02qr8gEnCi6m/6IEAw8/ZN0GeC8KY43G97x3lyXF3cV4jKFlyhrs6SJC/yeoJRMQRje2e78W9NUeFPngZhY9PYXrTB4lXNtlC308z6x8ljp36p6UsWnhfdpt3SMFPVR76JpPkf9U2IjWy6ZmDALxCCq6yoiMnES2HnCbWFkkGPdLHbngScH/8Ji7G/Oz3uXorwm3OAO3ZZ1G0X3rzrT5DZjgcS4N5H6qGiog+/AYXiE5az/1bF9AIBlPm72RVPEC1BOwGZdHewU6xbv3k=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;6:2R81Zu/91n8Qctz6OCbJ7GZV09t2bD7ME3yPydb3uYqXfz8saJ+ix+mZyuSDgjB5lsPSgni89FdvDCW1rxg1VBK+GxZDfmAQ/UdPtzM/vUIEsI1s026T/uTBhbgnpwCH8hctvfQXor2z4P/TsvI2ftX1ubKKuuubaybPco+K2wmnZSXDQrQg57xTGaBN14XlrEccGHhpKkE1eL2hyjchimxDtMM+6bXVHyPeS4xClj96DB+0W5MtgwuK+N1UMWIBak7GBBn7uVJeiwr4vi5UZlHxW5gTC1XfoW1QTYdTSiUx0aCqvMgz4GW+o+2lnVTXDVr8dGtedUC0Ox8P9SmWtSPr6BYYocOQcmP0ORY/DtVjzPPF+59PE2yPLhyIGveYr1XgSYAbuR0dX/OFoEsefXgQeVpHGU+VZ8g8HG/ZVuwxYriFF5x5w81k9i/doQDmtbx2nbOPOSObfqZw+W7PJg==;5:nGIKUWOrmvWP201jq7EDeaCCxj29o78SRFgaet/h5uyG6SxltlyWC+wYiqdqgbxgR7mM0nCQw/PCM79pJXVAz9UEK+H3n25ljSKHD0ETibuU4u8x5FjpqV81NoS9gd6FApJzrRaEjKqrcGK4rjdkos/zREnYG/3IHMUTUDFGG/4=;7:mibGk6WOIpYeDURL1ob6cUxGGknGsbEEbJvZG3lChHi79nsl43aeo++r+cclJN2z4MzVTkCU9nT6H9wLtLxFZw5l+mldX7ymdJSszz6XvzZO6QkJMu3++62l+kl8oSz0keiWXFDrg4HKE3dfm1N6Ul7nwgVsisSC9POj1Iwh4c86IwzKw/rxrd04PIZ9jB8B4PL8YNmgnmLoONkIKc1XhpfRzt/QA+AlIBPKqXFVf8KYveEb/5vFTEaDNyUf9bhq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 08:46:37.7820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47391a7b-bd1c-490d-12d2-08d5fe9dc923
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:
Patch 1:
	- nothing changed.
Patch 2, 3:
	- added reviewed-by's which were lost when new versions were added.
Patch 4:
	- fixed kbuild warning by adding a buffer overflow check in
	  adxl372_buffer_postenable().
Patch 5, 6:
	- nothing changed

Changes in v5:
Patch 1, 2:
	- nothing changed
Patch 3:
	- added a new readable_noinc operation based on feedback from
	  Mark Brown
Patch 4:
	- added a readable_noinc callback based on the changes from the
	  previous patch.
Patch 5, 6:
	- nothing changed

Changes in v4:
Patch 1:
	- used a lookup table in adxl372_set_activity_threshold() instead
	  of a switch(case).
Patch 2: 
	- removed the interrupt-parent from the bindings.
Patch 3:
	- renamed regmap_pipe_read() stub to regmap_noinc_read().
Patch 4:
	- removed the adxl372_read_fifo() wrapper and directly called
	  regmap_noinc_read().
	- called iio_triggered_buffer_predisable() before doing the local
	  changes.
Patch 5:
	- nothing changed.
Patch 6:
	- nothing changed.

Changes in v3:
Patch 1, 2:
	- nothing changed
Patch 3:
	- changed the name from regmap_pipe_read() to regmap_noinc_read()
	- added a check for readable registers
Patch 4:
	- dropped the fifo peak mode
	- corrected the patch based on feedback from Peter Meerwald-Stadler.
Patch 5 and 6:
	- nothing changed

Changes in v2:
Patch 1:
	- removed ADXL372_RD_FLAG_MSK and ADXL372_WR_FLAG_MSK macros.
	- handled regmap read/write by setting reg_bits and pad_bits
	  fields in regmap_config struct.
	- removed the buffer specifications when defining the channels.
	- changed the activity and inactivity thresholds.
	- added two new functions for setting the activity and inactivity
	  timers: adxl372_set_inactivity_time_ms() and
	  adxl372_set_activity_time_ms().
Patch 2:
	- introduced all the DT bindings in a single patch.
Patch 3:
	- backported the patch based on this discussion: 
          https://lkml.org/lkml/2016/6/16/548.
	- this patch is required as the regmap_pipe_read() API will be used 
	  to read the data from the FIFO.
Patch 4:
	- removed DT bindings changes from this patch.
	- removed the linux/gpio/consumer.h header.
	- used regmap_pipe_read() instead of regmap_bulk_read() when
	  reading data from the FIFO.
	- used multiple regmap_write() calls instead of a single
	  regmap_bulk_write() if there is no fast path.
	- used be32_to_cpu() inside the adxl372_get_status() function.
	- added a new in_accel_x&y&z_peak scan element which allows the
	  user to set the FIFO into XYZ peak mode.
	- used a adxl372_axis_lookup_table() to determine the fifo format
	  from the active_scan_mask.
	- made IRQ optional.
Patch 5 and 6:
	- nothing changed

Crestez Dan Leonard (1):
  regmap: Add regmap_noinc_read API

Stefan Popa (5):
  iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
  dt-bindings: iio: accel: Add docs for ADXL372
  iio:adxl372: Add FIFO and interrupts support
  iio:adxl372: Add sampling frequency support
  iio:adxl372: Add filter bandwidth support

 .../devicetree/bindings/iio/accel/adxl372.txt      |  22 +
 MAINTAINERS                                        |   7 +
 drivers/base/regmap/internal.h                     |   3 +
 drivers/base/regmap/regmap.c                       |  79 +-
 drivers/iio/accel/Kconfig                          |  11 +
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/adxl372.c                        | 986 +++++++++++++++++++++
 include/linux/regmap.h                             |  19 +
 8 files changed, 1127 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
 create mode 100644 drivers/iio/accel/adxl372.c

-- 
2.7.4

