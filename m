Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA06ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C65120880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qAZXcUOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C65120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbeGXP2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:28:43 -0400
Received: from mail-he1eur01on0046.outbound.protection.outlook.com ([104.47.0.46]:13408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388430AbeGXP2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSdnBqMSt1Z0s7KhfftOqm9EjShPrCckuDYwP2zurJk=;
 b=qAZXcUOGjFBDHDNN0u33VDgv0UdKleyEBdVHIhG3fiJDeWTr7h+hpUcOEMQTTxk4lExl8yNyb+GLKnEY8fhLthEeQ2urj2e2PATcuCx1ZonTe8y9RxPj5/B1X6qHD+0Seg73LMyIhr5N5bmN+kEGkjFYUtPfO3gua2PnDjxmMPY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 14:21:50 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to drivers/soc/fsl
Date:   Tue, 24 Jul 2018 09:21:27 -0500
Message-Id: <20180724142131.28970-1-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-to: roy.pledge@nxp.com
Content-Transfer-Encoding: 8bit
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR0102CA0006.prod.exchangelabs.com (2603:10b6:805:1::19)
 To DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e4f202b-8162-4d4e-4e76-08d5f170cd26
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4490;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;3:2fr+M69rYVkzNjFe9A/YiR9YuxzovqqgTCAdE8Vt3cg3wiGokVRP4s8DzesEGA1rlOqniADEoLfa3VU3tSRG1ya44Lyro/UNXgxf1TsWdclrteFxmIxkL34GNSBXdxR/eh1udRfor8A0jWcJe68qCKauUjbjZpcy68Kndb4SJZDlG8M04zR1R3FFOVMsmDmd0PkevroL+IXOaGV7iNDK41M4l5nUJNy7MbQtxKH6Dm9eLZGmze7sskiQ4uiHC2St;25:Wc2O/W1XybuzNhcVn51K/kJwomM6s8VBQS0/d8JHBuWHnxXof9kXnWsoNaqvtm7NhXy1XWmFl0cV3AKLIRtwJvSZoS9o5ryKgrAL+8hroRc9qAb+8nh2p7NwJUQZPvFwSrHFGecMyPi7sNrG/QoQW1jInv3qs683Tum/dVkxuaSAUMexbLqv9f046NkAn1zFwAV0yVjkPnvBY5pDH5cmN2mEa+p+GaK2vXh5iV/l+5sWey9ox/nUUPfg/DujKnJUMlPrcPuJ7DpdLPyuOQlhB30BFYFdS3Vc0AreOJ6/njKZRUtvTr+eBB8dthed3+RN4Iao601ccX6U/hWPF0kVXA==;31:MJF9F+goM6mkV4NPDd2c8Gq0jKK02TsbJjfLoe1HTplApYt/JrtpTQwoCESVQz53M/0FM46O9XQbI4NuEioPShoatDx0WNSTUQ27jASZv48/BmwVSMBZxuCiVwaIMfnZYGjUJqY591PBvAUHJNcNQEr5CVY2Rq+q5NMkIKNv9SGkkaYkPIj4u4MUmjgi4+HZbp8T7g+5pOnyq+POmBMBIlaUIVxbC095U0zXdBQc6Bo=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4490:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;20:O60YmE9OEuHJ96KJksanisL7bxFJpNWrVyNFJxV2C2tFqyROtOiYJttJSrQbi93zjAIAueg+W5Ewbt9U1CkjMZs5a2yT5cQwbfqo22Fc6u0Irvz3wU60TdmP3Qdp8kS62f7U6wrsD5J2OXZ3pVwSIzxtsxmgEnRFTIDdAuA4RPVXP1LPjFv/yPxGA2RS19JvzwJYuCjssNHANswb0EWoaXCqhVwVEzTjcGUijwUkdHIyQlSFYybg1b0MoOZVwJFvn3ASbc69YJ817AUyj5F6ILmzz0ecQTMkCpRTPxoq77b0MaUypPi2wXFMUYvHTY1t7x41mzFzYUkIjGa49V4sEj4LYKrFt+j8Ggg7kmBuUo0y7qoHRRTTOwQlifa8oA5M012pIGCIdgEOpiDTI12GgeO/H2CJQw/iLN+yt5wVkbwX1WEOO+fWmk4BPNOcanRZx+hb62XslkSjmmIQ43+aMQ183YomejLdWRXwmFD3Kk5UZX4gVHOGfn8BW5kTAHU8;4:XAotS8RoTHd5GczpgYZ1OLUpKytLbtBOtvb2ygD+yH8fcXkueXiyVbyBJHf1zHovGahK21/kifAEG3q4U9o8IVJ13gNFEcvQJD+XuSwtO9rBHm6KJVIzi3mbW9QmwbR7f+H6mPFZm5duxgqtV7tgT7fm9awiIOvWnD/YUEqwO+1rY8rbANENhtZ8yS5kbUUFq2PsfPpMCZDLN+PIjw5j3AdcARL+sB87/RYUVC0sWUkwkbLF1IUJGmfkwc5PNLSinMMfllFYoh6PvZZ8PHsFjA==
X-Microsoft-Antispam-PRVS: <DB7PR04MB449028887C2B4DF159E8ADE386550@DB7PR04MB4490.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4490;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4490;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(1076002)(2616005)(105586002)(44832011)(66066001)(486006)(2906002)(3450700001)(47776003)(2870700001)(478600001)(6486002)(36756003)(53936002)(106356001)(956004)(86362001)(6512007)(476003)(386003)(81156014)(5660300001)(6506007)(16526019)(68736007)(6636002)(97736004)(8936002)(6666003)(305945005)(23676004)(52116002)(186003)(50226002)(26005)(81166006)(7736002)(316002)(14444005)(3846002)(6116002)(25786009)(4326008)(43066004)(8676002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4490;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NDkwOzIzOjRRSmxlb0RMVFF1YlFGZWdUNGVzekJhdWpP?=
 =?utf-8?B?eXJGVWFWMWozSWZMOEt1L0UybDFRTUhkMXpRSkNJNjBPdUNZOTFFcytQNzZJ?=
 =?utf-8?B?M21qMkdGK2IxYk9nRWNRb2hDMkFpMVNFUmcraHhOWDFWa3JPZkJFdUlMTmtR?=
 =?utf-8?B?bUZKYnJ4WjJNanZxOHpid1NUZ0w4ODNCN0VkK0tZa2p2N3VDaDZNckJjY0Zn?=
 =?utf-8?B?dFhPK1dPYzZaWHl3bThaV3lqZnJmUnhZelhtUkRIUEJodUp1SEZVdHNUc0Zn?=
 =?utf-8?B?MXlTOEFFK3pYR2VhVHc0QjRGeDh1WGMxK215VSsxYk0weER2Y1o5WlpUV1Z3?=
 =?utf-8?B?eHlKOU9nUm9pdnpuSG9FOFNsUGgyMVBQbFJBRHE2M0VkOWFsVlp3akQ0UXZy?=
 =?utf-8?B?WVFCMzJ0NEFneGcrTXV0c2NsZ0xBZnZTWW9SMytDTzVUSzBxZ0t1aWhDOEFw?=
 =?utf-8?B?LzNNdFI5N1BmdUlVS1NzbjVRaHpKWGFUaEI4VHlxQ2hDeDZxY3FDeVNkU3BE?=
 =?utf-8?B?VDliRUpJMXlyVzBqM3lyVDlBWWNNYUFQd25DR2RtdXdnZ1Z4TlpDWDNoQXpa?=
 =?utf-8?B?dWo0bDBqNFd1eXh2VnpuOWdvRFE5NDQybTRDTndHcGNFYUY0cG40TGlCUDBo?=
 =?utf-8?B?eTlJNkR4ek5yU3c5RU1COXdUY0h5UzZXMjcyV28zRmUrNW81L1JUV3ZOem4v?=
 =?utf-8?B?U3ZDM0pTekdrb0N5Q2kvc0o0TjRKb2tPbGNITTQxQmptdHcxYk96THRrRHdF?=
 =?utf-8?B?V0RUeTJwTENaWFFOdkFiU0RZcEduU1VNaUl0dDRIYUt3Q0l2Y1FNUlRLUmUr?=
 =?utf-8?B?TEhWL05YbjB1OW5SWW5Kd0h4aEpJRVRKd1JOaVlLOTgrZDh4RkZSbjdJK3Y2?=
 =?utf-8?B?WGZuNWJ4VFNySlNyWktqRk1GSXgxa3BkWTRrbUJYc0RwdXBKdWtweHNoSnhY?=
 =?utf-8?B?OEoxTXF6K1JYdmNTaW1WL3cxaGIxL1ZSMGxuM1RLUUgyb3o3M3dQb0xhWlZa?=
 =?utf-8?B?czNIUDYzUmdZQTV6OEdZTTVlVVJLZWJhZlhKZzhYaGRwT1ZsVTV6SU5WQjFq?=
 =?utf-8?B?d3JuYkZKN1ptQUt2TmF4c09VRVd0WjN2UG1ESHlWajBBU2t2RFhtSEhodWNl?=
 =?utf-8?B?R29IWlZ4aG1sK0kzbFRJTkRjdlFESGJKc1BjWXZzTGowU2dZZ1ZtQnJBM091?=
 =?utf-8?B?ckJiT1lQeVI1QythRzJkU3JpeklxK3dTNDJlQVpROWxpMWd5SnpaSXpCcW9Q?=
 =?utf-8?B?Z1lZa1I4eEtLRG1mNFo3dWxsUkluMURVRVFGVGhOOUwycm5hSy83RWdBd254?=
 =?utf-8?B?QmJhcmtKVWpVNlZLRjFtVFVvNXRtdncva09Mc2FQV1EvMkhtZWcvTE11dDA5?=
 =?utf-8?B?TGNoQnJ0U2JIVlluSjhwcFNocFp0YkdUQVhweFM3aXpqenFacUhrUlU0VTl1?=
 =?utf-8?B?bGRycW5UV0Z3VVNLSUcyNmVRS3pIOHRMT3dNOHVvdUpRNithUmo0b25KVzJC?=
 =?utf-8?B?L2pHV1NDTUNmNDJtQVpORTd3WkZNdUJqRG90anJ1K25IcDdTc1dZckFLUDd4?=
 =?utf-8?B?dlZsZWpKRzl5VjJHeGJ3S1MweUdiK2RWSTVhWDRoVUFxYTRnb082VWI3VUpo?=
 =?utf-8?Q?9UIkz0uKHyFbgA0H9K34?=
X-Microsoft-Antispam-Message-Info: gl3YkNV20fUpsB/eXQqIrqN7iaA08Y8qyhzDwYvnUD9Kz1w9gpUXyOLz76Qfk2g6MIATAi1LRbLcMoUt7j5jncgzbFpLUkzJ21S3Vwr3j4XnpB9vpHIDQKJVU6z+KgD1jUDCabxGtw8bvsvkvmHTCQQcvXiZhw/kVIIYSRpomd84CAX0LuZ+NuwGNVKwABAoprgEaC5M5pkVMjXjIEW6u0qDf12o0FIfNpTuVWKOOWIJnFoJ0mYY6enliI+U0g0TosfQLTrzCQ4Ok9sFr68eBMeI3QekoRfe9V+iPaLg4b02OkzKOe/XIvWl2kw1l86gFLbszAdvv/GtwEQtZhrxzn5O1C8fjXnsApiXkJtPotg=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;6:SJpqYgZkrZhbkKl7mLGQb3AGeYpPCtNqR/58j/3cwCbztrYDRJ0JXYj1iMtmgXZAZXMlE7WRo0ndm79h5R8HGx3ja+0cstyKy2V8M+s1zj/HdBEJicQqKWFFg8I+ntXhMcx1Wc56qXYnztLJLW8y6CYehYaqzpOlVkd6TnTwOGkayoctojAKBZJxkRVfZB/qhr//N/CTzq09+nIGFm671739MGcSA5lMAgMFYLCzKxoiewphg8a0Bw2KuKl9msWb8MmrJ/f7CGtzmP+rbDoSfwVD3NV6jhzJYKmhRNBtKleQg4qLhbc6oK+ztYjosysBpw2LT45ayLVoxWjG9x2NkOYJMkeJQzi5LONKXmowRFVZhIAkdvymMkEVUgvccPOG+t1ttNT7GXm7fVP0x3OZtaWaQHhuGuhvADyRf8Azmv5pZJ4YKh/ooP15yqx8D/IPSCKd/UEDLOF8BAQLYL1I+Q==;5:o3oMw/Q1tyu/vEhgfJZYY9qA7XfcpuT6rhaksEJ5DnbbQro+sVD2t/h1YQOcrjq92hI/5AQcdzLpAJ9SQR4ruR+37ir5rrrkKidANIRG5K1RQzMUvbeZgXnGH5cneRG9dH60ypS8l5HlgP9AD1Luluee5e67jqZ1ak7V4GOcT3E=;7:Tc3Btk4tWHyhM5oSORiaRcH5qAluspIfivuSZWU/ozPExcsF3bT7eaWdWAUxRZKsnhQ/qzPWYtb7jjFYmFXk2jxOfZYlIhM9hosV6Yb0ttv/7erYJuE+ZD6dvS+fB6uilmdyVcNhR44oJaN6F7oeif5VKS56sze1r2FL/WbNvyIN+5BkNYxtHaQeJVHvE9aR7+okt68oKiIoSk/ktwT2LEgn1Y48tYpgB+zmBBFhkCw7KdrR/awojeiPzgwOPzkn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 14:21:50.3970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4f202b-8162-4d4e-4e76-08d5f170cd26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-mc/bus/dpio
directory to the drivers/soc/fsl directory.

The DPIO driver enables access to the Queue and Buffer Managemer (QBMAN)
hardware of NXP DPAA2 devices. This is a prerequiste for moving the DPAA2
Ethernet device driver from the staging directory.

Horia Geantă (1):
  staging: fsl-dpaa2/eth: move generic FD defines to DPIO

Roy Pledge (3):
  staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
  drivers/staging: Remove fsl-mc driver from staging
  drivers/soc/fsl/dpio: Convert DPIO documentation to .rst

 .../networking/dpaa2/dpio-driver.rst               | 29 +++++++++++++++++++---
 Documentation/networking/dpaa2/index.rst           |  1 +
 MAINTAINERS                                        |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                    |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                   |  2 +-
 drivers/soc/fsl/Kconfig                            | 10 ++++++++
 drivers/soc/fsl/Makefile                           |  1 +
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile  |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h         |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c      |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-service.c     |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c    |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c     |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h     |  2 +-
 drivers/staging/Kconfig                            |  2 --
 drivers/staging/Makefile                           |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |  4 +--
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 22 ++++++----------
 drivers/staging/fsl-mc/Kconfig                     |  2 --
 drivers/staging/fsl-mc/Makefile                    |  3 ---
 drivers/staging/fsl-mc/bus/Kconfig                 | 16 ------------
 drivers/staging/fsl-mc/bus/Makefile                |  9 -------
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h  | 12 +++++++++
 .../include => include/soc/fsl}/dpaa2-global.h     |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h  |  0
 26 files changed, 66 insertions(+), 60 deletions(-)
 rename drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (95%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (97%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

--
2.7.4

