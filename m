Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2917AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF53420870
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="RUZD1Sr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF53420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeHFL0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:42 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48158 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728147AbeHFL0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:41 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BGSD009132;
        Mon, 6 Aug 2018 04:17:48 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0115.outbound.protection.outlook.com [216.32.181.115])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn85wc4uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoM4secehgxyPTnPO1khW1Tz2/hQO23iKwpZtliMQf0=;
 b=RUZD1Sr/6FMpzS4+3NaZ1rTIjLzSVMgRLJIUJt7iUwixzVoYtVtRwVnTPp/M1iJAbZ1Zi/ULMxJT9c6EBrU24an+k+ILUQ/kGzq0f3l9ypw8zNTPi3DSoCIkd9hc7yRB5XdlEezfCJh71uXC53YEz4W3WeJwLiHE9ItACYlfhqs=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:55::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:45 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id E2B3F302D77; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH RT 08/22] sched, tracing: Fix trace_sched_pi_setprio() for deboosting
Date:   Mon,  6 Aug 2018 04:17:24 -0500
Message-Id: <4e6fa907dfa79aafc97aa3fd2386b12ef6a42446.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: CY4PR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:910:16::33) To CY4PR04MB0968.namprd04.prod.outlook.com
 (2603:10b6:910:55::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d442414f-e96f-4f39-a4c4-08d5fb7d785b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0968;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;3:18lzH2p7UxsALeQ+p4DxhPGmH6LfNxxZq+PeZ4FDy/LEkeqkg9aACnOkps3xtpy9FOunujv58/KaWlXUbP+CJcuIRNNJDExlIDpQdp2oXaQCuJ/STezB9OfJpILLgQXXL7v5LjOfxxFfahpdYa1j8zFWmEUjf5JLRZCwxeLBzVd9QChQD4fJshpT0/33pEbUKI0h0Ib1mA7qkwIsiPnsDf1RGG8+V7kGKkYjoKMLDK8K40oMLitcxZQV2nPJAvIY;25:D4E053lZtkiVYJbBdzG8WqdrTSiD4urKqrZtAJ8/oa5kheDkVyTSY1kxmcTKcAK/QjWUOgoae/ir1g860Nk7Zc8m+JpglN2R/QVf69j+cxHhqzi/lqRBjWY28x+lvfaTDcKMMEyDQDguung/nF85t6+My0S5JR8HGC5EH+3YHDzZCxDjPQCJ/Oyopo1AeyuLxepMV5+SCfu/2WAfUockCPmKd6wyVtCwc7fJRYrBJK5gLz5VV37BUNEvDNF331ZFBybsv3ReFKkdQeXPBWex4PSihD2vPoiGcOAh3VQ9FdU2Aawq6J0bX/JD5XPqbhoXyaIx9qH+djeLCcRzBIz+LQ==;31:FabjhARL3OocKnW1wVyDj5MaT3BuCSZoLX94cBGg8UcM0DmRIbzWdT282CzUwugGlwLrmFibGkqBNdTzXEd0Yf3MVtCc/wNrxpyqjSGwheSZ7/JUOuZUl4d2GYRT4PXvDuGZ2DnwQVvacm44Ii4K4gi2imAGbZ/6z0bOy7tf/OxeUnjmqMzwQpJBlAj2cWoQabd7WAuG6quPSH0rdjVCheK/9fQitmn0/mNo9i61NfU=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0968:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;20:xbuOaK3msiJ35WhtE7UOFhTjdHDVWFYVf+D/1lIQnkh/joGOUe9kQvBP+RTkskH/7qIRUHnDnsFYUj0bIOaGJv5jABw3NA6XRpUTNhhVEiC15o91c0BlJtBtpjt9/qT64sB4jW+cU2/uI/KBlpl9AZFHgiPjhjcu8JefcaKnynADG5CUY1V/q3H34mhUxsV9/9OlC9d+IFbSkn3KVgEx4C2NHkImaZ6cFPHe6/+kv6VZShtQr87rESr0Q1K+Lzyuaq1phBhTUXsVO7hddJoNEWzohNpce8/r7CPnFYsOIG6bzCHG2CQh78E++AtB/jKYGYBhHK179keARWCq2lNXjn64ZTqeg48JK7yoTTs2UtRcstT3X7lEFgQhrBdtEpADIxHNweduQDNqkT9X7heeMIQKcqfBWNKPpCyHc9hIWFDc+mqchtK6WHSYbon3gw88CA82Q+FbPXjJn6qFKSAadp4eCtz4LaeYz/iF1H9bKyQRcMGDsIPsdmfIuX/g0WMZuGNxYVzfiv6huYIh/fIaKnxugmgqCHz2d1qGFXvkwMJhfXJNpEbBsUOxfsPOsCGXwP8KzoOCl/2ZPnF+PITtKsyuFigXsVaHwxxY+53dxEA=
X-Microsoft-Antispam-PRVS: <CY4PR04MB09686FC24F2940F889126C3EF4200@CY4PR04MB0968.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0968;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0968;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;4:uCNFi0LNx4ln4YOGgF1Z4bC+9oFDU3XKbEWs/OIKz7kS/qPj6Aosv7kyzHmjuu39LjwOnUWWyby/t6bZ682g0OMtZw1DHVCibVKQFbHLzoRSMAQWVt/1szZeFm6Jy8fTDvCVh/BjZKEWW1jzmBGSvgUQIbVgLE+NJ5nZDcBpy+vSKYub3Iwp7tbwz1+t63Klzu+MWev2kL5aEfjP42dCVI8PX0455YkONxvLZUFZOBt0idp9tMP10DxTtKlZfmKTEU/eTQ64BgsD6GhHqz7eki8kSUKolg29AR/nikwzOu5WoCXhxyQs7MoWC4BVtn1m4rw1c7JPFpmBNBwCLF/LhGlSlwZhsEHfKVQHaYjo87A=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(346002)(376002)(199004)(189003)(6266002)(47776003)(14444005)(66066001)(54906003)(966005)(478600001)(476003)(386003)(97736004)(26005)(6666003)(3846002)(42186006)(6116002)(122856001)(50226002)(6306002)(316002)(446003)(2616005)(4326008)(186003)(106356001)(52116002)(5660300001)(68736007)(36756003)(2870700001)(105586002)(11346002)(305945005)(50466002)(8936002)(7736002)(81166006)(486006)(23676004)(81156014)(118296001)(76176011)(52956003)(8676002)(2906002)(7416002)(90966002)(53936002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0968;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA0TUIwOTY4OzIzOmRLVk1lU0xLS2J5Qy9qdGZOcktFbFdOSm03?=
 =?utf-8?B?NFg4cjN0alJNZG9kSXc1RnNKL25Fd010V3piM2tGd0FzeTQxNmpaVEhKVXZ6?=
 =?utf-8?B?UlIyYXNtN3N4UkxWWUdOQ0tIZkI1dHFtVEFFRjdmNDhTenArRy9OYld4amxj?=
 =?utf-8?B?SmpYRENZV2pzR0swMVduRmt0dGpXNmR1SlEraUk2L2tnL1FEUkFGdzJPN29h?=
 =?utf-8?B?bllUbnAybVBVMHAxODExelB3L0IycDdLZjlFemdjTEpET280eTA0ck50SU5n?=
 =?utf-8?B?K0FER2Z2YXYrVlIzQWF5YjJQZUhGeDJ1elUycmdNemdnSTBDREtrNkR0UXAw?=
 =?utf-8?B?WmRiTWs5dmliTjZvWFZiZTQzUi9nMzUyWm5yb05BSUhwNXRCeUc2THpqUlVP?=
 =?utf-8?B?blY2dzBNc1ptdW1KNDFWRzNSNGVxdWE1RkhITHpXZzQ1NDk2elRUb21HR2JK?=
 =?utf-8?B?SENHUFJ2U3kzZlBsRTdGRlVqUDBpMnJ2L2NxbFlXQllQdTY1SCtWZFRIaEly?=
 =?utf-8?B?WWhrZjMwbGhaSWM4dVI0T211QnRKcU5TY0RSdTF1VjNGWHNQQS9JcndMMkZG?=
 =?utf-8?B?T0JiMVFLVVVGNHk4MzBYVFFYZGZ2MWFqMUxIZUlxcVY1Q2RJSzlkVGMwZUdC?=
 =?utf-8?B?Ymk0bG5GR1RmRFZOdkVMeFk4VGtaQ1crV01PZ3gveFpRVXBDbExVSnBaUU9O?=
 =?utf-8?B?eE5vUFR1bUNFYUR5T0FHOGZwcVBxUWlYVkp4ek84UVZSYkVtckNsa3ZOYmxP?=
 =?utf-8?B?Wm1xUENLazdMbGlkNFY1T3BiUk5raFFOZnNzQzNjOUU4ajNsQXVrcXpPQ0JJ?=
 =?utf-8?B?RXlzYWpUR0QxWlZSTEM0cmNRdm8rYVlsQ28wQkF0bXp4T1RNWEd3aUZPdFRq?=
 =?utf-8?B?b1FsRGtUK0FTWlR3NEdFcUtzVnVBMTh2RERXL0Q5UzZIcFN3S2JGSjg1YkFl?=
 =?utf-8?B?dU1ReGpTa1N4NW9aVGhHYUlodHowZGJLcld1R3kvSmk1NkZlLzZuQ3oxS2Zl?=
 =?utf-8?B?eWlxL3FwSDZZMFZOcGFsUzVWMkh1eDdaamQ2SGtoSkF4a0w5a2VDby9aQXhU?=
 =?utf-8?B?K3VpaFBCYkwzWEs5SjJjR0tVNzVrVjRQNy84RTFxaEoyZkM4bm5wYWh1cjQ3?=
 =?utf-8?B?Y0RoN2N0UFhscUxKNVpQbFZvVGpvejNJQ1FPSFR0K2xDWFo4QUM5ZEZVeFBE?=
 =?utf-8?B?UDZ5N1U4aXF5QnVHTDViNWJlUGVTbGNiUHRmWTBTNjROS3Jnc3Z1bjlVUVFp?=
 =?utf-8?B?Q0FXWVNTbVJXSGdpdXc2aGhhb29lRlFmUmVRWnBKZFBFd0lFOHpCZ0pVS0FE?=
 =?utf-8?B?b3FuSUpJUW1iSzlpZFhtZXE1N3BSeFp2ci9PYVhjQXVzSEI5MVdVL1NXOWV3?=
 =?utf-8?B?ZjVBUllhdWZXNEFnSFlYUVRoQjEra3dPSkV6eFNZTFBOOVgvWGJlYmg4dWZU?=
 =?utf-8?B?UUZWeDM5MWU3R2NPemZieW4yMHNnNC82MkFwNE0xNE1ZVG5iWldJRytRUlZr?=
 =?utf-8?B?UHpaenRINWpiZUNoOVZYYzBYdVBPSGRaOFR4S2UwSVh3dHJ6V24wOXVvc1A5?=
 =?utf-8?B?a2ZMNW1vWkpDVTZJeTN4TG9lUnpnaWZLcXdBRy9jbWJVcjhqcGxxWDVGR2Z2?=
 =?utf-8?B?U1h1L0VSbFFaYnp4ZDkzelhIYWZUcTUrdkZKSjNoQTJDUUMrL0NhUGJUS0ZX?=
 =?utf-8?Q?yY1DowHT7A1ap27zrc=3D?=
X-Microsoft-Antispam-Message-Info: gZ6DScZg0Yp+5N9+80FtjBdafdMiRbO79YvO+d4OL58XIDGACmMzPx4RmB7NDAG7gOErGGJWphz0dbfUfnR+3WrWDKkzx7XcdeInk6Xl0Km5YUldJ2qhHgrPBQizL2/V1hCAgl1fHfjpqZBENtP6x364WE0T2M9mkxfWPHVfNMO0AsMZ4Wpe8yIf/GqjOlb0gK50k8SV40FG8swxsIZ/H1WGWCnqcz7IAr6e6TPTzDs+hlgCWaliGHTYYIbpTUIc9AWgNB4MaIxJp+7ulcde8ayCB6Zekn5rXfkelp41Z7I5wOw1rUZ7nDxBvhHAvyUdQ379z+IPJTZAHLbhdwqva2LTzXEQbKOtwaRHgZiAHM4=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;6:b0zALhQzx0rgbCy6Y4kGyuJBI0HCQQNir29yJAPAsMCut+UNsQm4hldnLE7w7mR0Odks+s2sFWZIb5h6Vga8y+s/E06gjYCIB5fU8fG+Beh82npDQLWoaXKKRny1/64bnmYmOyCZFaMRsPwAITNRmKvJcWOeM8UUFEW347t8l3QJycrwGKRkbVESP6bdhVZnmEHmN1nW1Mb4qFrg7h4GL0FRs6oORaCT4AktjTeYVSzO00rfYoEITzVQrZIifur4v6kbEswsRIVIJ1/6T5NTMgPT5z53S6bmtfn04DkwC3Ke02d922drYId8ljyQHlo0qyDESr6Q23fGLB5VrAlQWZVLoRvaipKtzxpWJlMdTHj2KnCj4iA4e4l1kmQYjIs9zXWfStohTkIvNEs9z/9emlwi8wKfhRuHvVcoaHGSfULLvbG3vxNuvhzM6uuH8lOFCXrUo10zFbZb2H0lEilQZg==;5:PXd9dOJf5RTlKvVsP12cYWEbXL+4FKuGThYAjk31H+ywISAcCYl486CL26t/UQVrDQNz/xuNQSU3WzoczgehQpzE6roQLyYVYuteI2JrGw2m7NtboKN7j2F6jLJ8GQ3aOgFY/12hB7PRkWr3tm7C5/Yv2sdCdYTbZD16bH46Dds=;7:67yzvd2W8T5q7yfvN1ihsMTpWlbhZiFbbeMvYEhWyGWMGgLHiRCJU+HSmnrUV8UdfMMAYpQm74K8hcyt5bctZLDof5xzkDiYnCs3Jt3KPuBTpv3V5AndRjgfh9nCKW3zj6VMeMuByRTvrOdFXbdpFsM9tuG1E0aMwwmnpVkoNesFGnCBTEshr4Sb3BHp9u7GrGPm/r1VAGf6azOdgQRJ+xtdPi+fJ5Nq6RgiQJRcKG2vwL1hQr9a9Huq++yyALKG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:45.1188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d442414f-e96f-4f39-a4c4-08d5fb7d785b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit 4ff648decf4712d39f184fc2df3163f43975575a ]

Since the following commit:

  b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")

the sched_pi_setprio trace point shows the "newprio" during a deboost:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"34 oldprio newprio=98
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"34 prev_prio0

This patch open codes __rt_effective_prio() in the tracepoint as the
'newprio' to get the old behaviour back / the correct priority:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"20 oldprio newprio=120
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"20 prev_prio0

Peter suggested to open code the new priority so people using tracehook
could get the deadline data out.

Reported-by: Mansky Christian <man@keba.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")
Link: http://lkml.kernel.org/r/20180524132647.gg6ziuogczdmjjzu@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/trace/events/sched.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 516ae88cddf4..742682079acf 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -429,7 +429,9 @@ TRACE_EVENT(sched_pi_setprio,
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
-		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
+		__entry->newprio	= pi_task ?
+				min(tsk->normal_prio, pi_task->prio) :
+				tsk->normal_prio;
 		/* XXX SCHED_DEADLINE bits missing */
 	),
 
-- 
2.18.0

