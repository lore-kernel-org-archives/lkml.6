Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BBAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBC620883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="mcXIwF2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBC620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeFUGe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:34:29 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:43072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeFUGe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gYqheOdxyjNJQJ8jKJt6VU6YZhv0VGw5nl+lEZE+RY=;
 b=mcXIwF2jb3+gp1Pl1s7MKAVOfb5uH3X0LlQJYgWwhnl6tJNAsiyx+FTBmlbRDZ1t9Rb7bTinSM29bl001BbTQCiLMad3CaB39GrkJnGKF5DWmJcT4wvxN/X8ojCngmP3ku053wGXU6mSlVMtNyEBVg4MQcFR/fNDXLU1k++Mx6A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
Received: from mypc.cavium.com.com (111.93.218.67) by
 CO2PR0701MB741.namprd07.prod.outlook.com (2a01:111:e400:1430::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 21 Jun
 2018 06:34:15 +0000
From:   Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will.Deacon@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, Robert.Richter@cavium.com,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com,
        gklkml16@gmail.com
Subject: [PATCH v6 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Date:   Thu, 21 Jun 2018 12:03:36 +0530
Message-Id: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To CO2PR0701MB741.namprd07.prod.outlook.com
 (2a01:111:e400:1430::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc949a38-a099-4636-12ff-08d5d7410441
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB741;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB741;3:zHI1OSQB+Hyg66Gp2Muqax7YRR15dlIRM/8QVWhoRWv9C3Bf603k/OxudqDN/IbR05LlBgwseFDPnzY/ggqOTpLbmOPQjTGSHES8/GNWpYwqvs6UX6MYwZ3rDXlYudZykMxjMwFCsIOd4g90NgJxE1jXtcQJ+wdeOZHh68BUUL5lUOF/n/VkaKDM0bagiIvCzsA8nXgdijGc+ubzn/2rrjvAmynGy+oA+BbKPCxkZ1eXPwvoI0NPtYng54D4r1SK;25:7C5M0isPOenmZYkJVl+1CsMy+jwU+Uqm7g0PPHvZr7Y1Oi4pdt+AmLF2VCdhCGDbbSmXmcS/lwewglDln6bg0D2TrYAnqX/dRDzYk6gyYFDmQPOuH6M34ZZ9CXHacZrES/ooFixEHPohdw9NewCtqZwVLBQ+IySh/fcN5xAAip79oaiN0s7dJeL++KDcFX+t7VeaG8sw50vLcj/X6XG9P+61SboWK/46yg/4fFKIWJFMwKWkRSh1OwRJp9Agu1U8Y/hJYgxkdF9bPDJJnvvDNszApVi3XDrYncqzFp1GiYbCWsgfDGLz+mXC2Zo0Md7sm9uW9y147uTdKGMAfIge6Q==;31:NBpAB6RKw+nB3u/6QEfC9SfMfouUiX3ojExnp4LV87BbgfQGk1X0o3jGK1Zt3KCGjf9knXWVsIfCtmKiolZWLFvT2eu6InGeoiiqZlyTSqEtr04ndg2WjrUTxSKoirkkIfP4tMCMcrh5fj0GX0ITp1sLdh/L2NPZpGXiEV5ij3UJxT5Vr5arYT9lGS22+R3kgzAovP1AN9+FNUaM5WefIkJzdhJlRJOkWqeNOCQTpgY=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB741:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB741;20:Z2PzyoGOO1OLqNwK66EuI9tPh7xoHGxBVu3b+qor/3FJSMfEoZRP3vzdLBuK3RqJ62a6zC4NLszwUh3ZW0bjN1HmNcVcd+bngoWX5GR9N5St3r2K3/KMzzJ1VV17HKODLgZBfET7rsk8TQnrB6uwH7hR+6hLP+/mitF8fFcKc51cfL95xIg1BHKIFuUdxQaOX6dnlAD5moPCSdHi7X7LlryUbdTiFlLdGYhkKzI7mYu1l+m3Gei+PJjpCMgx4stHjnborxwj4P07IdAzHGGf0Rg7YylOs6esvgy/VZgzf3UxRTh5jfi7ol1U6mMRKoFAk7khtjscaNkljfZ1o/TsvmN8QXbJG4HKl+hdL8rhruWLJM092E2SLiV1KZMRagyEtlcIVC1wFeJ1DOR9BJyPluqjOfvyn+kGLhZxJgYT/MYuxVmJknCm16C033xFeIkIiW4usscKrNxcr0wxFPmiVYfok0rbGmEJaEoH72fJcwkMKRdkaA4130a2N81d30YC;4:1qnyIm5BsNJbrNA7p/RnvVg7vwHR1vN9AdgnAJx4NfZZL6uzengy6FZATNDFvZzK6PquFW31qGsRw3JpzlzC+4/5BVS2y85sh/EK/uAKruT7nvOs2bBC36Dd9nYnO+1TVPKTLlUPbbzBqhLZSGG5WR+7vDatbjFcJ5ovsnl+uygT5QkeRvlcf22JwCGARjSC2AF1QecL4s7VWBJ7zm8JpI+6gLx55TEsm2MPy1LgW8BHztw9rPZ4SKblAtbUwPsbF74SDW/bfi+f51FyV3O9EfFn0bpJU3R8zGaDSBu8Tj1wi6jRec4ptuledAop7IvS
X-Microsoft-Antispam-PRVS: <CO2PR0701MB741FE4A8AE74E80B0EF441083760@CO2PR0701MB741.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CO2PR0701MB741;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB741;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(39380400002)(366004)(346002)(199004)(189003)(7736002)(3846002)(6116002)(66066001)(50226002)(478600001)(39060400002)(106356001)(6512007)(956004)(44832011)(47776003)(476003)(36756003)(6666003)(2616005)(72206003)(5660300001)(486006)(966005)(25786009)(6486002)(48376002)(1076002)(68736007)(86362001)(50466002)(8936002)(4326008)(97736004)(5009440100003)(186003)(16526019)(52116002)(7696005)(51416003)(316002)(105586002)(16586007)(6506007)(53936002)(26005)(81156014)(59450400001)(305945005)(81166006)(8676002)(386003)(6306002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB741;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB741;23:TSeNeb+aEIECola0eNAYhqgJGh0woEh3xC+v8yqY?=
 =?us-ascii?Q?AplTCGj7wMgsKP5rdBhR2BwpTbUewV4v+LpkWIGtywOdVo6lloYybARYN3Rv?=
 =?us-ascii?Q?+CjLAKgz8pP0smRFtoiXCaKrIPtJ0dcckfZ59+b5JP4Fbm5+V5+P5wWby5Bo?=
 =?us-ascii?Q?ojR+FnzFbL1pWPHqLhIPJqTftKnb49liB6RRL6Pb3PjBCMx2c/QOb8TcubIX?=
 =?us-ascii?Q?XxvLrMjMSBjTb+ChEcyq4EYkfGb8HfkFqhus76Q9Svx+2ugNrfPOJySNVDpW?=
 =?us-ascii?Q?//eVwiDR3kRzu38XzjWXXQbBsPRAM9lm4hIbl8H0No8pq5WuYZC5hJqt/syS?=
 =?us-ascii?Q?jSgUqVAHoR89nFMvl4/vfeMABTbOPBs3N1wpc+ZaC5nSaT/T2l0NJeeKqy8S?=
 =?us-ascii?Q?ZF5LEhoPPMhh2g12/nr6iyMXedsluPiELxlnLX+TRCQ+09R5G8ZJi6WvdIwO?=
 =?us-ascii?Q?XzKseU6g+esfsPThkpiLS39ahzO3/b6voDYDMTNr7fWRhjUTGQaEIGQQTUMz?=
 =?us-ascii?Q?UYPTKTqiwsyt2PsRtNzRY9/S4V3aslYijBsm96G3A3dbLEndXHDt8jwLskuN?=
 =?us-ascii?Q?vTJD9EmqUg85uf/dmlh5pneRvIFTGyudK9XbIq122PkHkoM3fAVcqUXmlKTj?=
 =?us-ascii?Q?kuC24vPLCiZnng1e0UBfSH84ekrxVI9Ow4z48O00cweIYtPuCwzdTR2eWKB6?=
 =?us-ascii?Q?iklVg1CmFZlRp/htgAA0uwzAafcolk7icXvkFxmtmrvqm4IRkQZmr7vBeLDj?=
 =?us-ascii?Q?iQV5B+lyrZM6FDvyjC7GFtFQdqr7eZliEw6u6olqbpt0xhIwVK9pj2UWZ3hm?=
 =?us-ascii?Q?AyPJn4gXPZS26BE3wDbIaGO/vcK2SnIOTH8PzemMh9xoLSw6xnC6OXugUS0F?=
 =?us-ascii?Q?ifizkeIVURMN5JHbcPvIoasTkQAvnXNi4N+u6j4WiHs+xOhHv827cM8E2X/J?=
 =?us-ascii?Q?k5zzLBfnBv0UDjGmJ7fd0/808AL2m4U6vHuEiwxPfVZezkfNSUtaIIVQZ3Tb?=
 =?us-ascii?Q?sQcDra7UWv3Q48YeRPwjDh3THQtQn7cARrvfRS0+pQkA+77fDjmvdLFbdzYH?=
 =?us-ascii?Q?gCuASyZINppRZZ9Y1lPQBceuRdXKrM2qOp3ZA8Ar4ezC3EoAfhQ+imwaPW87?=
 =?us-ascii?Q?4LGLPShuEk0PI+VbdgjP8H3Jt4GQjH92mb/ht2Zc1xIDkWgJ3f4sRgeYelcD?=
 =?us-ascii?Q?bK3sHXJmQ8z/XY1vc+o0/nntBnTjRUix0GXZX7XAZf4hunF/CLb3J1qMT99q?=
 =?us-ascii?Q?PGlBDALSoo2NETgRcgoWZld8FJ5/JqE7gD4atoTUkDbV52QuLiOiXDALYXil?=
 =?us-ascii?Q?SI7WbNYKWmb0QV45MZV6MwI=3D?=
X-Microsoft-Antispam-Message-Info: 4DwF3cOY5HBF0URFI0xuWRng02CFWa0nJ02+VKvmwm1Hx92GC6IgGD8YEPNydotFdwggZ7WbqigrsXKWsa7G77vLJB/kOTgbvEZO4G+AhRnQ/1ZP3/TFpj0IO1CDOGheIm3BHcKdVjh9ICBQLP+BKUD+rB5gd9HDNIsl4HK27UAkuVCKxHO4Cjt5GVMGfFzoPNhcb1Lj/L0g2AnfttwW6wqa2cY9BWFd/ZLXVWnWzDzhAOp7hP9/0oSaYN7PoxqC+wlyL9RZO6s9903wW7gsSwt7anwIgXCkMm4j9a9/3CaArzmjvskMfejzDze0x+hzfiKHuM7XF+AfIwnXF4gYRw==
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB741;6:dsNBpMN1ObPe1i3SbKj4Qf/Dsn/Mduk8N2InlssT1pOPMe+AGkOzwAneTrSEAozIAobjYot+ZN17DnRwmw02YcpNtsJkk4APhJooqrdTiyuiKj/s1djINBX0OqrXtAamlmYW1IWqUxNZG2ABVQh85UAFyNN9y2oTnhv11zAckJ5qZkAkq0WClSCYFDgS4auKyA2oqJ37ZDo73e0VEOoN/L7/2kuL1lhlzb4DnbxdrqHNDyhIpd98YW1kOBVQkbnEMJj36fAzpay5deAivtqsUhHl4r01+sRcdg+5ezFSMMh3SYpFF3VLwfOerNaVdsA91vsPE6cyqiBY0EsaO+Vxib/i8q6z9faKYSaL9FpoGWJMBlba23IIcE1/LkFREpOedeW8XGEXsZX8cD3oPs11bXxWNOyLY2k+Gb71VH6tWWD5l+XWgv93KH3gDsiUURNxa9ou8YpAvGyD8MtNyy8dKQ==;5:qfLmmnoC/jm0+jJB0l4Fnvr3nGj/Kl+7LSgWOtd6MxTtFT32BfoN92twrcJcgn507o5v6ZWY5uWQbMUsdxASG5KaIxXabczRPonVwFAb02WCQnV+AALrgVEh1L7SNEmV6AQmR++UvFmH/aOQYV3Un2HC4FkYbNBosa/1wWq4X+c=;24:4u3qVd9g8siUVBQAW2rEexWdCtNfomySGfpWUIchUrLDzI0Chm0Up29C9wo6L4LCnXzg3huqDFA35SLIzOdJ2VQclWV8wfX3z1oCylzinmA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB741;7:nIJs9LU9E0yrz6HBJYlcXTpAythKk+eb76uu4npj+Vl0sLhAqQilq0nvqOfv/BjUtTK6yUwuXsaolvX76kChc2E8SIzL4uQyEnY1Gzs5hzrFwJNX0sdZRvs2ElzbvwSyqCXd8bPPLk7tKsS6MaZJZ/I0QY7+TWJJdMaCTCFlyD1gGzjuf36cYxrDIkIRHHWycDuKCDoBtUvq6v3GPcMTOihtta2meJ7uOCtGtwp8Tw23KdFpJlVkdUm8VSh4AMJd
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 06:34:15.3106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc949a38-a099-4636-12ff-08d5d7410441
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

v6:
	Rebased to 4.18-rc1
	Updated with comments from John Garry[3]

[3] https://lkml.org/lkml/2018/5/17/408

v5:
     -Incroporated review comments from Mark Rutland[2]
v4:
     -Incroporated review comments from Mark Rutland[1]

[1] https://www.spinics.net/lists/arm-kernel/msg588563.html
[2] https://lkml.org/lkml/2018/4/26/376

v3:
     - fixed warning reported by kbuild robot

v2:
     - rebased to 4.12-rc1
     - Removed Arch VULCAN dependency.
     - update SMC call parameters as per latest firmware.

v1:
     -Initial patch

Ganapatrao Kulkarni (2):
  perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
  ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt |  66 +++
 drivers/perf/Kconfig                 |   8 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 949 +++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 5 files changed, 1025 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

-- 
2.9.4

