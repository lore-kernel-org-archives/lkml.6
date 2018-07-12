Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22BCC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D621476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rcMr29wK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4D621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbeGLF4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:07 -0400
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:63648
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732227AbeGLF4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk2xtC3N8vyNvatd3n5pIfq9SBsIWB0FkJkeeENCV6Q=;
 b=rcMr29wKfzceaIez1gREWlAt1AG1bsRr35O+J+lFpeH3ZFB6Ex8vUbUACzi9DWRRSzMx4tu0XMoE9x6IKEAvyiY8KPqFg3//P0aVBUFkVQi5yvHQO3AK4WUBYxOoUXaharm21aphncBYR1EO1n7y7kOLWcMXRyGxNOBX930zhYc=
Received: from DM5PR07CA0104.namprd07.prod.outlook.com (2603:10b6:4:ae::33) by
 BY1PR0701MB1335.namprd07.prod.outlook.com (2a01:111:e400:480f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:48:02 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by DM5PR07CA0104.outlook.office365.com
 (2603:10b6:4:ae::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.21 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:01 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT045.mail.protection.outlook.com (10.152.96.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUT017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:07 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:07 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lpg3029800;
        Thu, 12 Jul 2018 06:47:51 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lpuP029798;
        Thu, 12 Jul 2018 06:47:51 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 21/31] usb: usbssp: added queuing procedure for BULK and INT transfer.
Date:   Thu, 12 Jul 2018 06:47:18 +0100
Message-ID: <1531374448-26532-22-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(36092001)(4720700003)(105596002)(51416003)(6666003)(76176011)(486006)(36756003)(106466001)(5660300001)(2906002)(54906003)(186003)(26005)(11346002)(26826003)(426003)(446003)(336012)(126002)(16586007)(316002)(42186006)(87636003)(478600001)(2616005)(476003)(356003)(50226002)(246002)(7636002)(47776003)(305945005)(86362001)(8676002)(14444005)(8936002)(4326008)(48376002)(50466002)(109986005)(1671002)(107886003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1335;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT045;1:IXc/9eDtoUfnBVuhY6dJQcfq0EDWYOkEbLZK8wgoZ+V2jlcZ+BkAsN8eRTW3wyNf3OC+OWNN+pBTdHiRSS+2dwX3nKVYM3j6Lot/CAtAuyChZKYYonL4wQEEl/6bzuLU
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc8237cc-9564-4712-4dae-08d5e7bb0798
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY1PR0701MB1335;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;3:yC9yiYkiJSB/yMyMN1JjrH7ZL4Zb30b2UBS4w2CPK99gahKa/yJqsRW4npX+8A5sH2kj0MQkDFtKMfg4J5AsD4C03GtEbTXbT67GhtHRFCt/nUNlL2/wHUVfHYUlgCV59J1EDa8MwBb91MrEa4iKPM3whPQREvTJPdtyPOBWtUQ6yyP34k0TgjJ1GSg4Or3b4r9wpZQHncHwCpAQ2hJupi/hBs3L7TozV5P6gAWa5XJC77bhj/L+biNbGp5MfRURxA/Ii+o1Zx6ouQu6kWB9+kJEfma9ctpJ/SwknOfzZOj45shT46BEUofBkoASLM9mtTMCcFoB5ROokfGBP04PLgqKkKYqD0UTUtbKN9FB6vk=;25:1fPnNcn3QzAt4lK9taGHlH3eiNRqKdJXdoqFMiXrZzZZKdv/v1vs1G4RKlrhlESV4pbZ4BBUSR5IRdfdSDefgVLuXVcmZ5JlGpJMLrTQdvzc10aL0HXT1AMUqCERLyeIRRVE7fSiqU4gqZtT9c61qjDLtVo+HQi3nNra4lerVDyd4rSfv4SSJRDmWciNj1P+v2ECABDc/s9k9/YYLCNBUz7NuHbq0QemIF4N7wqTbYbvkSYnCy06a/xg5YKtMrILTKIj38wN/QSxXEhtlqHo8d2P7wdmDOF9rWSS8yZeBNglmOluF/hzL5paT6yp+flOOUweBNCobRYiVDF1kGIKWA==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1335:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;31:1/bq0hAsXHL92yS0deejcrujehx97Q8K614yxHOti3qcCgx1EjmF5wd1+jnvILerBOg/9ejRw4z8StA8sVwSvyXqttThBiiu1E8HBTbzbIgtNJUL4c3o8edrd1k/QgakwNnS52pZSTOKdpj7q1JuobNYNmQa9syHm6AdzEoq7QUhmN/+r+A6Zen5INU6T6MHb42+yro0Mc7Itq11FWMKjtWN8yxHsShW+Sul7LsxTQc=;20:hV1aKkEMnBhSZC0+15wr64b5VWSXVeGR4ivVCZbAHMSoVXDmtQ3jO1Zn8LxjYCiHTGgZf13Uq5eNilafQpMX3UKzvU9fMgVLulGUn4eo7omh3ykmMD7a3pMH09+6Bd3QAJI9kp/gp0q2wOhnR/LfEc62fwTorNL+Pbn3W+2YCJBDl/+J0rAdc+Y1J4PhgwY2mFNVYK9SJyTt4wmEPJnkHlDY54S26iUCcheuSAH6nt5d82IfulVHnbYeS8o2iWCTXej7NB78ifkS8EioIVtAoEODypWYHCwcU7z6blRAxjUf7xfF/CYb4XRlasuclUhS1ItNb9zPC6R+pEERQCTqmmt8tR2xuxGLVAmCLhlM/otkfS7OJsGbaW9pqx3tNz3eHgXLnyMwj8okDpJQN6/AyuP7kYR4LMF0QBJ8Iql9mSogaIiw07ARcx8EY2Cvg3hHJmb4cfMA3xKRTJ+QrcsGsqPn9T4ueV00JVN2HW7yO++Fwhz5G8Wx5h5P9+OCATYh
X-Microsoft-Antispam-PRVS: <BY1PR0701MB133544F5453AC09B1CA40ED5DD590@BY1PR0701MB1335.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1335;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1335;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;4:o1I9S4zGOXmSvtNucAw/gcYZKO4nxkyjZqa/o+RCrTtRrgW3xHhUJB1xpXwEEkQ4Ev/dtR2vdIlRIS7W8cdPchyiM4ZnJpXEttMioSZYe4joo/1CYaFn3lV9zC+tAlMY8fJowELgVMArsD9z8xhuA8iMhjB9fQniA72MUvBRZ58S831/l3ZaYFpkU4p8onaXPEhxLC2Dia4s7Qx/eHzACFWdzn2D9WZi/3L0kmzaVF3TQu3ymOF98MNpoPc3ewU8yJB7+vXvuwnxoKUWMWshbjzapvoPPVvChaQcEFzKUyCe3HukCJRVaz25+KvNezXJ
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1335;23:XkpONiJmDbpHxllalOTdVru+X9tuqN4hOP05Xwt?=
 =?us-ascii?Q?54z/XCnvqZDJ6+hf8YvfOpiguUzJTw+btdL04bHFlLcvB14sxq5GW76EfVVE?=
 =?us-ascii?Q?8LIz782Z+KefxkNjo8On0QbD7tOx5sgra60kcvbToqLhzWPnh3P8EcONXUUU?=
 =?us-ascii?Q?zAJWDiEGoD6f2Er7nzeDZVtw8CQLqBauvz3dKI0e3LCoJ3eXo6T/toNQBvPi?=
 =?us-ascii?Q?2XqrR+7/1Uzw1QrIPPBI8EP7mb3prY7Rv9BOFFw9sF2B3lomUpb9vzKiVMqk?=
 =?us-ascii?Q?NDbCxJSsP6bBEAQs8Tfn1ZvuOP65si3qwiLWIOZ8l84oLB62ypc6ik+a0S9n?=
 =?us-ascii?Q?SyO2Zwwp8UhOj4RVhIOvVnWjzHGaEttHcbpA7O9LK4bjvaj9c1G7J+M+H4lC?=
 =?us-ascii?Q?TOq3+lCq07fbQ4Q9HTphuXsKwfcfinCjmerSBJaiO5xDeyd/Ip2WNu5+VLFP?=
 =?us-ascii?Q?kypy2XXH8f60MdfZXQvRofu5deQ5Nmho17J9VJ1qGyzrBgQZAquFQafcDSnJ?=
 =?us-ascii?Q?5BpOcz5aWntCpE5nwtVTGyMXoYA/UaSoIO39hIj/P8FdAqjYtVM5ScKbXAY3?=
 =?us-ascii?Q?ePVJdCHdc14xpEvXyC9/WbV4dY5Ixfmela5yDm8t4nE1wUCWSFjZBaLAzi28?=
 =?us-ascii?Q?dxAJCZksZwP1MzDApm8z1p1DXqNTwF5vg7ynJUfL8wJgbN47C3t3iL8sONb1?=
 =?us-ascii?Q?Dw/O1iVUh0GKnGnKl0PZcddFhYEDwA4qIUd0eHV5P4SLB3FKrCg9FVjC02+K?=
 =?us-ascii?Q?zcbqrhBzjJiiuKlLANmACfgn26eE4trrXrDgaNUbZFzmAU+BWfisz4MG4yoJ?=
 =?us-ascii?Q?MwW0UkuRfKatHRAi5/I89YHWYc8sKyQb1XXGkWSmkd2flJo579Qaf4VTCPY2?=
 =?us-ascii?Q?NnaKfq3z6927sb/hbTMjH0s9jXHd4HraY6F5RmRW+gjtY8RsDsc4pC0G92Gw?=
 =?us-ascii?Q?9OaUEdQ42ij+Tr1HbdUMSYKzaFuFCsDDbfESSoVRS0Pz4K3Nlez/hm6LRpNX?=
 =?us-ascii?Q?ZxcDJuClVzWtrj8NW7/O/A3LbX6O1holyQmdzj+SZyjwvxpvZ/12e/nK4ep4?=
 =?us-ascii?Q?G7gwHUbe2SAhM19/WcPw+/JX236KPnb4J11RXY5lhf7SX8q10Dxck4nCkDIz?=
 =?us-ascii?Q?6TOv1WGOxIJRx8zeDZkr+2kgawr/WIzA9O9D0gH2Q8VgWgZeAzV6QEg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: jg8VA+8fEJZJiff5aoeHT9rpIvMDrYCi/+S+38hCXivmkpRu+cqD6J8mrgckyxEayJcD5yP2sVyj7bSVfl7rub/CRmCqMHeZAVU1Y3gOEsqxvcAfASJBXU8UyW5aRdAzqXqO8mpgIi7NYXQo6j1tRIs+9hWDZnJ4OSWhZZnSG4qZlwQjHk7vWadmNgK7vTJHuwymtIHv+jt31neEY1lUlqcWS1GKDFXrRB1FRAPK+la8+ySnwJM2Z+gb1vNbzCnQhSaDrvtbYnwX+W+LWHsy2zp/TR9iqzUDjseTShJvfilf+0hRpb63TTOAvwApIkraFZY+WMNpqH5AS+grS68xhOn6FUQRsoZNOF6U8ZZAC3r13Lfd/4z0+oM+Gm+dSr1pT7JF3cAGVmHtJZ3+Pt4QBw==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;6:JII80OqoaIHh8pZOflm3/WffCdXLki964e/auJpM7S3I6Oh+6BfPVNALsNSErIlxfWws5w9K1hs56EtYnAh45uDz+19+xOO/cG651h3wFOXVTCt1xKxXhlakCnYolkX39FPI1vS3HiXte7tWcVGrsWrhIPR+lS1P/K1w3BpjYTFzn3igzYRuyWAa+HXNda0ayz0gsaOmqPrExtkfhAnmFvlTUNz8Q2tZWUCsQ6BFCMH775T4sR2Vbi15mgAXRXlRGhYJh7hjfRfI6rDlcD+pzjMASGGKGyRlu+7B2TzmB5IeoDDyjHEp2yIpa8+gPvPZTf5hHkEgD2+IYVwQhH81C0BTybaLgXkGlR8y37UIlJ2LiX/fr5xah9/AVj1jt/xb5vDMZmYZzgO6TrxUPF/h38D0DbB1KkcnSN1f9BvqK45qC8h6VypACULwGGlagVch1nUOZUnnml7A39vebju3jQ==;5:110owh7ukOamncZe4roGmbhTwl3De1G4jzkfurzJnclGZjU7O59t6ttSHNBaWeaOpgLouQ0BT8VeLK5AO2qFQ/PvgkEZ+vhQU6j/ZaZDvxi0taLYtteQC2dk4I3bOSyYCi/7MuoSeGDyaAeVwqfyqfovDQEIo8DUL8UBewFyh7E=;24:ovJD6g1Rnt2sEInYR/yaHETgt5h/yPjzoVkOcwiD1VSbroN5s9GZPQEgyKpQ8QNSVH5jD/Q+cRyAoCtTAK35y2VpJG7MJUUg7deQFpPoCRo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;7:aGMPzUxT8/NyG+bTgMp69MlaYzd2GFh8DaH3VuRgN9iTo5FRE2jc33decmY9Ts1eQWvYJ+CrmcU2nbD9PDbXxsHV+RsK7/1rD70UwfEKDOf9Do6hMNZ5jnhPpuC3W6OpcWyhwRD95U92mVfwMfpmqeegWpbumWebDO3/wXW7R5/cx5DaaLwf/UcsMNvMrVjiOj84p5zObas+832K3m8V+aeyuzqppEXbat+zHt9psFrk/jwDBB8spd76la07mA2z;20:nEqVbLYd33dU/7Vd42lOiHybriMC9UIhPvb/ozGCG3WERyeNlwcsxh4BUUE2iGn+GRjmhk6tmrXdxGDaIGZHA9PqQ7Aajdp8+Fxx3KJ3PsiXmBHKrAtNL6s5LSoXzJ9uWUTt4u5I7hbvZwyQgL/YH5psQQUtlnadVKWLFB4LwBzQy2sG9t0Y3GRPbERrY2e7C54aqE5OTWZHeA76/LLrjlJocG8Pv/J1wDUVwsJE7V/0LG1C1hm7nr7YEf5ZLJIN
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:01.3396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8237cc-9564-4712-4dae-08d5e7bb0798
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1335
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds usbssp_queue_bulk_tx and usbssp_queue_int_tx function
that prepares TD, adds TD to transfer ring and arms the transfer.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 286 ++++++++++++++++++++++++++++++-
 1 file changed, 285 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 1b763faca7bd..1ee6b056c87d 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -1576,6 +1576,74 @@ static int prepare_transfer(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+unsigned int count_trbs(u64 addr, u64 len)
+{
+	unsigned int num_trbs;
+
+	num_trbs = DIV_ROUND_UP(len + (addr & (TRB_MAX_BUFF_SIZE - 1)),
+			TRB_MAX_BUFF_SIZE);
+	if (num_trbs == 0)
+		num_trbs++;
+
+	return num_trbs;
+}
+
+static inline unsigned int count_trbs_needed(struct usbssp_request *req_priv)
+{
+	return count_trbs(req_priv->request.dma, req_priv->request.length);
+}
+
+static unsigned int count_sg_trbs_needed(struct usbssp_request *req_priv)
+{
+	struct scatterlist *sg;
+	unsigned int i, len, full_len, num_trbs = 0;
+
+	full_len = req_priv->request.length;
+
+	for_each_sg(req_priv->sg, sg, req_priv->num_pending_sgs, i) {
+		len = sg_dma_len(sg);
+		num_trbs += count_trbs(sg_dma_address(sg), len);
+		len = min_t(unsigned int, len, full_len);
+		full_len -= len;
+		if (full_len == 0)
+			break;
+	}
+
+	return num_trbs;
+}
+
+static void check_trb_math(struct usbssp_request *req_priv, int running_total)
+{
+	if (unlikely(running_total != req_priv->request.length))
+		dev_err(req_priv->dep->usbssp_data->dev,
+				"%s - ep %#x - Miscalculated tx length, "
+				"queued %#x (%d), asked for %#x (%d)\n",
+				__func__,
+				req_priv->dep->endpoint.desc->bEndpointAddress,
+				running_total, running_total,
+				req_priv->request.length,
+				req_priv->request.length);
+}
+
+static void giveback_first_trb(struct usbssp_udc *usbssp_data,
+			       unsigned int ep_index,
+			       unsigned int stream_id,
+			       int start_cycle,
+			       struct usbssp_generic_trb *start_trb)
+{
+	/*
+	 * Pass all the TRBs to the hardware at once and make sure this write
+	 * isn't reordered.
+	 */
+	wmb();
+	if (start_cycle)
+		start_trb->field[3] |= cpu_to_le32(start_cycle);
+	else
+		start_trb->field[3] &= cpu_to_le32(~TRB_CYCLE);
+
+	usbssp_ring_ep_doorbell(usbssp_data,  ep_index, stream_id);
+}
+
 /*
  * USBSSP uses normal TRBs for both bulk and interrupt.  When the interrupt
  * endpoint is to be serviced, the DC will consume (at most) one TD.  A TD
@@ -1631,12 +1699,228 @@ static u32 usbssp_td_remainder(struct usbssp_udc *usbssp_data,
 	return (total_packet_count - ((transferred + trb_buff_len) / maxp));
 }
 
+static int usbssp_align_td(struct usbssp_udc *usbssp_data,
+		     struct usbssp_request *req_priv, u32 enqd_len,
+			 u32 *trb_buff_len, struct usbssp_segment *seg)
+{
+	struct device *dev = usbssp_data->dev;
+	unsigned int unalign;
+	unsigned int max_pkt;
+	u32 new_buff_len;
+
+	max_pkt = GET_MAX_PACKET(
+			usb_endpoint_maxp(req_priv->dep->endpoint.desc));
+	unalign = (enqd_len + *trb_buff_len) % max_pkt;
+
+	/* we got lucky, last normal TRB data on segment is packet aligned */
+	if (unalign == 0)
+		return 0;
+
+	usbssp_dbg(usbssp_data, "Unaligned %d bytes, buff len %d\n",
+		 unalign, *trb_buff_len);
+
+	/* is the last nornal TRB alignable by splitting it */
+	if (*trb_buff_len > unalign) {
+		*trb_buff_len -= unalign;
+		usbssp_dbg(usbssp_data, "split align, new buff len %d\n",
+				*trb_buff_len);
+		return 0;
+	}
+
+	/*
+	 * We want enqd_len + trb_buff_len to sum up to a number aligned to
+	 * number which is divisible by the endpoint's wMaxPacketSize. IOW:
+	 * (size of currently enqueued TRBs + remainder) % wMaxPacketSize == 0.
+	 */
+	new_buff_len = max_pkt - (enqd_len % max_pkt);
+
+	if (new_buff_len > (req_priv->request.length - enqd_len))
+		new_buff_len = (req_priv->request.length - enqd_len);
+
+	/* create a max max_pkt sized bounce buffer pointed to by last trb */
+	if (req_priv->direction) {
+		sg_pcopy_to_buffer(req_priv->request.sg,
+				req_priv->request.num_mapped_sgs,
+				seg->bounce_buf, new_buff_len, enqd_len);
+		seg->bounce_dma = dma_map_single(dev, seg->bounce_buf,
+						max_pkt, DMA_TO_DEVICE);
+	} else {
+		seg->bounce_dma = dma_map_single(dev, seg->bounce_buf,
+						max_pkt, DMA_FROM_DEVICE);
+	}
+
+	if (dma_mapping_error(dev, seg->bounce_dma)) {
+		/* try without aligning.*/
+		usbssp_warn(usbssp_data,
+			"Failed mapping bounce buffer, not aligning\n");
+		return 0;
+	}
+	*trb_buff_len = new_buff_len;
+	seg->bounce_len = new_buff_len;
+	seg->bounce_offs = enqd_len;
+
+	usbssp_dbg(usbssp_data, "Bounce align, new buff len %d\n",
+			*trb_buff_len);
+
+	return 1;
+}
+
+
 int usbssp_queue_bulk_tx(struct usbssp_udc *usbssp_data,
 			 gfp_t mem_flags,
 			 struct usbssp_request *req_priv,
 			 unsigned int ep_index)
 {
-	/*TODO: function musb be implemented*/
+	struct usbssp_ring *ring;
+	struct usbssp_td *td;
+	struct usbssp_generic_trb *start_trb;
+	struct scatterlist *sg = NULL;
+	bool more_trbs_coming = true;
+	bool need_zero_pkt = false;
+	bool first_trb = true;
+	unsigned int num_trbs;
+	unsigned int start_cycle, num_sgs = 0;
+	unsigned int enqd_len, block_len, trb_buff_len, full_len;
+	int sent_len, ret;
+	u32 field, length_field, remainder;
+	u64 addr, send_addr;
+
+	ring = usbssp_request_to_transfer_ring(usbssp_data, req_priv);
+	if (!ring)
+		return -EINVAL;
+
+	full_len = req_priv->request.length;
+	/* If we have scatter/gather list, we use it. */
+	if (req_priv->request.num_sgs) {
+		num_sgs = req_priv->num_pending_sgs;
+		sg = req_priv->sg;
+		addr = (u64) sg_dma_address(sg);
+		block_len = sg_dma_len(sg);
+		num_trbs = count_sg_trbs_needed(req_priv);
+	} else {
+		num_trbs = count_trbs_needed(req_priv);
+		addr = (u64) req_priv->request.dma;
+		block_len = full_len;
+	}
+
+	ret = prepare_transfer(usbssp_data, &usbssp_data->devs,
+			ep_index, req_priv->request.stream_id,
+			num_trbs, req_priv, 0, mem_flags);
+	if (unlikely(ret < 0))
+		return ret;
+
+	/* Deal with request.zero - need one more td/trb */
+	if (req_priv->request.zero && req_priv->num_tds_done > 1)
+		need_zero_pkt = true;
+
+	td = &req_priv->td[0];
+
+	usbssp_dbg(usbssp_data, "Queue Bulk transfer to %s - ep_index: %d,"
+				" num trb: %d, block len %d, nzp: %d\n",
+				req_priv->dep->name, ep_index,
+				num_trbs, block_len, need_zero_pkt);
+
+	/*
+	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
+	 * until we've finished creating all the other TRBs.  The ring's cycle
+	 * state may change as we enqueue the other TRBs, so save it too.
+	 */
+	start_trb = &ring->enqueue->generic;
+	start_cycle = ring->cycle_state;
+	send_addr = addr;
+
+	/* Queue the TRBs, even if they are zero-length */
+	for (enqd_len = 0; first_trb || enqd_len < full_len;
+			enqd_len += trb_buff_len) {
+		field = TRB_TYPE(TRB_NORMAL);
+
+		/* TRB buffer should not cross 64KB boundaries */
+		trb_buff_len = TRB_BUFF_LEN_UP_TO_BOUNDARY(addr);
+		trb_buff_len = min_t(unsigned int, trb_buff_len, block_len);
+
+		if (enqd_len + trb_buff_len > full_len)
+			trb_buff_len = full_len - enqd_len;
+
+		/* Don't change the cycle bit of the first TRB until later */
+		if (first_trb) {
+			first_trb = false;
+			if (start_cycle == 0)
+				field |= TRB_CYCLE;
+		} else
+			field |= ring->cycle_state;
+
+		/* Chain all the TRBs together; clear the chain bit in the last
+		 * TRB to indicate it's the last TRB in the chain.
+		 */
+		if (enqd_len + trb_buff_len < full_len) {
+			field |= TRB_CHAIN;
+			if (trb_is_link(ring->enqueue + 1)) {
+				if (usbssp_align_td(usbssp_data, req_priv,
+					enqd_len, &trb_buff_len,
+					ring->enq_seg)) {
+					send_addr = ring->enq_seg->bounce_dma;
+					/* assuming TD won't span 2 segs */
+					td->bounce_seg = ring->enq_seg;
+				}
+			}
+		}
+		if (enqd_len + trb_buff_len >= full_len) {
+			field &= ~TRB_CHAIN;
+			field |= TRB_IOC;
+			more_trbs_coming = false;
+			td->last_trb = ring->enqueue;
+		}
+
+		/* Only set interrupt on short packet for OUT endpoints */
+		if (!req_priv->direction)
+			field |= TRB_ISP;
+
+		/* Set the TRB length, TD size, and interrupter fields. */
+		remainder = usbssp_td_remainder(usbssp_data, enqd_len,
+				trb_buff_len, full_len, req_priv,
+				more_trbs_coming);
+
+		length_field = TRB_LEN(trb_buff_len) |
+			TRB_TD_SIZE(remainder) |
+			TRB_INTR_TARGET(0);
+
+		queue_trb(usbssp_data, ring, more_trbs_coming | need_zero_pkt,
+				lower_32_bits(send_addr),
+				upper_32_bits(send_addr),
+				length_field,
+				field);
+
+		addr += trb_buff_len;
+		sent_len = trb_buff_len;
+
+		while (sg && sent_len >= block_len) {
+			/* New sg entry */
+			--num_sgs;
+			sent_len -= block_len;
+			if (num_sgs != 0) {
+				sg = sg_next(sg);
+				block_len = sg_dma_len(sg);
+				addr = (u64) sg_dma_address(sg);
+				addr += sent_len;
+			}
+		}
+		block_len -= sent_len;
+		send_addr = addr;
+	}
+
+	if (need_zero_pkt) {
+		ret = prepare_transfer(usbssp_data, &usbssp_data->devs,
+				ep_index, req_priv->request.stream_id,
+				1, req_priv, 1, mem_flags);
+		req_priv->td[1].last_trb = ring->enqueue;
+		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
+		queue_trb(usbssp_data, ring, 0, 0, 0,
+				TRB_INTR_TARGET(0), field);
+	}
+
+	check_trb_math(req_priv, enqd_len);
+	giveback_first_trb(usbssp_data,  ep_index, req_priv->request.stream_id,
+			start_cycle, start_trb);
 	return 0;
 }
 
-- 
2.17.1

