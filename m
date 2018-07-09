Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C90C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3092F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Gmb7Hslm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3092F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeGIJ0v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:26:51 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com ([40.107.1.110]:13766
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932366AbeGIJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDSOS4nqmWRT0fpO2V3f4GBIAutDjARbU2qrqH0SDa8=;
 b=Gmb7HslmLEW2DMeDEjt7hSe5VzS8nSHqDYoYbVxwkDTX/xzpqiKpgDBBwpna7GUFdZrG1lDj7v7YtwoljLfEZf/lAGicR04uA3kflYOpQEY4LizKY3JkAoxy2MeVbRYRESJuoEmeCLlWEjwva8S4BB9RMt/ZsPtB3czdim71pSw=
Received: from DB6PR07CA0094.eurprd07.prod.outlook.com (2603:10a6:6:2b::32) by
 VI1PR07MB3200.eurprd07.prod.outlook.com (2603:10a6:802:21::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.6; Mon, 9 Jul 2018 09:26:46 +0000
Received: from VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by DB6PR07CA0094.outlook.office365.com
 (2603:10a6:6:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.8 via Frontend
 Transport; Mon, 9 Jul 2018 09:26:45 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 VE1EUR03FT041.mail.protection.outlook.com (10.152.19.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.16 via Frontend Transport; Mon, 9 Jul 2018 09:26:45 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w699PYoU012748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jul 2018 12:25:34 +0300
Received: from eskara-dhcp047134.emea.nsn-net.net (fihel1d-proxy.emea.nsn-net.net [10.158.100.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w699PYdv012745;
        Mon, 9 Jul 2018 12:25:34 +0300
X-HPESVCS-Source-Ip: 10.158.100.1
Message-ID: <1531128333.2711.19.camel@nokia.com>
Subject: Re: [PATCH] perf script python: Fix dict reference counting
From:   Janne Huttunen <janne.huttunen@nokia.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jaroslav =?UTF-8?Q?=C5=A0karvada?= <jskarvad@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 9 Jul 2018 12:25:33 +0300
In-Reply-To: <20180708111707.GA7092@krava>
References: <1530860024-12653-1-git-send-email-janne.huttunen@nokia.com>
         <20180708111707.GA7092@krava>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(43544003)(189003)(199004)(229853002)(2906002)(6916009)(336012)(5820100001)(4326008)(54906003)(478600001)(5024004)(5660300001)(6246003)(86362001)(53936002)(186003)(2870700001)(50226002)(68736007)(446003)(486006)(126002)(36756003)(2616005)(305945005)(44832011)(81156014)(81166006)(106466001)(47776003)(76176011)(8936002)(23676004)(8676002)(11346002)(356003)(316002)(97736004)(26826003)(77096007)(22756006)(106002)(26005)(476003)(50466002)(103116003)(99106002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB3200;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT041;1:Lz2ZY6182mTKP/gUW/QQ8HNIM5Lx13Qu+cNJZkn0Tu+Vq9fHWrZ5wSLNy21ewCMrtZrjdgRu2vu4q/VT8YsaPjGMCs/ypoM197HxJh52QfRbTWoxBtD2hiM8A2PFjTJX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47aa41a9-0d19-40e5-7da3-08d5e57e1705
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(4608076)(2017052603328);SRVR:VI1PR07MB3200;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3200;3:dizOKR9f9GhhjZLxa8HaXYEU4DeqrVDDq0tZiHNrn60hXLktFhK9hN0+5WNRyrE5tiS6YxvNUMK1wGGkjD7ui8/PCz2cx5SLI89VRyB4m61s/3HNpMnDu43vDNc7eAjx1Dy8MANphKg3o4VGWO398YBUPTp6+mcjQTBK8o9bJFe0E5rUWZGh2mQwly7VLn9DTTnuyh8uBmvYooEUW6QqZfqhILAF0SnBQ0+T51Tn4BjPoxS/gHMPLbw7adbymSV7uXQjn5QoC4z50+4dnNGYjLdXgwNgbZW5X8FqDaSwhmR2TtTAgWRc6ODBDvo+VnkDRNHzheNiP52ca0xtSodDw/blrhIflh6sQetjSznGQvX10g/5725xD8gZ6XYGsF7aXFAcIPKXCtQEW1a/pUm/og==;25:MSFCr5gtJh/cbn3MrTqiUj+yccQnBNWiPjgMfqB9T4fdSRgTEeMAS6HYhCo129B+2J5YdKyMY4DUpaSj0rJJsRmd0x/CMfd3+USiUoNAM55S95jeJNAC4uns6OhtLCFjf5YHw6+XwMSthZoi3iVjUqGxIrafUWskgAZ06kIQwc/bS/dBeYkzwbI0qd6xsavDqkZM2ykFrdDeL2aZq3k4yDO+gcCJPP9NvboY1/8EP0BtX295McJua5+k27OzvpTwj95CD7wQt8IATrj0xlqHz7JmNT+3XCIHYOWR8OXsAU5ipIczBoK7DxbAr1BO7LzKZMk1WvGqTHYg5Bh/pGNAxQ==
X-MS-TrafficTypeDiagnostic: VI1PR07MB3200:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3200;31:QVrv1HmPBzna297EygHnWkOb2/A09TldtkO4SR7cRG7NoO1mdzNLu3EcdoO4tSEP41CHv1ZkmcBgAq0aAM4ScWOmAS5kwNkMRG+ZO28KID3Ca0vVSL3yDGgsbuH2bD0OaqJ4pxlGYXxXOTYroKvvFFrX2y+QpoWQXt6f2dr+YPOWr1PY3SMj7CexzRCavmon8zaP7rj3Gb47yJFYJnmpXlYV9r5sthYsRZ0kFLf/tyE=;20:tLl1esp4S0NhU0uDPa+zwQwClgzFnaJPoQ51rJ5Cu9dUSIByrHG/sV2Eyg/ts+hPwrHkHCx9zpZLpBrvW0C5rIZEiTMsGgNJRqjGnBNw322mU3IqYSJ8U9Zq7W9Qqo7C3QCBAqV3cKDfjhEOAGZcaqC5gkYIxbiKLogfQpbx/O4kga1t3gsDFjJfj5ul7m8+dwN/1dB3/OzyzjRJl6MzaOBkyq5Lzw8vgwUozGB5n3uwPH2u+B+alz1en+PMUhJuVEAvcPs4uEy9shLXtPLWpEpvrvWaawHitm8e6drO0UiUsbKew3/lDwDAM8DnmAm7sXnpRWFcNOh/dw8NMmB+6jhyiNiPzHlZJGljOuruNqWwFZN4XMTrVYuYlYGNHJK2t1bkD8OPYED3YM9u+ncZIJ+C1AZ0NkaBjx8uwANL/eOtVcIikP4tWFaFQWiDZXG6C+wN20kzxV4RxLEi0FAfTwFNyzngFIgW7drxLiMfE5J6ZdzjgRSArB+Im24Jyo1PuVrm/HyMhprp5JR9hheq4K+lpM97+2TSix5yWphv9C7+v11RlUaiVyilgTtSmlJQFKn5iXHoL3feRSfxftEwb9/pcYWku7Hq4ZkVEMrzBJM=
X-Microsoft-Antispam-PRVS: <VI1PR07MB3200FBC156FDE10B43FFBDAF9A440@VI1PR07MB3200.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(11241501184)(806099)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR07MB3200;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3200;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3200;4:62PNXaSFgpal4r+Yc5Gqn9izxhj/0VXY1fDKi7ynSA7rIkqB/pRskKNLC3Uhz1v7GL9f0eC7/wdbaW4iLnDrJl6qhN7uewrwgeH05lQAiZGuWbg5mHVVd+kFp4y6F/8SMWAeplr56kon9VEuApCoToKPg/zoYcm6M1xmhGT82uHL3Ehsuru8dgHToINdIjK0wVosVowOUazUY24fI+gSx+PgLchUD6rFziWXV3pZ3Z/BRaQ2OdZSec+oZOsXEZi3l6agKkS/2+hUEqZbCZ8O9OpZU1z8XMjo/LQDujr/uLmLJnxgMaP64AG9+9gx9NpvoMqAy/Z5h4T1kt+embscMlPjvEYiczYnk9h3wLlDVJk=
X-Forefront-PRVS: 07283408BE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIzMjAwOzIzOllXL0lxdkZRaTd6NVNyNlo5SU54S25SOHRj?=
 =?utf-8?B?bTB6SDdCSEpWZWhIbWc1OTlKd0VHamtmSy8wd0hsbjdzdnc1b2ZGRUlJQjNK?=
 =?utf-8?B?M2ZFbFJwazM3MzlrWGxCUmtSKzNkZktCRW5BZlZQWjQ5MHFUN0RiZURETEVH?=
 =?utf-8?B?eWZsZ1pYaHoyeU01RW96aHlUSVRDZm5HckJNY3ZreGo2NzBmQWtzaE5pYUhn?=
 =?utf-8?B?SlNvalp2MEhRM25HY2hMRUF4NElRV1p3UU5TSHRON1FqeU9aT2dGbUt2ZC9v?=
 =?utf-8?B?bG44RUtOd1JMUCt3Y3FTK0pnV2E4dStMQjBheXF5UjNLMG1mRzMyV0VrbTFr?=
 =?utf-8?B?RG9GWUlRaFhNeUJOYXR0OG5EQkdTalR2RVJWMEhaa1ByVCtXeVBiN1RleTNt?=
 =?utf-8?B?aVpHRDdzYUlYbmhMY21NMGM1T2RORFBscHNlSkVmcmFCSWRUUFA0RUxoUWFG?=
 =?utf-8?B?dUpBNnlXM1RzTkZxMGJ3OFdUMExwM3kzQklZMVpxQ3IxR2p0QTRoazNacllC?=
 =?utf-8?B?YllDS0IvNFJZNEhqWWt5cDU1N1JQa1k4QjUxZE5pdnBQbXJBaTVSN3ZFUEs2?=
 =?utf-8?B?WCt3d1QrY21sYjJ1ei9NVi84NVBpclh2SEhKaTVhUUh0NkZsSWpodURTeTJa?=
 =?utf-8?B?a3hGUW96RnZ6ZUNjZktjOFZHTittclFPSVVJc3hTbThlVGpSNEE1YTJocWRH?=
 =?utf-8?B?TjZocnZKbjlLdCsrWUk2UVdQTER6YmhLWWxGTTUrVlZJS2NIL2xYWTFSSjYy?=
 =?utf-8?B?V2ltZ1Z3ck81Ly9xaTdOcnFSWWo5K1pQWGFuOXJiWUgwMnhCRDBqbmFRM2xl?=
 =?utf-8?B?ZGozQ0crRXRFcGdPbE9UaTZGVEtTN2QrM3JQUkdJU1BlSElkQmd6eitEbkZj?=
 =?utf-8?B?aUoxcmliVmpnUWVsWm9UaGNvUUt1TFE2azdLQW4zVU5QT1JEMHVZZG5YazJr?=
 =?utf-8?B?SE5hK0ZFWmZRVTdDeW1uL3pTU2IxSFZBb3J3MGtULzhOMGw0OWRLQ1lyV3Az?=
 =?utf-8?B?YmN3dUhUbjh3NlZERDFiREZaTStOMk9MYXlTbDNnOG9md0VMT0J4d0ZhQ2lB?=
 =?utf-8?B?UTY5WFNvLytlN1d0YXhDSU94WkRRZ3JhNXpqRDVROHBiU0F5ZTZVWk1VOVJx?=
 =?utf-8?B?L3I0N1kxWmh4cHNXdmlvakJ0alhYM3lKUGIrbzExNzJjaTdMZkgvbU5GTUJ2?=
 =?utf-8?B?c1l0WnJPaHIzR3d4SVRqWlVOSmdJRjhtaFdBakkvWmI5T2ZNVHJlOEk1RXo5?=
 =?utf-8?B?bXhhUE5NaCs4Q3h4YXZtY1RqbStia2xpU2xiZ2xzUmJxb1FhdzNSQm5GMEdx?=
 =?utf-8?B?QTIydFZWeFd6NUY5LytEcUl0Y0JOR1V1ZW43eVIzbjZPaCtWWkJ4ZG03U2ZB?=
 =?utf-8?B?dG5RV1ZyS3k0cHVkeUFkNWh4NWdPTVZIZHJEaHlQODBUMk1sbmN0V0dNV2tH?=
 =?utf-8?B?WWhsOGI3ZmMvTi9QVThjMzVSVDBWaGVWVXVhM092VFZwWG5FWFZsWHY4NTRJ?=
 =?utf-8?B?TW8wdG5Id2pWQTBlOHk5cmxtN0RSdjJ1ejBZYUxhRFE3M0tnWE5Jb0xqcldm?=
 =?utf-8?B?V2VvbFZFNWZ3SXFhY3lNOTBnZmZKOEhjNGw1bW5KQzBGUDJhMlVjcWlob09y?=
 =?utf-8?B?MEpKbGoxWG9wdEd0NlBzalBUM2Y0V0piZGhScG5rdHo4SWJuUHZ5UU53PT0=?=
X-Microsoft-Antispam-Message-Info: MlRKZKABPRirzZC6bnV665BVkh+91LdY+aHkS5TPC0Di0n5k/DXAXWiBi3JBNpyfAZc7leF8kEjGkiW8PpRL1ee1B1ufNzZ9AO0iaJXgIGeEPJrzuk12PQgEfi5p/2PscG7dO3wdCznJiwZo4FChNS/BFJmlTD1cPBaIzRQv19oNEctsPmyjK9id1+KEc//dOqGLKNVhV58bj/dT+FrF1Z9uVy2yf/veqAVLfJoNIDeEGg4ffj2c4Sr0aYV+K2TTNmZ0e5+49S/txcCSI+sgADbuM1t3ApyFKHYCnSWzwD93YH5bMEW2kOyr43mwsN0DspYe6MndrhqUtRfQluNkp8C21nqFRSqZJDEOLZ2u/OcIBgVYY9wEtxUE9C1jw+H8GWIG2wu+GIOndlXzbPpdhpPthVS7i2cEkiOoLewqrsxLkpPOpDBozJEE/MTzqnTw
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3200;6:7ZM/n3tSr9SQbqb5I1PpfGnGYpwpb2cUBrm6jDGDsR+e+8Y+ibhLPPbsYKseW1ur8LS+YujwCc8BoefOs9t4GC6YeUmRc2XalwS3+1wnYpEeqdo7KlLoBbiv56GoueYFdhCuqG2v2veeBXa/Ru6B96ainOJE2up6w7mLT0H4T7UtsCKBVv04VGyGOpv4AQtKX3MT08AC/Vkyi9qn0bLcFoHglXLB1I0tKBpfqmOVtbVloBgYXP0vu5/YJa66snxuz06vt1qtQ7RNWTSVjkmQwqt89KQtkfhVLZjlP9R/wjRYhY090q73vfqHYepkjHKnWbb5cvgZdeA69/wg/lNc8j9BfZFCYR/oRQ8PTz1rA3Jwivg9adjPpGkiebhV1S2pgue4yH8Y4Bqd9IevF5VHcNL62hIqIYr0S86KT+VieC+/jKjz/8X9XI+qJ0kqq4B55H0m9MXbnEqjKB9Qko8ukA==;5:I5ci6ppwOP+27CFr4RFCpE8QyDqcasXcwJKXTEp1aN9mBlsPmPuxDwKk9zz0YLzhU13s8/pho1DA2gOHRd1GJosKxXSzShms+/FHSbUjq5nP0GT4asrI9nTZE2w5ZKzz2v1GCiQQ/zaQ1mEM97XH1fs7KgjG9Nlm5WU3nTTPbzE=;24:QryRn1QA2FaTObl9EiplsXHGG9jceENv/xJ9Fv1IDnUI2ZNyAbXoHCnR68BxalGGYG9xh7NxpeJqqJG6MOxlA0ElEbOc4XScQCvCvAlZ+fI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3200;7:+xfV/mzzDFBEsneiSCu7ONdMiI9tsbYltdeyQl7FaHOvkkXDCxrCNiqS3hlOAIwNE3lHgC1i3XF33urstX97b0g4NBNNGpLHS58fOP77iEIwdZP/JK6gLKy7XmCUnmR5JbxIoq0N/9iUdrICHGcpcfm7NcD9BXFcX4XrpoKn3cPcgpuSCr3evU177Ck/EwF+GuVH9DVYXzHl9HDsab7DC9TNHGIhTBUMOFOBYthqMOXdWG1MxCyeMBDUft8ld7ug
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 09:26:45.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aa41a9-0d19-40e5-7da3-08d5e57e1705
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-08 at 13:17 +0200, Jiri Olsa wrote:
> On Fri, Jul 06, 2018 at 09:53:44AM +0300, Janne Huttunen wrote:
> > 
> > The dictionaries are attached to the parameter tuple that steals the
> > references. The code should not decrement the reference counters
> > explicitly. Otherwise the objects might be released while they are
> > still in use which may cause perf crashes, assertions or just plain
> > weird behavior like unexpected data changes in stored objects.
> > 
> > Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
> > ---
> >  tools/perf/util/scripting-engines/trace-event-python.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> > index 46e9e19..60fce44 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -908,14 +908,11 @@ static void python_process_tracepoint(struct perf_sample *sample,
> >  	if (_PyTuple_Resize(&t, n) == -1)
> >  		Py_FatalError("error resizing Python tuple");
> >  
> > -	if (!dict) {
> > +	if (!dict)
> >  		call_object(handler, t, handler_name);
> > -	} else {
> > +	else
> >  		call_object(handler, t, default_handler_name);
> > -		Py_DECREF(dict);
> > -	}
> >  
> > -	Py_XDECREF(all_entries_dict);
> >  	Py_DECREF(t);
> >  }
> >  
> > @@ -1235,7 +1232,6 @@ static void python_process_general_event(struct perf_sample *sample,
> >  
> >  	call_object(handler, t, handler_name);
> >  
> > -	Py_DECREF(dict);
> >  	Py_DECREF(t);
>
> so the dict is released when the tuple is released?

To the best of my knowledge, yes.

As far as I can see, there is only a single reference to each dict
and according to the Python documentation PyTuple_SetItem() "steals"
the reference passed to it. If so, afterwards the tuple owns the
only reference to the dict(s) and should take care of releasing
them when appropriate.

I even built libpython with reference debugging enabled and when I
run perf without the fix I get this:

Fatal Python error: Objects/tupleobject.c:238 object at 0x7f10f2041b40 has negative ref count -1
Aborted (core dumped)

With the fix I get no errors.

