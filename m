Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A065DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4907B21EF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZLngcQCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4907B21EF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeGCT6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:58:53 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:60512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753048AbeGCT6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CQ0VJjP+iZL6D/44O8x4PKftr28Yz63FlJst5BYThQ=;
 b=ZLngcQCU/VBX0T6VG8Mds50J7fPAay831Y1y8g+iRcjOoyXVw10AecqC+k7aTGyhfiGKED4xTa7F9ZqmgOjaZ8vR17FZMy9+hhwhUW/XT5W+wAtMu4PE+lej90SE+sV4CP4GE3DKm98lhcrFokV7UphGyd4LvYTmSMvX08p04OM=
Received: from SN1PR0701CA0072.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::40) by CY1PR0701MB1339.namprd07.prod.outlook.com
 (2a01:111:e400:4c1b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 19:58:35 +0000
Received: from CO1NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by SN1PR0701CA0072.outlook.office365.com
 (2a01:111:e400:52fd::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.19 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:35 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT006.mail.protection.outlook.com (10.152.96.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMsD006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:33 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:43 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:43 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwR5h012444;
        Tue, 3 Jul 2018 20:58:27 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwR3B012432;
        Tue, 3 Jul 2018 20:58:27 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 15/15] Introduce Cadence USBSSP DRD Driver - added USBSSP in Makefile and Kconfig files
Date:   Tue, 3 Jul 2018 20:57:59 +0100
Message-ID: <1530647879-10007-16-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(36092001)(316002)(50466002)(110136005)(42186006)(54906003)(53936002)(48376002)(16586007)(8676002)(446003)(8936002)(336012)(2616005)(476003)(97736004)(11346002)(5660300001)(356003)(426003)(26005)(81166006)(81156014)(6666003)(4326008)(4720700003)(486006)(126002)(86362001)(186003)(47776003)(305945005)(2906002)(76176011)(51416003)(36756003)(106466001)(107886003)(68736007)(478600001)(87636003)(26826003)(105596002)(50226002)(69596002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1339;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT006;1:QCM3HQZEOyrspvESsVZUZSzmo4lMgFyBgZTYoerITIA3feGxfpj+QLRp1t/IN+22Yw3nYaNqWUxP/YyY3nEZNwkyKk0PA0BSxUWJqgdGygiy6a5cGTwwU5XDtBHvNo4S
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41f9b779-9c11-4692-0b14-08d5e11f5c36
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0701MB1339;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;3:FY3pdkDwP27BvX/SSthrg2wE40+8sihweymRkHJSlpFxRq/XEc+F+cFEf8PV5HVookTHTestkT076upfjAGcxLxRsTLGDe5NADaW6UP4buvMjHBdy5Wymk1ex4oNL8SXYZGKyXRFWmqwHwHGFGoPkO4YGqUA+K1Oi0WD14jG8xiV9+ZCDVDbjOOoM5X+JSCqDmhjd4zoDoGosSxZvxirnOyRPSINhN1wQ2FhoiSGp/OsSglPS49mftSU+qu7Zic1YGKcB++pxolaaTvoTiKsqJ0urWGoku93zMOxmbHurMAIyP/B4rDQL5X/wfPoDOdXV8F61//g8s0EyoIclxzW+Q==;25:XlHleprpMfViuFYZR9cp4PGSY0a620aUqqeowAWdhkVq7ERcZ0sOmdhDiXOZG0GysQmMDrruaCTV9yy1FjZTXk9YhaOIXkVTlZU0GF469ACbfEcpGu5iKmXyqjGU/t+RneT2tVEzimqq9oRM73V4KmeWzc377f5hIUTOP9vuN1ISLc6VqM0B/PFOT7LqHkji7zN+87UHBa4l+Z9q+IzLUYkd0Q5PI1efRaLKysi4reDVFe9dr/zIO7Z6+HqGz9HCFz2G6Q7qSBs29U+/j/fu9cFIFczIfoE3Uy2muDOl0RqrQm+44kyYIX9JjCADPaU+krR4w2bijgbdZZ1uxboVLA==;31:vLpmHsiD2vCJ29jf3oON8MV3O0yODymOUYTi9oUEVot6MMS4HmlQve5lK6wHErqH0RIdK8hhwK1ebNP/AU6XwUNo8pbo+1W+oNmfMtLyfMB7p9xkYhWQHCAbGImHgvQ8G/aZx3KcM86rzgTbpcqljbQQRy/fhzEaOBszq7rcv7awe3R0G+F9aToxjHZEk2GpsMTV46EzKSyxRz34IRluzqJ4VwQloTMJYEDOU2mj6Dc=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1339:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;20:2sd4GjjYQLX2O8Zg4Vv2CIE1E2cDq9zszd94P6o0+LVlkfhmnOSdI5cdodL0iPh8bCCK1mENdYAiMrQS1pTYrijJOFPilabHy6tOh4O/ttC1V6JCz8Mf2Tyk38YUTHfvSjXf6h1qm7j5h2KMLk2FDjYJTdKOypjkOgD9j4m2Avk0+bWZhOla4+EsiPVKllFWCbAnC7BXv98oW4m393hWYqxMZ+g6PVzVxM2mOmZz4qJCAbXlnO8l4MOmHpa/8CwgnPYcMzIlFkoTFyFBbYmJzMrkPOX0iPBJ3BEE7DtKiRhIab7GnhDLbb1xqFF5DJNfjpC5/J8YowFPKmJprKO+Saxgi86kdhXke//oIcmisIHDk6KawlArjom0A/jG5q6lL8hNj4TwAYsECOACmW8F0NcCAc1i9z4HSe1w5H35NnUREY0XuwKq7y9yLqCJhSTm27fTXGbZLzMG3e5xHYbm0Q8vN+fuMSFprey0mbFRcZu/oeY7ji2YX0yCSlDwTQUQ;4:jNkw1TFWYuY41G0fdpawLqfm0o+2JygJWuBIaK6CL4Drh8A7mUsX7rYLEMaOzD2fGpxYWS3fiViiAfAZZhmlwUhcSW6znaiZOQ1u39u3LsQoPYXwoccv8KFjHnLgXRiEZ2uCqBeVpqY37sW9a4RtV5jxWVEMLcpOXB+7H4hnPBlPSgZCVGQF01ljX5xN2mRhPivJr/cvpgIQAcbD/we4jlomtD8C03zUrnR/Qb6v9L7dueDmKlZL5xH+2CD6gLb1ji2LGvI7BigmPzNQfnZeYFwhdElNJa83zNNZMbfZQlmgz1A1e7d1EOEFunIU1Pyj
X-Microsoft-Antispam-PRVS: <CY1PR0701MB13398D6AE170C7EF09C530CADD420@CY1PR0701MB1339.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231254)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1339;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1339;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1339;23:YE4fg2uicKCOfwVxavyYgzcz0fb8+eKKw1gHCyM?=
 =?us-ascii?Q?taWRA0x59RanNkPoPiMzKAIYosTfeEmx2nLmAYWcVNvjfcc/pc9llghC4ELb?=
 =?us-ascii?Q?bMyvO4Zpwm19uEwiQtY6D26WKrsSYFK4yJnp/ywCBsY0o/RuD4q+8dXjJtf+?=
 =?us-ascii?Q?heR4fEaAv8atLE3el3tIPtNBg2WiecjJ7Uv8X8I3Ckm+IC/umQfAesiu8q+m?=
 =?us-ascii?Q?gsMVWDJEx9bJvYGC+6jp0Q6Y3aR7x1unlEAakvS/vUtITBvaQKJS9HLx1eox?=
 =?us-ascii?Q?wO07YQW/kGHn7ohMVlB9DZOjKYct67Bw15TliGBTB5x4GikC0XouSeM/r/vE?=
 =?us-ascii?Q?WOuCynH/BTv6exKjKVk31bTVVf4UWqt5so9J4gWchB8k80/vmSHlWBGc3lpo?=
 =?us-ascii?Q?QjXr0aDqPzTUM6jRP4kn5EuaC2ouIduo1Nf4lVqwfI53f9WUIvCf4KCY86Yc?=
 =?us-ascii?Q?bfPeOtPdSIXjD47lwHL7S194K/Rd7x3qfivXkUzaUYaOs5hfnZqkTXUK4+PU?=
 =?us-ascii?Q?Fkhjc0i8gwUKG66u6RuKLQ/eJIhG+2bwg1evu1oT3wQajRbtoCh40b2LClyJ?=
 =?us-ascii?Q?eYjC1NYiG8YBmcGCDIoUx9PenqHaX9zNf9iVOoteR1g/FkTnNhLiKYUy3DeL?=
 =?us-ascii?Q?8CArlgdUiWb+DVzmim3GzWdQHjU0725M3OcH8f3wH1FVwhzfu8tC9oZJaApr?=
 =?us-ascii?Q?z0y9vZ2On/DI36+tgj8UYNMIB1znz7RHXd3H6Gor7+C8VVP1f0L7iFVYwI0W?=
 =?us-ascii?Q?VhJRdIflaKKl5jr3hQtTlzPSHZ5cfXOrSFLxO8RLYWK7ie2cClVrmK7JQQTZ?=
 =?us-ascii?Q?BvH0/pRO+9c//0YgBSezEapK4J7tIRniqV69lZ5aU7OoeMlAkibb1psfoZ4m?=
 =?us-ascii?Q?db0yCSucy2nBCY+1frNH6P0sTG98yxGHA+johYxfd3/HVkXdHLSOsFDzaSVI?=
 =?us-ascii?Q?D+ELRzlxh6HQ7p3LTsnfTfBDPV229MVtfIhL7LeAUMJuHj6FMHovuxmPPUXs?=
 =?us-ascii?Q?6BrOCFkG1Cso36pRORJeF9OBfunkwWbnd/iFBY5Lmwr4TEeDbFpRBGMGHlGr?=
 =?us-ascii?Q?AKCIyj7S+M0DpxQKZbfPbHJ8DK4m/J73KljWA0y+63hvKiy/G/IgBXQk2QrT?=
 =?us-ascii?Q?fJIxvd68MfH95+8FTQ3Q7zWj3HfgKMxk5gTRmRAA1nTXAaVfULLXgTt+g3h7?=
 =?us-ascii?Q?+WCAMz8KB8WhVRotuB+N4sHbJZEH1n8rBALqcsSxKPQ97aLx3UnJwfjZD5g?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: JcQgUa2BTPcw15sQQ8EBFHlYB2MoA/B7a+lyKW/dQlP0wMJEOduaCI9vliunOq5P2TMrTZGVPgmEDHDqCSt/W/TPoUUdK6hXnOfrEvtsi8vblZqWFH0SjTtpWaVRQQr+SlUxJNticbHYFgq4y6M8aqK/hno83xUp9TfqkQWz6zTuavlcE0dzIwglk28YLB+hZIIXDRqKoEIML4Ku5Vc+WDfa+OpNS6w7WXg+NiqKGHqCRzEQ2t4WGBAOZ952qmvSZhaZoq5RfuYYiqYOcmo2I885Jk61YskJ+enjV+TwIs1vZndAWWhfkvx2/csGenrvL4FpCi/7f4F2BKzHcAk3CRrpkCirdlyLiDpM3IVsiQF9ePdrRd3Oj4jn1cyr+HDAAQosYKrC/QrbbIBOmHueHA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;6:E2KXsx32xbYjpplVfh2OTujTRZN5wb2IGz3kYTvMI8XklmX3YOXQCUCpyjnnxFL/SJN+RTjS4c54aIHbuAaDvlGGR/RyNVApwQ+qElBjyl1iYoGvfaz8rr531GcT485levaQy721wgQpT1yBaowxgIRSn/+ajhDO49bODkIskkxCD8KQp0ot1B2YRWd5K/yWIDGNddSFrnkkIyPhwgLfJ/vOVxmw3nqxw1Ek4AiVgxjEDIMzgYq66RPQDqtPYtwdGRsVyVYpD69314wsuAbLWfsbEMpVBA7N73KP7TshSUORFsHLT+pq152Es5WfQQqVQlmEhpHcdnKvhxYpFJ8e1+lvtS/6rYAkIwOmv9TPt49AMWnA9Yk2DJ5EJw3Aecg3OD0nIEggSXCQG9ONPEegyFx61hFlLwoz7NMtXUqgbgeciWxPxvSJiR3zmk4xE+ocOqZPsLyU5XGhxwFla9jMvg==;5:lOITdWSknwnHws9NQGnaYzh99OCEozdmuBp3gy2gV7G8vz7pKf79LCkX8Y9hYSm6MGtSvg3sWTZS6L//VNOwzwYc/OInwFwjNcUPZwwbwy8YXp6+XSAAfTgQLxelUaOsgqvCg3ZKm0PTmawluMxjiUqaehyqJCCIVxRhs24U+0o=;24:xpamDZ/6XBdSWBj6hzBxvdRcZGgKzDue4QTk/y2kuNKay80lRm5/J2mRg57rzgCxv3C0hNSxSQmCA48sBA673Q0I8FO06VFJl/Da4T49Dyc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;7:u+ckJ8Pk+ObzSqUswfEWG6RFXsF+nnMZCRxRL6tAc/+ctjTFRVHm8KoAE4et2biW7fh9a8d+A1ADSpkbGRn5RFRAQzX+V0P0ZbGTcTDTmuOTNQ9Eb0cqk6kKYL11vELRomcZPMmjk1eNqeip1QLm/Bg0/AwGGO5b872nuMpDd1UVsK+fJErEztUzypCnBHBLgcpEDF6oTJfydpEeaVO06eGfpDcrqofVv0BIWpy5k2+HVr6DGohv17tGx0wMNlGc;20:ZqbBMn0xTNFzyQ1Tcpl25SRKSv+g5nJv+b10iX0z4qovXZEG5QU6YY7w06X6JTaQNju1UJ74YhD/QUwOGH/iUu+VuEb22u6G9NDefThDh6rv7EU9KW8cTuaSR4Qk3HpHl9lm/gtkrgSPvUY2yHBdvyGTmpzBigRn2O0h+URgvFo2Ujg051fs7/5RGYMrXAzwpidfqEOXuvBLWbI3V57rKHduruSEen2guW14OR5djFZmgCiU+T1DHiZl6yoIpIih
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:34.7105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f9b779-9c11-4692-0b14-08d5e11f5c36
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laszczak Pawel <pawell@cadence.com>

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/Kconfig  | 2 ++
 drivers/usb/Makefile | 2 ++
 2 files changed, 4 insertions(+)

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
index 060643a1b5c8..575e1fffba74 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -8,6 +8,8 @@
 obj-$(CONFIG_USB)		+= core/
 obj-$(CONFIG_USB_SUPPORT)	+= phy/
 
+obj-$(CONFIG_USB_USBSSP))	+= usbssp/
+
 obj-$(CONFIG_USB_DWC3)		+= dwc3/
 obj-$(CONFIG_USB_DWC2)		+= dwc2/
 obj-$(CONFIG_USB_ISP1760)	+= isp1760/
-- 
2.17.1

