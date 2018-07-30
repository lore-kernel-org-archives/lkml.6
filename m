Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB613F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC69920881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="NxsNGd3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC69920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeG3Pfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:35:55 -0400
Received: from mail-eopbgr690041.outbound.protection.outlook.com ([40.107.69.41]:13398
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbeG3Pfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1RTvGeNLJxB0etumBB0VRVqVsSZOb7Frb+blb9fDDw=;
 b=NxsNGd3PzbfRntscNBarkhE7d82ej5D3YEM5Dnmwt99GeaMz4343eM+TPl9/AfyuqkruVFccKyl/QPUV3t4gFN9Vg1MusxBee8RQZvyV9pUs5dfr3WzY016YC4gPrF4rGxKGDrsZ2MAyn1EHt6vdUqaaR3k4GMFg/yxHPlJwkwo=
Received: from BN3PR03CA0103.namprd03.prod.outlook.com (2603:10b6:400:4::21)
 by DM5PR03MB3131.namprd03.prod.outlook.com (2603:10b6:4:3c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Mon, 30 Jul
 2018 14:00:40 +0000
Received: from BL2FFO11FD012.protection.gbl (2a01:111:f400:7c09::138) by
 BN3PR03CA0103.outlook.office365.com (2603:10b6:400:4::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.995.16 via Frontend Transport; Mon, 30 Jul 2018 14:00:40 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD012.mail.protection.outlook.com (10.173.161.18) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.16
 via Frontend Transport; Mon, 30 Jul 2018 14:00:39 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6UE0cba014656
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 30 Jul 2018 07:00:38 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Mon, 30 Jul 2018
 10:00:38 -0400
Received: from mircea-Latitude-E6540.analog.com ([10.50.1.102]) by
 zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id w6UE0XIU013246;      Mon, 30 Jul
 2018 10:00:33 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
CC:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Rafael Aquini" <aquini@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Ludovic Desroches" <ludovic.desroches@o2linux.fr>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: dac: Add docs for AD5770R DAC
Date:   Mon, 30 Jul 2018 16:59:55 +0300
Message-ID: <20180730135956.4611-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(438002)(199004)(189003)(8676002)(72206003)(966005)(5660300001)(8936002)(7696005)(53416004)(1720100001)(51416003)(106466001)(36756003)(476003)(126002)(316002)(2616005)(16586007)(305945005)(336012)(6666003)(109986005)(50466002)(7636002)(356003)(48376002)(1671002)(106002)(54906003)(426003)(26005)(44832011)(50226002)(77096007)(486006)(7416002)(2906002)(478600001)(6306002)(246002)(186003)(86362001)(47776003)(1076002)(4326008)(39060400002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3131;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD012;1:W9i3dCnZZ4teN4JNuQ7h7Q0R8PJFmkGh8/KgtYJiC4RaaeddIe6jk9kEXQ7oACQgr+d/iP8NyubeMByCQTIfL4PkHntNjyJaSS0yxAb/z9uiDfcO+RqZdzwZ8Jy3Ze2k
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae92d669-e861-46cb-bd1b-08d5f624d4e4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR03MB3131;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3131;3:3P7/PTeHCK+Bol+8nwhEAI9HG6xN3XhlOatu6eURKrJgob2x+vqaiuxQX8xg7Uw2Lv5sL9xbLXpaAdqJh8r5Bv+FkrkhdqpiVln7wOwBOQCP2atIjNO1J91DvnnMVdHgpOpe1H8PigBfyAXiIkP3hjQXYE3g7v1mCxoTcqL1SM6D0E35B65afrUocSjvkNSfmqfoG71QV+6Kv7bxfTMldxvk0hpPVfUVEivUmQNN25ABmP9SuTVlPhGr199yEobsoV7mtW61W6ID/fYfdLuAOYLe8hGq87bkJueUG1dAZefNL7Aj+A7nCYvBtuZ6ABZHb7zLuOluxXbCsJhpS0iSJWjesU+Wbc6e/QWyIvNC65Q=;25:aPrvEt7hQ/0wm4zvFr4+P/HtOATernb7pNFmfEv4E/2/x2lLDcjMB+E8g5GW6FMVcqx7m4qgdpEz31AUDxVse9gLw/Ox71whm1QFOMn0Las6GNBIfBg5XYUm8wuwQCwv1folLAtzBUfQ+BCR71I+OtTOX7MxSAmMeKOGIYfJBdJgnfuXMB9e+XNtRYZXPrdkIrUNCphtKDsiNkOW6Dtwgmh1gmMsg9tT18cQA6moqaQ0LCHMbxVDf26YQHT5MVh7LO0lxK0flaQWSY4wyQsC7gTPm/dtEPePc9uB2N1J1sd1AOFFxENZ7fv+u4Vau2KceUiYBBmnsEz4FucULHEnVg==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3131:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3131;31:DnV5JRNwKO2w2sgpn1sOlFP4jte63VtrIK1gO8k/VEokk2dSLMu7WWv4pQxs0orxL1j6KpAbGVOisND2XQ4p2DuHgiHhN9VdW1xvdnQ8mgaSXuo3fqwlxTjLbSR9wCkkpsd809cZ/Yr9WgxHUskGTaRUYyR9WUwFxlbl8HVk0YPtFSPyzlyBDXX5f8OA/SowU2tiFAZ/f2/0sozxcYNq8O9cSVfxACQkR4UVdxZiS7M=;20:dOZqlblza2u1Cbs89/cLUXOKu2e5lDXJDZaD1YVzh/MH97a8Svz6N6iCrv3KnskXsA+R6RtTdTfc4XU2KfXhafzj4CSXwYxL3e8B/wh8QVyxPOXvmmNs80qFQ7S0lO96zLR1L/KWswZ7RY6qrZkw2ajwN9DO6SuPksvBvzy72V+b7yhu9HUKQbEVO6trjbSnEjxTSnTkJO82Mt+26Qtndw3BaKGbC5go/IOD3LpdVz2lMYMEY1joSpZzZXmRl3399qoODZBGRVvF9dbBxmeJ2dYCrYaZ8tnH9pnxOMdimFHGzAweGhIq2+RAWbgA9lz0TLo8tqNWR136YlCQ0VfMa0gT39WaHCl7FLZSgeeGwuuucFFMdt1JH/DHun0o7qr+9yQQeoU+SZJGGnIqSU2mvkWAdz6tWE0TA2lEpQm9S8cfeSw9/XfqNLI7haRaVvhlJVKXEeIGsanAToy1WMQ7u2YQ3z+WPWhi4LqUcuZgrgRj6HT67rX71roVaCxxpJFi
X-Microsoft-Antispam-PRVS: <DM5PR03MB31311C659AA83541EAFFCD3C812F0@DM5PR03MB3131.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB3131;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3131;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3131;4:X4quvpt8qD1NLoSdfByh97Tf6spmTesdx4gortE2MtCyGXp0DjviLpB+v3E60j/lOxkIXW6ryng1SPr/Ase7dATI4J73K9VnRZArTdB/Vse2wE+u9uAMv4hVVXMVLkE5nVBtBzLfzkpLyEo3E2gWHpQy3QR8N7MDWDo+14uTic7VDZeq0/vgPhXUr1ypZq44BtClNXe0bDdydYh3EE7cQ2wRhuWm221FQfbeyD29tIvtKuz8KQPeNKS7ixOYHxhF7xuUqPlYRsDJDBqM/Y0ZZ8Koj4a+tb1h7pvSQKhrfVop/h6DbhR87jnnKP5NtxoFxTx8UW8H65AxLrsNAkivUZiIxK4ty4sYjqZ6ztUC5xjZQkeeJQwS4G04x7LBKI0QQaANZ81UWPP8kjap0YyqT091wa/ZN51EU1rfZ3+BDXs=
X-Forefront-PRVS: 0749DC2CE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3131;23:2A/wSr8qjrLbpY23L8i6JYaTDPOiw3a02KBm4uHf0?=
 =?us-ascii?Q?ZEzHQuF8ZmtbiceiyaipHWGyQqY4rX402N2WUlQ+jsTVy98WznRHxxMxNU0D?=
 =?us-ascii?Q?r+1x/cqN2ZReS/4cTHR9uBGnFZqVICxE5SR3xxiNEWoVXjHDL0c0wXKMh5O4?=
 =?us-ascii?Q?CAr5vyXQS78kxZKGVikRwFlKDfZEuKYShfJVl+uPeBcO/UYmWKnMQfVGFLh+?=
 =?us-ascii?Q?2o6q/cKiCU0eFxdSqypzijxEELFQt6kD3mZN7m6TDBL/DK+4IBvVNwv5blfe?=
 =?us-ascii?Q?IpbiTUX9Ctczj0UAHsJjuerLSAHgBkevHibf0BJwQpJE5/zJmEvOnccSN+ee?=
 =?us-ascii?Q?zUYxdp3rnOs9UtOqAkf5ZJCEqmcy8BLnFpMq+fBZ4S2fNoy2mc5uXXIMQM+A?=
 =?us-ascii?Q?ao0LWXBcSy38lVnYBAunX71ZnIJkP0tPETUu0QDwH6ct9vOv6myP3wUzui/i?=
 =?us-ascii?Q?7Ymn2oUymrp9RMUGN/tpOTkT2Ih2GJ84kgXuHKqVpPI1kvFKleO7NScgKMGW?=
 =?us-ascii?Q?5YqC0wUrUcvRdTAOFLXN4AQJvvwIOtCQxlDaiH8lwFPEJTVV7UXbhmfdx8z/?=
 =?us-ascii?Q?wsK8H9ZyCw2XRejTrUtrdzL2jigZWO+bPrYNMgPlqaurieujtwuNIoSFMe1X?=
 =?us-ascii?Q?Q73YLTuZP/cPkBPXmBpqao0Oie7tcgTvXeZ7H6fvsW8MtA/0X0wnLB0z1DJ9?=
 =?us-ascii?Q?Y2MGwUv190W5qN9Rh9T2myjr2DztbqXUnDZudromodPF6ImOTQqyycoMhptf?=
 =?us-ascii?Q?8okJ76BqaUlmAJVsoag68vOpx2zdTfwB+08E8bAn71RpHk1wYiBHWyAqIZIn?=
 =?us-ascii?Q?+QBBUsUSpPRt69GFTUuWMoHrE81+L1897oX2zpsX0TCDNWU0N1JWAkoWk7Ss?=
 =?us-ascii?Q?xzUnPAWWpMITkk9IQVvw18bK1xUPKhW7mWalS2ts7GaDd+6gbqjmJByTD/5L?=
 =?us-ascii?Q?nJurDnJTFwbYrfrU+Mv8D71V3W6j4OjQEx9odHzDokauEa89/E3/oIvrmpVc?=
 =?us-ascii?Q?KiAiLCp1ZyNnyR4dYq9pjqRe2YAxRqfI89ox9gJOBvB1LDS6/ivNp8bvhJqZ?=
 =?us-ascii?Q?xTvFwlBtSyzX75IyL+K1TgqdCNByB+l8ISHKUnPzFERAT8ck5OcbS1MDHvGP?=
 =?us-ascii?Q?piBgcoKxE8awRtJfFfMMuXKhtB6+rL7Gb7AHeTvGZpZvwNSOx/2Eaa5jEwsZ?=
 =?us-ascii?Q?mjIlgjvQWXIF8E=3D?=
X-Microsoft-Antispam-Message-Info: dUFvISWMY3gSisyS3xkLyP95qJu0DdArd0bkAXcMmzjsOiy8v6aaEqFDtbuBKFz/N+L1kdRj9P3vlEW/jgMu3nbmlQdawZE7RbHSTDhca4olqDvPHBkGvjxAjEt0zKKtiyYYs1F6/4/DcRlD/y/39q3CeLcigYt+t89jKhcFSbD9zWMPTLZskZcu65cY2Kn0eGFl4A/2qH/Fh4uK7DuCWRs1tj4ufuWVViiqA5tSShkD9Md3jQ8gWrsTLZytWTH5vdSWCu1p2YTya4s9gfP0h+vypvmwhvxiQN6bLunBeIMgzAeIo9TMaNP+zc+DsMkic6Ow7LowdmISuK6vQPVDLCFgU7s5zQWD5e+fpBUcrTA=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3131;6:+AvF8MqkLF4HuDqbCb+wkrhzXxYZrFRHI6cykfMo5sURfqf7EnBEVVyiPQUYZoLH2IKzdSdCYLtBSf4klnrLHyk9p07Iji5SfDyfn/jec6TrGVoWrc3WpLdtZoOseRuto1E8hv63RcwBKus7a1oJNSn+39xjy5IRRHw45h/mhmfPmCIgv7b3qhAKia2JScDHjMhnAmpq/sNXCdD4+SiTNUM0BEggUFKnoEBO5OEJb9X8ilSja+K41GY4hSWvdteHHnc0tfHmPy7H6RN7titPDf4HEuNN42/wSdTEfrggOc6L18BprB6lGKMgvbGmr4T2JvZSrPkuwIFkByEF30/6bGapyvlki4iMG4unKpCjryfTpUccAvJXOw7ZMosHFxJNFqXp3FpfVJERpImkNMMCVCAUoXlRhlunbQH5nEGRasHQHuHrakr+rI+PyuE3Nab00Ywqr1r262dKUtUE2OxjXw==;5:88aOCvbTAAfjbXGzXZvgMyWbMcvZRQ4fhADkgqIge2kYSTGJkvT6DCwipNvX57uF1MSR8c8MDPxdydC4d3S2vEZZTaeO3aVSfjfHYXm49PQuy8zQ0wUxJQxZMl0ckgI19neG0B9Y2Sx3te8yWreS4ix+y3yZGSwG/8wjWpLxTQ8=;7:Ywb24WEdPdfo4NcDmKEvYb6rgetZ19eZ+ZOARtXx3TpCF+t2c8UKBf0t//YUSF/VMb+LRzmtwPXgVTSPYinqj2y9hsKdrbtRF6zm78GptkE8Ssx6as5FAxFX4Yuce8TJBt2sK/gpqB3E5fvV2NxPxDAePjwNHGtItIcCKL5RpTEQonpIphSQoCcqn8rX8evT2bRotVBeIE94dwAuqAGVb14EvizWIJhEbOEP4J53LPDVo/Wytl9lrdL1wupgMCcM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 14:00:39.2715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae92d669-e861-46cb-bd1b-08d5f624d4e4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3131
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding dt-bindings documentation for AD5770R DAC. The bindings follow the
standard SPI and fixed regulator bindings.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5770r.txt   | 86 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5770r.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5770r.txt b/Documentation/devicetree/bindings/iio/dac/ad5770r.txt
new file mode 100644
index 000000000000..bdd6ee4d5f2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ad5770r.txt
@@ -0,0 +1,86 @@
+Analog Devices AD5770R DAC device driver
+
+Required properties for the AD5770R:
+	- compatible: Must be "adi,ad5770r"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use (< 10000000, as per
+			Documentation/devicetree/bindings/spi/spi-bus.txt)
+	- child nodes: Each child node represents one channel and has
+		the following required properties:
+		* num: This represents the channel num
+		* adi,range-microamp: Output range of the channel
+		The following ranges are supported:
+		* Channel 0:
+			* <0 300000> 0 mA to 300 mA
+			* <(-60000) 0> -60 to 0 mA
+			* <(-60000) 300000> -60 to 300 mA
+		* Channel 1:
+			* <0 140000> 0 to 140 mA
+			* <0 250000> 0 to 250 mA
+		* Channel 2:
+			* <0 55000> 0 to 55 mA
+			* <0 150000> 0 to 150 mA
+		* Channel 3 to Channel 5:
+			* <0 45000> 0 to 45 mA
+			* <0 100000> 0 to 100 mA
+
+Optional properties:
+
+- vref: Specify the voltage of the external reference used.
+		Available reference options are: 1.25 V or 2.5 V. If no
+		external reference declared then the device will use the
+		internal reference of 1.25 V.
+
+- reset-gpios: GPIO spec for the RESET pin. If specified, it will be
+		asserted during driver probe.
+
+AD5770R Example:
+
+	ad5770r@0 {
+		compatible = "ad5770r";
+		reg = <0>;
+                spi-max-frequency = <1000000>;
+		vref-supply = <&vref>;
+
+		reset-gpios = <&gpio 22 0>;
+
+		channel@0 {
+			num = <0>;
+			adi,range-microamp = <0 300000>;
+		};
+
+		channel@1 {
+			num = <1>;
+			adi,range-microamp = <0 140000>;
+		};
+
+		channel@2 {
+			num = <2>;
+			adi,range-microamp = <0 55000>;
+		};
+
+		channel@3 {
+			num = <3>;
+			adi,range-microamp = <0 45000>;
+		};
+
+		channel@4 {
+			num = <4>;
+			adi,range-microamp = <0 45000>;
+		};
+
+		channel@5 {
+			num = <5>;
+			adi,range-microamp = <0 45000>;
+		};
+       };
+
+External reference example:
+
+	vref: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-supply";
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1250000>;
+	};
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 6f7721d1634c..9c2626079592 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -756,6 +756,13 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
 S:	Supported
 F:	drivers/macintosh/ams/
 
+ANALOG DEVICES INC AD5770R DRIVER
+M:	Mircea Caprioru <mircea.caprioru@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/dac/ad5770r.txt
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

