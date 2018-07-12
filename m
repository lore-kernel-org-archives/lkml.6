Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7158C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649B821476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UCZEM0Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649B821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbeGLF6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:58:33 -0400
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:46609
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbeGLFz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX2uDSeuZUsu67R8UyMq9croZfZHA8d2icwj9LqgfxI=;
 b=UCZEM0AgCOoMA5EkbIKBwiTktPEMmMIqcWtve9lIk6fztutspRiqwysGHk/mUaQrBloXghMXcQb2PT7tgqxAM8a3x+hrp6uOIXR4iBeMGpIFL7C+UaV2J4powoUfNwVG4A9+x+DOELOdwJ7E+RyH9ukG3+kYll8HpidvlTeAugw=
Received: from BYAPR07CA0063.namprd07.prod.outlook.com (2603:10b6:a03:60::40)
 by CY1PR07MB2297.namprd07.prod.outlook.com (2a01:111:e400:c5b3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 12 Jul
 2018 05:47:59 +0000
Received: from CO1NAM05FT048.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by BYAPR07CA0063.outlook.office365.com
 (2603:10b6:a03:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:59 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT048.mail.protection.outlook.com (10.152.96.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw8032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:57 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:05 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:05 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lnbu029695;
        Thu, 12 Jul 2018 06:47:49 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lnpo029694;
        Thu, 12 Jul 2018 06:47:49 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 15/31] usb: usbssp: added device controller error, transfer and SETUP completion event.
Date:   Thu, 12 Jul 2018 06:47:12 +0100
Message-ID: <1531374448-26532-16-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(36092001)(575784001)(476003)(6666003)(4326008)(4720700003)(50226002)(86362001)(7636002)(486006)(246002)(107886003)(109986005)(36756003)(2906002)(5660300001)(14444005)(446003)(2616005)(426003)(305945005)(47776003)(87636003)(106466001)(8936002)(105596002)(8676002)(42186006)(54906003)(26826003)(316002)(16586007)(478600001)(11346002)(76176011)(48376002)(1671002)(336012)(126002)(51416003)(356003)(186003)(6346003)(50466002)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2297;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT048;1:VEm7bFk5eAoHc1kyh73VlwPyMl6L9116eRGtCRnM9dBS3Ylf5U9EsHqr+vW+MlTMmhTQQGu/qFDlGQPBS4M2qWHkrxciAHdex5EbfILhRCGlMHvlPs6KlAvGS8BaYoUW
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53a38de9-aa80-4668-c6ad-08d5e7bb05fc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR07MB2297;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;3:ODD9+/PF1DR/36VomZOknZ+OrV5tLgPY/iMNtlm7hP5JvfNXsytfZl68X0XMVwHrWkcM1BBwZLF238sO8sM9MBv5yO3nGr4kKpeIQ5YFMazx4dwAJCntAGOYBEseUtPTg3pI7RVmHgdLqJgyAzO/urLRgsxN+RBForh9ufaFD6Op31md7rTatLGiC2PUF8nrhF28tD0CLqshjjMo82rmKA8bEVitT/QC7q4OIOKIgw++WLminKirou/2+bEcBGrynsIuUsLf7LYRunyV+cpQyHNIoSYpRAkxSDx6gkl9YV20yx5pfIIosYVFngJda2wQOZRLbtidq4140EVTjEpKmi035Dp/v25XSfOat2ijU/Y=;25:iznS9gzjXuKLTvg8Uqt+zQtwOkEaYeCDgL7ACO++Sh2/nyODoQgSKSiQRQVn6uFDVG0+DT92SKe7ovPpIDE7+MZD0uX8CMEQdNbiFBRw/uD5WC8hgtJvWCFv50Jx3qO4gUiYDIb8l/LZaFomLCbeIgO67itn67YumLbn7eftrrJvWqUuw5l60myOkYUwsxJXp/WZUGCfC7ddBTBIdxmQcC/gmuFoIE0iAiOH+SS7kEVCzrsklzUBVcnxpcDdYUmxSQDVKIwKbN09RJT+njtzDTihO4/Bp1Me4/plS6peg6toUymaG1g5lNIdUlbhXu8Wbj36Io1MExlvzS2IRIl9Lg==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2297:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;31:9yeOQir6nZtkW0GWnCS1RtIs1WbLuixyujwfQq8WJqvGRPFc5kPKr/Mvo898zirW5SEzTS3rlbLOW5ZNUvdd6S+Sfl3Wd3F1C1RJcaseaqkkL4H0aaYWrH1rf9MPpKvw8Am3INE+I+yhJoj3I/dq5xgoEkCy+W3oa9lUAd/joFl/NObuZqkzoE/R91pqEKxMhJz5HFEGYn/+p8bQTbUnsYIyREUHitgmwedLYLTGrWw=;20:eC/NL+EtAtpCJrd2Zr+lwam8U7bGQE77Mlz+4wo5aBYALt42gyZLVRE5BIuqe4kHBRCEr4h8mtOmMNARNJiKcIiVpIF1joWy0F7wOMnizoMnl+D6G5ZMnBwNqggYkXMN4KIvWKopQITggeeU8D0p/aJ9VTRwzhXCjsS1lVb41Iqiynow9IJ65pG4LJfp9Jq/JvYvVkzmKvwG1iYRCsP3/kvRf9NJkDUSQQMwyAia3F0tbgHMubnlD/VgbtgWmbkvM8t4P8Cr2FPKMIvWCtpYk7We/9TWaHQm5ET715FksNaEWpYnAi2BiVb99xA1ShWQZzmuiDCx768oiUXQh/YgwLMOKEDSeN6IFJT67AMjO9kdLdutPDxa+bCTHHrkM35NDjGRmJFdXveA8bDPDGR4B2e3C7tjdwAfvrqCAuGfTat1KefKtixA6IfzhUj8vgwAeKlVdLKdMlJNFDviOJy0nCcoun2fChJMenryr9rKbUcxtWrcL4VIZvqN12lOGDjs
X-Microsoft-Antispam-PRVS: <CY1PR07MB22974C4D291B26510A06CF7BDD590@CY1PR07MB2297.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR07MB2297;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2297;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;4:XxVZnpkiKC/zt/PgHS5yCYfZ+KvPykpVoU+ZDBIWPH7Az2nFKBW1bdB50Lt3Av2M2TBKSx/FlT3LJMHfI6hIHHc6ET2jYPjzNJ7bYKJSHNLyYdzgU9BwYveIqPCDhUH4a7Kj3YfC6EO7wYaB9yNm0ETZtn+gG5nzYiK7gD8KZRZuq2375fRScdL2+HIyvFtk72sAxwD0X+TjEKnL3KpEhGt+JndcuIfs8IXaPbaTFw+wBrOGABfTlaKncONUl31t79+2WA8vzCiqRKEc5xPMU2p4JdGMcQkihSZt8R99h9LDsjRYUN+G6EStAnBAIEzL
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2297;23:Dw8ZXMkNgp8GFUGgCDyHVaPxsxQPjcrvlbbd+paxV?=
 =?us-ascii?Q?Ci0Bvd55BVNetNMDwCwcTFG6hU3//WKFp2CU5o4MwQxV0F0qhbc/ayt/winB?=
 =?us-ascii?Q?TuPzY5oC0/p95exJ+WZECOa+JDb/xZEbVpJDLwaCIeLvX0z+3F+oY/DxjPmL?=
 =?us-ascii?Q?R2a5FcHTp/BhkiQtyc2HNZLUof550hDyH0jhjJFFjFWrdudizUDWnsyuy28t?=
 =?us-ascii?Q?abCwH5LRI4krDkH7COVWoEHuxGiNZ3Og/VEM/gIVPdap3pokPxULZDS64Akc?=
 =?us-ascii?Q?CZI+k/a3aO5DnQV0Fc59RCXJbxOwjTDoWqdQLyygOjZ5Yga86FfEi95WE7QL?=
 =?us-ascii?Q?zXqIZRsU6isibPe2RcKUtOvoL0W8RqjYe4YouW88YZ5wBrIlGAtDN/mLZEOP?=
 =?us-ascii?Q?yFUw/nXg4sawLewEL1yujG8cVc+tWImRQr6xgMsryqjr3E3xIoSwZVcbkBCC?=
 =?us-ascii?Q?IEXk7/Zee9EKu6pZS+eF2/q8/2XjPMQCbxoXiXiNRLLBWo6x1scFdPGbEctH?=
 =?us-ascii?Q?hwbQ0vTIB5VDska02QHdsP6O49BUwwzPQFzwZZNGagk54HMRxj7q+MjyMi1r?=
 =?us-ascii?Q?O4Fms4EDU4+ue5UsLBBXz0K9UewB5wkYudp5D+kjmALR7RcyLKnNkztKHVQj?=
 =?us-ascii?Q?3wvDWZfVgVnvKVsjhbYsPNyC0jk7Wp+9wK4Kk/0+X4Di1drYZ789co5RTvco?=
 =?us-ascii?Q?SrJRgf5zfQ2YwKqsRaltzfBsyqoFxq15q0aGsIRrrcnpqMgLK1a4PGK4WaJr?=
 =?us-ascii?Q?54HvgsEWoV13CeTob1i0JTuciRO8rpx6Pdl++5RaidqLddGAMiDWO0vMlJfA?=
 =?us-ascii?Q?BHqcUjav8qkdk+QRwIIcU5dQZEmdMf8HcLVU8qGEwGudp8CfEEU6sVHtzSEX?=
 =?us-ascii?Q?XrbNjbuDnT56lNxlRaOfqGrIDqjJ697xsO9jqjE9bqXuGngvGLMnrr8FAN/W?=
 =?us-ascii?Q?1CoOoKmw8oF+RsbSNO4Iry2O9ohmMw66n4HLzPKWgyG6yfHLgFRB6+fJ+Cp6?=
 =?us-ascii?Q?1ybARV4oSc9MDcVO/hn4KBXZbLXfWjxx2WKcfrq4yLIDPRRFjMyOb8xUr9cK?=
 =?us-ascii?Q?Hjd80azCIBN7XE3KEXrtM8w15wbfMWUekaK02LHy4e8AvpOeBisy6YtPUviP?=
 =?us-ascii?Q?xc9KFPsNiW1S/eXiPox3gSV7ENLZW995VAsV8mv48q5Wf5WBI/Icc0q1kAIJ?=
 =?us-ascii?Q?y4lHecXsgOgIDhcCKq49Okj6s2iX/aTYqt9?=
X-Microsoft-Antispam-Message-Info: 6xAFbsFteLWGuuLb+weFZg/5CjRQ2ZLiJWepi00wmPqnQGEQsVPSfhyFOhnOvaeq7HDZ980O2MAVqYpRJkhz37Iatb23zS+pN10GNApZ0ywuJr2uwbjz6pX1Prmd8NKVqecE3HA86tpPyQfw2XBohbfJ/4KPgMOdWmYdR4LhDAb7kLDPe200z2E8mhSjCFArs/73F1Dj3iKP/vebgcyoSMYbTL5+LO+J3fthLA55Ru0rXN33YXlmrLg942XGX3TuwsaGdAM03nd9P3EOQWcSC5d7cOmECWHKYghSVO48Gf9VtaECswHQjX151K770ES8HepnNyzAG8zaa36Ewg0bLxyW38Oka3j2YblE1Km/ODlstam7ibFQ0OBv3K1UiuMVWH8kEBPKZprGqlojXdmIfA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;6:L4ccYFY8M5ldvRAvYHckb/JOJk2Pf91X6uzgM/1yi4NHMw7oQ7p0sOBF8mz6kHKyigRgkGo2jAFGlZmafAVeIV/gd2YLvRwWnFtQdovq1BwySZuJPGOoUybpwKbUC/r/QaPgiFjvkkL2fE97m1Vjlpj/4v0F5fLFtY24aJOXWMODW78W3Z11ReKTKtFrqRUiMZUoedxfKUKQBo4wrZPgiXpEzzLL5tVXHFHV7uryVfKgat40OgXSnfPHCIKppm11VJ/3CHIolW6aOeCq7/pQFTf+5B3y18ly3jtPWLBYLylZnRQalbV2PaTqKUCcmdmvmM54RAUXgPQIP5SesKjq9zakqKkdZrx9Z4s8ZIH1SSmaysUCaOKZBV7wTi+yS+H5STjDq5YX1lqRvuAhRD00+jf0Z42U0Q/vc+6TXx2QR7uq5EffHJO17TMaTFveDb7JDbJqNz4Ol0iEcT4nfG3KsQ==;5:KjRjRtyf/sL8Q8YnySiTHs178aYfDQZD0jb9O6fcBNYrMFuOhwQusV+cMv6lWvE/bKrSgno+Plb2sH3Vc8FDij+2QYOBDPNp/oVbEtQmLKy+c4CuufD7ekazdIgI07h0VLoKKx4rtByw6S+w2PYNdjygr2hDxMZWUZVMswzYUFc=;24:hKZmdDpIIA1J/MBqGh/IP5AAnupDtGFAzUv6w2jwWDgSeL3YuU9/rRUb11JPASVnWHauGqN9zxIi5gE2fTa9qkuhqE3KpW+zsD5smgZZD5M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2297;7:QAQs0ZzbuZwNQ5F/w0DkNjBl95ILLNM5Y14DLBfw94FIxroY21RlUK3X1C5Xkca/QTAjiAmMRkZc4Uv2lSTqi8ZBxc0XKJIKws43RLwkQObHnc/PyExDrSxyFO+VLyiNeCF2gUwBU1LmEIQ3zHTwhMReFZw6yoEqo8fYVmMLh5hNjYtOT1ILLmb7gwyHs3zGv4NJ0igGsAF2xnnQTDAOrcc9CikIov8zNBxOBQUHyK9P//qL++/mzG/X93vzuZnP;20:keDyVxx3IhmSCM8rWqDzFZ2E11A/F3a7Yxoac6VbL+RXRF0xHjxIlw8Xd+ZDUt/iyAEQBKJxBDy/QBZ3AR2VNLs+Psq8jVNHGtdVdNBgTVr1g9vX2lICw3sR/DXsZbh8/wbFpBAjiemmX77Iq/Yur0BIVfXp6NYrr2RmFxewefIkZKLCSZvVn333Qysk5KKZ3kCkXr0xfdEbbXU2ftTgnQOwyti1EwsiDqDQAudgtp4q+gYD0shhfF314lBaygRl
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:58.6583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a38de9-aa80-4668-c6ad-08d5e7bb05fc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2297
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds some other completion events used in driver.

The Device Controller Error event is used for detecting
Event Ring Full error.

Transfer event will be implemented in later patches.

SETUP event handles SETUP packet received from host. In interrupt context
driver only preserve the SETUP packet, then postpone handling
it for later. We can't handle all Setup packet in interrupt
context because some of them needs to call command that take some time.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 399084963e3b..28b807fbbc64 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -1069,6 +1069,18 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 	return NULL;
 }
 
+/*
+ * If this function returns an error condition, it means it got a Transfer
+ * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
+ * At this point, the USBSSP controller is probably hosed and should be reset.
+ */
+static int handle_tx_event(struct usbssp_udc *usbssp_data,
+			   struct usbssp_transfer_event *event)
+{
+	/*TODO: implement function handling transfer event*/
+	return 0;
+}
+
 /*
  * This function handles all events on the event ring.
  * Function can defers handling of some events to kernel thread.
@@ -1079,7 +1091,9 @@ int usbssp_handle_event(struct usbssp_udc *usbssp_data)
 {
 	union usbssp_trb *event;
 	int update_ptrs = 1;
+	int ret = 0;
 	__le32 cycle_bit;
+	unsigned int trb_comp_code;
 
 	if (!usbssp_data->event_ring || !usbssp_data->event_ring->dequeue) {
 		usbssp_err(usbssp_data, "ERROR event ring not ready\n");
@@ -1109,6 +1123,50 @@ int usbssp_handle_event(struct usbssp_udc *usbssp_data)
 		handle_port_status(usbssp_data, event);
 		update_ptrs = 0;
 		break;
+	case TRB_TYPE(TRB_TRANSFER):
+		ret = handle_tx_event(usbssp_data, &event->trans_event);
+
+		if (ret >= 0)
+			update_ptrs = 0;
+		break;
+	case TRB_TYPE(TRB_SETUP): {
+		/*handling of SETUP packet are deferred to thread. */
+
+		usbssp_data->ep0state = USBSSP_EP0_SETUP_PHASE;
+		usbssp_data->setupId = TRB_SETUPID_TO_TYPE(event->trans_event.flags);
+		usbssp_data->setup_speed = TRB_SETUP_SPEEDID(event->trans_event.flags);
+
+		/*save current setup packet. It some case it will be used
+		 * latter
+		 */
+		usbssp_data->setup = *((struct usb_ctrlrequest  *)&event->trans_event.buffer);
+
+		usbssp_dbg(usbssp_data,
+			"Setup packet (id: %d) defered to thread\n",
+			usbssp_data->setupId);
+
+		usbssp_data->defered_event |= EVENT_SETUP_PACKET;
+		queue_work(usbssp_data->bottom_irq_wq,
+				&usbssp_data->bottom_irq);
+		break;
+	}
+
+	case TRB_TYPE(TRB_HC_EVENT):
+		trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->generic.field[2]));
+		usbssp_warn(usbssp_data,
+			"Device Controller Error detected with error code 0x%02x\n",
+			trb_comp_code);
+		/* Look for common error cases */
+		switch (trb_comp_code) {
+		case COMP_EVENT_RING_FULL_ERROR:
+			usbssp_dbg(usbssp_data,
+				"Error: Event Ring Full\n");
+			break;
+		default:
+			usbssp_dbg(usbssp_data,
+				"Not supported completion code\n");
+		}
+		break;
 	default:
 		if ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK) >=
 		    TRB_TYPE(48))
-- 
2.17.1

