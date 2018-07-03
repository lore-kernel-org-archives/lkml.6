Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5334EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01E521F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="kt40hz74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01E521F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeGCT7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:59:55 -0400
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:19504
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753123AbeGCT6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5yyUppcablpS4qhO4Y9cOjyw6Z3Tqewi4ZDnl6heWc=;
 b=kt40hz74EG5aeV38AhPpfk44E8f3C0dBrUCm/2u7Z1vdEAX9ot3BDvKinr1t+UVfqELxLceqQy3MDV8QQChnEQ0N8dw3XCmokFBVGu2VAxE9rifbIgrcdWgX2UlTnxO0sVb48961vDP1FMEHwa9rawkTQ1SOzctMjvd5IJljkHY=
Received: from SN1PR0701CA0040.namprd07.prod.outlook.com
 (2a01:111:e400:5173::50) by CY1PR0701MB1337.namprd07.prod.outlook.com
 (2a01:111:e400:4c1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 19:58:34 +0000
Received: from CO1NAM05FT023.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by SN1PR0701CA0040.outlook.office365.com
 (2a01:111:e400:5173::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.18 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:34 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT023.mail.protection.outlook.com (10.152.96.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMsA006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:30 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:42 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:42 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwPpJ012361;
        Tue, 3 Jul 2018 20:58:25 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwPR4012356;
        Tue, 3 Jul 2018 20:58:25 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 12/15] Introduce Cadence USBSSP DRD Driver - added usbssp-plat.c file
Date:   Tue, 3 Jul 2018 20:57:56 +0100
Message-ID: <1530647879-10007-13-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(36092001)(199004)(189003)(4326008)(486006)(47776003)(97736004)(105596002)(106466001)(305945005)(6666003)(4720700003)(11346002)(69596002)(2616005)(476003)(446003)(107886003)(426003)(126002)(48376002)(50466002)(86362001)(186003)(36756003)(26005)(2906002)(42186006)(81166006)(53936002)(81156014)(8676002)(8936002)(14444005)(316002)(50226002)(26826003)(51416003)(5660300001)(356003)(76176011)(16586007)(54906003)(110136005)(336012)(478600001)(87636003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1337;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT023;1:a2hzpxOgKW1DnZCbSZcwkkfdsZKKae2Pz1c9LLw3klPpl69IzyMLqUB131Go8PXm/oepjwmH922Wv4H8X5NisgMotBebqUGc1bqEzZmLC2vf6+kBRgjBSY6ANY0SHkcD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2851c703-71c2-4f39-dbbd-08d5e11f5aa9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0701MB1337;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;3:TbjolqAKvAS6ozniPWw7NhMB0e8gzo71o4oG51g9cvzB9BQCHP5P7gk9VrEp7iXxKYBb9K40QoTlEOVtVOV7iLaAveK7SpwpIpFOgkEt00AEIO71BWsjb4mXhVBy9LqC/sunjq6XRYDfMRfm7gPd+kHiI1DSp2gVSzteJC5Z3S5XVN2JnQpx4s5YnTBjsKMASVK2i5uJzI37wPy5W6JWPaEjghdIEnvtPhA9GkXGUTHVOSkqBUoHeIrsNSEkvCSyJIyJ7U9Mf8xiuQA6BnbdlrWdPcGFF0kZcdWoT+2MrEzCvtOMppKFW+mLP8Zx8iemW+KavFZ9WVBufngEzXWaig==;25:Hn4PXXhPwVsrK/jUN1NR9rOwqqNncjLzqt4UbmmILeri7ZyqYzDQL/wrErW6Ikl1k7bC/9EgOyFF8/DUZtcgcGgLRctE5d6Een5UMRzlfeFNBqY2018VR8gqCCnJOw0DVPYyB0M20mySgJZLzotLODfd2AE6eQXXpijX8pQCoLGOxG5KL0i5/N62LD/k+W+J6UyKQYtmdVyW77c6dAEwFieCsxEYVrwH6GZUXBQWCRLnRzJuFnBN0EYdpSLdJBGfrxHmg1G3QlRmwJuQBDNsMo4H7Dl3WtSS3WZhxFDdkFbn3GeggKR7frVh3U8eqC/4C6IYmivVLQKdVaiiUeAz2A==;31:OEJe3bBAwv259aRAVMHu4Tb/76UhK5amfag+l2CD5xQqhYj/LnnLsa/zaB15rbeIm2ALGyigqFIY8dDMvWqZgdi8MNKLWs7UsqlZuLyYUD1CLdSrlgHrPSkcFQ2vB7Kx3YkauKrLoLd2YAoprqSHxd7v5f76uE+aKg4A7QMUPWRRRDRnOoMi+C2dp31Uctzh0lpZSHdnRDQaxg9lCfGxKFHDezO0VyV0tVGeJFSJjNM=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1337:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;20:Y9GOC6QiyQuV/9vxD7CxPJU8KvoGCWEm8aXY/R7Cq/GEhJAp8KKIS5sCtG6UxCZkWfHQgRGGKVWRsFHqOB+lgJ9V2X1d6usNSy8bmlMdobIKwp79+ZpHbGJNu2nATm+hp815qLx6qtDAl20aPI7Cn4f+2DlSDV4NIJkn5vKV98mWwOSvCf1HIYS1b16XOZO9QBRPepeUVS/RIPq6metZTyg1i9XcOfR3mUm8no0gBD9kyf+NF5O/io4jIXik9FIj2CYWo4s0Nw/TzuLYVPu/stVQNlhA9XwCNovirU3iC4HVEE4wKDQDhqzXykQpwEj0mTvvf4eLDeOS5CiJF4Gdwz0OVXtqW3RIxRzDKjs8vbJyDHw5Gw6oO8zoVqOIj5fueGaLOkDTH5qx+KVjKNzj0+awQWLWSiO07HmeAoSadBdebHaFLhfZ7c+CyEUqgmYKdE6ASAv3DLpoERwJHifLY9e5Jtxvx9Iy38q4CMxGAUnRMSlpW4OiVjP6rbllRh1v;4:RpHonWfNN8F6UsrEWCYOD3j4mTl/1yZFZTwWZFNwZaCM6bIjVtteE1ZKTTV/8Eog9bKDXK7lDIsAMLWKkxFIixbO4kRvYnb/pzh1OxvHMThcyusIh9ev9l5jzaObBOx4lHZ/1u+bTBmwoIUfUu1+tFxuP5NkAWwym/on0z6exyYiw+xGCRszBfTBMBP5dn40hgADDE4373DV4mfQSbFU3WnXP6izAiWHHcs3lltVe7SVPGuyCQEngGuFCqGTv3chaGJp4bWJhfABEWHRUy5mxLcryYBsHtDvCjY4n00BKB3/Pz+h1koMD+hCHjAT6PM/
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1337A30635EAD08EA9BBAEF9DD420@CY1PR0701MB1337.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1337;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1337;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1337;23:DdJ2QYxd99/jGxWUkxo2iDBScYw4nUrooC4fL0/?=
 =?us-ascii?Q?nY1pc+tjkGqdkWitVUc6n/wdPGzax3HiuvePsScM4Xt4FtlYodd8G1SA1GqI?=
 =?us-ascii?Q?luPGP5rrQZ7uQ+EhrHCLXutwJ+F3sPXAAkSBbG+TQ0kDdyhlkE5xpp5c/uTZ?=
 =?us-ascii?Q?cce7lZDjfc2X77USIfEEJEdElNi2z6LaZY/Z79vmyJ4lh6sVpXrffHf5xnqm?=
 =?us-ascii?Q?Ne12KMU50CXk7pU1UEkkFIZYT2T2BlUVAfUtjqiOSckI8ZY1E6pfQkttoeu0?=
 =?us-ascii?Q?mglLFgrfZBQmBioWQhDAopsecRuQYlXheFi42VzmGUroZuEt/aTw1xfsIJUY?=
 =?us-ascii?Q?O67pCqL7JySBR38m/3dpt1Kb2Hx6FcPlFIvKj+8ZX1cEkFNsFSeO8rUjWegd?=
 =?us-ascii?Q?2a7v/QZ9Qf8tH/HNXIeJn4HnOId5L1IDD5/C9wsTgA9R2xgQJhBZ31U5RAKl?=
 =?us-ascii?Q?7jPXDJX0QPqXEHTwYKtL+3ZAXhawNVB9336amt2ZpO4hhIh59ayLtow2WRRB?=
 =?us-ascii?Q?Ck9oJzIsCWUbVxf+UaDnJm2p8hlmZ5wlIb98i6/vkbRT7Hy0fY3cAHhahw/k?=
 =?us-ascii?Q?R5nu+zVPlnnI9E5CqOIMG2+v+y4NYVTt7WHnKcikQSHQPqcvTgQF2ipnOfiE?=
 =?us-ascii?Q?3HFUttTAQ4T8PHnMQb9xxJwL/b/Tgx1jQG8mmhEjVhwlVwO2FdyB72jxGn7T?=
 =?us-ascii?Q?NqUh4gtXl838ZaS7VEinDcbosPIi3Grg3lebhmLjkJ2H74YLh9tmZLkyZU+d?=
 =?us-ascii?Q?jjH117GgywKa3ky8pTOlnTdDN6LGUV12agUc48pIfHu/h/RgXZOO5lkBM3Jh?=
 =?us-ascii?Q?buktl9ovn4Y83UWSpcRiK/eo5k3WFLmclHOcQ6o7MOlETxekqJUnn3UT0/u/?=
 =?us-ascii?Q?6EWsVFrqzrRBMXL3eEhL1CBdst+rsFHx0Gba52G+UYniRE3uwoxwewJpi9Ir?=
 =?us-ascii?Q?Bi5xQEL+OaQKbcgq+yERtv7vB8m1HJFCICqtaobmKUcIiaEDPZixs+GZwTBv?=
 =?us-ascii?Q?qvObNjI5lwt8nt0ZF3vEv8RmSN3IlrJmOqcSLcwEIPG3pRpAHQMJtULEsGr2?=
 =?us-ascii?Q?HwSx21FI0y0wT+/D4inRVpqmYV5KT6Qw+hvlZd0OevXNCqYUq6Ay/VHFKm9b?=
 =?us-ascii?Q?2LShyw3uEzQfEJXaGcCdKx38IJLKLZJhVn0JNqu9g4vuFJmOPJSyzXsTXGk+?=
 =?us-ascii?Q?iiwWNLl/IdzK18BXqCleCx+dDKjPWl97tmUWf?=
X-Microsoft-Antispam-Message-Info: S/PxjCnE03TUIe+NvyDTraTQTHF+qxS2dwWRBHRHAvybQjwmQyX3aYXim/RUdH/MCP5Fht2qaPRC1Uvk8wA4lurBVgsoLvBhP95Sd6bcPD3Kv3dv0V1CQY+aue4kQxw1GqfV8v7svDaup9CyhUH7fn9UfubBV6CVGchVVjSS48BHNhvtv0heMtE+ykGv9CxQ0CW3PPEy/Gi1k4fsySuEbzm+IReYFb9fT8xjoOZL/VXzUi+Y0FhOWAlmGuUfMTFUI6YLE7RMUlFS2iMP2ODIwoO8P1v2i7ofMIkj2TidsAU4k6aFgOzNF2QQWtreBLYP+KTbEWweVh2mGCPQh+JDGELU8tO/6fi3iAqSVt+3nI2/CUrpU41LcteQenXRSkXGyqFhp+FIzy8j9edD2lPtOA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;6:HfQBTMA0Doox/9kJEAHik9FDIGYcQSQTf6EudjGsGxOA5O30yegDFRbaXlOV0NiLoBO7NT0z/dMaEJc4bkSoY9eHvx19xm/ZkXSaetdjUCxlo9ee1+x4e1nXnh1xHBS8N/QzPcBIhiVDFHiT3W0TKXpXef7bDubhInJkUtHyecO+H2gGzkZAMcbnE9uNHNkT6wGQM3K/HBhmKkOkLt6mf+0yBQOlIk/Z9wWLtHfe2FsogEra9cRFrNuRU7tXD87ibj3+bMiLJ90eYrfAMS2QZ+9UeZJlN78rzry15/hRGoGoJtCOQMIT27OR37c3wRV6utLXsTLlm8XGqup5u47GmCYtZapYwD5o6JRSpSTwfpqh/dZyD8EtMqeHPbZHZz0oXFlxZTyZlYwAR/ixzuhoOascBOvVnT8Kz78pjbn+hwd4fTLsiJ46MwYOGyTVYjjxYbt5vVrWahco+qIu3+3KPA==;5:2BMLXSx8Rq19IQBl2Y/i3xnLheV9sp4ycYlc6fQ0VNe2zleQfqr0qXqVmw2f5HZgE9wIxtbAkcXhObSFcSmxS6pG52zGp7A53k0TY4Tau09tq7aWCCleziZXws91ZbCBG8uzZL6R1CcqEucj5+O6RtH/noo48YRnpzWxzuBVy9Q=;24:fPOAhdZk5PkL+ydtvIh4arTU6lvFYN9qU7bObaCHQTyDxi0sB/DAvulHiA+FV3+G9bJltFA3mCL51dAI/AlJ8nDOBBroCuevxlqJNMBEyxU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;7:wkgpnL66Z2xwWA61Q+wuS/swWgGu3JVU7w/T2VrdOr3PwtY/UUyqjN45sICb8v/iW7g5RIxAL8ArPvbQOIDGZyVshECJrzUPYlWQ3h2nexMLGqLC63GGRW+YU+MQL+nyBL8P8ntjTZegNAItDs6HLZSgZULb29zgVReCdb3Eddrw++0i6eHOcvG+QfdXM7eVYz72QVBg22HDgP0c/UdrgwsmOj4r97ki5OWVmgtZ49RAnhCj53CqzUbYoE8UQtrj;20:SkqR4t5arR5traTj1QR5Iwcsfl7vY3Ls62qtH1/40HaIa+EfgYWwSegYe/2Rpk63jjsQG2tMGFsycga5cHMbEu/uEqB+dl7bkKMfCE5rzT/vIVjUloL2+9QSPClcFeg3UWxYhbid9l5fh4POAeZ3SXu5GXVheD46mO7LN4oaJ/bbI0uz7oswsLP68JV0S3bndknNKnZ4GeZX+jOSF8c3UEq+01GqymxizWvlfXiI5WUDdbtMprUWx9b2VVlVHn67
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:32.1297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2851c703-71c2-4f39-dbbd-08d5e11f5aa9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/usbssp-plat.c | 186 +++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 drivers/usb/usbssp/usbssp-plat.c

diff --git a/drivers/usb/usbssp/usbssp-plat.c b/drivers/usb/usbssp/usbssp-plat.c
new file mode 100644
index 000000000000..91abd7a00907
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
+ * Some code borrowed from the Linux XHCI driver.
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
+MODULE_LICENSE("GPL");
-- 
2.17.1

