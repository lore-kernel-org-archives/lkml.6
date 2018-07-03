Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2DDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A1621F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mbHPRlXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A1621F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932310AbeGCUBA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:01:00 -0400
Received: from mail-eopbgr720081.outbound.protection.outlook.com ([40.107.72.81]:35744
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753068AbeGCT6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lDWWp5QsQ13XSnnvaZ0KGgrIvScahQe5s27K9jxr88=;
 b=mbHPRlXj260kCFMcnBcJBcp7TTbyzBKbP5NQ1J2UuPajbdKDPzBZbPJ1eXUJ0+FkcJ9GxJS5lx/nGF+vMtZECUglIeldu542aEAGFKOQF2AL3vqeIByOxdDOZhINc96Ac6NDK3cmgyGTIQXpf9rx5sQVeARa1XO0E1JYh7aRbdU=
Received: from SN1PR0701CA0056.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::24) by BY2PR07MB2294.namprd07.prod.outlook.com
 (2a01:111:e400:c50d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Tue, 3 Jul
 2018 19:58:27 +0000
Received: from DM3NAM05FT003.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by SN1PR0701CA0056.outlook.office365.com
 (2a01:111:e400:52fd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.18 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:27 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT003.mail.protection.outlook.com (10.152.98.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMs5006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:25 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:39 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:39 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMFT012216;
        Tue, 3 Jul 2018 20:58:22 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwMr2012211;
        Tue, 3 Jul 2018 20:58:22 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 07/15] Introduce Cadence USBSSP DRD Driver - added gadget-if.c Driver implements interface between gadget drivers and USBSSP device driver.
Date:   Tue, 3 Jul 2018 20:57:51 +0100
Message-ID: <1530647879-10007-8-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(199004)(189003)(36092001)(486006)(69596002)(50466002)(48376002)(26826003)(478600001)(5660300001)(81166006)(2906002)(36756003)(8936002)(81156014)(8676002)(14444005)(356003)(50226002)(305945005)(68736007)(53936002)(97736004)(186003)(107886003)(16586007)(26005)(42186006)(316002)(51416003)(76176011)(105596002)(54906003)(106466001)(110136005)(126002)(6666003)(2616005)(476003)(336012)(4720700003)(11346002)(87636003)(446003)(426003)(575784001)(4326008)(47776003)(86362001)(217873001)(309714004)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2294;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT003;1:Z6njkLrWm+98i7M7xpNPijoKJddI6ohpd1wy93AApwh62a6c6WfqtuFHJcs7BAgChEO7VmA8JtFs5bK0UCU6fVGOrBv/wUbpH8bZiCB8UaIeQeK9ROSCGeQmM3+zvK8t
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ad2e37c-c4f9-4392-3de3-08d5e11f5761
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR07MB2294;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;3:iIuIKdeJGmtZeDi+WHJQQmycavZ/E3B42RCB0yNSCzrLU6Bwi4+3D6/KZKVvAU4TcA9dpY2MQCdo3P6tsoz3uAswMDJ2PUj15gSXKflyOHYq1H+Lz+UjMaWB0M8IopNr7QrE0jkTtdK81UB3DXpiPWZPdPZ4bTH1XhNF/6ah/sLYm1GN13jkCozqRayNYu2fDWL0bry+Kv1bJZ4r85BXo6ACxliBZcXKC3WXhvMRDxMhlvUuy3pj7YEguWhHz7I3nMQuJGJ8ht0dRQ2sOS7B5myVgOLVzaof9BaNGhpBt5pb2U/+jTnZBlvPgidNGlmbwQCAxNMGi8dQsSLMth+S0Q==;25:QRvLCrw7qweWZoZ+G6MiSPqemh94wHrzZHE8ijKfmOvxYZ3smyoM5VoeMMppaDBbJcwL506gt9d2r6oncbFLCqXqqri1LEnrl5VyYotiuIOmNRW1cZym+nc/Dv5ZVsFIBVxM54PYQOFWhObkdkwSt33SyqiOL2HJL5ROn6/5BWidPrMEXxeBTqvnB8bSJLcGt49weoaBmV72ji1R5zQ0U88GcRUmeY8P3Cbx0VQROitrGmddjAJWpbdaZdAoF2dBblTLs1PfyUyrDU7e+Xa0XPyvz0ajHisQs92U02KLnc74KAM6n/h5QjHZmAc8tix2IgSctLwdcLl+htGjYRQ2Iw==;31:nokPE2DEm2oyVKFXiY1+Z/psDC+u0PpbOlQ8EKfxIeMjNMLboM17nPrWfznumautFMgJxrXtVsTtRFVczh63kiN/PQCwL1HByLsTecZjguLUNkPvHBrMQvyrj9BC5ke1lQPK4ogzSD+bXvwFeYxPa0Qoru+wLQOPRxqgDnxaOSYjDXixHFIGWsiBs4EhQTaCIbOM+/ZOBaSmgiFqzLrtrcXU18QA1dSRXiLJcEW3BZI=
X-MS-TrafficTypeDiagnostic: BY2PR07MB2294:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;20:omfGlL3LOAiyxOBndvNIGPxpl4RdabhM30uiINO3gljOTwsV64bDxSuYrEiXsVzCvxz53tOfJ6BOiVur45nBd5muzT4X1PaKcbmuJIhN+hRFlaTeIvGmAbqiXUtbkyB5PG4Y4jnkyAgvlAU0yiyl3AGeZBHgebak/UZdTajW8smt76DPGuBFr2B4Hnu1VKxgn6UzSP/0nESXH2C51bl3vehEvwTg7QBfzKXZK3+TicPssLeIiJ7JuheMQ/ioUrbRI+QnqLSIwT/QXPuS5QiUMsuR7lU+YBiOyO2jWdwE3cqwZGa5Dl2lsET2S1rFHvyuL5dbULr7pfHjJcJTNWuo0MOQmXXacpTT4UhUhCpK8VI4Bbk5DDkRmScjQQKGxw85VLl0zzsDXBjdlT+aH0mdJnooXP4RKL8xZ62kCKSKT6Vim5C9cRvdZvKOmpIYpvt3xDjDGwz4h+WLlS40uDeAjVEIi0fcSLTHeIBcpyHDYpe7OQsieHXtdbVy7vQf8dpI;4:1U4TKaD3UoAXEPsUOK1X1uxEYtFj08jIRIafrY13OeuJgfm5X31rJdy4v+D1ndE2mW7IaCPiaRcZC1NupSTAOPgRpZDBQ75MfaOB1rrvb4bRZCaM/Xxx+GwzFuip7rsKbzauy03tgBxUT5BoMUAPMdpXmqMXA6dNpNaPTAikHXJctieAk7G/wAgBb32D+tEEyv7jSoivsGvFbkGor54Ref1dXS/RA9Pi3JJOIxXknpZj+kFt30jO5MB/DkSpvvzm5r+8ZQHDkhMUp7bzC6rRpiV82YkE21fZ/ag37M/Wa7/+msMkzZb/WfmDfv9HPR7t
X-Microsoft-Antispam-PRVS: <BY2PR07MB229456B2FFF354F9E8871CBDDD420@BY2PR07MB2294.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB2294;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2294;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2294;23:+CL6Fj77htjXfpF65QxElEXtskXpozMDEiws5ATlA?=
 =?us-ascii?Q?sZIm/WH2HUD7TsqeTId1HkW+OB7U+G9ClIckuBuaR8zWyKDEyJY/9YlHLMe8?=
 =?us-ascii?Q?2kTFmlsdinFzQNDZsNWzbQ61rxkZoFIC/1/4Eefox7q2jwz4ttMPI3wK/Un8?=
 =?us-ascii?Q?1orkbpcZpBulGBKOUtEPqksRxrLviM9BC4LKtDuwwxwNbjXlv8OYTsk6eHE/?=
 =?us-ascii?Q?dBuuWrRLYfmBc9+fgZyYkER4Du9XCWT7q4glDKVytcApJAYNU4EpY5OGtk69?=
 =?us-ascii?Q?7sY/oq7bWzrv786Z9S/kIJPX5iSBJaAb+Ek7Dz6ytysVPjyW0g8fM+D3JlPm?=
 =?us-ascii?Q?VTKrki4Z/XblQwJexRg//7WLegZeRrlOneNm1uN8/CmN2uLGbPnyMpNd4TwC?=
 =?us-ascii?Q?fUyXXrO2S7+4p5Jkt5sbOheAF5lZsjE733Vm7OfdU5iqzYsJMR4+UFBXnxNV?=
 =?us-ascii?Q?HZEWAwI7epQ/74R1oXsKA6b47P227vYDKV/aHCeLA53S05YEMJTZCzQ1zUyW?=
 =?us-ascii?Q?jheYrfxJ0oOF4f+ME4tV3rCHuLoeOqL7r5tM/apiY7Lujlv5IPWBcVl8QXWn?=
 =?us-ascii?Q?27lIiWvBZ7d/P2DfM2a7diERQfdNND2XoTlKNiZ54Cw5wYUZbYDzRlAojLVa?=
 =?us-ascii?Q?11ILepbXkTpBogkWNZOGGoPVK2q+mLYbTuWD9mE8hyozhBfABPoACMLkCt5p?=
 =?us-ascii?Q?Ax56wxHcyzKnF1UDH35cju+6JPLLl/xO8rIOrXZUM8wGK4lmXKvZkuO1q0EC?=
 =?us-ascii?Q?6KMD0EDg5wlJw5ywwZexYRjbBjUR2gFRTPtu0WnTXveHHERUj6b9GpBcwv9u?=
 =?us-ascii?Q?LbrUMGRUzlkeJh6LMaUHyrujtKwCc2atpMrzTO73tij+e5XRjT+aQtJbjztk?=
 =?us-ascii?Q?hjvMhk+DcPAVW+vHAXVF0cnF8y7KKY/YV7g3VAoTARg8wpHyRCIf/hci+qJ5?=
 =?us-ascii?Q?237yLMX8s3+/So7TE97nTvILpFPHin6lfCekqbIXD3NFrMGWvVmGm5n7saXu?=
 =?us-ascii?Q?12z/COoaV/YdcIzsyrcYoYDqZSpEUfiREBfHLEu8/lBW6xspSsjD92SAfsx1?=
 =?us-ascii?Q?iC10SpHuwKiNQdX40hv40N3BPMJKkTVjbupyAaUf4mm7gUpH5ElKiDlxf9bH?=
 =?us-ascii?Q?XfLXtm+UJ9mbZoKC6jftMVqgzy4YObP6BqbNFKsDFedHek5mm1NMW0P88a12?=
 =?us-ascii?Q?iQkDsKA0bWNVHkKK2QgGrkJJmiE+Kqq2B3Nvvxt7SA5dCci668VZ9b7Zwnl7?=
 =?us-ascii?Q?7fZDjSZmS+kOH0gWFVOf49Om1vWTwiUsp3T6UOR5lFNqfSUbeOuoTJeGJZ/n?=
 =?us-ascii?Q?K18zcBhCpMETGRWr25nijE=3D?=
X-Microsoft-Antispam-Message-Info: pbP4lFwNDBebQuAtrryJ56Qw8CWer1vha+YPLBMzgGbNMrLZCZBQ1+kI0VbMwnRLrDP3rKlvnm1CkAMho/WYC0pZKXk1wuUwOCt9LoBGu/r6dLmltuVrKVNS4aKNkE3Mamu4Ph7kj9o30f3ECCK0Z5fR4p/Y+ajDkzsDEYgKjRK5tRWxqqxTMM+NJtsBtzT3pXrpmWUKMi4UDDm17vG5IgaeSfh8LrXkY7zjuqPFCtK/wT052filSO4D2R7UG2zLET6ZMGRH3L8jhxRo7EqD56UnRgGr/jnGZn9wT8d/2gZ3tilqGxAS2/i7Hx5ckfmoAwkp2mH4oaakobwGzUbasE7XdKOaRWj7rrIZDqsnTb3GE9g7xJC86X7Pb64cSd97p5ab9MuYQc7XBtmWicfpRA==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;6:HWidlOpzmXkn/lCyeqKesc8giH8hZApvNj5fYTSfmneP3WTHEXbQn3hqNocAlV2Cl3FKCq/h6Jpciaw6sEK8Thjdkx7QayUdEN1TKMpiuBpMgbg9Qog8JaWTPonJ4/jsY35ngihACj6ANS4SGJTXjNBhmza1LngsXVG5pq/wSOFpbymP7wu+ypNhixC/l+NeEfTS/ASNmXu4qF7MzZnUt4Zu8jkB6F72hWbmd3FQePKDmovBwzUjI31ZnyGvFXXU937ujEFtaMaHxTdIG5Z21fLSQ2QNh2nhTeDClnolxzweehrh8kBSWEjiu0+FsdcX2K950wS5fnA/iGQKrJy20XF7d8bdOxuY1Epo9UAEhikUr80NVTeKlinJzhe1UColckn/QV3/57CpYWIBeYW62UbSPru1DzKsG6OknYZ1cA3eBCeMlypDhqKrojeYG13nEgTuskwQRAtbRcEWoJC/0Q==;5:YR6PbthZFe77ct/bPAqPBNBOjiiayHScAtCfpaGfI+gg2eCCcdulpd+39BxXnzZixRQD4K7K7DttR6yCro6xv/Joqm1R9H96fFS3b5Yo6phnL1BKXOQCBC9EUzJJHA5OX9fwYnWvM66KQOA9a2Q+HvrQFGeIopVgRsvCJGSwsAw=;24:7DN7jSggBsGqa+UOfK3R/WaBk/qTvhJiqMDFtsY3KX2+N0ZBRfiC/ym+zXVhG/364t/gVqGPnxF8O4SjXTd45Z4LeHp7wpDfq9xavzT8L1g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;7:jdO3jjNxz7uz3Xa1nHC3BAkmg92a1IucH6qUZYr5it8nnRr04YOPDehzgCUEV6Saub6S9C+aJthlJm6iExSyYdX85VxxuByi2CcIjZnnSRNp94c8j0RTl13TUROYoopiKBMQi7wqpsscOQBOAgtgYJk9uZ8GTgXWNym49Ycji6swnP7iNddnSXkBlvQ/b/cj17/Xcq/pjFOiUeIP7JrDWuO3AN0/r+dqdMMIS9AygKgyJzn5Sp7C2/J4XqFbEwiK;20:3j3/HsY+UN4naqeJ6tLM8KH58w7UfSQBojBdvRtiBNe0ny6yydqEPWoozRjfTZssa30b+n8Oji/TtjouI7xlmpluuo6SWqcH288cIiYfu5Iw4jzZez7VBSbAbeZpWZYJT38A+nIaiY9KujSHWKD9n0kEAXKsQYtcBXjfiRMZZvK+T61gK3yliMUIpz/m8QOXmQsbTqGTDUFv4dVIOzd68stEvA9HbLlJuWyyEPsFTNWE5QTnUerZ5uHgIj0UBpv5
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:26.6207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad2e37c-c4f9-4392-3de3-08d5e11f5761
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c | 572 +++++++++++++++++++++++++++++++++
 1 file changed, 572 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-if.c

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
new file mode 100644
index 000000000000..00391560e921
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * Some code borrowed from the Linux XHCI driver.
+ */
+
+#include <linux/usb/gadget.h>
+#include <linux/usb/composite.h>
+#include "gadget.h"
+
+#define usbssp_g_lock(flag, save_flags) { \
+	if (in_interrupt()) {\
+		spin_lock_irqsave(&usbssp_data->lock, save_flags); \
+	} else { \
+		if (!irqs_disabled()) { \
+			spin_lock_irqsave(&usbssp_data->irq_thread_lock,\
+					usbssp_data->irq_thread_flag);\
+			flag = 1; \
+		} else \
+			spin_lock(&usbssp_data->irq_thread_lock); \
+	} }
+
+
+#define usbssp_g_unlock(flag, save_flags) { \
+	if (in_interrupt()) \
+		spin_unlock_irqrestore(&usbssp_data->lock, save_flags); \
+	else  { \
+		if (flag) \
+			spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,\
+					usbssp_data->irq_thread_flag);\
+		else \
+			spin_unlock(&usbssp_data->irq_thread_lock); \
+	} }
+
+static int usbssp_gadget_ep_enable(struct usb_ep *ep,
+		const struct usb_endpoint_descriptor *desc)
+{
+	struct usbssp_ep *ep_priv;
+	struct usbssp_udc *usbssp_data;
+	int ret = 0;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
+
+	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
+		pr_err("invalid parameters\n");
+		return -EINVAL;
+	}
+
+	ep_priv = to_usbssp_ep(ep);
+	usbssp_data = ep_priv->usbssp_data;
+
+	if (!desc->wMaxPacketSize) {
+		usbssp_dbg(usbssp_data, "missing wMaxPacketSize\n");
+		return -EINVAL;
+	}
+
+
+
+
+	if (ep_priv->ep_state & USBSSP_EP_ENABLED) {
+		usbssp_dbg(usbssp_data, "%s is already enabled\n",
+			   ep_priv->name);
+		return -EINVAL;
+	}
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret = usbssp_add_endpoint(usbssp_data,  ep_priv);
+	if (ret < 0)
+		goto finish;
+
+	ep_priv->ep_state |= USBSSP_EP_ENABLED;
+
+	/*Update bandwidth information*/
+	ret = usbssp_check_bandwidth(usbssp_data, &usbssp_data->gadget);
+
+	if (ret < 0)
+		ep_priv->ep_state &= ~USBSSP_EP_ENABLED;
+
+finish:
+	usbssp_dbg(usbssp_data, "%s enable endpoint %s\n", ep_priv->name,
+			(ret == 0) ? "success" : "failed");
+	usbssp_g_unlock(irq_disabled_locally, flags);
+	return ret;
+}
+
+int usbssp_gadget_ep_disable(struct usb_ep *ep)
+{
+	struct usbssp_ep *ep_priv;
+	struct usbssp_udc *usbssp_data;
+	int ep_index = 0;
+	int ret;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
+	struct usbssp_request  *req_priv;
+
+	ep_priv = to_usbssp_ep(ep);
+	usbssp_data = ep_priv->usbssp_data;
+	ep_index = usbssp_get_endpoint_index(ep_priv->endpoint.desc);
+
+	if (!(ep_priv->ep_state & USBSSP_EP_ENABLED)) {
+		usbssp_dbg(usbssp_data, "%s is already disabled\n",
+				ep_priv->name);
+		return -EINVAL;
+	}
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+
+	ep_priv->ep_state |= USBSSP_EP_DISABLE_PENDING;
+
+	/*dequeue all USB request from endpoint*/
+	list_for_each_entry(req_priv, &ep_priv->pending_list, list) {
+		usbssp_dequeue(ep_priv, req_priv);
+	}
+
+	ret = usbssp_drop_endpoint(usbssp_data, &usbssp_data->gadget, ep_priv);
+	if (ret)
+		goto finish;
+
+	ret = usbssp_check_bandwidth(usbssp_data, &usbssp_data->gadget);
+	if (ret)
+		goto finish;
+
+	ep_priv->ep_state &= ~USBSSP_EP_ENABLED;
+
+finish:
+	ep_priv->ep_state &= ~USBSSP_EP_DISABLE_PENDING;
+	usbssp_dbg(usbssp_data, "%s disable endpoint %s\n", ep_priv->name,
+			(ret == 0) ? "success" : "failed");
+
+	usbssp_g_unlock(irq_disabled_locally, flags);
+	return ret;
+}
+
+static struct usb_request *usbssp_gadget_ep_alloc_request(struct usb_ep *ep,
+							  gfp_t gfp_flags)
+{
+	struct usbssp_request *req_priv;
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+
+	req_priv = kzalloc(sizeof(*req_priv), gfp_flags);
+	if (!req_priv)
+		return NULL;
+
+	req_priv->epnum = ep_priv->number;
+	req_priv->dep  = ep_priv;
+
+	trace_usbssp_alloc_request(&req_priv->request);
+	return &req_priv->request;
+}
+
+static void usbssp_gadget_ep_free_request(struct usb_ep *ep,
+		struct usb_request *request)
+{
+	struct usbssp_request *req_priv = to_usbssp_request(request);
+
+	trace_usbssp_free_request(&req_priv->request);
+	kfree(req_priv);
+}
+
+static int  usbssp_gadget_ep_queue(struct usb_ep *ep,
+				   struct usb_request *request,
+				   gfp_t gfp_flags)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	struct usbssp_request *req_priv = to_usbssp_request(request);
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
+	int ret;
+
+	if (!ep_priv->endpoint.desc) {
+		usbssp_err(usbssp_data,
+				"%s: can't queue to disabled endpoint\n",
+				ep_priv->name);
+		return -ESHUTDOWN;
+	}
+
+	if ((ep_priv->ep_state & USBSSP_EP_DISABLE_PENDING ||
+			!(ep_priv->ep_state & USBSSP_EP_ENABLED))) {
+		dev_err(usbssp_data->dev,
+				"%s: can't queue to disabled endpoint\n",
+				ep_priv->name);
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret =  usbssp_enqueue(ep_priv, req_priv);
+	usbssp_g_unlock(irq_disabled_locally, flags);
+out:
+	return ret;
+}
+
+static int usbssp_gadget_ep_dequeue(struct usb_ep *ep,
+				    struct usb_request *request)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	struct usbssp_request *req_priv = to_usbssp_request(request);
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int ret;
+	int irq_disabled_locally = 0;
+
+	if (!ep_priv->endpoint.desc) {
+		usbssp_err(usbssp_data,
+				"%s: can't queue to disabled endpoint\n",
+				ep_priv->name);
+		return -ESHUTDOWN;
+	}
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret =  usbssp_dequeue(ep_priv, req_priv);
+	usbssp_g_unlock(irq_disabled_locally, flags);
+
+	return ret;
+}
+
+static int usbssp_gadget_ep_set_halt(struct usb_ep *ep, int value)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	int ret;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret =  usbssp_halt_endpoint(usbssp_data, ep_priv, value);
+	usbssp_g_unlock(irq_disabled_locally, flags);
+	return ret;
+}
+
+static int usbssp_gadget_ep_set_wedge(struct usb_ep *ep)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int ret;
+	int irq_disabled_locally = 0;
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ep_priv->ep_state |= USBSSP_EP_WEDGE;
+	ret =  usbssp_halt_endpoint(usbssp_data, ep_priv, 1);
+	usbssp_g_unlock(irq_disabled_locally, flags);
+
+	return ret;
+}
+
+static const struct usb_ep_ops usbssp_gadget_ep0_ops = {
+	.enable		= usbssp_gadget_ep_enable,
+	.disable	= usbssp_gadget_ep_disable,
+	.alloc_request	= usbssp_gadget_ep_alloc_request,
+	.free_request	= usbssp_gadget_ep_free_request,
+	.queue		= usbssp_gadget_ep_queue,
+	.dequeue	= usbssp_gadget_ep_dequeue,
+	.set_halt	= usbssp_gadget_ep_set_halt,
+	.set_wedge	= usbssp_gadget_ep_set_wedge,
+};
+
+static const struct usb_ep_ops usbssp_gadget_ep_ops = {
+	.enable		= usbssp_gadget_ep_enable,
+	.disable	= usbssp_gadget_ep_disable,
+	.alloc_request	= usbssp_gadget_ep_alloc_request,
+	.free_request	= usbssp_gadget_ep_free_request,
+	.queue		= usbssp_gadget_ep_queue,
+	.dequeue	= usbssp_gadget_ep_dequeue,
+	.set_halt	= usbssp_gadget_ep_set_halt,
+	.set_wedge	= usbssp_gadget_ep_set_wedge,
+};
+
+void usbssp_gadget_giveback(struct usbssp_ep *ep_priv,
+			    struct usbssp_request *req_priv, int status)
+{
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+
+	list_del(&req_priv->list);
+
+	if (req_priv->request.status == -EINPROGRESS)
+		req_priv->request.status = status;
+
+	usb_gadget_unmap_request_by_dev(usbssp_data->dev,
+			&req_priv->request, req_priv->direction);
+
+	trace_usbssp_request_giveback(&req_priv->request);
+
+	if (in_interrupt())
+		spin_unlock(&usbssp_data->lock);
+	else
+		spin_unlock(&usbssp_data->irq_thread_lock);
+
+	if (req_priv != &usbssp_data->usb_req_ep0_in) {
+		usb_gadget_giveback_request(&ep_priv->endpoint,
+				&req_priv->request);
+	}
+
+	if (in_interrupt())
+		spin_lock(&usbssp_data->lock);
+	else
+		spin_lock(&usbssp_data->irq_thread_lock);
+
+}
+
+static struct usb_endpoint_descriptor usbssp_gadget_ep0_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bmAttributes =		USB_ENDPOINT_XFER_CONTROL,
+};
+
+static int usbssp_gadget_start(struct usb_gadget *g,
+			       struct usb_gadget_driver *driver)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+	int ret = 0;
+
+	if (usbssp_data->gadget_driver) {
+		usbssp_err(usbssp_data, "%s is already bound to %s\n",
+				usbssp_data->gadget.name,
+				usbssp_data->gadget_driver->driver.name);
+		ret = -EBUSY;
+		goto err1;
+	}
+
+	usbssp_data->gadget_driver = driver;
+
+	if (pm_runtime_active(usbssp_data->dev)) {
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->ep0state = USBSSP_EP0_UNCONNECTED;
+		ret = usbssp_run(usbssp_data);
+		if (ret < 0)
+			goto err1;
+	}
+	return 0;
+err1:
+	return ret;
+}
+
+static int usbssp_gadget_stop(struct usb_gadget *g)
+{
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
+	struct usbssp_udc *usbssp_data  = gadget_to_usbssp(g);
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+	if (pm_runtime_suspended(usbssp_data->dev))
+		goto out;
+
+	usbssp_free_dev(usbssp_data);
+	usbssp_stop(usbssp_data);
+out:
+	usbssp_data->gadget_driver = NULL;
+	usbssp_g_unlock(irq_disabled_locally, flags);
+
+	return 0;
+}
+
+static int usbssp_gadget_get_frame(struct usb_gadget *g)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	return usbssp_get_frame(usbssp_data);
+}
+
+static int usbssp_gadget_wakeup(struct usb_gadget *g)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (!usbssp_data->port_remote_wakeup)
+		return -EINVAL;
+
+	if (!usbssp_data->port_suspended)
+		return -EINVAL;
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(port_regs+PORTPMSC);
+
+	if (!(temp & PORT_RWE))
+		return 0;
+
+	temp = readl(port_regs + PORTSC);
+
+	temp &= ~PORT_PLS_MASK;
+	writel(temp, port_regs + PORTPMSC);
+	usbssp_g_unlock(irq_disabled_locally, flags);
+	return 0;
+}
+
+static int usbssp_gadget_set_selfpowered(struct usb_gadget *g,
+		int is_selfpowered)
+{
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+
+	g->is_selfpowered = !!is_selfpowered;
+	usbssp_g_unlock(irq_disabled_locally, flags);
+
+	return 0;
+}
+
+static const struct usb_gadget_ops usbssp_gadget_ops = {
+	.get_frame		= usbssp_gadget_get_frame,
+	.wakeup			= usbssp_gadget_wakeup,
+	.set_selfpowered	= usbssp_gadget_set_selfpowered,
+	.udc_start		= usbssp_gadget_start,
+	.udc_stop		= usbssp_gadget_stop,
+};
+
+int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data)
+{
+	int i = 0;
+	struct usbssp_ep *ep_priv;
+
+	usbssp_data->num_endpoints = USBSSP_ENDPOINTS_NUM;
+	INIT_LIST_HEAD(&usbssp_data->gadget.ep_list);
+
+	for (i = 1; i < usbssp_data->num_endpoints; i++) {
+		bool direction = i & 1;  /*start from OUT endpoint*/
+		u8 epnum = (i >>  1);
+
+		ep_priv = &usbssp_data->devs.eps[i-1];
+		ep_priv->usbssp_data = usbssp_data;
+		ep_priv->number = epnum;
+		ep_priv->direction = direction;  /*0 for OUT, 1 for IN*/
+
+		snprintf(ep_priv->name, sizeof(ep_priv->name), "ep%d%s", epnum,
+				(ep_priv->direction) ? "in"  : "out");
+
+		ep_priv->endpoint.name = ep_priv->name;
+
+		if (ep_priv->number < 2) {
+			ep_priv->endpoint.desc = &usbssp_gadget_ep0_desc;
+			ep_priv->endpoint.comp_desc = NULL;
+		}
+
+		if (epnum == 0) {  //EP0 is  bidirectional endpoint
+			usb_ep_set_maxpacket_limit(&ep_priv->endpoint, 512);
+			usbssp_dbg(usbssp_data,
+				"Initializing %s, MaxPack: %04x Type: Ctrl\n",
+				ep_priv->name, 512);
+			ep_priv->endpoint.maxburst = 1;
+			ep_priv->endpoint.ops = &usbssp_gadget_ep0_ops;
+			ep_priv->endpoint.caps.type_control = true;
+
+			usbssp_data->usb_req_ep0_in.epnum = ep_priv->number;
+			usbssp_data->usb_req_ep0_in.dep  = ep_priv;
+
+			if (!epnum)
+				usbssp_data->gadget.ep0 = &ep_priv->endpoint;
+		} else {
+			usb_ep_set_maxpacket_limit(&ep_priv->endpoint, 1024);
+			ep_priv->endpoint.maxburst = 15;
+			ep_priv->endpoint.ops = &usbssp_gadget_ep_ops;
+			list_add_tail(&ep_priv->endpoint.ep_list,
+					&usbssp_data->gadget.ep_list);
+			ep_priv->endpoint.caps.type_iso = true;
+			ep_priv->endpoint.caps.type_bulk = true;
+			ep_priv->endpoint.caps.type_int = true;
+
+		}
+
+		ep_priv->endpoint.caps.dir_in = direction;
+		ep_priv->endpoint.caps.dir_out = !direction;
+
+		usbssp_dbg(usbssp_data, "Init %s, MaxPack: %04x SupType:"
+				" INT/BULK/ISOC , SupDir %s\n",
+				ep_priv->name, 1024,
+				(ep_priv->endpoint.caps.dir_in) ? "IN" : "OUT");
+
+		INIT_LIST_HEAD(&ep_priv->pending_list);
+	}
+	return 0;
+}
+
+void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
+{
+	int i;
+	struct usbssp_ep *ep_priv;
+
+	for (i = 0; i < usbssp_data->num_endpoints; i++) {
+		ep_priv = &usbssp_data->devs.eps[i];
+
+		if (ep_priv->number != 0)
+			list_del(&ep_priv->endpoint.ep_list);
+	}
+}
+
+static void usbssp_disconnect_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver &&
+	    usbssp_data->gadget_driver->disconnect) {
+		spin_unlock(&usbssp_data->irq_thread_lock);
+		usbssp_data->gadget_driver->disconnect(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->irq_thread_lock);
+	}
+}
+
+void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver && usbssp_data->gadget_driver->suspend) {
+		spin_unlock(&usbssp_data->lock);
+		usbssp_data->gadget_driver->suspend(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+
+void usbssp_resume_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver && usbssp_data->gadget_driver->resume) {
+		spin_unlock(&usbssp_data->lock);
+		usbssp_data->gadget_driver->resume(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+
+static void usbssp_reset_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (!usbssp_data->gadget_driver)
+		return;
+
+	if (usbssp_data->gadget.speed != USB_SPEED_UNKNOWN) {
+		spin_unlock(&usbssp_data->lock);
+		usb_gadget_udc_reset(&usbssp_data->gadget,
+				usbssp_data->gadget_driver);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+
+void usbssp_gadget_disconnect_interrupt(struct usbssp_udc *usbssp_data)
+{
+	usbssp_disconnect_gadget(usbssp_data);
+}
+
+
+void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data)
+{
+	usbssp_reset_gadget(usbssp_data);
+	switch (usbssp_data->gadget.speed) {
+	case USB_SPEED_SUPER_PLUS:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->gadget.ep0->maxpacket = 512;
+		break;
+	case USB_SPEED_SUPER:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->gadget.ep0->maxpacket = 512;
+		break;
+	case USB_SPEED_HIGH:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
+		usbssp_data->gadget.ep0->maxpacket = 64;
+		break;
+	case USB_SPEED_FULL:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
+		usbssp_data->gadget.ep0->maxpacket = 64;
+		break;
+	case USB_SPEED_LOW:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(8);
+		usbssp_data->gadget.ep0->maxpacket = 8;
+		break;
+	default:
+		break;
+	}
+}
-- 
2.17.1

