Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6707C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727C121F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cUowWJcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727C121F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbeGCT77 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:59:59 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:12721
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753067AbeGCT6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXCHFXAy54Pfc2pgTIc/s26DsWRkbLHiWa48VtFfq48=;
 b=cUowWJcWWJS4HVGFjIqe2l3PA8EBqeCx4lV8mVUTDr9sJ91S57rEdMZgQePhYSBl+xOh9pZCCzBA3XKl3cK7ZOTuXp411StHKZ4gCGu5dHzApu6oYMiphzefuZcxXxX5nJtRpxxKt/3IugrMHYnuRTfFavMrLk8XZNJsUwKI9Ew=
Received: from CY1PR07CA0027.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::37) by CY1PR0701MB1338.namprd07.prod.outlook.com
 (2a01:111:e400:4c1b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Tue, 3 Jul
 2018 19:58:34 +0000
Received: from CO1NAM05FT039.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by CY1PR07CA0027.outlook.office365.com
 (2a01:111:e400:c60a::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:34 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT039.mail.protection.outlook.com (10.152.96.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMsC006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:32 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:43 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:43 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwQd8012416;
        Tue, 3 Jul 2018 20:58:26 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwQYQ012403;
        Tue, 3 Jul 2018 20:58:26 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 14/15] Introduce Cadence USBSSP DRD Driver - added Kconfig and Makefile files.
Date:   Tue, 3 Jul 2018 20:57:58 +0100
Message-ID: <1530647879-10007-15-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(36092001)(50226002)(36756003)(2616005)(426003)(48376002)(4326008)(69596002)(5660300001)(87636003)(8936002)(446003)(478600001)(76176011)(51416003)(186003)(356003)(6346003)(26826003)(476003)(50466002)(11346002)(26005)(336012)(126002)(4720700003)(81156014)(6666003)(81166006)(107886003)(53936002)(47776003)(106466001)(86362001)(2906002)(486006)(105596002)(8676002)(97736004)(54906003)(305945005)(16586007)(42186006)(68736007)(316002)(110136005)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1338;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT039;1:TPkrnYuXFk0ZhhZcI8S7Eg2taeMVb9I5Ju02l7opimirHBkYh5xd6lILN1wdndJVp7EpHKeqst0ImwXRQNVFO+d1Ili9RT2dNhlWr5mE4f/PWDHmnM2MxLBP97knWCU0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4462dfa5-1e90-4ed8-9117-08d5e11f5bae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0701MB1338;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;3:MNzC+rdWgwfVsYs3zBvUj3OrHBTmHhWeYPiObax43H7U6hxIZhqHQyeLp/z1qWUJ03aKrJax7OdBTptBji0nvtnB9TeQTFrgqNEbT65BE3mpP7keJCBsQb/iOm+27MwWO8UfBPcXvjiZz4WOI4ubnjnAcPdUc6Y1xLTajyb6+BOQb+ImvopzPscL0o2VdCWW/WxJ7/6nDjnx7s/9E54GFvoWrOQhVm+/V3hVmWS7KQLBUu1EpkouisQFpP0dmRzcWlpNDoxiEC3YBCuCzFDWCB55ex73uMxI4AuPgC6G7jerVnIUYZIl4jsINL3Mn3aXvEaHbz9QHVOjWdmvf/mZAg==;25:s46gyezrJxjJgEKgmMF8Wmuez1U4IlP8yOvasHyqlzRZ3+ualkfV4wLNBuAOTE4s5k4JP5Rasaf3bZEElpSqXeAHZUTeHbiZdP88Z5O9+l3cG6AUkvQpwjtH8sgHNuT0o9bILGAtxd8wXv2yXEPAIFr8ixpsgF0oYnkvo/t9d/T3MrHbWfc9WBWMW4uP4snMtQvfAhQiK+QoHaaSFSw91+sGki0c8QAQ02vYx7uMKrK2eaBsJRY4UyvM/1AnJ9xHnVip0bRbzc1Q8fRXrljUp5AMYWpegwqxFuaHO3k/ByCme0mrlVnj0HKnvum2hEYt9w7qLEmPoHlrH8Q8D7x2tQ==;31:fElq966LwgYgXuCMSxHMXEKTVVMDvntQ+A8WmvT9Yi1BE/lRn2OHNe4lho1rEQxkE60lKDTU3fD6XavW2/1fWt8yuGCSvH7wG2b9GUaeXVlg1Sr9K+IzEGf2ZQ4fVFRd47TCKTfDjPDpgnIisIb9bFg2pdpC8BCTGNQJoWaB2SVpvHPkTK0wrQZ5nkTmivDkL+xWfHkjz8c3TW1UXJYZ7z7bBZSMAyBheJTIk/0WsDU=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1338:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;20:inIti165Y5j2TCb2n/rkGBqB4MVU9l35xKiW8gf+MtOIgJgPfHH2raC+FEHKr15S13CL6zXHfCCWKe4X45pVpq+Rk3gQCaUhRumBr/+yPKg2SO7jVJvAxhL1jjxlloIHrFjfnHFPsdB1WJRXmOoygIVPs4LCN2/f+s8rcW4goQja45T5Ogu292cyuZm1tTdYHD41utKoGzr3+IG3izkTX5b7fZks/pbA3updf6qYaouoHcVE4JbRIqQ4XuCIesT52RbhKl7QyzExcjgJQFLvSSKwLqNTHWKw5FPPVN13CpTMRpGNwOsWT77cbLaFJtfMKCOltFrEfuc6khZz9iQ6rDaFi2FduTBRivx9J5k0wM7FeCHVdIDWM/JpRYNKY9gbUvKTDr3gQxxnK27vTOYxywAy3dz1dO8HaXSl0du+zkOosOENsp1FBZmoadKcC0R0utMMEu5puZMm1B1iJDJ88efSv+fppdojWo1omLtwzBwHiQOUOc11ElTcBLTRV9zO;4:XjHRh/TfxZwcafO4J+KuyyBhRt3kG2Gg6GW/J4zRISq1hzXb+229oreG4vNBVyrhlu7KQ/05wuZJ4NtuP4f34C4Cvm01XUTOpZcw6UrtSPiHpu5yNoTZsysahmhAbK3AGbFnp0EkQU1rwECPYv4KeBjCP9P4Aleo9vuLFWAq80diROr+o8aPkUbzbhrGuJ6vHx+U/uhK2Js9qkcLvSHTDx77D5nUPTgxHSPB//9tcuD9CIHyQbVWHWrs741FpO+rQuzsG7W3FhzZf7PQiUSwe4FL/m3mSN3+815djsxKSYEly7aIioYIhLuqJxpEl42s
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1338A811D01ED2FE691F3BD6DD420@CY1PR0701MB1338.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231280)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1338;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1338;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1338;23:Y+IaCcBAKkoRzAEzuGozE0fQqE1dbfGRQtScZW2?=
 =?us-ascii?Q?8rH3tfQF6lK9RJCI+xvcWlWMkW3zd1YDPjYSomLHsvR+GuJ9VZELf1rLnrWF?=
 =?us-ascii?Q?fqlbXBaz6bjuBj4mQr43pe1YfYUTBYI/OjiUcaCfmT00m8a1q53I52f8/g7u?=
 =?us-ascii?Q?K8yZun1fdEoi9A4VMwCECHWWno1vSCl/ubtOyucLulguHbJuDRil8oYqebvF?=
 =?us-ascii?Q?3dl1Htk/iWyHuah1/CgEQPAzB3d3GLZ0LlUrayzHBH9tCw3LWlp8w29ColFb?=
 =?us-ascii?Q?R4aVCL6xRokT8QrstcR8nPPoQCttYhKlOw0rHDAvxWaJPaMS8A2IgQdKrnPB?=
 =?us-ascii?Q?1x6/3s/6pE8tCaDuHDyedkmufCprgAYu5y+5xhzwjGVzMVLLgdj2wBRrIfxH?=
 =?us-ascii?Q?6rugXKJMgwAwIkalAL2RMdvdPyKc8ApQFRZSmAB8kX/5R0Nqac7ks6c48LUA?=
 =?us-ascii?Q?EMUGhiWGWSW8AgGaPomyrcfOP3H4z9undyAm60cWI2pR3f8GEHFaNH4ngMAk?=
 =?us-ascii?Q?hj+y71nAIuqqVMrWQYxI96Ds1EKFw6znuU7bVtnUxk8Ndu7rePvedr7MJMVY?=
 =?us-ascii?Q?mS6KqzQGAbK8WjL21voO3zY8UGVMLe1n99cS46FFXNTdE/Dg1rIvmBXQbmx9?=
 =?us-ascii?Q?yu6K/WvaR+XJMSrF2F4UzmL6XBPq2uYoFi6S02dlLX7GL8YMeJbqVvFA8LhS?=
 =?us-ascii?Q?VxQ91gs+YLPN6JT10uMAwNh3/6sz4ygTkuTOdPbLX1eO3TlFVBNcu2h+8BhV?=
 =?us-ascii?Q?lG51nVYru13Jd8jQ+tzA+O84AtWvBvpZs3muaa+3CIspSEpfylElVFXlNr/r?=
 =?us-ascii?Q?e4gveNcYH/iAMfqSuXc1+uNUkO4I5J+ydG1TiWttWx7htYnXSsaw9eTqD+Fe?=
 =?us-ascii?Q?Onrohfo1dbCJuurVlcw3c+BbpUkqM+DA6zdekXXrtbes9GUPvULHXM1suQLN?=
 =?us-ascii?Q?JNJpnRgAY4cssgysBavhgBPvYlbIdbLgo/IgjJUIVnBxRMTF7NcvQ6kbCKjN?=
 =?us-ascii?Q?2WdW6Im52Ou0OS/x1g4k4O8C+MUdKNz9KgrXFf5wDd/OWpEp8Qb5jirmDyhB?=
 =?us-ascii?Q?7K6ssEA1kfmYm4BomlbqsL4WtU2QHB4Ag4v2sGXcQSy2a7iThqRqkGGY0y79?=
 =?us-ascii?Q?qKBFCo6VPCIKeVnIvYQdNGwx/4hY9JQhMY5Z21nHM6pGofvDpKDn3kt5FgjV?=
 =?us-ascii?Q?KPN98OFq4Hwolnu1GBTvaQfnv8bmkv1SqcWqygn4lwndvqhJF4Hp9ZPVdEQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: IjnVd5VKp/PelzUlQ9FT+GnAwkT6wEt0pTNoLFe/5j/son51Ben8Cy56AwDOo38zzeGHgUQrnqgj8ioJl0kocXjhUhOiO86UKB6a7DDSHuAMU1v86lapRFNQ0we8BP8ifyyZfqzA8jZJ4rwoVpK4EDWswPtoobKU7jsRTverQWjUtSOZLlwCkeogqCRibpusmX3/vmdNBBMfJImVNquEHvN2ckSzXofSNsqrdu2OYCHD5Xlr6R6qtOF3gOb78DQ5Grh0b7RJIop217/Q+bu+D2mPZbXGMRXNrbP0O3WACuseTxHmOPfibJFTPfPjaYjlsZsvVu9u4u1zZiOWF37qE5mehId/q4HUGUqdHMBfa+2tHCeB902sDx/YCXg+XPjKSmDsE7jdIQPdbj5KWoyAXQ==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;6:A6dhWZ0+KWO4Sn7iSnNjPsZqTZSLYgfq4TvsTnYbNNs7QYoGTBCfMVcx9dr/4k34aitPARsZsEqBcLb3fe3kHo0h0+5ULa/z4ZuhLytF3nv/qWalo7RbActpIwI+igf5AEyIvsPWN2vm6F0d/RiSfIGkqgpf/OWXCFUTSrWvBiewMMGHvegRAYqkeiEZng2Jl78mCHNoKd55ARtmlZXLWxhECpUw8bAJRhMyMcmmQ6A6UfgH6OHuPEVZOPioyeMRpZYsDA5TpA1jFaHXWJFFwaPoMbF2TXeO7WPbJYpwPYbkIJpPmPb+Hhyh/xeLsiQ0cO6VovqxK0CMxEmz3nAvgABTo5LBPm8KP4nbjyyl5Md1GX+HEgfUZNJG77gr3utU90VWZT8Vk2tZ4jremC1X6BLtSxWWPuvinRDkzH+evAnN+y1TeEpfqTWeSDYOBtkjMn5fmfmK/9awIgqOQrvsOg==;5:i+3r/54W/pKDMkPSUFDyJ3ghOjZLUGpk02exP7ljXfQBMHvzZMDqDeAPUP9cRiNVDAyg6NujBdrun8w0BXWq0j//iOAMLpa9sq31C6WoVZpv0KKuUGtUZUnyfHvQV9YXONMqPt/UWrTrTbOY1ui4Fxf1n1/57WcwYOuD/h7Hqhs=;24:xsFYLZDkh3yE03WeWidiUzcpd40ogLXqhFxyOYZXUUk/C+Q6ssg3k/UjLu9/r6MPDknV6jcPvEoJcmxb1XkJG1Ow/hkaKBXlCcpRFO97cro=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;7:m2hwJSlu8iR3GhWPAimXoypzm1LASuTkIcwsXGrV2DxNhkpD8WctiF2F7P4fZhoXgRPWl8ZT0fLFb7vehE1fu6MwzO2YJGftpQth/vbgcknkl1eI7J0TzUpqreDn31zTPxBn2ONu6OehEUwBo6fnIi0HK4fBP9TgWUwzrSsWsaH5a3JVSV2JNTEk1b8zHHIJYk64HvjUSDPDLTobd4UBnw5gnWY7E/dYRIdXIV4p0ZYvNbQfmjugu58+Ruo7Irea;20:3gsC59o30NfjKxi4eSAf4zUW/6Ut3xV+HLSYNnokpV+zIDiE/Gfe3Cj2vS4bZGXm8u6zgYb7a9hpuKE9+iwN1p1gVcN6BnxOYSqBnsn85UoSJzQZjUDmu6fbJKl7v2abV3l5+NSxwWpNPyN6tPEOyvIPFibs6PabMS7CGl/Ldy2HqYOk1f3UkO8r+atmMQWbgh0P103EqzGHTZKH7YnhTlrc51UmL85/xGNXCpZOqcIT7knADsbBvXnqEgNrvRc8
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:33.8383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4462dfa5-1e90-4ed8-9117-08d5e11f5bae
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/Kconfig  | 29 +++++++++++++++++++++++++++++
 drivers/usb/usbssp/Makefile | 17 +++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 drivers/usb/usbssp/Kconfig
 create mode 100644 drivers/usb/usbssp/Makefile

diff --git a/drivers/usb/usbssp/Kconfig b/drivers/usb/usbssp/Kconfig
new file mode 100644
index 000000000000..e55c97a2da5f
--- /dev/null
+++ b/drivers/usb/usbssp/Kconfig
@@ -0,0 +1,29 @@
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
+	bool "Gadget only mode"
+	depends on USB_GADGET=y || USB_GADGET=USB_USBSSP
+	help
+	  Select this when you want to use USBSSP in gadget mode only,
+
+config USB_USBSSP_PCI
+	tristate "PCIe-based Platforms"
+	depends on USB_PCI && ACPI
+	default USB_USBSSP
+	help
+	  If you're using the USBSSP Core IP with a PCIe, please say
+	  'Y' or 'M' here.
+
+endif
+
diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
new file mode 100644
index 000000000000..b6d5fabc3571
--- /dev/null
+++ b/drivers/usb/usbssp/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+# define_trace.h needs to know how to find our header
+CFLAGS_trace.o := -I$(src)
+
+obj-$(CONFIG_USB_USBSSP_GADGET)	+=  usbssp-plat.o gadget-dbg.o \
+				    gadget-mem.o gadget-ring.o \
+				    gadget.o gadget-ep0.o gadget-port.o
+
+ifneq ($(CONFIG_TRACING),)
+	usbssp-y		+= trace.o
+endif
+
+ifneq ($(CONFIG_DEBUG_FS),)
+	usbssp-y		+= gadget-debugfs.o
+endif
+
+obj-$(CONFIG_USB_USBSSP_PCI)	+=usbssp-pci-of-wrap.o
-- 
2.17.1

