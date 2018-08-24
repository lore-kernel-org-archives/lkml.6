Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E980621557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="08NWJcpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E980621557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeHXFMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:12:30 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:56241
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725735AbeHXFMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnROqOLA+TNFicn4ofLnitd8odTi9jWmZkaoxryPnEc=;
 b=08NWJcpzJlm8rhurHKyvTsPrRqz20H2SzRggE5UewHQDVq23sBewiITBMrhyFZK1/J2Qi6YSLM0ed7Bc581JgcIxz8ygWv9Z2C5RTyPo3mMCdnYRoXlTMVzqdpOiuBWElpnG448FX6zAUJe4qrlFaXmPfPn2nfHiGck3Y4M2g68=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
Received: from localhost.localdomain (172.56.39.74) by
 CY1PR1101MB1131.namprd11.prod.outlook.com (2a01:111:e400:5bd8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Fri, 24 Aug
 2018 01:40:02 +0000
From:   Ryan Lee <ryans.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@maximintegrated.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com
Subject: [v2] ASoC: max98373: Added 10ms sleep after amp software reset
Date:   Thu, 23 Aug 2018 18:37:08 -0700
Message-Id: <20180824013708.23737-1-ryans.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.56.39.74]
X-ClientProxiedBy: DM5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:4:2::34)
 To CY1PR1101MB1131.namprd11.prod.outlook.com (2a01:111:e400:5bd8::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 601423e4-f5da-4c9e-fb18-08d609628373
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR1101MB1131;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR1101MB1131;3:J5/C63AYRsI5030LNiUdNbqzrZ1l/5a/yUsnfqKqe+TvW5U2NDW4GQwtd1IN2zYZABnfMebNTicDEvPm7zHMR/p64AQl+lE1UG4RfXCtSK7IIjTSPRqhTBxn/cFAbgNqc9k2OI7bcLle8eMQTcvsvtsjpVQAztoR1wGu1EHgYQtgR3Kcu59Sk4c0X3USJ/Hsjg9exWMt8Z7RrhA/7IPRiTjJyEOmSgD1Vrb973m+8sHvCqeucgAwG/114Oru0NMX;25:n1Ku+nS3RH8RQw/fJQxW9jgHt3Jzo0X3Pi16+9DsBttqpy8bdg6jgFUQmIQV1a6FaTr2Cz+HwZZu/5jh0rRah0Ehtie5PkYyQNSYO/7rez9Y6cSgphpkrvscPIv5NolpFkSMxM/ifU28y25raHwcPKK3XQPtY4cKMzudyXoUVtatYlJZppQei7B7wmnmnZVeDz4R1NalBtvFcMoY5DQH6DWVZA/evUHTMc0JrHNMf7hFeCRlyePu7/LFdPveMs7bea78CqiSbiYJibmoZI1I5iD8d45O/YUMKCIadwg9z0G4zzf9wmPxqKZf462gInV4yZX+LNa0+3wz4dZy9c3YiA==;31:Sxs/LpZ9L69w4Pl0sn12TGsf9Ae0aMkKbSWzbbGKBwLSIl3YNjKlkvp58FTsW1GvM6K2+a7aiJyA2WjxqYU9v6YsCR4b+sJOBxbQFIAfZXorrofuaAspE17SBMWRbmigzi9YMmjQcgxV45zGQQvvNUF68RCkA4ZzK0LVeCLDilrMVOpx2skXDHbrp/9Svbay5V7qpMXA9EJPjFTnZEqYuy9xjqDA5B8aiz0d2MpCm2A=
X-MS-TrafficTypeDiagnostic: CY1PR1101MB1131:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR1101MB1131;20:MGrpx8t1xlFWMY7CGDT7dnmFDKinLAlV7C41d04ZRxIp58THU7Kjszox2AHtzF5Kj+7g2dOcUmYw+i1bm0KO8TUOkDySGpkN6K+vSGRTcjB7ySOfEYiuzsjiOIBQofegJ9Im4mzq5patI04BaEP2g+WXUzZb9hlfnyBD4FqBq/qrGS21C8QXtWLmj9jdKf7P9dwdaXU6rppUQ6HnNkjdWFxm/GXAR/Ny2idoRH7fhyQxB2XkQJw9Eodbqx+vp5yl6QupTZVEOo3hq1eLyk1BQUT/BD4DS4Le+hmiWypuG1jx5S0mhMfUemvplWHJhlVWrKUYwnJDS0AcnvkpZaGJbB049XvSyDosYGsvTbPa7wSG9Qm8lvaPHWs3Lzq71ox3XOGR+bH7wWH/D/1qHAVoaLbvnA/Fkv6oCo27BgVWdmg8/VufR5w22ITDo4TwsMYPJsKlxHcztMR9WKUri63zxLiXXUWnEHnMLyzKiSvWZZIahE7KXfBC6joeSLy0+K1o;4:Mr8QWokSFnU20Ktz8RQCGRVPyHXaWCMsufXgG8+WIG3cRcul3P3NXmDnZdGVyySKD6na7b1nF2nb1OIHJYq5haatwYd/Og/VzCTUjIItjP1EAjUv1+HhxlhoDCW6d9wkhmCcFrPjkpOTLa1MqwsTNkuDB+L6e0GiuxWEyq1zLnxTHr07pD23gTDCZ2y12b2JhMd+TW7aYGkdYNe0uY06uwOekA9RV7xBSAkuLXF62XoQfGA4199iLpA9StEB97kwUjmFoBKIx93gDJ5c9Pe+zma+rNMUc/XxysbfM4QcCT9lmU8/nhMpQjSTTxmTeYYT
X-Microsoft-Antispam-PRVS: <CY1PR1101MB11318A28CDDB2175B6A14A54E7360@CY1PR1101MB1131.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(108721460000369);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR1101MB1131;BCL:0;PCL:0;RULEID:;SRVR:CY1PR1101MB1131;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(376002)(396003)(39860400002)(136003)(199004)(189003)(478600001)(6486002)(53936002)(48376002)(86362001)(72206003)(50466002)(50226002)(36756003)(51416003)(68736007)(6512007)(6506007)(386003)(52116002)(26005)(105586002)(4326008)(8936002)(486006)(8676002)(106356001)(1076002)(81156014)(81166006)(66066001)(25786009)(3846002)(316002)(16586007)(6116002)(97736004)(956004)(5660300001)(39060400002)(476003)(186003)(16526019)(7736002)(2906002)(305945005)(2616005)(47776003)(69590400005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR1101MB1131;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR1101MB1131;23:biRBNeXoJ6p03uwuzb4CqddzgdBL2SGEdtIuoTu?=
 =?us-ascii?Q?Sfv9UAoVSG+XQGpSrjCEGATGS0GxJzN46T2aZOOgqDZZUOqL3RLrDKbWnOqt?=
 =?us-ascii?Q?nTNzRCwkxtwlvup2nb3PBZy8OT088QgXvroRAepd41iu3gR9GNQFsjNr75kW?=
 =?us-ascii?Q?xTfpisu8b/Z7zUwmE66/6596pqgJcc0W53B4LwhyrNeWY4U8yLZyr+oQzt2S?=
 =?us-ascii?Q?+OE1GmaEecGeW5bDVg5j3EvXyzBM87VMbYd9NpQ4fLNtxByVpOQYMULj47fc?=
 =?us-ascii?Q?6Dxf98a1SZhmt2HsLCJ4R1ZnzBr88W8rxzXdp/Y10xqGdq8kar2/0Faz9LQP?=
 =?us-ascii?Q?T7AD+npoDd44cHM0OGJpGQYp9KeQU8nYS/SmblnZRkpb+C/OA02js1a3yWgo?=
 =?us-ascii?Q?qTM6/3kZ2rc54JrmoriNT9Zr39n6zKJMNM5/2TFusxQsAtOWKNEdxHhATTgB?=
 =?us-ascii?Q?BwkoOLawUOcve31h+En78jhehsmN79iUpNIN9w/YH0Ik0EYGBsVxPjgSiQkt?=
 =?us-ascii?Q?7uuudbx1PkygunyXtuCbC2hcC2QiNd+NZ+HrAlpQrta/pUzgeU/3oLYSfg+h?=
 =?us-ascii?Q?TKujh3Iclq6yiRsjIHqm2qru7/gywEfIE5dJAF39HT5rBVtKJD0crgf17MTZ?=
 =?us-ascii?Q?38BvnREk3SPMAZpwHRlhAumJX6VQSRtMeQ0ccc26Sr4Rii5y2Sq2H3Gt7Y8I?=
 =?us-ascii?Q?jYWOFOnkD8YnhJPi9V/fErol4VMegY2aOLjJ+6KrVgRCpFaiXWDNHU5y7OfY?=
 =?us-ascii?Q?mjoAMN6JcXElAlZM4FWZ6f06D92vgRG1+f8erZAl0eGiObxJ7p8B0rmn38Db?=
 =?us-ascii?Q?aA/niRc/EIeizHlSOE42a3eKNhUaRqI+u7K5M/WyWl4rN2QFRlLDAaGbFaGc?=
 =?us-ascii?Q?5EyluQqepB6A6v4jodl6aywW4QZNMGQuoFM5A5VJyqVy+AHeulU31YritmKS?=
 =?us-ascii?Q?1NdShegqFRx3Oh1X/EVR1IDi9Scl1FtPmtyZa3+bzLUd2VOLuneRz0rLeIGC?=
 =?us-ascii?Q?ndOkMlHzmgcdP9U29JjfFXvucxx+X3554I31g65UydV+jD2iyfat03pWsK15?=
 =?us-ascii?Q?fTY7i5q/Qny7WYYAVFvNK60wbm72FVTfSkrme04Mj6l9aUugf06vJwql7JhZ?=
 =?us-ascii?Q?zR2/p/SLN4CeIN+KoLuvvHWuNmXy8c7bfDJfdYA8PkFJoC7uHQsc7hyiFjhT?=
 =?us-ascii?Q?wLwrAcoee1pcHXyE=3D?=
X-Microsoft-Antispam-Message-Info: ZpGFlfDIrflpl4ZdByUT87xvc7NhLooZ3PcIIJQCA6rqmnoaijtTfalX0nheIFgNKKJoekXOmOA5YcKNsN2beRJe0EC64os0y7caV2LOrDt0rL8MuPFczys8SRvA7RP/DBxg2l9YMcZ75mg65TRE6pYOQPQJ4kjQDnTn3Vzn4NHIDpWXEDgGAi1C0rgYGg5nR7NG9vU0cGiIf8HezOwuMu0qJTXZYlG80Md5apIjd9W4M8AmKTPZTUX3WZEMPRXicNUIQDiQtUfv8GzGm0eSjo1gQNo6PN0tpJm23S0WXs79jMlzNzWJ/vEt8n2TRncKb6j/HPMpETrPHvVfPZhMsY4TAfcEsN0E7p4GLBYc+Dw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR1101MB1131;6:om8nZW/EE/9/N7WHn6Y2wG6nRNtWT4G9wb0qQE0/Icz3xvd+ztAARYzb6cPc8Ez+WCehBl9tcRqJtLIDdi0Hqk7L4uSnBRXOpR+InXASOqYd+dy9ifcXx5RILuzlIbMKbxWvwZoT3q8YkzLn4XuhYfjuo3I/ri6Kt9aHiNekK4A7wBx/3Mwo3stgUBz97rVOxFPLujSyZKOh540KX9Wez2tuFyG8VVXVy1P8BNhYXGmQYolozVpHAhTtIw8QhQEXcyDD/y0Vx1oA6402x0VESvD4bpao05dd6oVFQtwLZpbB1Isbe6d5YTPMue5wb8NapmnKwgWB2FIrjbcwFIgftjVCOzhoC/FGgVkjCW6PqN6gH9b9BWTfg+rJMK6mSNqqFhScH6rpUHatLgAbaoehRy77xVtJ59+wlUdRPdE/8/ivgZXLXtsc/MT3KVbAPDcd84VsnKhPbaP7i7YXnY+qhA==;5:Niw6vUi7M94UNhM1xVLX689i8nfS/zPdwSlO1Uqq2/zJJQsQ+kwvvzt7ws+OJzarHFLxdKfrAePbsij/03P6BDwJroX56TVdpkLLdKEv9WnPv+EwX5LJnDhTBsJzkDvgrdftKSmgz2/q6KkXG4MG0vl6Ix7EvyNjItbHGf/EV+k=;7:V95izgsu73T5I2a7h613pYdULOdwPWxAJrWyv5NtXeD+AarJxG8wr+ML7JHHKgchTg6Q1IW41O0+4/PN0CJOjhin1I0pjONo7Hjhp++Vo6gjlQ9qg+hXEe5Q0NIbp5QQDOOi+67WFP8JKUNuagOnt4/ZttBgjebCZMjuyvZOHWiXIzpfW70HjaYJbPsRVdrmMdTg8bJFSs+fM5AAmxyJ21LDCqKN/Tv9u3JhFV+b54dtUA0JXu5XAh9yeIFOLBD2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 01:40:02.2822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601423e4-f5da-4c9e-fb18-08d609628373
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR1101MB1131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes since v1 : Applied usleep_range intead of using mdelay

 Changes : Applied 10ms delay after amp software reset.
           10ms guard time is required for stability.

 sound/soc/codecs/max98373.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 2764fae..6aaff03 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -730,6 +730,7 @@ static int max98373_probe(struct snd_soc_component *component)
 	/* Software Reset */
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -818,6 +819,7 @@ static int max98373_resume(struct device *dev)
 
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
-- 
2.7.4

