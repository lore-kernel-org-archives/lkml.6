Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80961C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060CE21F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Bn0vaF5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060CE21F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeGCUBE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:01:04 -0400
Received: from mail-co1nam03on0044.outbound.protection.outlook.com ([104.47.40.44]:21425
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753070AbeGCT6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/shWsvt55QGw090+5IOx1zqCqf0lpq7h1EANnXnkFWE=;
 b=Bn0vaF5NzM5fkiBCpSbhXHbkdAoJgoHDXMuAQ7ALf6IjYJaISd9on8l3MgqonCHUHIdbGuiY1TFuX0AfvFG+48eB/eQTSoLouwdXTysC0sAmod+thFw0Hkb6i6amJENjfcnZFk19O/KKR6P9WcWzmTK7yV8GnoMGAKxdV4eDFK8=
Received: from DM5PR07CA0031.namprd07.prod.outlook.com (2603:10b6:3:16::17) by
 DM6PR07MB4714.namprd07.prod.outlook.com (2603:10b6:5:a1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 19:58:29 +0000
Received: from DM3NAM05FT039.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by DM5PR07CA0031.outlook.office365.com
 (2603:10b6:3:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.18 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:29 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT039.mail.protection.outlook.com (10.152.98.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMs7006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:27 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:41 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:41 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwORt012301;
        Tue, 3 Jul 2018 20:58:24 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwOOn012293;
        Tue, 3 Jul 2018 20:58:24 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 09/15] Introduce Cadence USBSSP DRD Driver - added debugfs files.
Date:   Tue, 3 Jul 2018 20:57:53 +0100
Message-ID: <1530647879-10007-10-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(36092001)(189003)(199004)(476003)(316002)(42186006)(69596002)(4720700003)(107886003)(6666003)(16586007)(8676002)(36756003)(8936002)(53936002)(5660300001)(54906003)(446003)(110136005)(106466001)(97736004)(105596002)(87636003)(478600001)(47776003)(86362001)(575784001)(68736007)(486006)(50226002)(81166006)(76176011)(14444005)(81156014)(48376002)(126002)(426003)(336012)(11346002)(4326008)(50466002)(186003)(2616005)(26826003)(2906002)(26005)(356003)(51416003)(305945005)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4714;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT039;1:BA5RlQxzjm6h+LcEssFv9euS0K4OkQ61ulaBtlaYrgeu6QK0yKvBYq9GCKVcjDatN1T/Lao1xZFLfeBfL2a1PWoM/azDqc3CL/hZlF82YTKrsVNTkfMCoJV8IaYkSv2Q
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c03edc-884a-48cb-4475-08d5e11f589b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4714;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;3:kaqJegfB7KQoayqdgjtWjEModa+A80rXTT/NCYjgKIbM1ie73u5vCj0nLjFOgfzufR8YxDOlG45P2bHa2WFpw608tLI8rhxSwCCp3KGkUbfuPDmiaM3VOdOouLI5tIGjXEec93HbgKmC7p28sgd2VUDWyxS7YxaaRhUlltWrIhvGhKNayZfAm/rPXrUKBOecN5GUdBF3kJDg6Ap3LBJXr1C00bnHKaBOQJGuvdz36Aw2AiEfmQ3REbK3uW4l/h6QIdE8LYuMzDLxYCBgPZCkFol19DnVNiZd+VyDJef9PKPQ/3imiLmuOQO0NUxX/f/crCnx9yQhGBz5umQAInU0jg==;25:X88vf4hFEv4seIghJ2YwzmXqP72AX+Hd4bxjh8MuRns64JsBUhYdjLTJBgWdTvrxmYkpGd9jjbg5LGXa3z8nFlDpB/WAKFc+seYUzkYD+tXcmdqxQOUtVB3fnMAOS2dGnsT3O65yDGZQHhxrruLWQZArPoxDTjl6gTnwMX2rbAcZqPI91jfnaIQVk+GMuw6dBu+KiWQTEErcJAEQnR1uohbbgr1v/dw5+2BXue7yaMt4v90MoEG4Lnh3FrVLPBU89Y+pAfo2KRY3qkkPexkwArbg1MdxZFd6r0HBOP7ONRVEbuqLOS3Y7dMQRXWWjs8xGCgQLRNw19T+Iq8yq/Q9Mw==;31:t3Oyr6UbHP30NQs0A0RqK8jAI8og8OopHcIyyW2cRmCaUxLJ90aGmPXSkmFpJspSgTzBM9Lpsqg0METuTWlPJzc90Ks3JD/RLeS7lD4F6hV92V04mrLpEw0fm90gloRyei1OnwmL1w0mBM4Zd6YlYnkUs9ngxvH5gRRiFz9M0zm7GhN82epnG8DN5w4Hmg0tlCAhef/xuYu72BWaP+gDq788JzurNPZnfLHsM7Igr+g=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4714:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;20:naAOcGKDph8BsQkvH9vt6tJejEw6NT15jz4/YMbPUEZIvX9CXfUlO1OkXqCKAsCDyBQ1wKKzoMPcqW3HfLaWGwkod9elgFyiwbXYBDbUjXn7i5RX3NuujP7ZWQGwtQ8PdpGICYjWOqHBBqucbpC73EfrBtTOFCCQvWZ++OqkffWuIpVr0usMYYuhzlqxYp8suzxwWVn3MP+pbcoFjB6Q9w55TEsu/ADE8IRpPQYr4cb86o25QTQD5EtfOU1B5RIRSBd14jNvTF0upCW13VFeGKrlL5QhK5cvuCNl4zQrbA7wSlkjErB5rZuOTeufslo+PLN601jnh2/i9GThGevq9Rz9nPDhHedxfu9h5lm08VlwpBkG+Lx3lzhGoTlC1PGs5EAe5gYh0YNypxwIWWi/Cvj3rsD7bhqBN/cYcmETe4d/5B4H0nu9Dinjp1WN7c8ADFwpCMt90zBpl3kdJ3VWwr7VFXU1UkO/umY9RZO8w19EpQuYzKjASggrEALVuPJy;4:qxA887ymxDQUPj+7q/HhjnyR9FkLli8IpUBMsgcYLkoYrS/qB1vu4+NfXZmGNfWOHzHWZMbUsOnVAn313zXxAGDdevlg9vI4dlPvPp4BZUHHbBNlm4/xd54XJRFSECrmvueM5ZWa5aQL7syKJRl9x3L3aon8L/S9mHwYbJLB8a9+jiWDs5M4dKgNZDXqzMD2Le7/WFDGQKJYttjQ8HvcTrN4yAw+bS+mtByZxezGMRGdKtdhq2Ton+3JQYSEQdfTeNOEoZn0LrzO2O4EWXpFi6bcxKh9QSNMNqL14ANGCktwG+J0nfG9BZ1XWvwmH1pF
X-Microsoft-Antispam-PRVS: <DM6PR07MB4714CEF70559E618BFEB31EADD420@DM6PR07MB4714.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4714;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4714;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4714;23:wWZlsEsxk0tG5Ui96OafOzNG2zGnHIA9SXEuWJJ4D?=
 =?us-ascii?Q?4FkT0sBREFIGmGlvz+mbA2ZgeuSLxUcr8tZ3bzagtj8NBJy3s/9O0695fSur?=
 =?us-ascii?Q?AQPlhZCiSkFPNrqvQlfW8/Cl4cJNrgfBBLYyxm06Cu8pBVukcGQzSG9a3/Oh?=
 =?us-ascii?Q?NqsNiS7BJZ3lspqjVpFfOt/VtotmF7GEMiGO5qpTiU6xAMNZWtXTmAb9M3XA?=
 =?us-ascii?Q?G+ewxl1MSZtRA9QoW1YsERboiHsFPcpJc4NWYA9wCiYkoePPICeSbiU2j1H1?=
 =?us-ascii?Q?8aLIMyerH041NsMB/QAfD/GiH4FcneW3hmK63g+X9VxDclE73AX7MVLjFAyH?=
 =?us-ascii?Q?EX7gg0x84URkc/kTLKATjBl9uSnSvCysimDRsWBKGdZbf6fGpMKY1y3ni6Vk?=
 =?us-ascii?Q?zHULFbE3IFjU5sOQF7G+8EUEXE+wayC3MSE7WqsiVo3j4pem3vFQk7GjG13A?=
 =?us-ascii?Q?DVoBfT0AScIC944EolZE0bZ0ejIbgjcZUDfQJkGWd6jOEQ1RyVK+KzwVo8Q0?=
 =?us-ascii?Q?Jta9aQ2+RRLVM4p2efOl0r2QPH+XxGGOrZevurma9rUb0nWZOsoxma+dHZVt?=
 =?us-ascii?Q?5ThEOp5UG+PdJBM73HLK0kqAB93GpWtSvqJRylNg14UyQoQGwbMF+XxRox8O?=
 =?us-ascii?Q?uDOhLKHTAhAoqJd2mOHYomV0Ks0aXBi6mXBp+nsssquW4CqybM0BPOvfBiFM?=
 =?us-ascii?Q?hJKPDdL3RG2UTdIwkb83CB3JCLOwGouiGw3YESc/9ajxSq2UxXyf9K6nCdke?=
 =?us-ascii?Q?YQBkECRBCbo+dn0ym3akV2WX6gNrzqbAKkKmVSiKxdEXvS7LpZ8WyJuDVlZF?=
 =?us-ascii?Q?Brpzr4iSZowoFygPVW6YHmHCvu/QA9amE7+PyVY6eKKWoDRdmiL5t3AT0DC2?=
 =?us-ascii?Q?r8OKp6868BTAZX0BsFOS/SC1lBdgE1Fohm52XgbHDV8yXXxVR3y8RIpJHf3x?=
 =?us-ascii?Q?cFMi+5SG+zOFPfwCTiVJuqYBl+5WB05495eUzjEh+ncnuWY0vE0NrbP1+6Lz?=
 =?us-ascii?Q?SpEClask4v4Yc57rpc2eRvJkeotgv1uLfYDi5ojX7gbx7+1T3Mla20mN8trv?=
 =?us-ascii?Q?7UU0fn9Us7UZVnMCwtlZ3foVAfqptBjN2wT3yKJ1p24jxcfGvFDW7tHJiGyp?=
 =?us-ascii?Q?R/cVuEMTuUjmjZrOjUtS52iZMzReSeC9mgJJ1cnDu44uU/XkSreBlugZQ2b2?=
 =?us-ascii?Q?eTz/E8AN478d0zDY4VydCZrbULEst43wCaLO9c5U73CKybtDrVBzCoCP+6dp?=
 =?us-ascii?Q?LcCCSh5SXhUxrX914+V0/oTWLA8IaD+zFLTA5c+?=
X-Microsoft-Antispam-Message-Info: LMzXvbeBV1T7dDwlXgW8EHCDa5R9KBpArfKyOKDD86Ew6gEybI7WEK7s3raMi5OQ9pU9XJNpW544ES/PWeFhJLipCTi4Yh0qhKgzWqUwJlOdRQnX8fL2GnLb/wPUy4VBBUj9ZlceH07dJamXFceTCWONqn2deBZ/VwPCf+DE/Ul012SmOKMqRw9YaENb5woZJk2HfxHv2XawRa7Ugw/2d4Dg3otdkAcA6YBx63pgo35mDsJ4ksO8uYW9b51y3koHLx+SaqC+/Xs5I7UNjty42AswdLF7/Y1v3OownBkg2KIEdh+VixZPnJ8Kb1QCftqtmDCuo24okSD5nFFUMQrby6v1woK3SJbc7JpAuKaTMVqCMc0jCE7MRQVXo1tQ5Uv9xPKsgKGKjGdD8q8z7er8Vg==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;6:89ggKgj7DQXXHs/edKEQqpwJj7PN5AQ2pYwRh7ssxAAtSuru3iO7LwUCyhTswsWuoj5em80U7t7pGwupkBCYpqD7ZbSiQfswyJxgZsRJv9l1KtdSIgnUCtoiRjyNsiMHQiyozWNxSSzCzr89IbuHYJ/5go5Tn3CxlKq/pyhvvvJ+mwTXcftepzxa54ZBmICrRY45W0zl7xVuh+eR0Kme+ACw0h9pQmZ4fqUyrbPA908sM0rRc+mIFKn02m0AdJFk5CZuoEdbYQO2aPZar1A+JIe7LiO24XV8OedqHtF2QTI0K7jz0wAh7tdumXF+NvlK11QffMqr5TFLRQ2P7UNmI7cokfBbETRex50/4Ka4NmGCkfTpDc+IV6qvbZa54wCE8RRi0KPSv6vecwE+p6n1CGcdQwwvegdnToxhubP3KCNZNrni+vqt/x0cZ81GQ5Sx/yKc9UiK6FrbXPFlU0BtMw==;5:TDmuXFGGr6HOOUtoOc55WPj+ciZ+dD3GEQxJWyo9KH9nO5gvrvmH1GEpmJIVqCtiHD6RF5txCQDPubjc1nrP98YexER/kvMBMwUsXXs/T97F22qa2QI1vBdNcaGsmd6J3vHlb5qXwqUKYl45FYYeQZ18FSFbp0MKIpgkLOR59u4=;24:Rsz+XM2zUoEungIy6a6klLuX1DL2/WuvXRS3nqHLgc7gcWH1hDc2EDE7l48iWl90lSgN6sWwGLlolMPO8EQFEuSCxqXL/mtCcL/Gkx/aSVU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4714;7:MeANZc9LObhxPdyOHlck3UzuaMK+Le5ygE1Xh4lvExEuXYYeEGvbMimIYhc8n42Ox45pQiL3EovD5voJhJ/lLaWH3EdFIb3eEvzf/q67En3JLvupckRRZE/r6DD0tBA9w3O02EW9aALfavzU3s1Sf5M0BE++mKsGBDoKPRxPQpZpPZABjzqFbchElHN1XDeN5DEx76RMRwsbNgMT/5yPzxOdjQiE5kGKX+MdtojUudlP+EvU2smS9+VbH/XANfOk;20:6GlI8Z3WMPpIC1poaWq1Rtui6ajpLNNAsH75iRjaT2HhSnD58WNp2Zy52+2GJgdoIevnS+v1OWYbTWDZY6oB13DYSHHx6deVH5cUdntn4Az5rd1EvpViUsRYWGegoRFeebOrdrVg/wKhElhmLrQOJRZJYdNmC8ddrHQqEoaTrokg2is2UJqnqUzz9ELk74FVh5WZ1qvvffYiK3ZHEI74h/+z0xQR++gbeRpa/gVIs6Vnd3rT8FEkX2jRpvbe4HqP
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:28.6786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c03edc-884a-48cb-4475-08d5e11f589b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-debugfs.c | 514 ++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget-debugfs.h | 137 ++++++++
 2 files changed, 651 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-debugfs.c
 create mode 100644 drivers/usb/usbssp/gadget-debugfs.h

diff --git a/drivers/usb/usbssp/gadget-debugfs.c b/drivers/usb/usbssp/gadget-debugfs.c
new file mode 100644
index 000000000000..c0d1e96728e6
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-debugfs.c
@@ -0,0 +1,514 @@
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
+#include <linux/slab.h>
+
+#include "gadget.h"
+#include "gadget-debugfs.h"
+
+static const struct debugfs_reg32 usbssp_cap_regs[] = {
+	dump_register(CAPLENGTH),
+	dump_register(HCSPARAMS1),
+	dump_register(HCSPARAMS2),
+	dump_register(HCSPARAMS3),
+	dump_register(HCCPARAMS1),
+	dump_register(DOORBELLOFF),
+	dump_register(RUNTIMEOFF),
+	dump_register(HCCPARAMS2),
+};
+
+static const struct debugfs_reg32 usbssp_op_regs[] = {
+	dump_register(USBCMD),
+	dump_register(USBSTS),
+	dump_register(PAGESIZE),
+	dump_register(DNCTRL),
+	dump_register(CRCR),
+	dump_register(DCBAAP_LOW),
+	dump_register(DCBAAP_HIGH),
+	dump_register(CONFIG),
+};
+
+static const struct debugfs_reg32 usbssp_runtime_regs[] = {
+	dump_register(MFINDEX),
+	dump_register(IR0_IMAN),
+	dump_register(IR0_IMOD),
+	dump_register(IR0_ERSTSZ),
+	dump_register(IR0_ERSTBA_LOW),
+	dump_register(IR0_ERSTBA_HIGH),
+	dump_register(IR0_ERDP_LOW),
+	dump_register(IR0_ERDP_HIGH),
+};
+
+static const struct debugfs_reg32 usbssp_extcap_legsup[] = {
+	dump_register(EXTCAP_USBLEGSUP),
+	dump_register(EXTCAP_USBLEGCTLSTS),
+};
+
+static const struct debugfs_reg32 usbssp_extcap_protocol[] = {
+	dump_register(EXTCAP_REVISION),
+	dump_register(EXTCAP_NAME),
+	dump_register(EXTCAP_PORTINFO),
+	dump_register(EXTCAP_PORTTYPE),
+	dump_register(EXTCAP_MANTISSA1),
+	dump_register(EXTCAP_MANTISSA2),
+	dump_register(EXTCAP_MANTISSA3),
+	dump_register(EXTCAP_MANTISSA4),
+	dump_register(EXTCAP_MANTISSA5),
+	dump_register(EXTCAP_MANTISSA6),
+};
+
+static const struct debugfs_reg32 usbssp_extcap_dbc[] = {
+	dump_register(EXTCAP_DBC_CAPABILITY),
+	dump_register(EXTCAP_DBC_DOORBELL),
+	dump_register(EXTCAP_DBC_ERSTSIZE),
+	dump_register(EXTCAP_DBC_ERST_LOW),
+	dump_register(EXTCAP_DBC_ERST_HIGH),
+	dump_register(EXTCAP_DBC_ERDP_LOW),
+	dump_register(EXTCAP_DBC_ERDP_HIGH),
+	dump_register(EXTCAP_DBC_CONTROL),
+	dump_register(EXTCAP_DBC_STATUS),
+	dump_register(EXTCAP_DBC_PORTSC),
+	dump_register(EXTCAP_DBC_CONT_LOW),
+	dump_register(EXTCAP_DBC_CONT_HIGH),
+	dump_register(EXTCAP_DBC_DEVINFO1),
+	dump_register(EXTCAP_DBC_DEVINFO2),
+};
+
+static struct dentry *usbssp_debugfs_root;
+
+static struct usbssp_regset *usbssp_debugfs_alloc_regset(
+				struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_regset *regset;
+
+	regset = kzalloc(sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return NULL;
+
+	/*
+	 * The allocation and free of regset are executed in order.
+	 * We needn't a lock here.
+	 */
+	INIT_LIST_HEAD(&regset->list);
+	list_add_tail(&regset->list, &usbssp_data->regset_list);
+
+	return regset;
+}
+
+static void usbssp_debugfs_free_regset(struct usbssp_regset *regset)
+{
+	if (!regset)
+		return;
+
+	list_del(&regset->list);
+	kfree(regset);
+}
+
+static void usbssp_debugfs_regset(struct usbssp_udc *usbssp_data, u32 base,
+				  const struct debugfs_reg32 *regs,
+				  size_t nregs, struct dentry *parent,
+				  const char *fmt, ...)
+{
+	struct usbssp_regset *rgs;
+	va_list args;
+	struct debugfs_regset32	*regset;
+
+	rgs = usbssp_debugfs_alloc_regset(usbssp_data);
+	if (!rgs)
+		return;
+
+	va_start(args, fmt);
+	vsnprintf(rgs->name, sizeof(rgs->name), fmt, args);
+	va_end(args);
+
+	regset = &rgs->regset;
+	regset->regs = regs;
+	regset->nregs = nregs;
+	regset->base = usbssp_data->regs + base;
+
+	debugfs_create_regset32((const char *)rgs->name, 0444, parent, regset);
+}
+
+static void usbssp_debugfs_extcap_regset(struct usbssp_udc *usbssp_data,
+					 int cap_id,
+					 const struct debugfs_reg32 *regs,
+					 size_t n, const char *cap_name)
+{
+	u32 offset;
+	int index = 0;
+	size_t psic, nregs = n;
+	void __iomem *base = &usbssp_data->cap_regs->hc_capbase;
+
+	offset = usbssp_find_next_ext_cap(base, 0, cap_id);
+	while (offset) {
+		if (cap_id == USBSSP_EXT_CAPS_PROTOCOL) {
+			psic = USBSSP_EXT_PORT_PSIC(readl(base + offset + 8));
+			nregs = min(4 + psic, n);
+		}
+
+		usbssp_debugfs_regset(usbssp_data, offset, regs, nregs,
+				usbssp_data->debugfs_root, "%s:%02d",
+				cap_name, index);
+		offset = usbssp_find_next_ext_cap(base, offset, cap_id);
+		index++;
+	}
+}
+
+static int usbssp_ring_enqueue_show(struct seq_file *s, void *unused)
+{
+	dma_addr_t dma;
+	struct usbssp_ring *ring = *(struct usbssp_ring **)s->private;
+
+	dma = usbssp_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
+	seq_printf(s, "%pad\n", &dma);
+
+	return 0;
+}
+
+static int usbssp_ring_dequeue_show(struct seq_file *s, void *unused)
+{
+	dma_addr_t dma;
+	struct usbssp_ring *ring = *(struct usbssp_ring **)s->private;
+
+	dma = usbssp_trb_virt_to_dma(ring->deq_seg, ring->dequeue);
+	seq_printf(s, "%pad\n", &dma);
+
+	return 0;
+}
+
+static int usbssp_ring_cycle_show(struct seq_file *s, void *unused)
+{
+	struct usbssp_ring *ring = *(struct usbssp_ring **)s->private;
+
+	seq_printf(s, "%d\n", ring->cycle_state);
+
+	return 0;
+}
+
+static void usbssp_ring_dump_segment(struct seq_file *s,
+				     struct usbssp_segment *seg)
+{
+	int i;
+	dma_addr_t dma;
+	union usbssp_trb *trb;
+
+	for (i = 0; i < TRBS_PER_SEGMENT; i++) {
+		trb = &seg->trbs[i];
+		dma = seg->dma + i * sizeof(*trb);
+		seq_printf(s, "%pad: %s\n", &dma,
+				usbssp_decode_trb(trb->generic.field[0],
+					trb->generic.field[1],
+					trb->generic.field[2],
+					trb->generic.field[3]));
+	}
+}
+
+static int usbssp_ring_trb_show(struct seq_file *s, void *unused)
+{
+	int i;
+	struct usbssp_ring *ring = *(struct usbssp_ring **)s->private;
+	struct usbssp_segment *seg = ring->first_seg;
+
+	for (i = 0; i < ring->num_segs; i++) {
+		usbssp_ring_dump_segment(s, seg);
+		seg = seg->next;
+	}
+
+	return 0;
+}
+
+static struct usbssp_file_map ring_files[] = {
+	{"enqueue",	usbssp_ring_enqueue_show, },
+	{"dequeue",	usbssp_ring_dequeue_show, },
+	{"cycle",	usbssp_ring_cycle_show, },
+	{"trbs",	usbssp_ring_trb_show, },
+};
+
+static int usbssp_ring_open(struct inode *inode, struct file *file)
+{
+	int i;
+	struct usbssp_file_map *f_map;
+	const char *file_name = file_dentry(file)->d_iname;
+
+	for (i = 0; i < ARRAY_SIZE(ring_files); i++) {
+		f_map = &ring_files[i];
+
+		if (strcmp(f_map->name, file_name) == 0)
+			break;
+	}
+
+	return single_open(file, f_map->show, inode->i_private);
+	return 0;
+}
+
+static const struct file_operations usbssp_ring_fops = {
+	.open = usbssp_ring_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int usbssp_slot_context_show(struct seq_file *s, void *unused)
+{
+	struct usbssp_udc *usbssp_data;
+	struct usbssp_slot_ctx *slot_ctx;
+	struct usbssp_slot_priv *priv = s->private;
+	struct usbssp_device *dev = priv->dev;
+
+	usbssp_data = gadget_to_usbssp(dev->gadget);
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev->out_ctx);
+	seq_printf(s, "%pad: %s\n", &dev->out_ctx->dma,
+		   usbssp_decode_slot_context(slot_ctx->dev_info,
+				slot_ctx->dev_info2, slot_ctx->int_target,
+				slot_ctx->dev_state));
+
+	return 0;
+}
+
+static int usbssp_endpoint_context_show(struct seq_file *s, void *unused)
+{
+	int dci;
+	dma_addr_t dma;
+	struct usbssp_udc *usbssp_data;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_slot_priv	*priv = s->private;
+	struct usbssp_device *dev = priv->dev;
+
+	usbssp_data = gadget_to_usbssp(dev->gadget);
+
+	for (dci = 1; dci < 32; dci++) {
+		ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev->out_ctx, dci);
+		dma = dev->out_ctx->dma +
+		      dci * CTX_SIZE(usbssp_data->hcc_params);
+		seq_printf(s, "%pad: %s\n", &dma,
+			   usbssp_decode_ep_context(ep_ctx->ep_info,
+					ep_ctx->ep_info2, ep_ctx->deq,
+					ep_ctx->tx_info));
+	}
+
+	return 0;
+}
+
+static int usbssp_device_name_show(struct seq_file *s, void *unused)
+{
+	struct usbssp_slot_priv *priv = s->private;
+	struct usbssp_device *dev = priv->dev;
+
+	seq_printf(s, "%s\n", dev_name(&dev->gadget->dev));
+
+	return 0;
+}
+
+static struct usbssp_file_map context_files[] = {
+	{"name",	 usbssp_device_name_show, },
+	{"slot-context", usbssp_slot_context_show, },
+	{"ep-context",	 usbssp_endpoint_context_show, },
+};
+
+static int usbssp_context_open(struct inode *inode, struct file *file)
+{
+	int i;
+	struct usbssp_file_map *f_map;
+	const char *file_name = file_dentry(file)->d_iname;
+
+	for (i = 0; i < ARRAY_SIZE(context_files); i++) {
+		f_map = &context_files[i];
+
+		if (strcmp(f_map->name, file_name) == 0)
+			break;
+	}
+
+	return single_open(file, f_map->show, inode->i_private);
+}
+
+static const struct file_operations usbssp_context_fops = {
+	.open		= usbssp_context_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void usbssp_debugfs_create_files(struct usbssp_udc *usbssp_data,
+					struct usbssp_file_map *files,
+					size_t nentries, void *data,
+					struct dentry *parent,
+					const struct file_operations *fops)
+{
+	int i;
+
+	for (i = 0; i < nentries; i++)
+		debugfs_create_file(files[i].name, 0444, parent, data, fops);
+}
+
+static struct dentry *usbssp_debugfs_create_ring_dir(struct usbssp_udc
+						     *usbssp_data,
+						     struct usbssp_ring **ring,
+						     const char *name,
+						     struct dentry *parent)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir(name, parent);
+	usbssp_debugfs_create_files(usbssp_data, ring_files,
+			ARRAY_SIZE(ring_files), ring, dir, &usbssp_ring_fops);
+
+	return dir;
+}
+
+static void usbssp_debugfs_create_context_files(struct usbssp_udc *usbssp_data,
+						struct dentry *parent,
+						int slot_id)
+{
+	struct usbssp_device	*dev = &usbssp_data->devs;
+
+	usbssp_debugfs_create_files(usbssp_data, context_files,
+			ARRAY_SIZE(context_files), dev->debugfs_private,
+			parent, &usbssp_context_fops);
+}
+
+void usbssp_debugfs_create_endpoint(struct usbssp_udc *usbssp_data,
+				    struct usbssp_device *dev,
+				    int ep_index)
+{
+	struct usbssp_ep_priv *epriv;
+	struct usbssp_slot_priv *spriv = dev->debugfs_private;
+
+	if (spriv->eps[ep_index])
+		return;
+
+	epriv = kzalloc(sizeof(*epriv), GFP_KERNEL);
+	if (!epriv)
+		return;
+
+	snprintf(epriv->name, sizeof(epriv->name), "ep%02d", ep_index);
+	epriv->root = usbssp_debugfs_create_ring_dir(usbssp_data,
+				&dev->eps[ep_index].ring, epriv->name,
+				spriv->root);
+	spriv->eps[ep_index] = epriv;
+}
+
+void usbssp_debugfs_remove_endpoint(struct usbssp_udc *usbssp_data,
+				    struct usbssp_device *dev,
+				    int ep_index)
+{
+	struct usbssp_ep_priv *epriv;
+	struct usbssp_slot_priv *spriv = dev->debugfs_private;
+
+	if (!spriv || !spriv->eps[ep_index])
+		return;
+
+	epriv = spriv->eps[ep_index];
+	debugfs_remove_recursive(epriv->root);
+	spriv->eps[ep_index] = NULL;
+	kfree(epriv);
+}
+
+void usbssp_debugfs_create_slot(struct usbssp_udc *usbssp_data, int slot_id)
+{
+	struct usbssp_slot_priv *priv;
+	struct usbssp_device *dev = &usbssp_data->devs;
+
+	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
+	if (!priv)
+		return;
+
+	snprintf(priv->name, sizeof(priv->name), "%02d", slot_id);
+	priv->root = debugfs_create_dir(priv->name, usbssp_data->debugfs_slots);
+	priv->dev = dev;
+	dev->debugfs_private = priv;
+
+	usbssp_debugfs_create_ring_dir(usbssp_data, &dev->eps[0].ring,
+			"ep00", priv->root);
+
+	usbssp_debugfs_create_context_files(usbssp_data, priv->root, slot_id);
+}
+
+void usbssp_debugfs_remove_slot(struct usbssp_udc *usbssp_data, int slot_id)
+{
+	int i;
+	struct usbssp_slot_priv *priv;
+	struct usbssp_device *dev = &usbssp_data->devs;
+
+	if (!dev || !dev->debugfs_private)
+		return;
+
+	priv = dev->debugfs_private;
+
+	debugfs_remove_recursive(priv->root);
+
+	for (i = 0; i < 31; i++)
+		kfree(priv->eps[i]);
+
+	kfree(priv);
+	dev->debugfs_private = NULL;
+}
+
+void usbssp_debugfs_init(struct usbssp_udc *usbssp_data)
+{
+	struct device *dev =  usbssp_data->dev;
+
+	usbssp_data->debugfs_root = debugfs_create_dir(dev_name(dev),
+					usbssp_debugfs_root);
+
+	INIT_LIST_HEAD(&usbssp_data->regset_list);
+
+	usbssp_debugfs_regset(usbssp_data,
+			0, usbssp_cap_regs, ARRAY_SIZE(usbssp_cap_regs),
+			usbssp_data->debugfs_root, "reg-cap");
+
+	usbssp_debugfs_regset(usbssp_data,
+			HC_LENGTH(readl(&usbssp_data->cap_regs->hc_capbase)),
+			usbssp_op_regs, ARRAY_SIZE(usbssp_op_regs),
+			usbssp_data->debugfs_root, "reg-op");
+
+	usbssp_debugfs_regset(usbssp_data,
+			readl(&usbssp_data->cap_regs->run_regs_off) & RTSOFF_MASK,
+			usbssp_runtime_regs, ARRAY_SIZE(usbssp_runtime_regs),
+			usbssp_data->debugfs_root, "reg-runtime");
+
+	usbssp_debugfs_extcap_regset(usbssp_data, USBSSP_EXT_CAPS_PROTOCOL,
+			usbssp_extcap_protocol,
+			ARRAY_SIZE(usbssp_extcap_protocol),
+			"reg-ext-protocol");
+
+	usbssp_debugfs_create_ring_dir(usbssp_data, &usbssp_data->cmd_ring,
+			"command-ring",
+			usbssp_data->debugfs_root);
+
+	usbssp_debugfs_create_ring_dir(usbssp_data, &usbssp_data->event_ring,
+			"event-ring",
+			usbssp_data->debugfs_root);
+
+	usbssp_data->debugfs_slots = debugfs_create_dir("devices",
+			usbssp_data->debugfs_root);
+}
+
+void usbssp_debugfs_exit(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_regset *rgs, *tmp;
+
+	debugfs_remove_recursive(usbssp_data->debugfs_root);
+	usbssp_data->debugfs_root = NULL;
+	usbssp_data->debugfs_slots = NULL;
+
+	list_for_each_entry_safe(rgs, tmp, &usbssp_data->regset_list, list)
+		usbssp_debugfs_free_regset(rgs);
+}
+
+void __init usbssp_debugfs_create_root(void)
+{
+	usbssp_debugfs_root = debugfs_create_dir("usbssp", usb_debug_root);
+}
+
+void __exit usbssp_debugfs_remove_root(void)
+{
+	debugfs_remove_recursive(usbssp_debugfs_root);
+	usbssp_debugfs_root = NULL;
+}
diff --git a/drivers/usb/usbssp/gadget-debugfs.h b/drivers/usb/usbssp/gadget-debugfs.h
new file mode 100644
index 000000000000..53adb028e7f2
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-debugfs.h
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * Some code borrowed from the Linux XHCI driver.
+ */
+
+#ifndef __LINUX_USBSSP_DEBUGFS_H
+#define __LINUX_USBSSP_DEBUGFS_H
+
+#include <linux/debugfs.h>
+
+#define DEBUGFS_NAMELEN 32
+
+#define REG_CAPLENGTH		0x00
+#define REG_HCSPARAMS1		0x04
+#define REG_HCSPARAMS2		0x08
+#define REG_HCSPARAMS3		0x0c
+#define REG_HCCPARAMS1		0x10
+#define REG_DOORBELLOFF		0x14
+#define REG_RUNTIMEOFF		0x18
+#define REG_HCCPARAMS2		0x1c
+
+#define	REG_USBCMD		0x00
+#define REG_USBSTS		0x04
+#define REG_PAGESIZE		0x08
+#define REG_DNCTRL		0x14
+#define REG_CRCR		0x18
+#define REG_DCBAAP_LOW		0x30
+#define REG_DCBAAP_HIGH		0x34
+#define REG_CONFIG		0x38
+
+#define REG_MFINDEX		0x00
+#define REG_IR0_IMAN		0x20
+#define REG_IR0_IMOD		0x24
+#define REG_IR0_ERSTSZ		0x28
+#define REG_IR0_ERSTBA_LOW	0x30
+#define REG_IR0_ERSTBA_HIGH	0x34
+#define REG_IR0_ERDP_LOW	0x38
+#define REG_IR0_ERDP_HIGH	0x3c
+
+#define REG_EXTCAP_USBLEGSUP	0x00
+#define REG_EXTCAP_USBLEGCTLSTS	0x04
+
+#define REG_EXTCAP_REVISION	0x00
+#define REG_EXTCAP_NAME		0x04
+#define REG_EXTCAP_PORTINFO	0x08
+#define REG_EXTCAP_PORTTYPE	0x0c
+#define REG_EXTCAP_MANTISSA1	0x10
+#define REG_EXTCAP_MANTISSA2	0x14
+#define REG_EXTCAP_MANTISSA3	0x18
+#define REG_EXTCAP_MANTISSA4	0x1c
+#define REG_EXTCAP_MANTISSA5	0x20
+#define REG_EXTCAP_MANTISSA6	0x24
+
+#define REG_EXTCAP_DBC_CAPABILITY	0x00
+#define REG_EXTCAP_DBC_DOORBELL		0x04
+#define REG_EXTCAP_DBC_ERSTSIZE		0x08
+#define REG_EXTCAP_DBC_ERST_LOW		0x10
+#define REG_EXTCAP_DBC_ERST_HIGH	0x14
+#define REG_EXTCAP_DBC_ERDP_LOW		0x18
+#define REG_EXTCAP_DBC_ERDP_HIGH	0x1c
+#define REG_EXTCAP_DBC_CONTROL		0x20
+#define REG_EXTCAP_DBC_STATUS		0x24
+#define REG_EXTCAP_DBC_PORTSC		0x28
+#define REG_EXTCAP_DBC_CONT_LOW		0x30
+#define REG_EXTCAP_DBC_CONT_HIGH	0x34
+#define REG_EXTCAP_DBC_DEVINFO1		0x38
+#define REG_EXTCAP_DBC_DEVINFO2		0x3c
+
+#define dump_register(nm)		\
+{					\
+	.name	= __stringify(nm),	\
+	.offset	= REG_ ##nm,		\
+}
+
+struct usbssp_regset {
+	char			name[DEBUGFS_NAMELEN];
+	struct debugfs_regset32	regset;
+	size_t			nregs;
+	struct dentry		*parent;
+	struct list_head	list;
+};
+
+struct usbssp_file_map {
+	const char		*name;
+	int			(*show)(struct seq_file *s, void *unused);
+};
+
+struct usbssp_ep_priv {
+	char			name[DEBUGFS_NAMELEN];
+	struct dentry		*root;
+};
+
+struct usbssp_slot_priv {
+	char			name[DEBUGFS_NAMELEN];
+	struct dentry		*root;
+	struct usbssp_ep_priv	*eps[31];
+	struct usbssp_device	*dev;
+};
+
+#ifdef CONFIG_DEBUG_FS
+void usbssp_debugfs_init(struct usbssp_udc *usbssp_data);
+void usbssp_debugfs_exit(struct usbssp_udc *usbssp_data);
+void __init usbssp_debugfs_create_root(void);
+void __exit usbssp_debugfs_remove_root(void);
+void usbssp_debugfs_create_slot(struct usbssp_udc *usbssp_data, int slot_id);
+void usbssp_debugfs_remove_slot(struct usbssp_udc *usbssp_data, int slot_id);
+void usbssp_debugfs_create_endpoint(struct usbssp_udc *usbssp_data,
+				    struct usbssp_device *dev_priv,
+				    int ep_index);
+void usbssp_debugfs_remove_endpoint(struct usbssp_udc *usbssp_data,
+				    struct usbssp_device *dev_priv,
+				    int ep_index);
+#else
+static inline void usbssp_debugfs_init(struct usbssp_udc *usbssp_data) { }
+static inline void usbssp_debugfs_exit(struct usbssp_udc *usbssp_data) { }
+static inline void __init usbssp_debugfs_create_root(void) { }
+static inline void __exit usbssp_debugfs_remove_root(void) { }
+static inline void usbssp_debugfs_create_slot(struct usbssp_udc *usbssp_data,
+					      int s) { }
+static inline void usbssp_debugfs_remove_slot(struct usbssp_udc *xusbssp_data,
+					      int s) { }
+static inline void
+usbssp_debugfs_create_endpoint(struct usbssp_udc *usbssp_data,
+			       struct usbssp_device *dev_priv,
+			       int ep_index) { }
+static inline void
+usbssp_debugfs_remove_endpoint(struct usbssp_udc *usbssp_data,
+			       struct usbssp_device *dev_priv,
+			       int ep_index) { }
+#endif /* CONFIG_DEBUG_FS */
+#endif /*__LINUX_USBSSP_DEBUGFS_H*/
-- 
2.17.1

