Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995C620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eXI7Ikum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995C620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbeHASGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:06:30 -0400
Received: from mail-eopbgr40133.outbound.protection.outlook.com ([40.107.4.133]:55954
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389854AbeHASGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqm33LVSUgrjO95cagpDaqnIg5f99uYSB4hhs7JIMr4=;
 b=eXI7IkumXGhIhleIXunnKTCYfI5Ph/MUDdpWKsivhW7xHld5J5+R+OAacH99LC2GfVQtkzagUoOgI79ZdcZud2SCzswwNRnjR1ESvwonfE0v78Gp769p9LOLfG+sfADCESBozcvrlNgzOVWRt9PK5xzN1XGpfTXJypewxO8zhSE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Wed, 1 Aug 2018 16:19:38 +0000
Subject: Re: Commit "new primitive: discard_new_inode()" introduces a problem
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <64a0f022-a32d-d4ee-7464-5c5ce0ebd222@virtuozzo.com>
 <20180801151937.GN30522@ZenIV.linux.org.uk>
 <96e3c195-aaca-9214-0dcd-5c2b970a72ae@virtuozzo.com>
 <20180801161151.GO30522@ZenIV.linux.org.uk>
 <20180801161648.GP30522@ZenIV.linux.org.uk>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <31fa5f9e-6378-2345-777c-7deb6f9a2d19@virtuozzo.com>
Date:   Wed, 1 Aug 2018 19:19:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801161648.GP30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0007.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::17)
 To HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a248dd-58fe-4926-8bdf-08d5f7ca9493
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:wqXXSRIhpzjMdu5IbBb5eLNxOhzALcj4hB1A6f7qWWsuBB3hPHm6P4cJ3qn1LCySogvB3wzFOSxIGsnK374g6p9027MUwLk+P2xCi83jAB9Qxp1Bt0m6yF/ORvO5LTKIyv5cS1y5JBd7mvJtcQvb3ndAlKu6KzDXTmUPYvBmE7xYrGzYKRM/5PifoeqE2XHWdexOcc7N4+AbknJq8ZCSi8Djo7Vt9iSjHsnzDr3LdSKQT8yy1c/ynwSCM/iMN+lR;25:kPf3hOpj2d8N/t1cJGdXbNVf/3Ys2ArecqhLMSQglCPFMB+7uODc2sNEoXVC0quHESFxf6r4SeY9AU1evNFVXtMKx8xGvUHRG1m85B+/PNV+eyKCw28PEnm9VghQlF2spXoPlAKbFpQlXYC7huI9sPLAnpiPeE3jfmmkmGVoGOQuQlsIgtePPQcphfL1nXjU7Embm0Vj8H+02MNz8QGrv5rnrxfW2om528P2tbWPWoayghGXWT/C1dXOGS3NWHtpvFsLzf9qC0YZ35X36Pcr/T6n2W9mdmMkUl7Bpqyrzos7NiVuX2Sujeqf76GbJSmJvrNZfJ6hohH99WUX6V+hvQ==;31:ENRe8+3AogFBAP9Lbxs3qTUpEigv5S0m96nUzk6d6rwMLEP8lBMI84O01S8z78QJ1cRjMci7Y1nYkvEZXheNfzwbFAl1+xs57kOEevUXQyGodX6tunRZu1fBLDjagkSBUaHAlNl/G+ELq67e+JAmwjEddgz6Q9iBFpNC63tKNbYtaDBJj8T0AXgNb7Wu3KbDzd3iYXEsysasktsN69klFS4/FhbeX7mGfea6Ju67E50=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:OWZd6sR+LrZoY7YECccznyWUFUv6i0G8MimDKJhTnYtTeHwmwVnbLrlw99+y/zqrwVT8WHdhQizAI6Wwub1tphq2SUk20Aj8xND/9l36ytVQumjHMC2QfDN+xnfgp03M0OdPSdzFc+ud85eowrCp6E1l3g0UBH0Boe5s56zlz3ky5Bvvt1Zy+J8vvd52mYhxIs51tqcNQ6GFLwTXzESYOk0WZO9KoRLwgXIO4FI7psegzX1OJoTflMzvWDzlB8aeuzlK/rRI0n/gPFvwBzfPS73iO2/P8DNFmYVUvksFJiyrKBX7FrKnAlallgybXm8CjL8PUcSGJ6k5XC+8ZbS1Ufnpzv17ZfejbAi8ABZrli3IdAGJjn8Uo4ji86UkB7Epx7ayY7+KRxuDBjzFcoEhTPe1E1VAXcUY+FiceZpOVZ7KfkDTNy5KsFpLWvDYGri11F5Ton+WMB/0LA7xpj5aQ/sKAiNKny651mZjl06jkJCiAmVFSOKL6ghP1wKM6CqC;4:9foUFKkrnrRijZBmYs6JQyjWwJMktkWOovyTkcrGpEm1PJQIhyKzomz2Gh1kfJ1b5mH9yUv/Hd48lKznlsoJv2HwwK/dBkhup0lIS6grA5ZQLHge4k8BPZ37f5x3BevwtkT5bN6Haqspv1fGbhY1VeFSlXtejGkaoBwZDZ4UBOGk/2UogzTc60yA9i5jbInQNt0Rj/dGOLxwDx9ppKoFLlGBJ3Kr9Bp6bX60sVHMihTmI4bk+/JaJ1Dt+n+/kGXKYzrvnxTSx2KHxTo7QpHxww==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2026C28B80BCEA725BD93199CD2D0@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(136003)(39850400004)(396003)(366004)(199004)(189003)(2906002)(106356001)(6666003)(478600001)(6916009)(5660300001)(77096007)(446003)(186003)(97736004)(68736007)(36756003)(11346002)(2616005)(476003)(956004)(58126008)(316002)(65826007)(16526019)(64126003)(486006)(6486002)(16576012)(81166006)(53546011)(8676002)(305945005)(7736002)(229853002)(8936002)(26005)(81156014)(47776003)(4326008)(3846002)(6246003)(23676004)(31686004)(386003)(50466002)(52146003)(66066001)(65806001)(76176011)(65956001)(52116002)(105586002)(2486003)(53936002)(54906003)(6116002)(31696002)(86362001)(14444005)(575784001)(93886005)(230700001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6UCtFU3hvV3VocFNmcEZqbXo2NVRGUGFQ?=
 =?utf-8?B?cWdNdjRuUGRTSVZjbkF0ellBK3lnVlo1MHVVOHV0VnhLS21QWFJHVDFXL2Nv?=
 =?utf-8?B?UDJvMG9meS9jSGFieXF3MFpqWTYwMjBWS0RtQU8ydEtCcloyQUh2dmNHTGhZ?=
 =?utf-8?B?ZVJmR1pib085QkpKbzJEZjlxL1FrdzdEWnEyVFhreDJwOHJNZWZpUE9GNWkr?=
 =?utf-8?B?dUVHTnlwNVkrSGdTZEJ3QjNPQ2t0byszMkIwUU5wVjRUZUphNmZDb2ZQMUtL?=
 =?utf-8?B?Y1hIKzdQdWtmNGsxb1VtcVpIbzB3b29lTFNWVCthWURQRmdjeU1oK2Y3TVJN?=
 =?utf-8?B?NHk1amtsbWd4a3BoUkNyZkxJRGc4Y0RTZHNMem1CZUswcGxWSVZQL2pjTFVl?=
 =?utf-8?B?aTAwUExJQmtFVmdkRGQ2S1VnOXJML2NUc1hINHdmeUE0eS9hLzhpYk9kRzAx?=
 =?utf-8?B?Y2J1bG9SZ0ZuMDcyRDhWYU8vaGRINXpTa1NjeTRUNnZ5dUhBZndtenN3VFZW?=
 =?utf-8?B?RzBteXhxVG83cGQyQ05oMGpYM0hoTVRNUmljaElPVnhWOVVYdGFKTTZhaHB1?=
 =?utf-8?B?Q0sxZ0premZvTEtRQlEwV09oY2FpNHpVdU9YaUUvRHRSQVoxMWpINVhlaThW?=
 =?utf-8?B?d3A3c1UwWmQrVFV6Witwd2lWRWl4WGJzNFNGb3lxb25mUzJtQXk0NlpHdDVU?=
 =?utf-8?B?ZEN2ZGdaUjczejBuZWh6eHBXV3FXYUY2LzNlOG9LZ0U5K0xCdjc3eTNzUWlz?=
 =?utf-8?B?S2lRTXhqMzhBZTNLclAycmhpRk9PWENValNVVmlHVHVBZUlVSmtaNitaZnZo?=
 =?utf-8?B?V1h6SmIybytiVlptTzVxUGhxRnFMcURLTnpKb0VYWTkvNzJzbGlRZzlaUHBo?=
 =?utf-8?B?WUlwWUdOYVlnd2JBN1ZnVmE3N0J1RHBLejJ6QWk3WjFTbFN2bFNpak9taTlG?=
 =?utf-8?B?cUYvSWpFSHZlZjFsMk5kbGNhcnBCUlhoTHl6OFZua2ZqRFh1T3pKYTBDYjRn?=
 =?utf-8?B?ZmdRcXJRdHFvQWZBeUtIZjdMbUdwTkxBR256VFgwL3VqK1YxV3pXdk1IeDJD?=
 =?utf-8?B?TVd1Q3RlYk5OTGtoeWU5OE1SSDhjT25hWnRRQ0dOWXR6Q2IwVHhsYVVURHI0?=
 =?utf-8?B?WmE0WGlLcmVpK2pJRUZaNHpKeVo2elBaU2tHVVBZZEVKd2V5UXdvdkJMSmp6?=
 =?utf-8?B?L3RRVjZVTm5MYWFlYlJtZEh5TnpUdnVCZ3VwZlY3NEFzMVB5MGJ4YzRTbkRK?=
 =?utf-8?B?YVM5WFNNdk15d0l3SWJZSEdyN2RDN0xnRiswemNucFZqd3dPeHVEbnUwVlhS?=
 =?utf-8?B?M05rc3F5V1hsTDBsQnpjQkMrdzZQelU5SWxmT3pjVUtvQXlNYVlGWkZYS0tD?=
 =?utf-8?B?cHdkRWRUSzVDSmljUEJpMTZFbHhReEtkclIrWUN0dkZDSWVqTzQ3MWkvTmdL?=
 =?utf-8?B?Tk5pQm9VVXlNR2Q5aDFlV3pGNnYyREtHazJOZDVNRUVhRENLMi9QQk5YaDNm?=
 =?utf-8?B?bUNaZVF2cEZHTThLeEs4L2FNK3dWUTA4RkJYQnZSdEsxNTZNZUIwMTQxMFoy?=
 =?utf-8?B?K1V6T0QzT3pHM3I4RjkxdVlvc0lKUVNtREdCOHNDaVN5OFdONVQ4WWJXbTNx?=
 =?utf-8?B?K0VORUdLWXNmYWlwYVN1YTdxWFY4UlI1b2lPaC8reHpOTnNxYXRxSVdoRzFK?=
 =?utf-8?B?YzRjRHl6dlluZlpCelVQMUptU2Q4dXBkeGtWYWtyNTZsSFBqZlFjaWYrUi9U?=
 =?utf-8?B?c213Q3BKNmVmMGczRlBzM1pLMTQ3SUp4ZlBSTUhITnFrKzRMTlNyUHJva0dr?=
 =?utf-8?B?cUlHMjJ2ZjU1N1NKaW8xNFNTaUNLLzZlSmNvOEx1RGRQQnlnZ01KV3BiR2hJ?=
 =?utf-8?B?SklRbVdyM3BwOXo2dy8vZVpCTU9jbkQyZXhVUkh0bk1DRHBvZUIwNm1YVVBD?=
 =?utf-8?B?R1JkUm91YTZMSkJUZC9CSm1VcDZVYTZzMXBURWNJeU9Dc0hUeSt6MnNVZUIv?=
 =?utf-8?B?S2ZaN3NYR1JpSFhsRGpuUGptampLSHBLUEJjWExRPT0=?=
X-Microsoft-Antispam-Message-Info: 6p+L5FH6HJ9OjYzstJ4bu+I2Y7Y4deVBR/sFKRIkT+nygBzYU9YrX7o9i3tAELltnl4vDIeb2dfeA4eGTg+Ng1Dc03YOGCpt+3S+lKEaeW08TzwX8LP8AKvKludbfUQJ5h5SCbcwtNH4qlytxrBuEc9mVWtQBoKLYngJTC9wT+yag3qg+oNIZ4z04myRWJkt8SuTqTMqBiargpZ+6mfoc/Va2lg++9Cxe2IcYJVV5mXABvsX8/eod5Uq/JulP5VQns7oCZQvWHaJEB1PKgmngyQHceGsrqefOTww8EuNzKhgTQfBQVbHfZ0m1PW5HzdfZ6+Oc/Tlv264Yqf4uXcelGGSMXN7DkmNwfcW2KKfxxM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:0FErFUw8Dx9LjHAiyrzIJEt+2RR827EECcZRbdFSCvYHishcecSyLCW5kpcoCQsGAQw9iDJpq6i/zwEQ/vyePbM4CNNP75vm3HKCPo4+3Q7XIbQ86OKPKuvo0xwtXApXxbS7Tg0uzpaFd4RkoOFBdQOWZzgyd7KjluOsxAcuVzg3uZhIia76iR04KWXvjLv2tuQncdJgBzQ2z2xCixPBlBsTwJkPgjopYwV1/Mpmj3ZsdR1vAhR9lRHJUzmy1PDlPyRYsRNaUfnkZL588SGbR3T3UI0q1HyLNJfXys3CyuBmYI4NKqCFT4OcYYx4qhbVcaxL2qhZwomEpO7/p4Bc1AhYUBuxpyNZcIXOUhE8yRKWywUj1d0H7M0CiHakbcxBZ4AmASRRppD2mGJpLq4yzz1n/QhwBzIFvy3+IV5dtm52sspq6oSojG8sFCY4x2TGCuxCHiyqf5btS8gArqvgaw==;5:/r/5q4DvyPbBVtSlVKylDAvDbNb39HvLDaHQvGgMcMzf8HEjPJP+vqZgK/MCVyM2AiCvtbE1pWXdRkFxTWom8srRVgOaKGufRdHFaPp204hce9B9wc+2u6VfWhnXqap1e1Z5R7/iDR1CTrMcZP1dzVN4pwKIf68z8oxY2ULnlVE=;7:lsB+dlAwESheblHpGM3NvFyWEVBqUkGGYJa8X9u3TCNvYZbvnFvsrGpxRHd/duhKs0en5EiZX9fs00gHL290SLq2EjjX60JMQeoHYPlz6nNsAttAEt/0XrDY5QU85HYRhaOAuoZ/N0pAkbmbK36JKBsDn93ACL2ceHQjTe0LxxJBBiFztQ3sohLiWZ5zwdLMongDL6CW1dI+P4JcOwcxAMt4NYCKdsVD/RqDhiaYtI7YBa4IZCaGvHefyJcS+pPL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:jtqR/tBFXb8GLE6NkcWXvQfR6JwN8f69VhUL/lBnr/aHgGOZZGELW9n8guGWvTiWvvOZF/aKJeJOECzflh6VRN2TA4OGL3Cn0BigWTPgDi5mIdzEWO0wtAZPZtRdFnU81DA6CtlMMv/qCXyEtg/FBxAfzVElgUyU+dLL6K2ktK0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:19:38.5320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a248dd-58fe-4926-8bdf-08d5f7ca9493
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.2018 19:16, Al Viro wrote:
> On Wed, Aug 01, 2018 at 05:11:51PM +0100, Al Viro wrote:
>> On Wed, Aug 01, 2018 at 06:43:56PM +0300, Kirill Tkhai wrote:
>>> #git status
>>> HEAD detached at 22dc9a168272
>>
>> Wait a sec - just that commit?  With discard_new_inode() not even
>> used anywhere?  Then any of those -ENOMEM is disguised ERR_PTR(-ESTALE)
>> from find_inode()/find_inode_fast(), i.e. an inode found by
>> iget5_locked() (your /etc is on ext4) with I_CREATING still set.
> 
> iget_locked(), that is.

[   32.266377] WARNING: CPU: 0 PID: 2301 at fs/inode.c:841 find_inode_fast.isra.24+0x90/0xa0
[   32.268509] CPU: 0 PID: 2301 Comm: grep Not tainted 4.18.0-rc1+ #32
[   32.269209] RIP: 0010:find_inode_fast.isra.24+0x90/0xa0
[   32.269789] Code: 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f6 c4 80 75 11 f0 ff 83 30 01 00 00 4c 89 f7 e8 4a 7c 24 00 eb de 4c 89 f7 e8 40 7c 24 00 <0f> 0b 48 c7 c3 8c ff ff ff eb cb 0f 1f 44 00 00 41 54 49 c7 c4 30 
[   32.271876] RSP: 0018:ffffc9000113fb80 EFLAGS: 00010282
[   32.272448] RAX: 0000000080000001 RBX: ffff88013aff9088 RCX: 0000000000000002
[   32.273231] RDX: 0000000080000002 RSI: ffff88013fec2350 RDI: 00000000ffffffff
[   32.274019] RBP: 00000000000405fb R08: ffff88013950c400 R09: ffff88013ac43ea0
[   32.274796] R10: 0000000000000014 R11: 0000000000000014 R12: ffff88013b199000
[   32.275579] R13: ffff88013fec2350 R14: ffff88013aff90f8 R15: ffff880135cb5180
[   32.276355] FS:  0000000000000000(0000) GS:ffff88013fc00000(0000) knlGS:0000000000000000
[   32.277189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.277786] CR2: 00007f6f73e26018 CR3: 000000013a98f000 CR4: 00000000000006b0
[   32.278513] Call Trace:
[   32.278777]  ? iget_locked+0x69/0x190
[   32.279162]  ? ext4_iget+0x3f/0xc00
[   32.279443]  ? preempt_count_add+0x44/0x90
[   32.279733]  ? d_alloc_parallel+0x358/0x4f0
[   32.280039]  ? ext4_lookup+0xd6/0x200
[   32.280282]  ? path_openat+0x9d6/0x1400
[   32.280537]  ? do_filp_open+0x8e/0x100
[   32.280842]  ? __lru_cache_add+0x6e/0x90
[   32.281300]  ? kmem_cache_alloc+0x22/0x120
[   32.281544]  ? do_sys_open+0x181/0x210
[   32.281789]  ? do_syscall_64+0x56/0x2f0
[   32.282046]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   32.282351] ---[ end trace 109b3dd4fd5e6451 ]---
[   32.282657] WARNING: CPU: 3 PID: 2300 at fs/inode.c:841 find_inode_fast.isra.24+0x90/0xa0
[   32.283126] CPU: 3 PID: 2300 Comm: parallels-serve Tainted: G        W         4.18.0-rc1+ #32
[   32.283595] RIP: 0010:find_inode_fast.isra.24+0x90/0xa0
[   32.283881] Code: 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f6 c4 80 75 11 f0 ff 83 30 01 00 00 4c 89 f7 e8 4a 7c 24 00 eb de 4c 89 f7 e8 40 7c 24 00 <0f> 0b 48 c7 c3 8c ff ff ff eb cb 0f 1f 44 00 00 41 54 49 c7 c4 30 
[   32.285066] RSP: 0018:ffffc90001137b80 EFLAGS: 00010282
[   32.285397] RAX: 0000000080000001 RBX: ffff88013aff9088 RCX: 0000000000000002
[   32.285829] RDX: 0000000080000002 RSI: ffff88013fec2350 RDI: 00000000ffffffff
[   32.286218] RBP: 00000000000405fb R08: ffff88013950c400 R09: ffff88013ac43ea0
[   32.286601] R10: 0000000000000014 R11: 0000000000000014 R12: ffff88013b199000
[   32.287035] R13: ffff88013fec2350 R14: ffff88013aff90f8 R15: ffff880135cb5180
[   32.287430] FS:  0000000000000000(0000) GS:ffff88013fd80000(0000) knlGS:0000000000000000
[   32.287872] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.288202] CR2: 00007ffd0f3e4f68 CR3: 0000000139d59000 CR4: 00000000000006a0
[   32.288650] Call Trace:
[   32.288871]  ? iget_locked+0x69/0x190
[   32.289106]  ? ext4_iget+0x3f/0xc00
[   32.289333]  ? preempt_count_add+0x44/0x90
[   32.289595]  ? d_alloc_parallel+0x358/0x4f0
[   32.289858]  ? ext4_lookup+0xd6/0x200
[   32.290059]  ? path_openat+0x9d6/0x1400
[   32.290268]  ? __mod_node_page_state+0x64/0xa0
[   32.290510]  ? do_filp_open+0x8e/0x100
[   32.290721]  ? __lru_cache_add+0x6e/0x90
[   32.290968]  ? _raw_spin_unlock+0xd/0x20
[   32.291218]  ? __handle_mm_fault+0x6f2/0xbf0
[   32.291473]  ? do_sys_open+0x181/0x210
[   32.291684]  ? do_syscall_64+0x56/0x2f0
[   32.291932]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   32.292239] ---[ end trace 109b3dd4fd5e6452 ]---
[   32.314195] WARNING: CPU: 1 PID: 2303 at fs/inode.c:841 find_inode_fast.isra.24+0x90/0xa0
[   32.314866] CPU: 1 PID: 2303 Comm: uname Tainted: G        W         4.18.0-rc1+ #32
[   32.315479] RIP: 0010:find_inode_fast.isra.24+0x90/0xa0
[   32.315889] Code: 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f6 c4 80 75 11 f0 ff 83 30 01 00 00 4c 89 f7 e8 4a 7c 24 00 eb de 4c 89 f7 e8 40 7c 24 00 <0f> 0b 48 c7 c3 8c ff ff ff eb cb 0f 1f 44 00 00 41 54 49 c7 c4 30 
[   32.317376] RSP: 0018:ffffc900010ffb80 EFLAGS: 00010282
[   32.317797] RAX: 0000000080000001 RBX: ffff88013aff9088 RCX: 0000000000000002
[   32.318374] RDX: 0000000080000002 RSI: ffff88013fec2350 RDI: 00000000ffffffff
[   32.318979] RBP: 00000000000405fb R08: ffff88013950c400 R09: ffff88013ac43ea0
[   32.319529] R10: 0000000000000014 R11: 0000000000000014 R12: ffff88013b199000
[   32.320089] R13: ffff88013fec2350 R14: ffff88013aff90f8 R15: ffff880135cb5180
[   32.320630] FS:  0000000000000000(0000) GS:ffff88013fc80000(0000) knlGS:0000000000000000
[   32.321258] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.321697] CR2: 00007ffc86055fe4 CR3: 000000013b2a4000 CR4: 00000000000006a0
[   32.322254] Call Trace:
[   32.322450]  ? iget_locked+0x69/0x190
[   32.322739]  ? ext4_iget+0x3f/0xc00
[   32.323015]  ? preempt_count_add+0x44/0x90
[   32.323334]  ? d_alloc_parallel+0x358/0x4f0
[   32.323655]  ? ext4_lookup+0xd6/0x200
[   32.323943]  ? path_openat+0x9d6/0x1400
[   32.324248]  ? do_filp_open+0x8e/0x100
[   32.324541]  ? __lru_cache_add+0x6e/0x90
[   32.324833]  ? _raw_spin_unlock+0xd/0x20
[   32.325088]  ? __handle_mm_fault+0x6f2/0xbf0
[   32.325335]  ? do_sys_open+0x181/0x210
[   32.325551]  ? do_syscall_64+0x56/0x2f0
[   32.325778]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   32.326100] ---[ end trace 109b3dd4fd5e6453 ]---
[   32.328654] WARNING: CPU: 3 PID: 2304 at fs/inode.c:841 find_inode_fast.isra.24+0x90/0xa0
[   32.329183] CPU: 3 PID: 2304 Comm: grep Tainted: G        W         4.18.0-rc1+ #32
[   32.329600] RIP: 0010:find_inode_fast.isra.24+0x90/0xa0
[   32.329887] Code: 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f6 c4 80 75 11 f0 ff 83 30 01 00 00 4c 89 f7 e8 4a 7c 24 00 eb de 4c 89 f7 e8 40 7c 24 00 <0f> 0b 48 c7 c3 8c ff ff ff eb cb 0f 1f 44 00 00 41 54 49 c7 c4 30 
[   32.330947] RSP: 0018:ffffc900010ffb80 EFLAGS: 00010282
[   32.331246] RAX: 0000000080000001 RBX: ffff88013aff9088 RCX: 0000000000000002
[   32.331651] RDX: 0000000080000002 RSI: ffff88013fec2350 RDI: 00000000ffffffff
[   32.332083] RBP: 00000000000405fb R08: ffff88013950c400 R09: ffff88013ac43ea0
[   32.332476] R10: 0000000000000014 R11: 0000000000000014 R12: ffff88013b199000
[   32.332871] R13: ffff88013fec2350 R14: ffff88013aff90f8 R15: ffff880135cb5180
[   32.333277] FS:  0000000000000000(0000) GS:ffff88013fd80000(0000) knlGS:0000000000000000
[   32.333725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.334054] CR2: 00007f49836d1018 CR3: 0000000139475000 CR4: 00000000000006a0
[   32.334438] Call Trace:
[   32.334578]  ? iget_locked+0x69/0x190
[   32.334790]  ? ext4_iget+0x3f/0xc00
[   32.334990]  ? preempt_count_add+0x44/0x90
[   32.335213]  ? d_alloc_parallel+0x358/0x4f0
[   32.335445]  ? ext4_lookup+0xd6/0x200
[   32.335650]  ? path_openat+0x9d6/0x1400
[   32.335888]  ? mmap_region+0x265/0x590
[   32.336097]  ? do_filp_open+0x8e/0x100
[   32.336306]  ? __lru_cache_add+0x6e/0x90
[   32.336522]  ? kmem_cache_alloc+0x22/0x120
[   32.336756]  ? do_sys_open+0x181/0x210
[   32.336968]  ? do_syscall_64+0x56/0x2f0
[   32.337180]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   32.337461] ---[ end trace 109b3dd4fd5e6454 ]---
[   32.341735] WARNING: CPU: 1 PID: 2300 at fs/inode.c:841 find_inode_fast.isra.24+0x90/0xa0
[   32.342298] CPU: 1 PID: 2300 Comm: parallels-serve Tainted: G        W         4.18.0-rc1+ #32
[   32.342767] RIP: 0010:find_inode_fast.isra.24+0x90/0xa0
[   32.343116] Code: 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f6 c4 80 75 11 f0 ff 83 30 01 00 00 4c 89 f7 e8 4a 7c 24 00 eb de 4c 89 f7 e8 40 7c 24 00 <0f> 0b 48 c7 c3 8c ff ff ff eb cb 0f 1f 44 00 00 41 54 49 c7 c4 30 
[   32.344127] RSP: 0018:ffffc90001137a68 EFLAGS: 00010282
[   32.344405] RAX: 0000000080000001 RBX: ffff880135cc1858 RCX: 0000000000000002
[   32.344785] RDX: 0000000080000002 RSI: ffff88013ff13260 RDI: 00000000ffffffff
[   32.345162] RBP: 00000000000c04c0 R08: ffff88013950c400 R09: ffff88013ac46548
[   32.345533] R10: 000000000000001c R11: 000000000000001c R12: ffff88013b199000
[   32.345914] R13: ffff88013ff13260 R14: ffff880135cc18c8 R15: 0000000000000000
[   32.346291] FS:  00007fedf735d700(0000) GS:ffff88013fc80000(0000) knlGS:0000000000000000
[   32.346732] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.347078] CR2: 0000000002741088 CR3: 0000000139d59000 CR4: 00000000000006a0
[   32.347522] Call Trace:
[   32.347676]  ? iget_locked+0x69/0x190
[   32.347893]  ? ext4_iget+0x3f/0xc00
[   32.348082]  ? preempt_count_add+0x44/0x90
[   32.348303]  ? d_alloc_parallel+0x358/0x4f0
[   32.348527]  ? ext4_lookup+0xd6/0x200
[   32.348789]  ? __lookup_slow+0x8c/0x150
[   32.348997]  ? lookup_slow+0x30/0x50
[   32.349190]  ? walk_component+0x1b4/0x490
[   32.349405]  ? path_lookupat.isra.75+0x70/0x200
[   32.349646]  ? filename_lookup.part.76+0x9b/0x120
[   32.349907]  ? kmem_cache_alloc+0x22/0x120
[   32.350127]  ? getname_flags+0x49/0x170
[   32.350333]  ? vfs_statx+0x6e/0xd0
[   32.350517]  ? _raw_spin_unlock+0xd/0x20
[   32.350732]  ? __handle_mm_fault+0x6f2/0xbf0
[   32.350962]  ? __do_sys_newstat+0x39/0x70
[   32.351178]  ? _copy_to_user+0x26/0x30
[   32.351396]  ? __x64_sys_rt_sigprocmask+0x8a/0xd0
[   32.351697]  ? do_syscall_64+0x56/0x2f0
[   32.351946]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   32.352278] ---[ end trace 109b3dd4fd5e6455 ]---
[   32.352667] WARNING: CPU: 1 PID: 2300 at fs/inode.c:841 find_inode_fast.isra.24+0x90/0xa0
[   32.353193] CPU: 1 PID: 2300 Comm: parallels-serve Tainted: G        W         4.18.0-rc1+ #32
[   32.353739] RIP: 0010:find_inode_fast.isra.24+0x90/0xa0
[   32.354069] Code: 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f6 c4 80 75 11 f0 ff 83 30 01 00 00 4c 89 f7 e8 4a 7c 24 00 eb de 4c 89 f7 e8 40 7c 24 00 <0f> 0b 48 c7 c3 8c ff ff ff eb cb 0f 1f 44 00 00 41 54 49 c7 c4 30 
[   32.355255] RSP: 0018:ffffc90001137a68 EFLAGS: 00010282
[   32.355566] RAX: 0000000080000001 RBX: ffff880135c8efc8 RCX: 0000000000000002
[   32.355991] RDX: 0000000080000002 RSI: ffff88013ffb6d28 RDI: 00000000ffffffff
[   32.356411] RBP: 00000000000c0485 R08: ffff88013950c400 R09: ffff88013ac453a8
[   32.356792] R10: 0000000000000018 R11: 0000000000000018 R12: ffff88013b199000
[   32.357297] R13: ffff88013ffb6d28 R14: ffff880135c8f038 R15: 0000000000000000
[   32.357820] FS:  00007fedf735d700(0000) GS:ffff88013fc80000(0000) knlGS:0000000000000000
[   32.358430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.359200] CR2: 0000000002741088 CR3: 0000000139d59000 CR4: 00000000000006a0
[   32.359622] Call Trace:
[   32.359768]  ? iget_locked+0x69/0x190
[   32.359967]  ? ext4_iget+0x3f/0xc00
[   32.360167]  ? preempt_count_add+0x44/0x90
[   32.360388]  ? d_alloc_parallel+0x358/0x4f0
[   32.360615]  ? ext4_lookup+0xd6/0x200
[   32.360820]  ? __lookup_slow+0x8c/0x150
[   32.361031]  ? lookup_slow+0x30/0x50
[   32.361224]  ? walk_component+0x1b4/0x490
[   32.361439]  ? path_lookupat.isra.75+0x70/0x200
[   32.361698]  ? filename_lookup.part.76+0x9b/0x120
[   32.361974]  ? kmem_cache_alloc+0x22/0x120
[   32.362215]  ? getname_flags+0x49/0x170
[   32.362436]  ? vfs_statx+0x6e/0xd0
[   32.362634]  ? _raw_spin_unlock+0xd/0x20
[   32.362868]  ? __handle_mm_fault+0x6f2/0xbf0
[   32.363108]  ? __do_sys_newstat+0x39/0x70
[   32.363357]  ? sigprocmask+0x6d/0x90
[   32.363546]  ? _copy_to_user+0x26/0x30
[   32.363776]  ? __x64_sys_rt_sigprocmask+0x8a/0xd0
[   32.364046]  ? do_syscall_64+0x56/0x2f0
[   32.364259]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   32.364546] ---[ end trace 109b3dd4fd5e6456 ]---
[   33.075577] WARNING: CPU: 3 PID: 2305 at fs/inode.c:841 find_inode_fast.isra.24+0x90/0xa0
[   33.076723] CPU: 3 PID: 2305 Comm: dmesg Tainted: G        W         4.18.0-rc1+ #32
[   33.077766] RIP: 0010:find_inode_fast.isra.24+0x90/0xa0
[   33.078466] Code: 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f6 c4 80 75 11 f0 ff 83 30 01 00 00 4c 89 f7 e8 4a 7c 24 00 eb de 4c 89 f7 e8 40 7c 24 00 <0f> 0b 48 c7 c3 8c ff ff ff eb cb 0f 1f 44 00 00 41 54 49 c7 c4 30 
[   33.081018] RSP: 0018:ffffc90001107b80 EFLAGS: 00010282
[   33.081721] RAX: 0000000080000001 RBX: ffff88013aff9088 RCX: 0000000000000002
[   33.082670] RDX: 0000000080000002 RSI: ffff88013fec2350 RDI: 00000000ffffffff
[   33.083613] RBP: 00000000000405fb R08: ffff88013950c400 R09: ffff88013ac43ea0
[   33.084521] R10: 0000000000000014 R11: 0000000000000014 R12: ffff88013b199000
[   33.085259] R13: ffff88013fec2350 R14: ffff88013aff90f8 R15: ffff880135cb5180
[   33.085882] FS:  0000000000000000(0000) GS:ffff88013fd80000(0000) knlGS:0000000000000000
[   33.086433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.086841] CR2: 00007f85a9d03018 CR3: 0000000139d99000 CR4: 00000000000006a0
[   33.087267] Call Trace:
[   33.087410]  ? iget_locked+0x69/0x190
[   33.087839]  ? ext4_iget+0x3f/0xc00
[   33.088059]  ? preempt_count_add+0x44/0x90
[   33.088285]  ? d_alloc_parallel+0x358/0x4f0
[   33.088515]  ? ext4_lookup+0xd6/0x200
[   33.088725]  ? path_openat+0x9d6/0x1400
[   33.088937]  ? do_filp_open+0x8e/0x100
[   33.089153]  ? __lru_cache_add+0x6e/0x90
[   33.089363]  ? kmem_cache_alloc+0x22/0x120
[   33.089582]  ? do_sys_open+0x181/0x210
[   33.089788]  ? do_syscall_64+0x56/0x2f0
[   33.089994]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   33.090271] ---[ end trace 109b3dd4fd5e6457 ]---
