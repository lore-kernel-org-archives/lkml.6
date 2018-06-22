Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C2BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E682447B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GqTZ7UFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E682447B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeFVPQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:16:17 -0400
Received: from mail-ve1eur01on0084.outbound.protection.outlook.com ([104.47.1.84]:59070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754190AbeFVPQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZD050OA20IdczhE4Ckhz9Z1mNugV9V2j3TxCsgQFd4=;
 b=GqTZ7UFOXYXz3JBTZofmLvcwkgezcrRc4gmh4ExC8avPyk2/WZOfLKhnZvUBU2JjLFRoO55ioUyX2RJr4CH3LFkbxEHGTp8Yy+pyjVBlDNq6g0hLr3Sgd0egX3NnPRvOiB7y/x9QAtO9iI0hcF6r3eLrOILDfkRXR7Yf129Au7Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1613.eurprd04.prod.outlook.com (2a01:111:e400:596b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Fri, 22 Jun
 2018 15:16:09 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 0/2] pinctrl: imx: Add driver for i.MX8MQ
Date:   Fri, 22 Jun 2018 18:15:47 +0300
Message-Id: <1529680549-22079-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM6PR0402CA0036.eurprd04.prod.outlook.com
 (2603:10a6:209::49) To VI1PR04MB1613.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a07ce1b-2a70-4e4b-9ec4-08d5d85315ed
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1613;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1613;3:JcX9CU8shqWQeRc6wO/AH656tx26i9mLm00tuhzg25gAg7v3+qrrf/crfEbA041ZrXmpn8TuTs/OH5Cex6nTWTgn2eO84jMJUYIGhciOOsqmiwuhYS81q7kLsK3QjhUZBUUqFjH7NF6cdznr1xk2tTUpyeQPWwyzE5Pjq1QvoRr94BsG3jdVNEGYOXXOVbg4KkO8/0lprexHmvMPxBSBSgm60vrRrYPAnIbSM/mZ/hBwRERTS8JJlpMWioJ45ahn;25:BE6TMg1SFORtSm5xKkuTKDdRw52NeEdaLODRL6qceassqVqMaHhHKPXEOMWjzE9627z4PG9T0ms6RYQQqqcPRdNAJ6Ncv6ZzHkf+ahOrr0bfvrLDVZW8L2YektBSIsaWkLlhzEuOg4OouxfRGJ7L7g7l/BOSl7m+ZAYvtrqMQ229FDqA3Pw5KvvGamVqEUkHSQjS4ZSrXQondyAVLi6OaM0siwk11wyoSsr8VIWk/O8x/rZuKx5VM0r4++4Nt9SwzeDbYLP3Qvf7BIH5U093rscduGI4zIVLnpLyfdLYVxMAtGMydNQpnviL2nzzIRoPv3u0pBAuG72WJSmxKEQKPw==;31:O8/fVlhLFwB0bV/v+W9j0u6FS7v5uvLW/BBDYv4+QTRYM4vAE7jq6fst71Es40uZt5B+HlmohrVLwBIqJ/KU6EYxOIkht7oWqg1K8mwn81YDm1yYAjqeaK/cgHMWxuaaDeNwSZQcFILPmMl0iD+VB6FQ4AyYaYQA57pwgGASRv/Z/5DE2yfi0gCOx3jAdvqt5ZoZRpmkoB2nc+8OH9sHOSIImwSrpUz2i7VQ3ZRlrRM=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1613:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1613;20:vz97O9xMRgiqLTQTefn5BxxY4EsW1sPAWpDj/ztBAZDV0atOiPPfVAcMLjF6wSHI3pFyGR8HkJ11jh9PYVEfANqA5oPaYdjvsJrWHwjeKwws0lUX8zT4p2NlHC7jdCVu28rUktkCikVf/iwAMZVKC0j2fj0miuWtf0bJTp7+BtGUSLwQN2WlzQLmYi2adxM40iotx1MpLUrO3RadhPy1tVP6n/7rzsEj5HaBMrd/s14oevL6HcjjblzfmXjk23ETCe3NvqvHONyc/42anHiFKzvStbbOgUawqP+5TtvTUJJ4PufBJU/UqpdjR5kuH3CbVlaA4MyyhdgJOEMQ5RLaG2HIGHUBuId27+kQ+/Ln250HyLiTp9w2UJi09f6yPyUqwGm3ataAd4lRI3Zr8RP3WgZr+yiZOQBmgz/2W8kPvqufIVn3yYwXzaGL7k7ase9V+Xu75N1lNkWGkcz7YV8tuMtdYynCCyxhXpAzeiO2mqaLNMl47Y6pJ9wDLYY6Z0IN;4:rpdQuAdsrRRVIHGXe232BDhYRLrjrgQqdwVpbgfFtBTjjSabBTb1hPMJydlcCQ9M7wzEC3vdJrlMkhWe13LO/E5fvSg6Fi6T3xLBS6BOwrwpBnbaGRpYdKIkHIQ68dVEtNZjSHOHER7iF9v2oSN+51FaQekdv70+vAtlOfKWxnqdauVYKCL9HXk1Cumu48QJrFMSBCm+bXyuVmYQtehBktlo3uryzbqdoMeYOrFLQwepzMd9HgRm9CtHuxGW90smG1JHMVmT7Gb0Kt7zgBdyAmedAtdU7zghZ0wKVEP4aU8BxNmf/TdGH+TfslkCp8l3
X-Microsoft-Antispam-PRVS: <VI1PR04MB16137B1E280A0BEAF0FB5C64F6750@VI1PR04MB1613.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1613;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1613;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39380400002)(396003)(39860400002)(376002)(189003)(199004)(105586002)(47776003)(6306002)(54906003)(478600001)(50466002)(48376002)(5660300001)(81156014)(6506007)(53936002)(3846002)(6486002)(110136005)(8676002)(6116002)(186003)(26005)(81166006)(106356001)(386003)(6512007)(16526019)(956004)(51416003)(36756003)(86362001)(50226002)(66066001)(7736002)(6636002)(4326008)(6666003)(52116002)(8936002)(316002)(966005)(44832011)(68736007)(97736004)(486006)(25786009)(2906002)(7416002)(476003)(16586007)(2616005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1613;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1613;23:pEbXaWHLtTyNVRnVeKrI0lOg+xe15gHM344inb8/n?=
 =?us-ascii?Q?6O/aLe+BjR8AmR5K2xf+gD/v1VDokZkeG/uTFEhlGo4Yh6nTW5egderPmMYM?=
 =?us-ascii?Q?f70V0SQC/K3x1/ci2iOqAy+ancH2MRp7QcLpvNB3dkMe3aR001STDVyy69vu?=
 =?us-ascii?Q?43X2Nuh8YVHdlSXPiavgMi/gDNOPqkeaC3ToQ85wWxF0wFQPVBvkxp4t3p1u?=
 =?us-ascii?Q?PeZY8lF79H1RLKy/vbs8/zF16RypdmVVnfwMGBwIFTLsdVkG1fJrH9u031uY?=
 =?us-ascii?Q?IRC3YfjqEznxe6HIWfwSksyGFudnk3irBxRepD7qy3u6HnhTeCIY9BtOUv6I?=
 =?us-ascii?Q?dCJEzON9rPA2UsMW817b5V8ayZVZbCLFmdr29mQm7MH1Lu3egn0a6nhYfcyi?=
 =?us-ascii?Q?s1BuL9WEXv9g3GiTT1AjSknj4kq5PFq69I3C93BENepcRfUUyhVLahxLX8Qw?=
 =?us-ascii?Q?iusXvB2jw6rrbfsF9trlxH5/SGHz9Z2FYREazJr60pXKXKTzBgGFR5cTh/ch?=
 =?us-ascii?Q?qMWhGXPKvBS9SI1gDAy8Wc4i2QvKffuLQqgfBOw0iozAWuNsnzIfNmsSqQZS?=
 =?us-ascii?Q?19BGz0YEfVhGyM5gVu587WunyDPn3oBIyKhMan4ExqvqpcyJRGzLanbVhJln?=
 =?us-ascii?Q?ATm3TqhTRedqWgztPQ0hMH70YlUkPhy6x5jXSMnV2HNRwdvDOMM0FAXwsQlc?=
 =?us-ascii?Q?Bo9AzHRA1y7gkMsFvVyfEgtidHL3/TGck6znX1F7AVBo2ZkWwDHCz0HnSzXu?=
 =?us-ascii?Q?+O3YFs8K5ZkP5GfXL87tinMdqGnvaXsxoYFT24K5uiGtOpb68P4z6ubaPsA1?=
 =?us-ascii?Q?7Olde39FE6lFEuEszN2JRwvECqZFf38+Q6gK6GrEEZ3EaR17is1lwFP7tAQM?=
 =?us-ascii?Q?zLPsLGCE/7sC6wrri0acFm5OeHA6eej/a2d1AyTgwQNVzOiCKYum7B02iNcQ?=
 =?us-ascii?Q?hZnG0zwgk8ot+YfusqFKLSJX1hOLOl+BghFGtqJb1B9xDquqao7ImGD1Mn8/?=
 =?us-ascii?Q?oQUqc4Ligs9ZG1cpPftM8AovGtv230pKnzZgXzsVZKlTAUTg27oIUR1YpmRv?=
 =?us-ascii?Q?2QxwWhGi1jVZqV0qO+X0nFnEXqaGy64jI9cmMKJXPO5/sOs7enMEJRdxXNWf?=
 =?us-ascii?Q?xUnJZD53iziIuSS6fSbmGWIfAxjtv4nGWV2gQMN0pAoDVnWxzzjb8bUqLff9?=
 =?us-ascii?Q?PiXrXpKZGX/ismqty6+InbU8Q8DmvPEwVNeCWkmrwk83SveGbbWGdU5tlAPU?=
 =?us-ascii?Q?6zFYQ+pU96gSXeroW8=3D?=
X-Microsoft-Antispam-Message-Info: +zZClsdgNK7rzBXlhzKzgKXdVnql4w0H1m3FSAQZWsDj7vNeGzCrZfMmvqEhSwKUnhc9sc7vJuTZaaEGYXkEYuwjXjC33ctvWAKG8VNmvGF+TtNDWiLZ8bvCvdqjBtcLztmOSqp7LHAY3Bjhl0r0rggs/BUL5agZErnOXwK+ftPtGVyQsjRS8OYtzXFd6BuXq/9awq0k9XF09K4hJhCURvlSXfT8NJspHyU8bwnSneCBUKiXlIOoX7X+y9yDgxHoz69gvf46SPnNpN+dMQxU6SOi5M9Jv6808Tph8cPIMIUHs/3F5Jh/U/eJKMcQAPW2
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1613;6:lixOkXDSEBSQj5vNnTy+/JcHQU0F7HcZbTVOWuxOK/3v9aZ7PYN1ztqsd/mgE1r0oRdonQBrCb5Kvi5e0lYxY7gwvP/PNEJl8ZYlfp0mU1X+l0SwW788hOTS9tVbOefSigzSJgKXfOeP/QkbsNxIAtKtdDEgcfYIw8qQE2XDMpVci+H7AzClRKufFmJkludMg67Cv3ft8XKTaTHillnRB+taxTh1ICq8UCkZfNzTvFT1awR6FsV2K5KlN6X61+CVo3ewIR4KHMZfxiMdrvI5zNawSYyWIbOp3BaBR5OL0r2h7FjipC/oYDZlNpqvV/1BCr5cD50O4iHdZ1DEkO8PG6PSN90PK55iBsHVj/KgcAKB70Xro2vt1JwYY3aL9wh9NmbIzC7fkmuOT9sgV7vvIEULmktrNwUCp65zi/y7WbqbSRjRWrHMxLv+pMq136gkUT7ep+XocsuKW1jfbqmYSg==;5:Hw0m4ghQq4v/hvKyURxFSWV8jOStF9q28kZQh7JK5uxVSpAL7fXysG9damKJM9F6jdEQpdCELtswupy6Nb61zDZwWadMjz17i8Nb0phNKigMcNbXZwuWrIhv1oZd5lORRGtRQqCEW8hEDlTYnXspPUrLt0CY2OG2kL+kGJI5Bak=;24:IH2KuvbmneoSHgT4ya4naGgNWQHgBfZlUWrV2hR2zAoEu9l6yecRcd2lJBl+Pywq/xbX92TjwGCNdxOBkHSHVB9oeVDzEratq/JKen9w+sw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1613;7:tppdcJZAvP6RIq40oLaT9Qui7rDdIinU6kM5gKnLJ2FJInmHBD+GvPpXEiCqMQRelFU6GVdvIQ1ryEwE9FY7hBB0lAh2CSmqurdu8fj4fAqa90KreYZdB4dGEkR29bAvKYmP5fB45XP4EpoJgrmtny0yAti4zj95f+KKDHZs4WkxfNvRWs92jI9bL9ek5w44e22LsbcF2CZf46ubVaPMfjoMYyhr7AOJFeGcx7Q3h+TS94HhDDxq9urn2zwYB9HY
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 15:16:09.5565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a07ce1b-2a70-4e4b-9ec4-08d5d85315ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fifth version for the patch series sent by Lucas.

https://www.spinics.net/lists/devicetree/msg212752.html

Fourth version can be found here:

https://lkml.org/lkml/2018/6/20/478

Changes since v4:
 * implemented all Aisheng's review comments

Changes since v3:
 * dropped the SION generic pinconf changes
 * added examples to the bindings doc

Changes since v2:
 * switch back to the 'fsl,pins' and hardcoded the config values
inside the dts.
 * updated documentation accordingly

Abel Vesa (1):
  dt-bindings: add binding for i.MX8MQ IOMUXC

Lucas Stach (1):
  pinctrl: imx: add driver for i.MX8MQ

 .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        |  32 ++
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx8mq.c         | 351 +++++++++++++++++++++
 4 files changed, 391 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8mq.c

-- 
2.7.4

