Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97952ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7E02084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="s6AOa3Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7E02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbeGSSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:37 -0400
Received: from mail-by2nam03on0064.outbound.protection.outlook.com ([104.47.42.64]:33957
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731733AbeGSSng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRYNrI8kSPvI83GmjCJ3Is9w9fyo6qpm6CwLBUelT0U=;
 b=s6AOa3Lwvp1ZIPHr0KtkvISC0ISHEEU7ZI10F4OmqeoQj4u2cChaeSiHfwLgIBW9fKpxWBC9q6NY5joaR0honSTjm0yt46NC7pmPpsnKRe1+n4NcZ1zwfj8W+Yl62hsYTbMUYziP0Ijp3s+0+aEqLOj5dNmoFNT+YbULrp7b3E4=
Received: from CY1PR07CA0013.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::23) by SN1PR07MB2302.namprd07.prod.outlook.com
 (2a01:111:e400:7a45::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:15 +0000
Received: from DM3NAM05FT022.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by CY1PR07CA0013.outlook.office365.com
 (2a01:111:e400:c60a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:15 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT022.mail.protection.outlook.com (10.152.98.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxARs019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:13 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:25 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:25 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAHH005674;
        Thu, 19 Jul 2018 18:59:10 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxAeg005664;
        Thu, 19 Jul 2018 18:59:10 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 04/31] usb: usbssp: Added USBSSP platform driver
Date:   Thu, 19 Jul 2018 18:57:37 +0100
Message-ID: <1532023084-28083-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(36092001)(107886003)(54906003)(316002)(16586007)(42186006)(36756003)(26005)(186003)(109986005)(50226002)(5660300001)(2906002)(106466001)(4326008)(1671002)(246002)(48376002)(8936002)(478600001)(26826003)(50466002)(8676002)(356003)(47776003)(336012)(87636003)(7636002)(305945005)(14444005)(126002)(11346002)(2616005)(86362001)(6666003)(446003)(476003)(51416003)(426003)(105596002)(76176011)(486006)(4720700003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2302;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT022;1:jSI3pbMxEYpQ1wgWIpzQ5VJE/EMRGZekCwgZ7u2J2PQh0ROYJ6HXxzsUYAxXZ9W8vaUuQZS73mbeHEdvjO2QeOgpWmwGxKsBNxXZfJ4H0pqzjmDg426cv8d9DB1nqOAJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfb56bba-6d76-4741-529d-08d5eda1571e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2302;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;3:yXaW5kWdkXcfVr4+Mx1d0WOOCDsHuWkDp+qJmdAIPCYaPW0v084HSc2sDQs2qU7sjRdmm5W6/U9Fuusiqarp4RbJPW5HuoIkVcM+6f0n+vVYe6CISbt+B7xeAhQZwsyR8k7FPJsJ2ltnPCrVW7GLif5c7qx4BJcTl0n7Uw84WE1x+O5TTkivjXgGZPBR578ySaY4+cH+HWeAxPABVtKZrMBLO/KwDrp42WBLGZE5EQmuHbNeDJfWwoNiJj+2f2fiD+NU7sNRm7p1fpUqV0fTqfzdHhbtH+I2aioar6uzvxfE62mBJkZ3UgfDMm0Bn/3SMSwZxxeqFqZeXaZbFW9FIefrWbobHEh3/7JU7M7Fk/I=;25:P/bN3HSul6RIQeE2/OpBpnWlXK2wy9W7e1w+JdMijCKw8UokKXoRV0BLSvkDPVMwP4ORcVn5szsFxGVej9L+AxkhlCTnSa9kXrhCivuqfXEHbRG7ZMEunh4REnISYy7huSwfqz/4b+Rn/wcqoaf2ervvmDsQUWkIWrvkjKEAdalkfnNBuTjSPkf9NvJQltbkcl+TZw/jsXN/g75fgHaz1QjbIbzCGuTSmBAsRWXXNXJCf87F+A+JsKV13EivGVEwl20EYEEamfDos7OzWFZy+QSNeVwX2UsfS+WiFKWWRutIKkQQPanpHekOswmh09/YQ/M+6qEfTKYLV/qkFtZcOw==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2302:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;31:MswrYvFRJoh0NbudyrIDf4e364AymQCJHF+etxmf5VPAgVigUNs67MFNF3nZbCRhCthhuw5L78YH0pWdmHVk2FgWfCXn+Fdo93ERfC73EYdMSzQtlbG0Eg7b8Qj+0kHAwRahhVp36dfqFPNQCyQjf2GVHhWn9elOP1ezEJloBZBsnBpgQFEkAwP385svA+8ASdzbl3G6K1RiaP/kxm/XaBrg+oLK+1EM9Nb8K7M/nmw=;20:QPlXXjmCwiF9O8rZDuftHnhF458tZJ0DTUcFg5uRMezQdUhnyIxqEZLy8gnez8l3F/E/lBwPuGb4dUbcFoRgXIVhlDZ8ZEZ/7y0WMZAV2dW5YIprVUfodNOzFJzt6JiR4O8mtVo8CX4VtAvIf1ARVfzVYlF88pYL7gDiZTg17rtnfQR/4us5RaL+VXI5yk3vPml955byec7Rb0l4G4Fdd/u9mrZrPVXhbj21vf/yv7bLmFsLNdqImf1JDExovpswmIIBBMd6msmrAg0gp8MT/LxS0/wNlB205MWS+EE9JGRHCMJnE1sJMWOFw/RTekKlu5xnmh4tVU3iRcshesiSlQxrds7pHt6rI081uX9ozkJebvTmlaGWQ0ALecY4l4UZfB0ARyGw2Vpk8lbn8iNmo7cB5w0btVD/0hzxruaO4/h1RWzAQYPs2PfOqWsmuYXIt8bAFvr3fnfs8CVcy/sbJdAoxpNvQOiVb4cJ2lXwM2ioUlefaN0b6/rW6v66oIn+
X-Microsoft-Antispam-PRVS: <SN1PR07MB2302FECF2717D266F6C25B0DDD520@SN1PR07MB2302.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB2302;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2302;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;4:rTowDTOGIOmu+FttVjWD9K7QnCT2G7bbaGiotj85B5al3/C/7SxNvHOCGBrfshTuc0G5Dtuak0Zo8R9VUy9q5J2vEb7HwXYUQFs1Ld9uSl6ENC2hS9okZE4ZazJLvetrvj7GA2NI1Pm1mki9hZddUtNfUVhf6ocZsnhsEhhOWPwHuD6wQ5SCdD9j8UdIZPLLdwMMZ6i8kVixy3m3dHP4Dn+8wNF/D12a6nQ6xp4Vcj4pK4A3lpsrSnPeV2tw1U+5V8FCZzz209tHmnHqP/igA+za7l7dawInsa9Dia6m839PsJHoOiufWvSkbzhkil/I
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2302;23:npxVVMspp9BEz+S35dGCg5qUrVRkKsXuiz58z3/KM?=
 =?us-ascii?Q?TP39QjyzLY9zvUlmxAiu4LcgGttv5dZj5Ql58dN67f8oV1ypr9UsEiYfUfLe?=
 =?us-ascii?Q?1TnwM6qPQDLCOdYUennnNPbNZQ8fHdNBOt8L/N8ozTJDVq/Z9XtxRs3CoM5E?=
 =?us-ascii?Q?fh2LZqVgogthJLyVxtbp9O5KvDCOn2zCKde9+GOtR3M3YbfzQ9jj/huVZLCN?=
 =?us-ascii?Q?mpB/eedbA9YIE8dN0LmOUtdftv9S2ehcIMm6ccom3wyitBT0AvmPwZ0yqAZQ?=
 =?us-ascii?Q?cFq0B1mJKaHe4ZAK9JuINn4ixBAZMtQX0PUP6xKrMR3WGWf9jV6UAOs0Y8+A?=
 =?us-ascii?Q?lrHGpW9fzxkHg6FmpmFgrmOuhPQ95/uKwUqdBHdL3fteGiwPHVYihCB9DKG9?=
 =?us-ascii?Q?FKC2w2plweRsohHeegsPQ5vqT6X4jis249FWse4WfSltJbEQl2oUklskeCcF?=
 =?us-ascii?Q?r2QLRO6h/7MV6DLlzpgGSUJ7f20YPx+ZA/vrSEcrxV3pIylpnm+ZNtJy3UqA?=
 =?us-ascii?Q?VWJ+0mt0CeKtMM9z0iEMT+CwqliHxUTd3KYE+M5nnuZqzii2zYYI2CV+uKLn?=
 =?us-ascii?Q?K+E0V2VOksvod9pTmkUVIH5tLIjLO6xd1SJDr/xpPihc6AKaHEpy+yhVB2fq?=
 =?us-ascii?Q?MJvkFRLCNFCH6/CgPs3YBycwJ6i0efFOF383t8bd9gpHC2dxrPWNPaexxeku?=
 =?us-ascii?Q?eOYrld8zyJjgvGXEhyIoFKSH2iFZbsSeieHhHJFw2r9YWacux8cHkQE8Z8H7?=
 =?us-ascii?Q?cFnaP5WZob08U3JoGyrjGHXM5HLgVE9v/pHLUxtcMmbtYYdeC4HOa/B/oHna?=
 =?us-ascii?Q?+NeYECgtQMcjzuMtquWk0rGfarFYgXGeaaX5EOevNSWpbwFKlePRN1770qO3?=
 =?us-ascii?Q?0+TrPYK+YTaE0EMa9E9OxwRXr/iMOa1Oxblft9PmJigClm//9KYEacotyuBY?=
 =?us-ascii?Q?qHgzSVTExj8lTJj705t33l9hmKaF4BqKaHNamRhqk+sA9RScctBfvP9JEc7N?=
 =?us-ascii?Q?aT1GZOT3dqT7GCDLeIBrPuYej7xCUIYJ1pGcOTIkFRfAYfZsUbUK+kYBjnGD?=
 =?us-ascii?Q?bigKwYQiQKSZq85Zh2ScP7o4JLD8N9cgdDJHCmIdwy0wNOsfBgUPTw8R6zFG?=
 =?us-ascii?Q?rWrgw8JP6xwsEf0B5ETcKUQsjK9cNBS6XLwoESKC6FouFV3AGgAtg=3D=3D?=
X-Microsoft-Antispam-Message-Info: e4msY+A55pKnSDQwG8dm5kdTcDj47nDy3g3B8SwvxEQEE6n+JZreCcJkDt39d6deZfplvpDD7nuXEdwY8zy5Lrt6T/8hbqC35Fd1NnsRJXb8cPn12h0wJU8gvFnCZR2p6MkHkhUIzyouR4M0wKsgijHpMVUUTZikXuUCpyfMKKhjDPeTzRH5rYdKbCV6Jw6keXHIf2ORvf/8QGRgmYTs0jpkWsvijdM8FZiZnrP307cd4U7zBWHyYIxpQC5LtUDcngQ6GslLBsM7qVSfDdju/GfE6eKMpXe2PnQNSkbwRXHtut+a+gLUV5EmqTNf8cCTtYneQf+vF3w4Auwm5qdGDwyi8iMduWFy7t6y79nEfOdDlEP5l8YneCfM/RX+eiY148CRCUmv7G76TcFYZkE4vQ==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;6:rCV42rfI0ALFfral8S8zXdheVNrSjpKZSJoNaU8qkxH6lUf9pdSDYtWTw4bHdlKdolw+l5rkZ1iog5UhoFeKUYXvBOqWaoQnNbVPgEmbOHQsafDZoRdIbNPko5k3a7bc1EnRfSpK8LCqmJrXfHimunHnLe4l2UPyyDCNDD0wogOR8jwN4zdXkEx+JpVdv4o/2gW2OimNajFUWn2/ItdU1U1jUi/aOaOzdKreQ2OBfCq+79W4gPcTXSOPAn2xDDaSj33OmK9F7nuf5dJJor+nVoFT6z4USfE0mDF7GTUXJ9M0ZFYvJC5ai+2N9eB6qWml4hnlt5tJ1YdXDiwl5CS0i7q2Z96VfaRJgUPO2lT5DJr9Es0fbXrL5VjORUjeZJKd9RdtVqkpsNfyD2iPuhAHW5Q3otWWdnqXipy3JNTx+csG+HsKHSrSovDmGzqQlALQvnXQIWfXRh9pvtAe/0MWGQ==;5:uWXJ+QCAKV3yLi6Thyc/0Z62io+BZAnOn65EAJigYrohffpGo/yw22+ZePuZGxnj6YlEJ19zupPqCQD1ec/b96XwXk9mIHDH1HW3Poom8suvjlSDTFq3xcIvjIYK1MTFscLtQPNfAuUtkY0FzsKlro7Ppsq6jU8QCIMa7fetjEI=;7:JKAXEDcjiGZZj19vcJLY5nWcpntMeBU/k2/zWZvb0w+9aMj7ZG3na+XHqf5qgkdon54iQQaCD8DXeX459yM0qiYeYbpOg5qlwI8pkHl22cvOfOLKl9VyO6DbPPIF7SeiM8tJ7CT7J5nXp7rXU0CAsfgKGjLIneWexM2scCm1v7SlRi4o23WPfU3ITLKz+inzyMTCrtAGDwl5CZmqTkahhqdaTLh/b30uiMYepfa6FwXY/Bop7xzu5FnknS7qPthC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2302;20:xNSEOcL2T7H+GIGU8HapQcvjdsWebYgYBBWwwmL1WneS3LigO3wYZ2/FgWbpwhYN2AcisnDLsG23guoqjXqtEzWrCuKsmoeSQofesJl+I8+9GlxB+djr7JYYQMgVYVmI7rg6JjUVPbbz0M7MlG6xzn+gFTO+aR+uqPEnApMTJPcscupMt4QwDcGM4tK4UI7SF9h+4m/qajdn7gi3B2v39MLT2V/BcKHMtVbPJNRn4MOH1c8wxKpsEiavkULFDUAm
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:14.6790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb56bba-6d76-4741-529d-08d5eda1571e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2302
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds platform driver that is entry point for loading and
unloading usbssp.ko modules.
It also adds information about this driver to drivers/usb/Kconfig
and drivers/usb/Makefile files and create Kconfig and Makefile
files in drivers/usb/usbssp directory.

Patch also adds template for some function ivokked from
usbssp_plat.c file. These function will be implemented in next patches.

This patch also introduce usbssp_trb_virt_to_dma that converts
virtual address of TRB's to DMA address. In this moment this
function is used only in gadget-trace.h.

From this moment the driver can be compiled.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/Kconfig              |   2 +
 drivers/usb/Makefile             |   2 +
 drivers/usb/usbssp/Kconfig       |  21 ++++
 drivers/usb/usbssp/Makefile      |  11 ++
 drivers/usb/usbssp/gadget-ring.c |  48 ++++++++
 drivers/usb/usbssp/gadget.c      |  64 +++++++++++
 drivers/usb/usbssp/gadget.h      |  16 ++-
 drivers/usb/usbssp/usbssp-plat.c | 186 +++++++++++++++++++++++++++++++
 8 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/usbssp/Kconfig
 create mode 100644 drivers/usb/usbssp/Makefile
 create mode 100644 drivers/usb/usbssp/gadget-ring.c
 create mode 100644 drivers/usb/usbssp/gadget.c
 create mode 100644 drivers/usb/usbssp/usbssp-plat.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index f699abab1787..dc05f384c34c 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -110,6 +110,8 @@ source "drivers/usb/mtu3/Kconfig"
 
 source "drivers/usb/musb/Kconfig"
 
+source "drivers/usb/usbssp/Kconfig"
+
 source "drivers/usb/dwc3/Kconfig"
 
 source "drivers/usb/dwc2/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 060643a1b5c8..b1cd5f83d440 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -8,6 +8,8 @@
 obj-$(CONFIG_USB)		+= core/
 obj-$(CONFIG_USB_SUPPORT)	+= phy/
 
+obj-$(CONFIG_USB_USBSSP)	+= usbssp/
+
 obj-$(CONFIG_USB_DWC3)		+= dwc3/
 obj-$(CONFIG_USB_DWC2)		+= dwc2/
 obj-$(CONFIG_USB_ISP1760)	+= isp1760/
diff --git a/drivers/usb/usbssp/Kconfig b/drivers/usb/usbssp/Kconfig
new file mode 100644
index 000000000000..ee20b01753dc
--- /dev/null
+++ b/drivers/usb/usbssp/Kconfig
@@ -0,0 +1,21 @@
+config USB_USBSSP
+	tristate "Cadence USBSSP DRD Controller"
+	depends on (USB || USB_GADGET) && HAS_DMA
+	select USB_USBSSP_GADGET
+	help
+	  Say Y here if your system has a cadence USBSSP dual-role controller.
+	  It supports: dual-role switch Host-only, and Peripheral-only.
+
+	  If you choose to build this driver is a dynamically linked
+	  module, the module will be called usbssp.ko.
+
+if USB_USBSSP
+
+config USB_USBSSP_GADGET
+	tristate "Gadget only mode"
+	default USB_USBSSP
+	depends on USB_GADGET=y || USB_GADGET=USB_USBSSP
+	help
+	  Select this when you want to use USBSSP in gadget mode only,
+endif
+
diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
new file mode 100644
index 000000000000..d85f15afb51c
--- /dev/null
+++ b/drivers/usb/usbssp/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# define_trace.h needs to know how to find our header
+CFLAGS_gadget-trace.o := -I$(src)
+
+obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
+usbssp-y 			:= usbssp-plat.o gadget-ring.o \
+				   gadget.o
+
+ifneq ($(CONFIG_TRACING),)
+	usbssp-y		+= gadget-trace.o
+endif
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
new file mode 100644
index 000000000000..d1da59306d02
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/irq.h>
+#include "gadget-trace.h"
+#include "gadget.h"
+
+/*
+ * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
+ * address of the TRB.
+ */
+dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
+				  union usbssp_trb *trb)
+{
+	unsigned long segment_offset;
+
+	if (!seg || !trb || trb < seg->trbs)
+		return 0;
+	/* offset in TRBs */
+	segment_offset = trb - seg->trbs;
+	if (segment_offset >= TRBS_PER_SEGMENT)
+		return 0;
+	return seg->dma + (segment_offset * sizeof(*trb));
+}
+
+irqreturn_t usbssp_irq(int irq, void *priv)
+{
+	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&usbssp_data->lock, flags);
+
+	spin_unlock_irqrestore(&usbssp_data->lock, flags);
+	return ret;
+}
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
new file mode 100644
index 000000000000..2f60d7dd1fe4
--- /dev/null
+++ b/drivers/usb/usbssp/gadget.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/dmi.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "gadget-trace.h"
+#include "gadget.h"
+
+#ifdef CONFIG_PM
+/*
+ * Stop DC (not bus-specific)
+ *
+ * This is called when the machine transition into S3/S4 mode.
+ *
+ */
+int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+/*
+ * start DC (not bus-specific)
+ *
+ * This is called when the machine transition from S3/S4 mode.
+ *
+ */
+int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+#endif	/* CONFIG_PM */
+
+int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
+{
+	int ret;
+	return ret;
+}
+
+int usbssp_gadget_exit(struct usbssp_udc *usbssp_data)
+{
+	int ret = 0;
+
+	return ret;
+}
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index b5c17603af78..55e20795d900 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -9,7 +9,6 @@
  * A lot of code based on Linux XHCI driver.
  * Origin: Copyright (C) 2008 Intel Corp.
  */
-
 #ifndef __LINUX_USBSSP_GADGET_H
 #define __LINUX_USBSSP_GADGET_H
 
@@ -1676,6 +1675,21 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
 {
 	lo_hi_writeq(val, regs);
 }
+
+/* USBSSP Device controller glue */
+int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
+int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
+
+irqreturn_t usbssp_irq(int irq, void *priv);
+
+/* USBSSP ring, segment, TRB, and TD functions */
+dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
+				union usbssp_trb *trb);
+
+/* USBSSP gadget interface*/
+int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
+int usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
+
 static inline char *usbssp_slot_state_string(u32 state)
 {
 	switch (state) {
diff --git a/drivers/usb/usbssp/usbssp-plat.c b/drivers/usb/usbssp/usbssp-plat.c
new file mode 100644
index 000000000000..c048044148aa
--- /dev/null
+++ b/drivers/usb/usbssp/usbssp-plat.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/usb/phy.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+
+#include "gadget.h"
+
+#define DRIVER_AUTHOR "Pawel Laszczak"
+#define DRIVER_DESC "USBSSP Device Controller (USBSSP) Driver"
+
+#ifdef CONFIG_OF
+
+static const struct of_device_id usbssp_dev_of_match[] = {
+	{
+		.compatible = "Cadence, usbssp-dev",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, usbssp_dev_of_match);
+#endif
+
+int usbssp_is_platform(void)
+{
+	return 1;
+}
+
+static int usbssp_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct usbssp_udc *usbssp_data;
+	int ret = 0;
+	int irq;
+	struct device *sysdev;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Incorrect IRQ number\n");
+		return -ENODEV;
+	}
+
+	usbssp_data = devm_kzalloc(dev, sizeof(*usbssp_data), GFP_KERNEL);
+	if (!usbssp_data)
+		return -ENOMEM;
+
+	for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
+		if (is_of_node(sysdev->fwnode) ||
+		    is_acpi_device_node(sysdev->fwnode))
+			break;
+#ifdef CONFIG_PCI
+		else if (sysdev->bus == &pci_bus_type)
+			break;
+#endif
+	}
+
+	if (!sysdev)
+		sysdev = &pdev->dev;
+
+	/* Try to set 64-bit DMA first */
+	if (WARN_ON(!dev->dma_mask))
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(dev,
+				DMA_BIT_MASK(64));
+	else
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
+	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
+	if (ret) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	usbssp_data->regs = devm_ioremap_resource(dev, res);
+
+	if (IS_ERR(usbssp_data->regs)) {
+		ret = PTR_ERR(usbssp_data->regs);
+		return ret;
+	}
+
+	usbssp_data->rsrc_start = res->start;
+	usbssp_data->rsrc_len = resource_size(res);
+
+	ret = devm_request_irq(dev, irq, usbssp_irq, IRQF_SHARED,
+			dev_name(dev), usbssp_data);
+
+	if (ret < 0)
+		return ret;
+
+	usbssp_data->irq = irq;
+	usbssp_data->dev = dev;
+	platform_set_drvdata(pdev, usbssp_data);
+	ret = usbssp_gadget_init(usbssp_data);
+
+	return ret;
+}
+
+static int usbssp_plat_remove(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct usbssp_udc *usbssp_data;
+
+	usbssp_data = (struct usbssp_udc *)platform_get_drvdata(pdev);
+	ret = usbssp_gadget_exit(usbssp_data);
+	return ret;
+
+}
+
+static int __maybe_unused usbssp_plat_suspend(struct device *dev)
+{
+	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
+
+	return usbssp_suspend(usbssp_data, device_may_wakeup(dev));
+}
+
+static int __maybe_unused usbssp_plat_resume(struct device *dev)
+{
+	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
+
+	return usbssp_resume(usbssp_data, 0);
+}
+
+static int __maybe_unused usbssp_plat_runtime_suspend(struct device *dev)
+{
+	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
+
+	return usbssp_suspend(usbssp_data, true);
+}
+
+static int __maybe_unused usbssp_plat_runtime_resume(struct device *dev)
+{
+	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
+
+	return usbssp_resume(usbssp_data, 0);
+}
+
+static const struct dev_pm_ops usbssp_plat_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(usbssp_plat_suspend, usbssp_plat_resume)
+
+	SET_RUNTIME_PM_OPS(usbssp_plat_runtime_suspend,
+			usbssp_plat_runtime_resume,
+			NULL)
+};
+
+static struct platform_driver usbssp_driver = {
+	.probe	= usbssp_plat_probe,
+	.remove	= usbssp_plat_remove,
+	.driver	= {
+		.name = "usbssp-dev",
+		.pm = &usbssp_plat_pm_ops,
+		.of_match_table = of_match_ptr(usbssp_dev_of_match),
+	},
+};
+
+static int __init usbssp_plat_init(void)
+{
+	return platform_driver_register(&usbssp_driver);
+}
+module_init(usbssp_plat_init);
+
+static void __exit usbssp_plat_exit(void)
+{
+	platform_driver_unregister(&usbssp_driver);
+}
+module_exit(usbssp_plat_exit);
+
+MODULE_ALIAS("platform:usbss-gadget");
+MODULE_DESCRIPTION("USBSSP' Device Controller (USBSSP) Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

