Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA718ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B88720684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UkDoiIEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B88720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbeGSSoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:44:09 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:63840
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731839AbeGSSoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJSDrchNce0qJVfZk590Qz4R/7C6tjyjc0wNFf51IHU=;
 b=UkDoiIEC2Gdb5/HFj59yjXyQySF3DgAiaZ7NK2cSJI+h66+sRRYD8nlB5YDjhLbExpfGPwB8JK2DX8tutXyFggCnseUQFGFyDKXKhwuJ05kyrCGiEwDAuwcXExW8oPP4ZRnHrhOLDJJtbH3rR+flV27xQqg5AhgkcYBRaClSz+I=
Received: from DM5PR07CA0051.namprd07.prod.outlook.com (2603:10b6:4:ad::16) by
 DM6PR07MB4716.namprd07.prod.outlook.com (2603:10b6:5:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 17:59:32 +0000
Received: from DM3NAM05FT034.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by DM5PR07CA0051.outlook.office365.com
 (2603:10b6:4:ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:32 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT034.mail.protection.outlook.com (10.152.98.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgK025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:31 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:33 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:33 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxHu0006101;
        Thu, 19 Jul 2018 18:59:17 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxH4H006096;
        Thu, 19 Jul 2018 18:59:17 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 30/31] usb: usbssp: added support for TEST_MODE.
Date:   Thu, 19 Jul 2018 18:58:03 +0100
Message-ID: <1532023084-28083-31-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(36092001)(1671002)(11346002)(4720700003)(4326008)(36756003)(2906002)(107886003)(109986005)(186003)(126002)(2616005)(48376002)(486006)(476003)(8936002)(336012)(426003)(305945005)(7636002)(356003)(50226002)(50466002)(16586007)(246002)(446003)(6666003)(42186006)(8676002)(316002)(54906003)(26826003)(478600001)(87636003)(5660300001)(86362001)(14444005)(105596002)(106466001)(47776003)(51416003)(26005)(76176011)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4716;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT034;1:lMFcNIMy/tatzlIsCf28OoPcyl+7/nlI3evJwLqIlty6VONPa66G4Sr4uiGGzzdum39ilEuPyUAv9Wv0f9T7h8cgduIZNlo/1WC0OWekHJowt9lqDIj2X3m0bvl0kGjY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b03c0f7e-af08-4579-aeeb-08d5eda16197
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;3:NNuLz08wkVIP119CC2krhXkXa498zDan/SsjJXpnEaqQVL6mx7J//vSpITw8W1O2b94a35pOeTZWjhE5jC4VtD3kkFYGD/tV7UkkqhWWla+DVAUsRH9JfGlJtQMd95sltPqOuOuTZCFoyc2YMBwkY0MhoaNqizAus0ANl08DpB2Te+o/zKgN7iIcKP+jcFhqdtn81bPJ7dns0ukLiKDAVPJVLYSxL2cerGq61Lc+UEFKXEHrkk2JzpV5gXXo7fC90KPdmai7ZuKAIqvVgROFfnMcxrmLV5waj654BssGrLWp6jWwLGSPLLoSR4KQGSShoLeRRE15hMs6r05gLrdCfvafb4dXlfP4IZG3jwbgRRU=;25:0ENqD4UjE6ZQMKQ+kP9jKib28Przm6Z1AasrkDo6OiPDFocYZ8xvNEF36VoyQ9CGrOy7r3QZLATc6Yd18ToR8CuG9MS7CdvfwI2TWN/UpTgM2Y/U5XEPzNTinWP+EDn17tsXPhJYCK6ijRf5hbcqmu8hXILlCpdCQUxOjrZXetQeAZcPKwGGqHMs+3OxwnwVv9zvlDRp9POMujb1pmFm5tGOuAf0/jVah8nPHB3ksifJL/5YSer3eqYQXlFKWQUHuM16pu41PNtJXhIGWBkhId5knlD0eHArOsrFFCITz8NytStos1JrJKHdB7pKSJuiBa6p/kLcyWma4b9AjWqKkA==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4716:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;31:VSMI5PnT4CISyc8cPlqLdy6QIiPN6/0UHnqeCql5CWG9b4iRvmvfP7EqhSIQ9qHteRotqjJCM9bd/bzkEg/irBfGdtKuNw1sDINE3Z607diU2FAbkoGRfOXT5GQfnhqXFa2fYnEb9twLEPx1PpM3vlf7K9P9j6RvQrH3/mJBaDaXs3olw0d/EGBWd4XiTpXmcDap2ZllNmxPJronBRkCQ5jTeJmR3QQV8zaWOWC8fO0=;20:/DM1HHaJuLKm3EmNp8FZFcih4RzXGLDv77TETvJn8oxHrXM7dw4abWfIaFEaTjET8kVupRrKUyqKq6tJHE2GcFzq0A2bM530O1Y1tuc6Cy2RFTUQU8Rs72t7JYwmTXEIRRp/kJXBCl8hqoVGtVe5kHoSHp0mfPdR4X3qjwWsnRbZUtBz/flpxXD4CJluxX8eRROd3V4yxebiL7csMDb0BFgG3U64fKQgK6bj8n8aC2DMoL2w68fSF+5J8UoGH4pKKneTMUG4dYmQ7BdKJ+Hg3TpdzUSfJ6ccO/knUrQ1uWebT0y2yPWi2EYmJZ5fpn+PZcgPY3efBVOZchWvV1pYHMzzy7MHwgbPvOe5d84ryLoMrhzFBeBETX5UIkoz0FDRcZWIad/0HX4tiOlKJZt9QaM7vwF+uUHQ8Z+oEsCoBrGlFVY5IGporX+X1fzniFHODPyKxA+OPoPYnpqkuRoNa8ccfOBL3m/oCX7FV+VjS4eb4UwY10XIkRK2uKB5ea0e
X-Microsoft-Antispam-PRVS: <DM6PR07MB47161288DCC1688D357AD81FDD520@DM6PR07MB4716.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4716;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;4:GiPftMs2LYpzBDVOaHm6pY0dM9erVHcm+FKKI4pIDdT7sQXcroXaJniRlfE313nQTVSwThSghdFsRCDh4W3JskqeFXTT+wU3Z39xpmMRp7Q3XrdUU41MhMadSBYeTQvQs4PKVrWhWghCJbeyUrJ4MRS8eFTmieMStJfsxnrNxqtLopRzYXwyzMpWwy2T5AeGEkn0+8/C80lhGdJ+UcQSVKaj78TKRg5gkZ0zYk6OrX6IfMik0Me0THkEhrcxpysfgd8UeEf0BVG/xjrnjYjG/3pZhfIQI4yfLXICREBj7nP7Bjm4tAq8cpZ+UHAE+skL
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4716;23:vAfbQ2NO1Qrb0wEvhvMkExZaGYKIuVBCHjtsYyO32?=
 =?us-ascii?Q?fIKxOeDF1aftKktnv3Dj1BpDxNMS7x9HJtoFwv7XcQOmGtCpVZX6bxKY1NIs?=
 =?us-ascii?Q?TCAcWosEdbNzplDtGW8GMl4WSFIjnejn7Rd7GtsoAk6Nu0emx4OYQLjDKHsV?=
 =?us-ascii?Q?9JMZZLuY08z45TyhIhSafEDMjvgZbv0rRSiduK68+TdCba6ao0Cboake8reU?=
 =?us-ascii?Q?qU+rHeRTGey828vISBMQP/zCDqzceveSprDpVKS2GS4rkWaER+gtVE/Z+Jcr?=
 =?us-ascii?Q?cZFdVugy3AYZWLjLLfF7my6iPCV/21FE4SuKCYXIq4DxAHYp8/kYrcbVSzGt?=
 =?us-ascii?Q?8hT6iU3wqTkKdsRzuAlwLUh4ahujomoZCX+KEb3nzIwj+ZyQjbklka1dS5ZY?=
 =?us-ascii?Q?vqI6aBEWmQN3QMM1JoNzXyva7h9MWcZo3DOis0QWtpF2qnkeqdJ+wpQWclFk?=
 =?us-ascii?Q?wtNIWsiWWSeOePdW8fQ6b/j8iwiqBisxKiJ4eKJ+l021QOSyEt26ookMXG4P?=
 =?us-ascii?Q?JbuYBT0JJjrt3UUKCqJdYK9In9JicUj5FpbRZN7rsbR5eHgCWXuNyK3PE8Td?=
 =?us-ascii?Q?JyzdHDQiSdWUvx9Xv1NSHnpTO13gHCiwf9+UJb3Q4DInKLRiJ1HNmQCyJ3el?=
 =?us-ascii?Q?HHUCi+Jvin10OhwwLC7++O5rRzmJJNNlPNJ+2REJqgOjhCptfxXsfkEn+H0F?=
 =?us-ascii?Q?gdPdAnipogrjC8dfM/jxslLEwpY9FFX6WIyKl2XEooOfxVCfrkAp58sUc/Mt?=
 =?us-ascii?Q?MZMab05a37miH0aewDXsVugv+Q3OuDyu0Vlr4i9h1RTT24ziPVZB/HRzcvmI?=
 =?us-ascii?Q?OKk6QpTGfJJpOVTvYHPkeCi/ct6NjGCDXxIQJefkxRT4bn4WjkoX1QtgRaBb?=
 =?us-ascii?Q?w3tNgRu1y6eetUnGU22Dkt9flIR1EmncMbgThZ9PmU0QbWIGpb/rbv9OXop+?=
 =?us-ascii?Q?GyLIJIpYISBbUl2c0FjNsp7pJOJ5D5qX3rG02omnG3/G/6K6mspwI44aWrQw?=
 =?us-ascii?Q?kHy8Izz1+rcxfiu87tV8rRQE+u9C2Wnd4eXsdQVxyQM6iiFOs47qK8cVRUuO?=
 =?us-ascii?Q?khkQeFsSBWqe2E9xCe3H7VQOw7N9aj+SNIv+tKhrpU+/l9545p5JMgjvzEcZ?=
 =?us-ascii?Q?qhbhyairAjyTx7uVhn8COiBf+FroZkNx8zw+K9ClMh0//tkRtjCCw=3D=3D?=
X-Microsoft-Antispam-Message-Info: CQ7guLEFStioeAIiZEK0NHCFrQ0DTHQAZsMiE9nZrGKx//upbzma807gge1w1jEYJhDwiw5oggIHs4TL4lUUxLqWz3N1KoFCiK52N2pjoSBtDq5/Z3rG1IlTYL9TRqweJL1z8YR92MhakSMqNHJ1pzecBsjmmdKs64LHVPvVK3/xA4H3H7yjomSpPLsO9ZHmmwQsMlAhxFxkntnD5XJ2AN7IcHwGLDy+5Iy5mxr5Tuuu0tLZMxmztwSWgBGvUeBuK6BrVfWf8zn9Sap1mNKdg5e36aNEuivmCrJLlOYFylCylLCKdKn7I5LSgWIRoUFPBhDelkmGlxBS/+JPpa1AABYykQlqrDp801S8xeXssPeIS+QwU3Edg9/Ax3yUhcuVB9dbe/+HCkkky9hxv9KkCg==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;6:mxkeiPijhCUh8sscd4PeFxqYIIapvbuO71ntQE1AXlPkFjgg2IMuyGATBY1RwoETL3KtmLZrqUaALCcceXT0qgZIezlYuVCWcd0YvCxU/HXVtC9Vm/89MPreYkRyeiHH4EsqkJWPMb1PKOHLP/GStg8DgA1hUX/GpKJfJtH4zApXqCHf8jORiBEa8F4+1fYYxQZaKjxR6mMQukj/pQo3XzH6Bcfg4VJX8sgNFZR1fRAJfLATe9rrUQiVcg/w9o99iD2XyJZc6NbdIR8POcHYx4yMeQprwMgXxzjAsg9bdh0bAwdtdrx2rzbzu6umPYMQJLZxiSQjtsa+KTTFUQKlUDNHKBcY6KBxhTkcwTg3WO+/k08T2TvkJo7qPyDwArbAjhs5iLSbZev/ADcKvsDkWTZBkd9FC2VW7+WmMod6sVmX0sOdvo03M1qSd5VIiqRP9e7EFvIGUf5oRPuqD0EuZw==;5:XVNxSfnDicsVq7I4iDQobRIcqripztUBYtiIMOGLEpOZM8LZNj9bnQb7Ou9dkO+Lug0fDBsP3YsfEs1Z4G2qW669+t682yjL6krEDrqP8Y8Ksj3lvGrXC9y6GJtHUqrS1oVSF4+6juKhnAWMeRkRQlftDGzmhnwcs0I4IkFw0IQ=;7:mtLduV+WUFIbiW3gANh0IYMnL99mT4FQ+0qUq1J6DN+99RnCHu1fQZX76dm8iV0k5oMmCTKZs5G3SAxq2DrZ1BgzTeFAnmu76K8m+eQ2D6C6kSXF0TsNaAaYy2m0KnRNbL3LYPwzRv1fCZhdfap4MvGEqBVSkdniNUuZvhQb34x1hG1UqKtOzF4jpIDSYnKm9dlLYHaIz27hL9wnimvY623E+Prue3adjwG4xuxitNoS0FOM5EPL1kdpojvl3jub
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;20:cXcFqWhGUaez4I5OQEQYKD26J7GvuWR2EROEzXoLTrJFpqcRlnRO+7dGCUAhOvZQ0janc9uFrw0aJ7Lre/wt5lB39DEYA23lpMRPPOtAvNxzCVbjiu7ycVxjE6a5T8sIdDMrdPOWGY5PYbc3cCw3FRhiq0iIOc3tiWwMB+ngh+CRkpCrm9Kl3r9c6FyBxBPQyPL9ss0GAFo9UedLl3pq1G7CYzOQQutFw1+acUx81uQC1WauaoWl7why4nGwzHp/
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:32.2516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03c0f7e-af08-4579-aeeb-08d5eda16197
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4716
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements TEST_MODE feature that puts the device port
into test mode. This feature is used only when device works
in HS mode

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ep0.c  | 39 ++++++++++++++
 drivers/usb/usbssp/gadget-port.c | 93 ++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h      |  6 +++
 3 files changed, 138 insertions(+)

diff --git a/drivers/usb/usbssp/gadget-ep0.c b/drivers/usb/usbssp/gadget-ep0.c
index 3b7066875d46..e03a34d11dab 100644
--- a/drivers/usb/usbssp/gadget-ep0.c
+++ b/drivers/usb/usbssp/gadget-ep0.c
@@ -245,6 +245,41 @@ static int usbssp_ep0_handle_feature_u2(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+static int usbssp_ep0_handle_feature_test(struct usbssp_udc *usbssp_data,
+					  enum usb_device_state state,
+					  u32 wIndex, int set)
+{
+	int test_mode;
+	__le32 __iomem *port_regs;
+	u32 temp;
+	unsigned long flags;
+	int retval;
+
+	if (usbssp_data->port_major_revision == 0x03)
+		return -EINVAL;
+
+	dev_info(usbssp_data->dev, "Test mode; %d\n", wIndex);
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+
+
+	test_mode = (wIndex & 0xff00) >> 8;
+
+	temp = readl(port_regs);
+	temp = usbssp_port_state_to_neutral(temp);
+
+	if (test_mode > TEST_FORCE_EN || test_mode < TEST_J) {
+		/* "stall" on error */
+		retval = -EPIPE;
+	}
+
+	usbssp_status_stage(usbssp_data);
+	retval = usbssp_enter_test_mode(usbssp_data, test_mode, &flags);
+	usbssp_exit_test_mode(usbssp_data);
+
+	return 0;
+}
+
 static int usbssp_ep0_handle_feature_device(struct usbssp_udc *usbssp_data,
 					    struct usb_ctrlrequest *ctrl,
 					    int set)
@@ -275,6 +310,10 @@ static int usbssp_ep0_handle_feature_device(struct usbssp_udc *usbssp_data,
 	case USB_DEVICE_LTM_ENABLE:
 		ret = -EINVAL;
 		break;
+	case USB_DEVICE_TEST_MODE:
+		ret = usbssp_ep0_handle_feature_test(usbssp_data, state,
+						wIndex, set);
+		break;
 	default:
 		dev_err(usbssp_data->dev, "%s Feature Request not supported\n",
 			(set) ? "Set" : "Clear");
diff --git a/drivers/usb/usbssp/gadget-port.c b/drivers/usb/usbssp/gadget-port.c
index 05a4eb2fd8bf..ebbff47e9455 100644
--- a/drivers/usb/usbssp/gadget-port.c
+++ b/drivers/usb/usbssp/gadget-port.c
@@ -192,3 +192,96 @@ void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
 		writel(temp, port_regs);
 	}
 }
+
+static void usbssp_set_port_power(struct usbssp_udc *usbssp_data,
+				  bool on, unsigned long *flags)
+{
+	__le32 __iomem *addr;
+	u32 temp;
+
+	addr = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(addr);
+	temp = usbssp_port_state_to_neutral(temp);
+	if (on) {
+		/* Power on */
+		writel(temp | PORT_POWER, addr);
+		temp = readl(addr);
+		dev_dbg(usbssp_data->dev,
+			"set port power, actual port status = 0x%x\n",
+			temp);
+	} else {
+		/* Power off */
+		writel(temp & ~PORT_POWER, addr);
+		dev_dbg(usbssp_data->dev,
+			"clear port power, actual port status = 0x%x\n",
+			 temp);
+	}
+}
+
+static void usbssp_port_set_test_mode(struct usbssp_udc *usbssp_data,
+				      u16 test_mode)
+{
+	u32 temp;
+	__le32 __iomem *addr;
+
+	/* USBSSP only supports test mode for usb2 ports, */
+	addr = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(addr + PORTPMSC);
+	temp |= test_mode << PORT_TEST_MODE_SHIFT;
+	writel(temp, addr + PORTPMSC);
+	usbssp_data->test_mode = test_mode;
+	if (test_mode == TEST_FORCE_EN)
+		usbssp_start(usbssp_data);
+}
+
+int usbssp_enter_test_mode(struct usbssp_udc *usbssp_data,
+			   u16 test_mode, unsigned long *flags)
+{
+	int retval;
+
+	retval = usbssp_disable_slot(usbssp_data);
+	if (retval) {
+		dev_err(usbssp_data->dev,
+			"Failed to disable slot %d, %d. Enter test mode anyway\n",
+			usbssp_data->slot_id, retval);
+		return retval;
+	}
+
+	/* Put port to the Disable state by clear PP */
+	usbssp_set_port_power(usbssp_data, false, flags);
+
+	/* Stop the controller */
+	retval = usbssp_halt(usbssp_data);
+	if (retval)
+		return retval;
+
+	/* Disable runtime PM for test mode */
+	pm_runtime_forbid(usbssp_data->dev);
+
+	/* Set PORTPMSC.PTC field to enter selected test mode */
+	/* Port is selected by wIndex. port_id = wIndex + 1 */
+	dev_dbg(usbssp_data->dev, "Enter Test Mode: _id=%d\n",
+		test_mode);
+	usbssp_port_set_test_mode(usbssp_data, test_mode);
+
+	return retval;
+}
+
+int usbssp_exit_test_mode(struct usbssp_udc *usbssp_data)
+{
+	int retval;
+
+	if (!usbssp_data->test_mode) {
+		dev_err(usbssp_data->dev, "Not in test mode, do nothing.\n");
+		return 0;
+	}
+	if (usbssp_data->test_mode == TEST_FORCE_EN &&
+		!(usbssp_data->usbssp_state & USBSSP_STATE_HALTED)) {
+		retval = usbssp_halt(usbssp_data);
+		if (retval)
+			return retval;
+	}
+	pm_runtime_allow(usbssp_data->dev);
+	usbssp_data->test_mode = 0;
+	return usbssp_reset(usbssp_data);
+}
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 59d7ef573d96..418bc5ad2a22 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1744,6 +1744,7 @@ void usbssp_stop(struct usbssp_udc *usbssp_data);
 int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void usbssp_quiesce(struct usbssp_udc *usbssp_data);
 int usbssp_halt(struct usbssp_udc *usbssp_data);
+int usbssp_start(struct usbssp_udc *usbssp_data);
 extern int usbssp_reset(struct usbssp_udc *usbssp_data);
 int usbssp_disable_slot(struct usbssp_udc *usbssp_data);
 
@@ -1836,6 +1837,8 @@ void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
 			__le32 __iomem *port_regs, u32 port_bit);
 
 void usbssp_udc_died(struct usbssp_udc *usbssp_data);
+u32 usbssp_port_state_to_neutral(u32 state);
+
 /* USBSSP DC contexts */
 struct usbssp_input_control_ctx *usbssp_get_input_control_ctx(
 					struct usbssp_container_ctx *ctx);
@@ -1867,6 +1870,9 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data,
 			struct usbssp_ep *dep, int value);
 int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		struct usbssp_ep *ep_priv);
+int usbssp_enter_test_mode(struct usbssp_udc *usbssp_data,
+			u16 test_mode, unsigned long *flags);
+int usbssp_exit_test_mode(struct usbssp_udc *usbssp_data);
 int usbssp_setup_analyze(struct usbssp_udc *usbssp_data);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
-- 
2.17.1

