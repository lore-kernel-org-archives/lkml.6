Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84832C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2664A20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GEcYDpQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2664A20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeG0LNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:13:35 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:54672
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729431AbeG0LNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uy/vayzFv74T0yDoWVIVS11SRfQTHHTFuDeGTu5DGU=;
 b=GEcYDpQntdPA+9vimFQywxQ7w+5Q91Pks36rG6JvZ5ca9hAh0nRvTMQfB9CmN0QTcxxcYF5tVsQQkwM58wNrvqTODLVWTFyVhu+8Eqvo/YPVe0SMZ/1CiTROybgEjgwZ+o4V549dNAJOyAy9gvn7n6pd17ytcN9iwZXuBCPX5KQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
Received: from localhost.ap.freescale.net (14.142.187.166) by
 VI1PR0401MB2557.eurprd04.prod.outlook.com (2603:10a6:800:56::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 09:52:20 +0000
From:   Bharat Bhushan <Bharat.Bhushan@nxp.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
        joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 0/5] powerpc/mpic: Add non-contiguous interrupt sources
Date:   Fri, 27 Jul 2018 15:17:56 +0530
Message-Id: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR0401MB2557.eurprd04.prod.outlook.com
 (2603:10a6:800:56::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2edb0a28-e614-4789-2e9b-08d5f3a6a6c1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2557;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;3:tpTKXJtQnsnuLAPLyshvKgdgc0fOzUuJKVGRhN+sJkNsnmhqlO0knJ8WxTdK39HdPVNm+sdBzhxBErLc7KYt3/zi8NJoS+ap+ueIX1v5N7kSkaNQr1kullI587cdATle/Vlh63dO/BQzVzHbCgzSSpemSMVwtp8j+cEBbd2AgSAhivA8mCmtNyeyfcFPxgDAYB5kXNI3UF7km+sUb3OPbHh7ssJ0YXGxWWVE2G/vDRgv3sRQODIcBPKGPYYyLssa;25:GUvAn9rn3Kqhj/lK1hurXESpOrFnaIOW03svRHMtIur10UFfpyGUQA8UrsoN4F/tmHABipn1L15vLE2vI8F6qm7LgjY58vDi03p6bK5GpSpeiL2NG7nX+kd2NdeGtf0Y5MYCfAcLhZA1XdXN0M47QLGd7wLL6dDhwKL95pFOZgxmLD6XHdCOWK2pw8aIw30SqGz4k7Y/+gK2TNLCCiFW6ilqfbfh3ssv6Tl0b3xr/iEX3i+ndGkxc7jtFkhAwt4fB8vXwisU6w+0w7XCQtzecc4EJrjxHXRxpJcLzY0YAtX0js7G8dSK5ddB1UltSaIKZeVES3cIcPMcBVM/l4kGmA==;31:KcXbaBsrH9wUP8osOlJghdHBkhJBl9UldAB663OLLRDayizvzEm4x6BUHMQa4pAAtWUmFm2XnRt17sYh7NaFHROJ4LS4h/OaTCBXdnOFL9PWqDzpQxqtnBFBKeZnLMzCUlxUTAWSRcncI221ugUJYF/icJtF0O7PlxNI0VHHw3VmNLpYcH5S2grNbM9hBJjSxqx17DHrZIL6pIgGV+alTYox1IAbI1naO0BzEbRIbf8=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2557:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;20:9VQho7h0OixjNst8PNekN9bwce9q6GNQat/yjzzqcUPx6pSYkmZYquy4loqOGmvTm7aCZFIWEO1YM5x8xqy7JNuIYqqVTm9PBkTaXkZkeVUpMIF4lhb1radWZ3f67eEwNLbqdjA+O72oCWwl4FknCTThXFzXGIS9jy0teu12pFn64D9LLPjz8WPpKZfJBVqaEJJfO1Rnjm3DJheCi98iZ6q3OZF5Z3JOnbG76BOUn909SZS3CUeaCLRnYZEvJxOWxDrI/EfdRfwp4+YJ3wa4tz07UZZKTWkJn8Xihcf2AhwNpAe4wPaKDtLApE4fCQUB8bSjCeDSzEHpnw+6L/tCvTww81RhgIwLMRPsp0+zT2Yf2FD9jzKFpjIIhH1Ck9ea3o9gDeSTMlP1feJsAgPQ8kf115XyG7pOCEwU63jK+RoSdj/hjGKt5yUidkR8uoGseGbqSbtkKLVXpQqCr9X55kBcI6qCnfMlAbogL5nPskNNa9AArzf8r7ptvmEb7Ys9;4:4cRMQ2Od/ZscEseB0A/nUScosjyPR8qRXgO5p1Ni6YqWLZYMgijXOffF1WH2/kPweVnV8hLgsz0wg2ZzwYSyb+mceJqWRhcsSL+dswpW9HzYJRXCkByuahpLlH67AiG+8TwjgUlrivfVxQuwQ1Pd847VEnHyq4uvFZXGd4N1U3VY+5/hqKZPi9kBEo4f+kmUvXh3E64Kwb5oxTR6Ya6R7Phggg+KyNfauXCkVmV/llhw4VBSctLaOEdSqyAAgoRH5YXy6yLVWXHn9Y4K0F9saQ==
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25574399C28C94E5F18D92CD9A2A0@VI1PR0401MB2557.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2557;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2557;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(14444005)(6666003)(48376002)(68736007)(5660300001)(3846002)(6116002)(36756003)(5009440100003)(53936002)(25786009)(50466002)(97736004)(7736002)(2906002)(305945005)(7416002)(478600001)(81166006)(81156014)(186003)(6506007)(386003)(55236004)(26005)(16526019)(4326008)(956004)(66066001)(2616005)(476003)(47776003)(316002)(50226002)(486006)(8676002)(106356001)(8936002)(86362001)(6486002)(16586007)(51416003)(52116002)(6512007)(105586002)(76506005)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2557;H:localhost.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2557;23:FN9KzUjoojNZo58XSa3QZAAVcpamjthCoj/LMyD?=
 =?us-ascii?Q?PJ+oDXyhr/eWF9+5seubNeOBfpSMeIg19VyYkXLLgDQ/cOZGlf9QnKwf36gd?=
 =?us-ascii?Q?VgRUTu0pjwzqoMvp5CEMkoGrX/3EzjGdCaKujCqJYYY0rfOWs0x7PAcTYjhm?=
 =?us-ascii?Q?Jrk5tAPUvAgZbHayiFmzGpvi3168TVLu+jVNOkDXbAaJdABAdAmxOjcWtP98?=
 =?us-ascii?Q?ZrQVETrNyucoZn57JDN0xvxY6fGlUaUidySrFpCUniR+9rh8ChYCpcaqyTNZ?=
 =?us-ascii?Q?KkPB4BGq+LY4aVFWeYj5jCNPEbYd8ncX/mYI9hy4ti/6K6Dr2FZgSc2HeJNQ?=
 =?us-ascii?Q?EHL26D+z+r2YtjEFDwumb3GjZBGj8z9c2WpdHLeG6HJ5blOOKRU6XP7o4Hf5?=
 =?us-ascii?Q?bh3ED9Gyz9SIv0O73KKkxj8grIL4LjybQ7amuwLhlhWmdyqiTZUrb7+H99jt?=
 =?us-ascii?Q?Hny4d9Wn2UOSlhKCIsmywZSnnmbKz/d3sx24lEpUsl81MdjW+Dr2NWy291dM?=
 =?us-ascii?Q?qs5AAPLA6op+uK+kZgBvJpVvJWsxCl+Juke+k8uCZlhhURrK28P9HvzG1iTU?=
 =?us-ascii?Q?wK5yHx5vPffMhjBZ+hZBC+VxnKAp9dWQ+HXR/YizgtzngXSL/Z+NBQXm1uyN?=
 =?us-ascii?Q?qF6URclkYoE1/96jVNUgPk4EHQYk4vAnDFivmr+QzJMNoJxTrkkLZxgMFFZb?=
 =?us-ascii?Q?gEOtkaC03ColvOTxfLEwmg5wF1Jt9Wuo+1PbJxqx52tIey9eGkt6GegRImE5?=
 =?us-ascii?Q?6nO+gfxQ2OjyUf+UKYbgrxBvzF5/C8B1mnx/BMtQaNhgHxMuOlShU8GCPAKB?=
 =?us-ascii?Q?G3+zWupPauE0riNzIhDYohBKhgmhFjzGpccwYYsJsJ+Hu1xyEWMGdCepg8I2?=
 =?us-ascii?Q?aoC9NGO7OOvOG0AYgtDqOfmPUKV0kGn3aUd98yGnmfoG+5oQbdNkUFc+7A0n?=
 =?us-ascii?Q?OZ3HDbsulIy1ihyLbmht4NNCiVersZZgFP4M8bPql3Yv+Ol0GSvwXFqEwIlJ?=
 =?us-ascii?Q?FGY0n6o9f5Px0AM5paTob/wwDTtBCDfuo8fNjO2Uco1WnjsMh8UDVDK+9qb3?=
 =?us-ascii?Q?Y2hh6I/tI9YC0YbPonFu/TUWD/L/s2O0X8nX80kngtpaknrq2Z+RIv4TLUD2?=
 =?us-ascii?Q?3poBRDChdHGFe/ue41cbjTGNzBTM4+vdbDI018c5mHvHv29e+/HRGMX+rcWZ?=
 =?us-ascii?Q?ulu3Zb71+mZnyzMO6mBB+zNqkYIhAhrF66fIuqXhl0tk06H2UKn4QF2BocZQ?=
 =?us-ascii?Q?kXTgbfMZVBmROQzrjH59/LKUcM1ERcwskuDmgkpnEML3jRabMleeo656tgJ3?=
 =?us-ascii?Q?u/g=3D=3D?=
X-Microsoft-Antispam-Message-Info: vyL+UE7M89nfVGGMO1NTv8D+1DxjW2R+qclUwMjuLp1NNXNKhX52bmHVrCx66PDGod2lZb2l99WLOMGSh0EthgiCy0R58k+FvKnkkN3+1zghXpgN0S+vAP2MGS2SWEuspiyrt/L9ZjUJe85xRqz1JwzTWcea4Mt7B1D9pCXdIaat1d+VKs6CX2SSQLpNG+Vu7tOxxpyrNO+A0Y6bXQ1czo+/OQlLOcLh9PuL3YUeG+I1xo6aUyBYvrwPsf0QCEf6OvwpQc5yD4fSfvy8RtVTvaO85dkZTb5SVdR/05CFt53J9E2hoZqHiIoYHWoZbmmClP0mvrolGbu1JT2omrlCz00e97gqs5TmbLGYGXRf5As=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;6:ce6QqxUVWg9o1MJ9IP3XsfyO9kTsAE/ILZnQV+rLNsKdEp72RE/EsA8wvL9Qtn/zwYET1JYC7rnk1dpZ5QDjZu4rAgzMbZ9qyK3r+jwYaGProMpwhDsNuV+yV5nPW+FHHTm58lInsIMkFI6VkOvxGGAe0OL4Ehf2dCIeUegDioBil1cI0xixlEOJBRVU+/RqaahQ9+d/ZiRWZMuIXgsWQR1TAG4YB9JRRQDNotaQ4pGEhtHSnncuPLQRXd/h4oL3ZKj2I8Sp3Nj+fSR1CveDtgI5jLvpTQZDDK8AiSmkcnNMiAaZWR1t3hB0N73KYumycCPz1uPRSjFv3sVWcwxquMNgZ5II2azDUykp6Epbrrq65nKKwrgL92Zaug/DZMgCzMCeYycsFGnCjy0k+gE1eP5AFTqG6pLJw7rBqn2KQlVgoZMoFBwHB4fIjeoCnij6DGxa0d3va6TURFdllCiz7g==;5:bmL/tvwanTbKfNmn6xhwe1XKnolo3ugfYcK/YDtlOzh2BjMIU3eBeN8RzGCDowYW142T/aSVMYukzaeSMORec9TpAf/ZURqsTIB1zI+RI1Hv/ec5Mqup95Sdx91ITJ5/gyTkw2XL5B/c7XUql6smN/+SdmXrVTSwYO2A5C0tiqE=;7:ll5WhEIQ43ACXtQrrLdjaEyFEh33QzXbu8C7V5KmUhekm8aikpe1y3ssDmmOVS+rGvJgFVuAxcpDvcNyDxpSZwPSkxWCFCiCS1ipViJwseskOp+huzoYiG86bwF8AMfsRMgHWFQdi7lJY0W7QU7Tfm5F+ehlUiekCyS+rsXpTOsY/VteSI6zXtp7Af68pqN3A8F5KMsfuYZbPrX/Is+oF26/9PjHP4Y9JacJTvh+n47XuoyREEv3AsA63KKa6nN1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 09:52:20.3404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edb0a28-e614-4789-2e9b-08d5f3a6a6c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale MPIC h/w may not support all interrupt sources reported
by hardware or "last-interrupt-source" or platform. On these platforms
a misconfigured device tree that assigns one of the reserved
interrupts leaves a non-functioning system without warning.
 
First Patch just moves the last-irq calculation logic to a function,
Second patch reworks same logic, While I feel that device-tree should
 get precedence over platform provided last-irq, but in this series
 I have not changed this logic.
Third and fourth patch add non-contiguous interrupt sources support
Fifth patch enables this for P2020RDB-PC for now.

Bharat Bhushan (5):
  powerpc/mpic: move last irq logic to function
  powerpc/mpic: Rework last source irq calculation logic
  powerpc/mpic: Add support for non-contiguous irq ranges
  powerpc/mpic: Boot print supported interrupt ranges
  powerpc/fsl: Add supported-irq-ranges for P2020

 .../devicetree/bindings/powerpc/fsl/mpic.txt       |   8 +
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi        |   3 +
 arch/powerpc/include/asm/mpic.h                    |   9 +
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   5 +
 arch/powerpc/sysdev/mpic.c                         | 184 ++++++++++++++++++---
 5 files changed, 182 insertions(+), 27 deletions(-)

-- 
1.9.3

