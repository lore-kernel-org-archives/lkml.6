Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26549C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A149219DB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iKXb9hMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A149219DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeHFI07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:26:59 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com ([40.107.6.105]:58435
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725735AbeHFI07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeCWIUxTohsIxryJN6FR9Yt1B/+SxXbIfN6TPEyPvOk=;
 b=iKXb9hMNlUpoKhoCYnAGYlqDfLudxjyNr1X/0nye3xgf4p40ug5uNp32UhhHupi3CCwFcUeQWcBEirGdnYsFxNT3yyQk8lPG6W1TXU4sUEeT5CnQLC6YSjdgO2t/SDLvkjAQhlsoaSiHRFzZGiZj9ONNXb6v0mmqEAnZ4RVySzg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2455.eurprd02.prod.outlook.com (2603:10a6:4:35::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 06:19:21 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 0/2] drm: fix some bridge api misunderstandings
Date:   Mon,  6 Aug 2018 08:19:08 +0200
Message-Id: <20180806061910.29914-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0334.eurprd05.prod.outlook.com
 (2603:10a6:7:92::29) To DB6PR0201MB2455.eurprd02.prod.outlook.com
 (2603:10a6:4:35::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53473a0f-648f-4232-c254-08d5fb648d17
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;3:sLfw6zqWd/BUQ9DIn6OE8dzQB0T+uUQSxk89IxhoFVpKqPf4jSZz2TLDLwNBWR+vqz8G//9bKH3Tzh1LY2IUCpgogrWVX8wUtycIYPd1O8QrjTHh7bex7pnNtKyKlCvwvs3JgL4qKakJxgrQgba/KEkdfNqlv/ls3DndkQ+bVlcwA8fqqVIb6Hdmi8eMsTp1qtwz+fpTxw92TdAw4iu0Xg8LK7lgn5+qWhnU7Tz2yg/NBKR2lDp6mw/xOBafRVb+;25:NqX31VYo7DZNYVwKUXbBRlU6y46wy11nD6bMGTQRTOjEolgb6LNvRSbcwHFhp8Yo1sTh2S3j33xbO3bp2DkMz8UclR0Z0StlrNBM748czZ3pqRP1S633ulWTppEvoe3AAqBRvEPzfvu3puxWEMz+kYBIAoD5PR5r4w/LNCWx++jGuraoVUFUvlbrZ6F73W5WJDwiVg/ge260ekmpiQzJJFEkXE7upSfAs8HTepTSMrdXpdrnCApnNKBnKgxjOXalcuuFSp/hMIwleUuflJ8SFMG5PWmA3HPZE+wTD5HwZeCo8+qY06a4d+eEOvjI13/seY8FHOJCc5YHlGL1dVbtXg==;31:6ht2OJ3CLuekjbTAqcQ4i7LsA0XazwMvQ562RlDPMRH8VK5veDuhViFMoqCQ5f8yjWScUnnzyjuhjHnoM0E6AkA2KDaAWN2XhyNvk1yoSnw8XHEtRIhxT0Qh3+pLE36An2EJCT/VgIJpeL37uzXfTAymq6d+KdCs1kWNyLLWGq1AbItdiF5GqyFIMJ6NkLcTXjVJqM0Dmpa8TAzWvGIv/00YZqKIzP6lRfqxVUdLtLo=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2455:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2455D34A54A92D47D8B1A224BC200@DB6PR0201MB2455.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2455;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;4:X33FFvk0FlkLphLDuVg9joMq5iDRIq0O6r0ngcHC0BG+lICsw//KE/06MtXxoMSxQlIs4YblsZHCazSijVQQoCdF73ZrY9+OmKlu0aQGbbxdTBSM7fOe1jNwrkdt1gpIWkNdFxzUPccBzHLWCqmybgnPom0O2oqw4+LPIcPmEpMqr0na2WVMwP5fnfTu2byMH3B766EF/lp3THefKxEJDB2X7pgwyaFGvq6Y+LBCMz+0lPuRiamFdb7TdXlbmcA+6A5a85SgEUTD6wZw0wYMiw==
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(396003)(136003)(346002)(376002)(199004)(189003)(2351001)(106356001)(74482002)(105586002)(316002)(4326008)(47776003)(6116002)(386003)(66066001)(3846002)(25786009)(6506007)(16526019)(186003)(1076002)(97736004)(956004)(50466002)(48376002)(2616005)(476003)(68736007)(486006)(5024004)(14444005)(2361001)(26005)(16586007)(52116002)(8676002)(53936002)(478600001)(6512007)(36756003)(86362001)(305945005)(6306002)(5660300001)(54906003)(81156014)(8936002)(966005)(6486002)(2906002)(6666003)(6916009)(81166006)(51416003)(50226002)(7736002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2455;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2455;23:td7HYKNNOfqjEyvaKBj8E8V3CEdHGYCZ+Wg5OOn?=
 =?us-ascii?Q?EJZanESQjK/hE4mP8xtCSl0a9LqqOugQkl2hjW4OqKgmhobr1I3y7n1OROp5?=
 =?us-ascii?Q?RAJbfLVCQhENMi0EazS3oyGwahIAzjfRvNJ+hOzNbHmSnrxeb5N1JyIBnAGg?=
 =?us-ascii?Q?B9/Hsbc4QR4VAujbsbSJ/ttxBsXrtdLoNWgugFXeh+prUKnAHQcKgrXbgHf7?=
 =?us-ascii?Q?UyIpx17IwTk548ASPjVOS61yqZ2rF2lkOKlQfuv5JsUes0Q44/jyiscv7CK+?=
 =?us-ascii?Q?DqY6T+gF19inN3A8/oSk/nTL51IxFLSSPJM7xtTJM/4FSy/3FkvwQpnaDdRC?=
 =?us-ascii?Q?UTFr1v+WVSaXy+rRsrNY7NCLtBWuUua4yMtZ3B3jwxl6r0zz3AldImkIWvSA?=
 =?us-ascii?Q?DqqOEcOHL0FeU5J88UG94t53ocH/Z3WAFkXu/griTljWeLnEukoC6kRkzcOD?=
 =?us-ascii?Q?/rxlWiv87SK6i41ZkMsK8ILAKhXfMxqc8pOAgU8qQKRkW35sTliqcn8eIorr?=
 =?us-ascii?Q?BIyKa8YqqhLjKeRjSs4BU1Jvp6eYv0KvTdmzedoWLdfSkn0KvPkl5iJJBeFK?=
 =?us-ascii?Q?AaB05yWdTS0ocm4fbf7GQaYexOeanB0W+C4C5hR9+Sg2LI0lCoJAR4bK/HwI?=
 =?us-ascii?Q?35rG96wR08W74xEI/7s4MYiy3vu5kvbNXm89WExRVHdWrBl68YzggaCuapJY?=
 =?us-ascii?Q?6ZyvqaJ5Rf2qZvvezkMOVnKZhogPksaSAwu/EwPIr3+JwfT9yrnMxTfoxlua?=
 =?us-ascii?Q?S8Ne1FFEkAK8O+yibSNYWubI8jqePpxZaOsYbAbqIjxUe27ZEaHa/rQlNAap?=
 =?us-ascii?Q?Lz7T13bVEZMqcspaMHXowDHLd2h9w7DYbxs8eEHw2CQ473jqUcYuXLILbNIz?=
 =?us-ascii?Q?+nD1geQzNondkJ0c7ERGRzzqfAm5mxribvpApBMdjbMe1X6yb03d4wIYcXra?=
 =?us-ascii?Q?nENTwN4reoFXeB8x2dFw5rm87ghY1CD0/CYSXFpCiw2mPKOiBRhksAlxuhrr?=
 =?us-ascii?Q?ZaINIs3ylPuqW58cqMRZRrTYsSmj+nlKBNSP3+qNc6Oso9norLR2GV4yINpQ?=
 =?us-ascii?Q?8hV/0R1yLPyewV3N/J5Ub/pMq5NwpAkKk1VMe6KSeySvWokOf4O2C4dTPSQ2?=
 =?us-ascii?Q?Et9RkQP6FK+oRu6AFaNlEXSQvNO4uOCMNRXQuQttUB6wEzZ9dPMrLs55u3vX?=
 =?us-ascii?Q?Vi6GWBEUoi9Rbg+tdUiUNUDPsfMgC+kJHSXnK245ZYiV0BtSOqAZhsmOzYBp?=
 =?us-ascii?Q?XrYA2xR+CRTBd3NKU760HdmekOwLevsKnPI8UDbbuH8jmtJHJDwy0HfDdvEn?=
 =?us-ascii?Q?8eg/PjkUXPRVmGzr5r/lhuIg=3D?=
X-Microsoft-Antispam-Message-Info: +nBB3ORITHEEk3QJkKdTR68dGwypuDlbdmTaMAFpE2d51HhGc0+oo3UUtJf1KsmbAqEnsUSZuYqVUyvqJsS1jWMrXCHT18pOhtsS8ZJAKTNPc8nVLuQ/EVLAxItxVjd5H1D757a7Ne7Ni2v7sub8T5kY/EBgQ4t6X4XorcO2PYsxmk2ESgnoJL3xqj7ZLJbjiGXT1kQfzeYuo9naaemllsC6GKoRmzKkf1h/bCW3v8hqaMqEaiQNoCzLtF8L/uqh2SwqjmUce14Ud32dE8nHwo5xFYM+s5pYjhwVizkx/FAxcmEaUQWDjj0XqprXfHFM+Gi/+Dq71RsCIy5YqZhvXFBY2SfujXmDtBSZoTwdQZo=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;6:WWtspc+S57yyHdRTyZwDSKW20plyK+kggnYEcZvdhIbVIKeYSDdTe3Hdz+L2resqVeWciTpADg2I3A7ImV/GtZUhwyShOv7KBQ9imBkQ/8EbGUaKD5Tu+lx3jwje/ur4adrYepAHsbVpNxxD644PZF1X2huAjc5jxS6Ds6XeqG83B4t4u2c8kRxNP1LSB6TETSAWJiyGYRMSQ8UNQHlSgGCBK0dfFxpyVL7+utN6qecriXSb/Fy0z6Edwjz1qc7rw+LjKpMnQVbs4a4rZh/WSGafbJtGVEZDhMHejBNAEjv0v4zOY5MSQuJlg11/FoKKKPCb6Z/OZXl0FSh2czkzIiZRJTneIFIrKGb7by9yJI9pe3ud+JHvUPnbOtLLseaG4KRXdJKzXrBtPdj9VF1nFcxAaajlIpJZIySRunlMGNhypnidOUvCy7Jn3J/AEjV8LtWzRYInPjve0C9ovrmOTQ==;5:OSSVFEuGP5LrWrwt5Oadcmcz5NEBXMD73wKCSOoIZuCA9WBb4ZOo0pgJkY7KInHi+GkdlwojAWGWC5XgCvCGRRMFq0Q7VmLKkTdYvcDXFHsKxQSjdoI0TPkRpyQ1fqChwqZbThWyRd5bOlsFCAbAYlpFFIlShLXzp1gIDfAt5uA=;7:8dZ6V0sSlqPMvbU8Jli8ZcQKMoPEicBYQV3Hdr9XTVGFI1Zi52J5Yi+zbAF8LWXk8b9+VsZ+PVm/kUMkEFyfM9OxpRLwLpvQMiw0fUp6gf1ssoKbBEx2RBfEIRD70+MKhiaGEeG4K94ayjPO2VHAWcD2yViVtm8nH2jM7nyyJkUCSMZ3bWuc2lcCH+1Z8kSGJSL32pE05xxwz6FjmabIDMOyrjGHx4EotBqYtiPtZmRUX+KL74cLi7shzMKKUcU2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 06:19:21.7412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53473a0f-648f-4232-c254-08d5fb648d17
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The first patch was forgotten, so I improved the commit message based
on the discussion from last time, and then added a patch with a
requested documentation update.

See https://lkml.org/lkml/2018/5/2/81

Cheers,
Peter

Peter Rosin (2):
  drm/sti: do not remove the drm_bridge that was never added
  drm: bridge: document bridge attach/detach imbalance

 drivers/gpu/drm/drm_bridge.c   | 4 ++++
 drivers/gpu/drm/sti/sti_hda.c  | 1 -
 drivers/gpu/drm/sti/sti_hdmi.c | 1 -
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.11.0

